params ["_chopperGroup", "_baseMarker"];


_leader = leader medevac; //
//_leader = leader _chopperGroup;
_chopper = vehicle _leader;

_baseMarker ="base"; //





[_chopper, _baseMarker] spawn {
	params ["_chopper", "_baseMarker"];

	_fn_spawnMedics = {
		params ["_chopper", "_baseMarker"];
		 if (_chopper inArea _baseMarker)
		 then {
			 ((str _chopper) + " is landed in base " + (str _baseMarker)) remoteExec ["hint"];
		 }
		 else {
			 ((str _chopper) + ": " + str (_chopper getVariable "heloLanded")) remoteExec ["hint"];
		 };
	};

	while {alive _chopper} do {

		if (isTouchingGround _chopper) 
		then {
			_chopper setVariable ["heloLanded",TRUE,TRUE];
			[_chopper, _baseMarker] call _fn_spawnMedics;
		} 
		else {

		};
		sleep 2;
	};
};


// return
nil
// [this,"taor_nato_hq"] call A35LIB_fn_medevac;
