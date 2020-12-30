params ["_key", "_default", "_useModule"];

private _module = A35LIB_ENTITY;

if (!isNil "_useModule") then {
  _module = _useModule;
};

if (isNil {_module getVariable _key} and (!isNil "_default")
) exitWith {
  [_key, _default, _useModule] call A35LIB_common_setVariable;

  // return
  _default;
};

if (isNil {_module getVariable _key} and (isNil "_default")
) exitWith {

  // return
  nil
};

if (!isNil {_module getVariable _key}) exitWith {
  
  // return
  _module getVariable _key;
};