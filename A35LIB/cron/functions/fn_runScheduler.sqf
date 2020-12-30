params [];

// prepare times
_lastCronRunMinute = A35LIB_CRON_ENTITY getVariable "lastCronRunMinute";
_lastCronRunHour = A35LIB_CRON_ENTITY getVariable "lastCronRunHour";
_lastCronRunDay = A35LIB_CRON_ENTITY getVariable "lastCronRunDay";

_now = date;
_currentYear = _now select  0;
_currentMonth = _now select  1;
_currentDay = _now select  2;
_currentHour = _now select  3;
_currentMinute = _now select  4;


// logic to start new cron cycle
// assure that cron runs every minute!
if (_lastCronRunMinute != _currentMinute)
then {
	A35LIB_CRON_ENTITY setVariable ["lastCronRunMinute", _currentMinute];
	[_currentMinute, _currentHour, _currentDay, _currentMonth, _currentYear] spawn A35LIB_cron_runMinutely;
};


// logic to start new cron cycle
// assure that cron runs every hour!
if (_lastCronRunHour != _currentHour)
then {
	A35LIB_CRON_ENTITY setVariable ["lastCronRunHour", _currentHour];
	[_currentMinute, _currentHour, _currentDay, _currentMonth, _currentYear] spawn A35LIB_cron_runHourly;
};


// logic to start new cron cycle
// assure that cron runs every day!
if (_lastCronRunDay != _currentDay)
then {
	A35LIB_CRON_ENTITY setVariable ["lastCronRunDay", _currentDay];
	[_currentMinute, _currentHour, _currentDay, _currentMonth, _currentYear] spawn A35LIB_cron_runDaily;
};



// return 
nil