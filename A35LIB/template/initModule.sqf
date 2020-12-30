// ----------------------------------------------------------------------------
// <TEMPLATE> Module
// ----------------------------------------------------------------------------
A35LIB_TEMPLATE_ENTITY = ["template"] call A35LIB_fnc_findModule;	// FIND MODULE ENTITY
[A35LIB_TEMPLATE_ENTITY] call A35LIB_common_loadModuleConfig;	// LOAD CONFICS


// ----------------------------------------------------------------------------
// Work with module entity (can also be set in 3DEN on module entity)
// ----------------------------------------------------------------------------

/*
// save value
A35LIB_TEMPLATE_ENTITY setVariable ["key", "value"];													// write on template module
["key", "value"] call A35LIB_common_setVariable;														// write on common A35LIB_ENTITY
["key", "value", "explicitOtherModule"] call A35LIB_common_setVariable;									// write on common explicitOtherModule

// read value
private variableOnModule = A35LIB_TEMPLATE_ENTITY getVariable "A35LIB_template_varName";						// read from template module
private variableOnModule = ["key", "defaultValue"] call A35LIB_common_getVariable;								// read from common A35LIB_ENTITY
private variableOnModule = ["key", "defaultValue", "explicitOtherModule"] call A35LIB_common_getVariable;		// read from explicitOtherModule
*/


// ----------------------------------------------------------------------------
// Work with datastore
// ----------------------------------------------------------------------------

/*
// save value
["key", "value"] call A35LIB_common_setVariableInDatastore;
// read value
private _varFromDataStore = ["key", []] call A35LIB_common_getVariableInDatastore;
*/

// ----------------------------------------------------------------------------
// CONSTANTS
// ----------------------------------------------------------------------------
CONF_A35LIB_TEMPLATE_CONSTANT1;
CONF_A35LIB_TEMPLATE_CONSTANT2;