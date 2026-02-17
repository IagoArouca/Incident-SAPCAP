using { IncidentService} from './incident-service';

annotate IncidentService.Incidents with @(
    UI.LineItem: [
        { Value: title, Label: '{i18n>Title}'},
        { Value: priority_code, Label: '{i18n>Priority}' },
        { Value: description, Label: 'Description'},
        { Value: status_code, Label: '{i18n>Status}' },
        { Value: createdBy, Label: '{i18n>CreatedBy}' },
        { Value: createdAt, Label: '{i18n>CreatedAt}' }
    ],

    UI.HeaderInfo: {
        TypeName: 'Incidente',
        TypeNamePlural: 'Incidentes',
        Tite: { Value: title },
        Description: { Value: description }
    },

    UI.FieldGroup #Details: {
        Data: [
            { Value: title },
            { Value: description },
            { Value: status_code },
            { Value: priority_code }
        ]
    },

    UI.Facets: [
        {
            $Type: 'UI.ReferenceFacet',
            Label: 'Informações Gerais',
            Target: '@UI.FieldGroup#Details'
        }
    ],
    UI.Identification: [
        {
            $Type: 'UI.DataFieldForAction',
            Action: 'IncidentService.closeIncident',
            Label: 'Encerrar Incidente'
        }
    ]
)
