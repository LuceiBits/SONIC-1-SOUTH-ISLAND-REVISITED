function player_shield_normal()
{
	with(shield_obj)
	{
		// Play the shield animation
		animation_play(animator, SHIELD_ANIM.NORMAL_IDLE);	
		
		// Correct the depth
		depth = other.depth - 10;
	}
}