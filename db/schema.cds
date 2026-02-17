//CDL(CORE DATA LANGUAGE)

namespace it.incidentes;

using { cuid, managed, sap.common.CodeList } from '@sap/cds/common';

entity Incidents : cuid, managed {
    title : localized String(100) @title : '{i18n>Title}';
    description : localized String(1000) @title : '{i18n>Description}';
    status      : Association to Status @title : '{i18n>Status}';
    priority    : Association to Urgency @title: '{i18n>Priority}';
}

entity Status : CodeList {
    key code : String(20);
    name : localized String(100);
}

entity Urgency : CodeList {
    key code : String(20); 
    name : localized String(100);
}