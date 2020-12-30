params ["_currentMinute", "_currentHour", "_currentDay", "_currentMonth", "_currentYear"];



// ALiVE Save every hour
1 call ALiVE_fnc_AutoSave_PNS;
sleep 10;
-1 call ALiVE_fnc_AutoSave_PNS;



// return 
nil