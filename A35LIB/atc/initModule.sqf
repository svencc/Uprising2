// ----------------------------------------------------------------------------
// ATC Module
// ----------------------------------------------------------------------------
A35LIB_ATC_ENTITY = ["atc"] call A35LIB_fnc_findModule;
[A35LIB_ATC_ENTITY] call A35LIB_common_loadModuleConfig;



// ----------------------------------------------------------------------------
// ATC OFFICER
// ----------------------------------------------------------------------------
A35LIB_ATC_OFFICER = ["atc"] call A35LIB_fnc_findModule;

private _allMan = entities "CAManBase";
private _atcOfficers = [_allMan, {!isNil{_x getVariable "A35LIB_atc_officer"}}] call BIS_fnc_conditionalSelect; //@TODO: REFACTOR: suchen und Filtern. Das brauche ich oft -> commons fn
A35LIB_ATC_OFFICER = _atcOfficers select 0;

// @TODO -> WAS passiert wenn das nicht definiert wurde???? Etwas überlegen und selber einen setzen?.


// ----------------------------------------------------------------------------
// PLANES
// ----------------------------------------------------------------------------
// Find planes
private _allPlanes = entities "Plane";
private _atcManagedPlanes = [_allPlanes, {!isNil{_x getVariable "A35LIB_atc_jet"}}] call BIS_fnc_conditionalSelect;

// Register planes
{[_x, _x getVariable "A35LIB_atc_jet"] call A35LIB_atc_registerPlane;} foreach(_atcManagedPlanes);



// ----------------------------------------------------------------------------
// TAXIS
// ----------------------------------------------------------------------------
// Find taxis
private _allUgvs = entities "Car";
private _atcManagedTaxiOutPlatforms = [_allUgvs, {!isNil{_x getVariable "A35LIB_atc_taxi_out"}}] call BIS_fnc_conditionalSelect;
private _atcManagedTaxiInPlatforms = [_allUgvs, {!isNil{_x getVariable "A35LIB_atc_taxi_in"}}] call BIS_fnc_conditionalSelect;

// Register taxis
{[_x, _x getVariable "A35LIB_atc_taxi_out"] call A35LIB_atc_registerTaxiOut;} foreach(_atcManagedTaxiOutPlatforms);
{[_x, _x getVariable "A35LIB_atc_taxi_in"] call A35LIB_atc_registerTaxiIn;} foreach(_atcManagedTaxiInPlatforms);



// ----------------------------------------------------------------------------
// CONSTANTS
// ----------------------------------------------------------------------------
A35LIB_ATC_ENTITY;
A35LIB_ATC_OFFICER;