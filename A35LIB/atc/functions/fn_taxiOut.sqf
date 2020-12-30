params ["_callsignTupel"];

if (isNil{_callsignTupel}) exitWith {
  ["1578256676: _callsign is empty"] call A35LIB_common_debug;
  false;
};

private _planeCallsign = (_callsignTupel splitString "#") select 0;
private _taxiCallsign = _callsignTupel;



// ----------------------------------------------------------------------------
// PREPARE
// ----------------------------------------------------------------------------

// Find all registed taxis
private _registeredTaxis = ["A35LIB_atc_registered_taxis_out", []] call A35LIB_common_getVariableInDatastore;

// Find taxi with given callsign
private _taxis = [_registeredTaxis, {(_x getVariable "A35LIB_atc_callsign") == _taxiCallsign;}] call BIS_fnc_conditionalSelect;

if (count _taxis != 1) exitWith {
  //["1578256721: taxis found ("+(str count _taxis)+")"] call A35LIB_common_debug;
  false;
};

private _taxiTemplate = _taxis select 0;



// Find all registed planes
private _registeredPlanes = ["A35LIB_atc_registeredPlanes", []] call A35LIB_common_getVariableInDatastore;
// Find taxi with given callsign
params _planeTemplates = [_registeredPlanes, {(_x getVariable "A35LIB_atc_callsign") == _planeCallsign;}] call BIS_fnc_conditionalSelect;

if (count _planeTemplates != 1) exitWith {
  ["1578257578: planes found ("+(str count _taxis)+")"] call A35LIB_common_debug;
  false;
};

private _planeTemplate = _planeTemplates select 0;
private _planeTemplate_taxi_speed = _planeTemplate getVariable ["A35LIB_atc_jet_taxi_speed", CONF_A35LIB_ATC_TAXI_DEFAULT_SPEED];
private _planeTemplate_taxi_offset = _planeTemplate getVariable ["A35LIB_atc_jet_taxi_offset", CONF_A35LIB_ATC_TAXI_DEFAULT_OFFSET];



// ----------------------------------------------------------------------------
// CREATE INSTANCES
// ----------------------------------------------------------------------------

// Create plane instance using template
private _planeInstance = createVehicle [typeOf _planeTemplate,position _planeTemplate,[],0,"CAN_COLLIDE"];
[
	_planeInstance,
	["Green",1], 
	true
] call BIS_fnc_initVehicle;

_planeInstance setDir (getDir _planeTemplate);

// @TODO: Die Loadouts müssen auch Konfigurierbar sein!!!!
// Set Dynamic Loadout 
private _pylons = ["PylonRack_1Rnd_Missile_AA_04_F","PylonRack_7Rnd_Rocket_04_HE_F","PylonMissile_1Rnd_BombCluster_03_F","PylonWeapon_300Rnd_20mm_shells","PylonMissile_1Rnd_BombCluster_03_F","PylonRack_7Rnd_Rocket_04_HE_F","PylonRack_1Rnd_Missile_AA_04_F"];
private _pylonPaths = (configProperties [configFile >> "CfgVehicles" >> typeOf _planeInstance >> "Components" >> "TransportPylonsComponent" >> "Pylons", "isClass _x"]) apply {getArray (_x >> "turret")};
{ _planeInstance removeWeaponGlobal getText (configFile >> "CfgMagazines" >> _x >> "pylonWeapon") } forEach getPylonMagazines _planeInstance;
{ _planeInstance setPylonLoadout [_forEachIndex + 1, _x, true, _pylonPaths select _forEachIndex] } forEach _pylons;

// Disable Simulation for plane
_planeInstance allowDamage false;
_planeTemplate enableSimulation false; // enableSimulationGlobal in MP!




private _taxiInstance = createVehicle [typeOf _taxiTemplate,position _planeTemplate,[],0,"CAN_COLLIDE"];
[
	_taxiInstance,
	["Indep",1], 
	true
] call BIS_fnc_initVehicle;
_taxiInstance setDir (getDir _planeTemplate);

createVehicleCrew  _taxiInstance; // set a drev to vehicle, to enable ability to drive!

// Make the taxi invisible and still responsive. 
// Due to that, we have to get rid of the textures of the taxi vehicle.
// Downside to this approach; The shadow is still visible; But I don´t know any other possibility!!!
{
  _taxiInstance setObjectTexture [_forEachIndex,""];   
} forEach(getObjectTextures _taxiInstance);

