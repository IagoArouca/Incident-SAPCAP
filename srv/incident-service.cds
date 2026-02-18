using { it.incidentes as my} from '../db/schema';

service IncidentService @(requires: 'authenticated-user') {
    entity Incidents as projection on my.Incidents {
        *,
        case status.code
            when 'OPEN'          then 1
            when 'IN_PROGRESS'   then 2 
            when 'RESOLVED'      then 3
            else 0
        end as statusCriticality : Integer,

        case priority.code
            when 'HIGH'   then 1
            when 'MEDIUM' then 2
            when 'LOW'    then 3
            else 0
        end as priorityCriticality : Integer

    } actions {

        @(requires: 'Admin')
        action closeIncident(resolutionText : String) returns Incidents;
    };

    @readonly entity Status as projection on my.Status;
    @readonly entity Urgency as projection on my.Urgency;
}