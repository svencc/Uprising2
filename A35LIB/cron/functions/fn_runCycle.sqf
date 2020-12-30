params ["_currentMinute", "_currentHour", "_currentDay", "_currentMonth", "_currentYear"];


_fn_isAfterTime = {
	params ["_currentTime", "_plannedTime"];
};

_fn_isTime = {
	params ["_cronNextRunTime", "_currentTime"];
/*
	_currentYear = _cronNextRunTime select 0;
	_currentMonth = _cronNextRunTime select 1;
	_currentDay = _cronNextRunTime select 2;
	_currentHour = _cronNextRunTime select 3;
	_currentMinute = _cronNextRunTime select 4;

	_nextYear = _currentTime select 0;
	_nextMonth = _currentTime select 1;
	_nextDay = _currentTime select 2;
	_nextHour = _currentTime select 3;
	_nextMinute = _currentTime select 4;
*/
	_nextRun = dateToNumber _cronNextRunTime;
	_currentCycle = dateToNumber _currentTime;

	if (_currentCycle >= _nextRun) exitWith {true};


	// else return false
	false
};

_fn_formatDate = {
	params ["_minute", "_hour", "_day", "_month", "_year"];

	_dateString = format ["%5-%4-%3 %2:%1:0", _year, _month, _day , _hour, _minute]; 

	// return
	_dateString
};





// Fixed in version Format is [Year,Month,Day,Hour,Minute,Second]
// If you wanted to update a MySQL TimeStamp just do 
// [0,0,0,Hour,Minute,Second] Same with the other 
// date/time mysql datatypes.

// The schedule table
// Example cron result
// [0, "A35LIB_cron_updateCron", "*/5 * * * *", [],[]]
_cronTabResult = [] call A35LIB_db_query_cron;

if ( !isNil "_cronTabResult")
then {
	{
		_cronId = _x select 0;
		_cronFn = _x select 1;
		_cronInterval = _x select 2;
		_cronLastRunTime = _x select 3;
		_cronNextRunTime = _x select 4;

		_shouldRun = [
			_cronNextRunTime,
			[_currentYear,
			_currentMonth,
			_currentDay,
			_currentHour,
			_currentMinute,
			0]
		] call _fn_isTime;

		if (_shouldRun) then {
			// berechne nächsten Lauf
			_cronInterval;
			// schreibe nächsten Lauf
			


			// Ausführen des Scripts
			//_scriptHandle = [] spawn (call compile _cronFn);
			diag_log "xxx";
		};

	} forEach _cronTabResult;
};



// return 
nil