// Executed when mission is started (before briefing screen)


// Spawning player group AI members after persistent save
// http://alivemod.com/wiki/index.php/Script_Snippets#Spawning_player_group_AI_members_after_persistent_save
/*
waituntil {(player getvariable ["alive_sys_player_playerloaded",false])};
sleep 2;
{
	if !(isPlayer _x) then {
		if !(_x getVariable ["Persistent_Teleport", false]) then {
			_x setPos (getPos player);
			_x setVariable ["Persistent_Teleport", true, true];
			sleep .5;
		};
	};
} forEach units group player;
*/

// Every HC gets 10 cars!
//if ((call BIS_fnc_getNetMode == "HeadlessClient" )) then {
	// LAxemann ambiDrive
	#include "L_ambiDrive\init.sqf"
//};

// ALiVE config
call compile preprocessFile "staticData.sqf";