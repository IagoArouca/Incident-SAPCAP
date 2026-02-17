const cds = require('@sap/cds');
const { UPDATE, SELECT } = require('@sap/cds/lib/ql/cds-ql');


class IncidentService extends cds.ApplicationService {
    init() {
        const { Incidents } = this.entities;

        this.before(['CREATE', 'UPDATE'], Incidents, async (req) => {
            const status = req.data.status_code;
            const description = req.data.description;

            if(status === 'RESOLVED') {
                if(!description || description.length < 20 ) {
                    return req.error(400, 'Para resolver um incidente, forneça uma descrição detalhada (mínimo 20 caracteres).', 'description');
                }
            }
        });

        this.on('closeIncident', 'Incidents', async (req) => {
            const { resolutionText } = req.data;
            const incidentId= req.params[0].ID;

            if (!resolutionText) {
                return req.error(400, 'É obrigatório informar o texto de resolução para encerrar o incidente.');
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

        return super.init();
    }
}

module.exports = { IncidentService };