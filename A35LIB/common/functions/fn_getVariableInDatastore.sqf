params ["_key", "_value"];

private _variable = [_key, _value, A35LIB_DATASTORE] call A35LIB_common_getVariable;

// return
_variable;