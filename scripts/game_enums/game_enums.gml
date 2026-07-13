	// Enums for monitor type
	enum MONITOR
	{
		RINGS,
		SHIELD,
		FIRE_SHIELD,
		ELECTRIC_SHIELD,
		BUBBLE_SHIELD,
		INVINCIBLE,
		SPEED_SHOES,
		EXTRA_LIFE,
		EGGMAN,
		COMBINE_RING
	}
	
	// Enums for culling type
	enum CULL_TYPE
	{
		DISABLE,
		DEACTIVATE
	}
	
	// Enums for culling flags
	enum CULL_FLAG
	{
		CHECK_ENTITY_POS = 1 << 0,	
		CHECK_ENTITY_START = 1 << 1
	}
	
	// Enums for bounding box sides
	enum BBOX
	{
		LEFT,
		TOP,
		RIGHT,
		BOTTOM
	}
	
	// Stage state
	enum LEVEL_STATE
	{
		NORMAL,
		BONUS,
	}