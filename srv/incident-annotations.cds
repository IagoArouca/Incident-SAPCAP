using { IncidentService } from './incident-service';

// 1. Anotações de nível de Entidade (Tabela e Cabeçalho) - SEM CHAVES
annotate IncidentService.Incidents with @(
    UI.LineItem: [
        { Value: title, Label: '{i18n>Title}' },
        { Value: priority_code, Label: '{i18n>Priority}' }, // Use o campo da associação
        { Value: description, Label: '{i18n>Description}' },
        { Value: status_code, Label: '{i18n>Status}' }      // O Common.Text fará a mágica
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
            { Value: priority_code }
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

// 2. Anotações de nível de Campo (onde usamos chaves {})
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