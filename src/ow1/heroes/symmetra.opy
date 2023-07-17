#!mainFile "../../main.opy"

subroutine initSymmetra

rule "[symmetra.opy]: Detect Symmetra initialization":
    @Event eachPlayer
    @Hero symmetra
    @Condition eventPlayer.initialized == false # without this flag, the reset code in generic.opy executes after initialization

    initSymmetra()
    eventPlayer.initialized = true


def initSymmetra():
    @Name "[symmetra.opy]: initSymmetra()"
    eventPlayer.setAmmo(0, OW1_SYMMETRA_CLIP_SIZE)
    eventPlayer.setMaxAmmo(0, OW1_SYMMETRA_CLIP_SIZE)

rule("[symmetra.opy]: Slowed Secondary Fire")
{
	event
	{
		Ongoing - Each Player;
		All;
		Symmetra;
	}

	conditions
	{
		Is Firing Secondary(Event Player) == True;
	}

	actions
	{
		Set Projectile Speed(Event Player, 50);
		Set Damage Dealt(Event Player, 120);
	}
}

rule("[symmetra.opy]: Old Teleporter Cooldown")
{
	event
	{
		Ongoing - Each Player;
		All;
		Symmetra;
	}

	conditions
	{
		Ability Cooldown(Event Player, Button(Ability 2)) > 11;
	}

	actions
	{
		disabled If(Is Button Held(Event Player, Button(Ability 2)));
		Set Ability Cooldown(Event Player, Button(Ability 2), 10);
	}
}
