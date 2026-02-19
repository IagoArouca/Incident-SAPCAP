const cds = require('@sap/cds');
const { UPDATE, SELECT, INSERT } = require('@sap/cds/lib/ql/cds-ql');


class IncidentService extends cds.ApplicationService {
    init() {
        const { Incidents, Comments } = this.entities;

        this.before(['CREATE', 'UPDATE'], Incidents, async (req) => {
            const incident = req.data;
            const status = req.data.status_code;
            const description = req.data.description;

            if(!incident.description || incident.description.length < 10) {
                return req.error(400, 'A descrição deve ter pelo menos 10 caracteres.')
            }

            if(status === 'RESOLVED') {
                if(!description || description.length < 20 ) {
                    return req.error(400, 'Para resolver um incidente, forneça uma descrição detalhada (mínimo 20 caracteres).', 'description');
                }
            }
        });


        this.on('closeIncident', 'Incidents', async (req) => {
            const { resolutionText } = req.data;
            const incidentId= req.params[0].ID;

            if (!resolutionText || resolutionText.length < 20) {
                return req.error(400, 'Para encerrar, a resolução deve ter no mínimo 20 caracteres.');
            }

            const updateResult = await UPDATE(Incidents).set({
                status_code: 'RESOLVED',
                description: `RESOLVIDO:  ${resolutionText}`
            }).where({ ID: incidentId });

            if(updateResult === 0) {
                return req.error(404, 'Incidente não encontrado.');
            }

            return SELECT.one.from(Incidents).where({ ID: incidentId });
        })

        this.after('CREATE', Incidents, async (incident, req) => {
            if(incident.priority_code === 'HIGH') {
                await INSERT.into(Comments).entries({
                    incident_ID: incident.ID,
                    comment: 'SISTEMA: Este incidente foi classificado como alta prioridade. Atendimento imediato requerido.',
                    createdBy: 'Sistema de Alerta'
                })
            }
        })

        return super.init();
    }
}

module.exports = IncidentService;
