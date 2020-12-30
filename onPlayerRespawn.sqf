// Executed locally when player respawns in a multiplayer mission. 
// This event script will also fire at the beginning of a mission 
// if respawnOnStart is 0 or 1, oldUnit will be objNull in this instance. 
// This script will not fire at mission start if respawnOnStart equals -1.

/*
 * newUnit: Object
 * oldUnit: Object
 * respawn: String?
 * respawnDelay: Number
 */
params [
	"_newUnit",
	"_oldUnit",
	"_respawn",
	"_respawnDelay"
];


// Reset groups AI units to players location
// http://alivemod.com/forum/1613-ai-teammates-location-persistence-solved/0
/*
{
	if !(isPlayer _x) then {
		_x setPos (getPos player);
		sleep .5;
	};
} forEach units group player;
*/