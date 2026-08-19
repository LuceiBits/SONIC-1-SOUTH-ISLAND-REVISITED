special_stage_start();

emerald_index     = game_emerald_count();
reward_is_emerald = (emerald_index < array_length(global.emeralds));

activated = false

activation_timer = 0
fail_state = false