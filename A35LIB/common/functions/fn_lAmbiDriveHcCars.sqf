params ["_interval"];

{
	if ( (side _x) == civilian) then {
		private _grp = _x;
		if (local _grp) then {
			{
				private _unit = _x;
   				if ( isNil {_unit getVariable "alive_x_lib_lastcheck"}) then { 
					if (vehicle _unit == _unit) then {
						// if civ not in vehicle, do not delete it
						// deleteVehicle _unit;
						// deleteGroup _grp;
					} else {
						_car = vehicle _unit;
						_car deleteVehicleCrew _unit;
						deleteVehicle _car;
						//deleteGroup _grp;
					};	
				};	
			} forEach units _grp;
		};
	};
} forEach allGroups;

sleep _interval;
[_interval] spawn A35LIB_reset_lAmbiDriveHcCars;

// return
nil
















