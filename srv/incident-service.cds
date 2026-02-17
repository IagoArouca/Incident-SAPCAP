using { it.incidentes as my} from '../db/schema';

service IncidentService @(requires: 'authenticated-user') {
    entity Incidents as projection on my.Incidents actions {

        @(requires: 'Admin')
        action closeIncident(resolutionText : String) returns Incidents;
    };

    @readonly entity Status as projection on my.Status;
    @readonly entity Urgency as projection on my.Urgency;
}