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
            $Type: 'UI.CollectionFacet',
            ID: 'GeneralInformation',
            Label: 'Informações Gerais',
            Facets: [
                {
                    $Type: 'UI.ReferenceFacet',
                    Label: 'Detalhes do Problema',
                    Target: '@UI.FieldGroup#MainColumn'
                },

                {
                    $Type: 'UI.ReferenceFacet',
                    Label: 'Administração',
                    Target: '@UI.FieldGroup#AdminColumn'
                }
            ]
        },

        {
            $Type: 'UI.ReferenceFacet',
            Label: 'Comentários',
            Target: 'comments/@UI.LineItem'
        }
    ],

    UI.FieldGroup #MainColumn: {
        Data: [
            { Value: title },
            { Value: description },
            { 
                Value: status_code,
                Criticality: statusCriticality

            },
            { 
                Value: priority_code,
                Criticality: priorityCriticality
            }
        ]
    },

    UI.FieldGroup #AdminColumn: {
        Data: [
            { Value: createdAt },
            { Value: createdBy }
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
};

annotate IncidentService.Comments with @(
    
    UI.LineItem: [
        { Value: createdAt, Label: 'Data' },
        { Value: createdBy, Label: 'Usuário' },
        { Value: comment,   Label: 'Comentário' }
    ],
    UI.HeaderInfo: {
        TypeName: 'Comentário',
        TypeNamePlural: 'Comentários',
        Title: { Value: createdBy },
        Description: { Value: createdAt }
    },
    UI.Facets: [
        {
            $Type: 'UI.ReferenceFacet',
            Label: 'Conteúdo do Comentário',
            Target: '@UI.FieldGroup#CommentDetail'
        }
    ],
    UI.FieldGroup #CommentDetail: {
        Data: [
            { Value: comment }
        ]
    }
);