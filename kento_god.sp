#include <sourcemod>

new Handle:Godspawn = INVALID_HANDLE;

public Plugin:myinfo =
{
	name = "God Mode",
	author = "Kento",
	description = "Lord Kento Gives You God Mode",
	version = "1.0",
};

public OnPluginStart()
{
	RegConsoleCmd("sm_god", god);
	RegConsoleCmd("sm_mortal", mortal);
	
	HookEvent("player_spawn", OnPlayerSpawned);
	
	Godspawn = CreateConVar("god_spawn", "1", "Player Spawn In God Mode Or Not.");
	
	AutoExecConfig(true, "kento_god");
}

public OnPlayerSpawned(Handle:event, const String:name[], bool:dontBroadcast)
{
	new client = GetClientOfUserId(GetEventInt(event, "userid"));
	
	if (GetConVarInt(Godspawn) == 1)
	{	
		SetEntProp(client, Prop_Data, "m_takedamage", 0, 1);
	}
}

public Action:god(client, args)
{
	SetEntProp(client, Prop_Data, "m_takedamage", 0, 1);
	ReplyToCommand(client, " \x04[SM]\x01 God Mode on")
}

public Action:mortal(client, args)
{
	SetEntProp(client, Prop_Data, "m_takedamage", 2, 1);
	ReplyToCommand(client, " \x04[SM]\x01 God Mode off")
}