_planeInstance attachTo [_taxiInstance,_planeTemplate_taxi_offset];
_taxiInstance limitSpeed _planeTemplate_taxi_speed;
_taxiInstance disableAI "AUTOCOMBAT";
_taxiInstance disableAI "SUPPRESSION";
_taxiInstance disableAI "CHECKVISIBLE";
_taxiInstance disableAI "COVER";
_taxiInstance disableAI "LIGHTS";
_taxiInstance disableAI "AUTOTARGET";
A35LIB_ATC_OFFICER action ["lightOff", _taxiInstance];

// @TODO - REFACTOR -> setter and getter functions planes!
// Connect every instance inside the plane!
_planeInstance setVariable ["A35LIB_atc_planeInstanceFrom", _planeTemplate];
_planeInstance setVariable ["A35LIB_atc_currentTaxi", _taxiInstance];
_planeInstance setVariable ["A35LIB_atc_currentTaxi_template", _taxiTemplate];




// ----------------------------------------------------------------------------
// SPAWN PILOT
// ----------------------------------------------------------------------------

// @LIMITATION _nextPilotSpawnMaker has to be max 10!
private _pilotSpawnMakers = ["A35LIB_atc_pilotSpawnMarkers",[], A35LIB_ATC_ENTITY] call A35LIB_common_getVariable;
if (count _pilotSpawnMakers < 1) exitWith {
  ["1578306604: A35LIB_atc_pilotsSpawnMarker min 1 entrie! Found: "+str(count _pilotSpawnMakers)] call A35LIB_common_debug;
  false;
};
private _nextPilotSpawnMaker = ([_pilotSpawnMakers, [_planeTemplate], {(getMarkerPos _x ) distance2D _input0 }, "ASCEND"] call BIS_fnc_sortBy) select 0;



// Spawn pilot and let him mount the the plane
private _grp = createGroup independent; // @TODO make SIDE configurable
private _newPilot = _grp createUnit [typeof (driver _planeTemplate), getMarkerPos _nextPilotSpawnMaker, [_nextPilotSpawnMaker],0,"NONE"];

_newPilot assignAsDriver _planeInstance;
[_newPilot] orderGetIn true;





// ----------------------------------------------------------------------------
// PILOT MOUNT PLANE EVENTHANDLER
// ----------------------------------------------------------------------------
_planeInstance addEventHandler ["GetIn", {
	params ["_plane", "_role", "_unit", "_turret"];
  [_plane, _role, _unit, _turret] spawn getInHandlerScheduled;
}];

getInHandlerScheduled = {
  params ["_plane", "_role", "_unit", "_turret"];
  
  _taxiInstance = _plane getVariable "A35LIB_atc_currentTaxi";
  _taxiTemplate = _plane getVariable "A35LIB_atc_currentTaxi_template";

  // Spinning Engines for nr of seconds
  sleep CONF_A35LIB_ATC_ENGINE_SPINUP_DEFAULT_TIME;

  // Taxi start follow path
  _taxiInstance setDriveOnPath ((waypoints (group driver _taxiTemplate)) apply {
    waypointPosition _x;
  });

  { _x setWaypointCompletionRadius 1;
  } forEach (waypoints (group driver _taxiInstance));



  // Check if taxi reaches its destination
  [_plane, _taxiInstance, _taxiTemplate] spawn {
    params ["_plane", "_taxi", "_taxiTemplate"];

    private _runwayId = _taxiTemplate getVariable "A35LIB_atc_taxi_destination_id";
    private _destinationCallsign = _taxiTemplate getVariable "A35LIB_atc_taxi_destination_callsign";

    while {
      private _speed = speed _taxi;
      private _distance = (_taxi distance2D (getMarkerPos (_taxiTemplate getVariable "A35LIB_atc_taxi_destination_id")));
      private _comparison = ((_speed == 0) && (_distance < CONF_A35LIB_ATC_TAXI_DEFAULT_DESTINATION_DISTANCE));

      !_comparison
    } do {
      sleep CONF_A35LIB_ATC_TAXI_DEFAULT_DESTINATION_CHECK_INTERVAL;
    };

    [_runwayId, _destinationCallsign, _plane] call A35LIB_atc_prepareTakeoffPlane;
  };

};


// Dann brauchen wir noch diverse Routen die das Flugzeug dann einnimmt.

// Der ATC muss einen Flugplan haben für Patroullienflüge

// Dann müssen die Flieger auch wieder reinkommen und TAXI-IN machen

// WICHTIGES THEMA - AUFRÄUMEN? Umgang mit kaputten Flugzeugen?
