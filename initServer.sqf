// Executed only on server when mission is started.
// Executed when mission is started (before briefing screen)

// Task					Applies To		JIP		Related To      Exec Environment	Notes
// initServer.sqf		Server			-		Event Scripts	Scheduled			-	
// initPlayerLocal.sqf	Client			+		Event Scripts	Scheduled			-
// initPlayerServer.sqf	Client			+		Event Scripts	Scheduled			-
// init.sqf             All				-		-				-					-	



//AI Driving Control (script version) (add to server)
null = execVM "aidrivingcontrol\init.sqf";

// LAxemann ambiDrive
//#include "L_ambiDrive\init.sqf" // switch to hc?

// Set real date:
/*
if (isServer) then {
	waitUntil {time > 0};
	private _now = (missionStart select [0,5]);
	_now set [0,(_now select 0)+20];
	setDate _now;
};
*/

// A35lib
if (isServer) then {
	A35LIB_PATH = "A35LIB\";
	call compile preprocessFileLineNumbers (A35LIB_PATH+"init.sqf");
};

// Tidy up lost L_ambDrive vehicles (every 60 seconds) (in case HC is gone)
if (( call BIS_fnc_getNetMode == "DedicatedServer")) then {
	[60] spawn A35LIB_reset_lAmbiDriveHcCars;
};