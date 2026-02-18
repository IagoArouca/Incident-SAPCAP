using { IncidentService } from './incident-service';

annotate IncidentService.Incidents with @(
    UI.LineItem: [
        { Value: title, Label: '{i18n>Title}' },
        {   Value: priority_code,
            Label: '{i18n>Priority}',
            Criticality: priorityCriticality
         }, 
        { Value: description, Label: '{i18n>Description}' },
        {   Value: status_code,
            Label: '{i18n>Status}',
            Criticality : statusCriticality
         }   
    ],

    UI.HeaderInfo: {
        TypeName: 'Incidente',
        TypeNamePlural: 'Incidentes',
        Title: { Value: title },
        Description: { Value: description }
    },

    UI.Facets: [
        {
            $Type: 'UI.ReferenceFacet',
            Label: 'Informações Gerais',
            Target: '@UI.FieldGroup#Details'
        }
    ],

    UI.FieldGroup #Details: {
        Data: [
            { Value: title },
            { Value: description },
            { Value: status_code },
            { Value: priority_code },
            { Value: createdAt, Label: '{i18n>CreatedAt}' },
            { Value: createdBy, Label: '{i18n>CreatedBy}' }
        ]
    },

    UI.Identification: [
        {
            $Type: 'UI.DataFieldForAction',
            Action: 'IncidentService.closeIncident',
            Label: 'Encerrar Incidente'
        }
    ]
);

annotate IncidentService.Incidents with {
    status   @Common.Text: status.name   @Common.TextArrangement: #TextOnly;
    priority @Common.Text: priority.name @Common.TextArrangement: #TextOnly;
};

annotate IncidentService.Status with {
    code @Common.Text: name @Common.TextArrangement: #TextOnly;
};

annotate IncidentService.Urgency with {
    code @Common.Text: name @Common.TextArrangement: #TextOnly;
};

annotate IncidentService.Incidents with {
    createdAt @readonly;
    createdBy @readonly;
}