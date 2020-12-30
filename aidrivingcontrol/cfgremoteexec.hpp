// List of script functions allowed to be sent from client via remoteExec
class Functions
{
	// RemoteExec modes:
	// 0- turned off
	// 1- turned on, taking whitelist into account
	// 2- turned on, ignoring whitelist (default, because of backward compatibility)
	mode = 2;

	// Ability to send jip messages: 0-disabled, 1-enabled (default)
	jip = 1;

	// your functions here
	class AIDC_fnc_init
	{
		allowedTargets = 0;	// can target anyone (default)
		jip = 0;		// sending JIP messages is disabled for this function (overrides settings in the Functions class)
	};
};