// Executed only on server when a player joins mission (includes both mission start and JIP).

// Task					Applies To		JIP		Related To		Exec Environment	Notes
// initServer.sqf		Server			-		Event Scripts	Scheduled			-	
// initPlayerLocal.sqf	Client			+		Event Scripts	Scheduled			-
// initPlayerServer.sqf Server			+		Event Scripts	Scheduled			-
// init.sqf				All				-		-				-					-	

/*
 *	player	Object
 *	didJIP	Boolean
 */
params ["_player", "_didJIP"];


// Hide CTP Speakers! Everytime a player joins; to make sure they are hidden!
{ _x hideObjectGlobal true; } forEach (nearestObjects [_player, ["Land_Loudspeakers_F"], 60000, true]);