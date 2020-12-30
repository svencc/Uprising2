// ----------------------------------------------------------------------------
// <TEMPLATE> Module
// ----------------------------------------------------------------------------
A35LIB_CRON_ENTITY = ["cron"] call A35LIB_fnc_findModule;	// FIND MODULE ENTITY
[A35LIB_CRON_ENTITY] call A35LIB_common_loadModuleConfig;	// LOAD CONFICS


// ----------------------------------------------------------------------------
// Module
// ----------------------------------------------------------------------------



//initialize some crons time variables needed for cron cycle calculation!
_now = date;
_currentDay = _now select  2;
_currentHour = _now select  3;
_currentMinute = _now select  4;

A35LIB_CRON_ENTITY setVariable ["lastCronRunMinute", _currentMinute];
A35LIB_CRON_ENTITY setVariable ["lastCronRunHour", _currentHour];
A35LIB_CRON_ENTITY setVariable ["lastCronRunDay", _currentDay];





// main trigger object, which checks if we have some jobs to do
private _cronTrigger = createTrigger ["EmptyDetector",[0,0,0],false];
_cronTrigger setTriggerActivation ["NONE","PRESENT",true];
_cronTrigger setTriggerInterval 5; // run only every 10 seconds!

_cronTrigger setTriggerStatements ["[] call A35LIB_cron_runScheduler", "", ""];

A35LIB_CRON_ENTITY setVariable ["cronTrigger", _cronTrigger];




// ----------------------------------------------------------------------------
// CONSTANTS
// ----------------------------------------------------------------------------
CONF_A35LIB_CRON_CONSTANT1 = 10;