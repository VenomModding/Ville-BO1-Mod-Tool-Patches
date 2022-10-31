//
// file: wmd_amb.csc
// description: clientside ambient script for wmd: setup ambient sounds, etc.
// scripter: 		(initial clientside work - laufer)
//

#include clientscripts\_utility; 
#include clientscripts\_ambientpackage;
#include clientscripts\_music;
#include clientscripts\_busing;
#include clientscripts\_audio;


main()
{
	//************************************************************************************************
	//                                              Ambient Packages
	//************************************************************************************************

	//declare an ambientpackage, and populate it with elements
	//mandatory parameters are <package name>, <alias name>, <spawnMin>, <spawnMax>
	//followed by optional parameters <distMin>, <distMax>, <angleMin>, <angleMax>
	
	
	//************************************************************************************************
	//                                       ROOMS
	//************************************************************************************************

	//explicitly activate the base ambientpackage, which is used when not touching any ambientPackageTriggers
	//the other trigger based packages will be activated automatically when the player is touching them
	//the same pattern is followed for setting up ambientRooms
	
	
		declareAmbientRoom( "wmd_outside_high" );			
			setAmbientRoomTone( "wmd_outside_high", "bgt_outdoor_wind_high" );
			setAmbientRoomReverb( "wmd_outside_high", "wmd_outdoor_snow", 1, 1 );
			setAmbientRoomContext( "wmd_outside_high", "ringoff_plr", "outdoor" );
			
//before the stairs
		declareAmbientRoom( "ext_canyon" );			
			setAmbientRoomTone( "ext_canyon", "bgt_outdoor_wind_high" );
			setAmbientRoomReverb( "ext_canyon", "wmd_cliff_face", 1, 1 );
			setAmbientRoomContext( "ext_canyon", "ringoff_plr", "outdoor" );

		declareAmbientRoom( "ext_open_garage" );			
			setAmbientRoomTone( "ext_open_garage", "null" );
			setAmbientRoomReverb( "ext_open_garage", "wmd_metal_shed", 1, 1 );
			setAmbientRoomContext( "ext_open_garage", "ringoff_plr", "indoor" );
			
		declareAmbientRoom( "computer_room" );			
			setAmbientRoomTone( "computer_room", "bgt_computer_room" );
			setAmbientRoomReverb( "computer_room", "wmd_stone_room", 1, 1 );
			setAmbientRoomContext( "computer_room", "ringoff_plr", "indoor" );
			
		declareAmbientRoom( "mud_room" );			
			setAmbientRoomTone( "mud_room", "bgt_mud_room" );
			setAmbientRoomReverb( "mud_room", "wmd_stone_hall", 1, 1 );
			setAmbientRoomContext( "mud_room", "ringoff_plr", "indoor" );
			
		declareAmbientRoom( "ext_shed" );			
			setAmbientRoomTone( "ext_shed", "null" );
			setAmbientRoomReverb( "ext_shed", "wmd_ext_shed", 1, 1 );
			setAmbientRoomContext( "ext_shed", "ringoff_plr", "indoor" );
					
// this is at after the stairs
		declareAmbientRoom( "wmd_outside_low" );					
			setAmbientRoomTone( "wmd_outside_low", "bgt_outdoor_wind_high" );
			setAmbientRoomReverb( "wmd_outside_low", "wmd_outside_low", 1, 1 );
			setAmbientRoomContext( "wmd_outside_low", "ringoff_plr", "outdoor" );
			
// before avalanch
		declareAmbientRoom( "final_ledge" );					
			setAmbientRoomTone( "final_ledge", "bgt_outdoor_wind_high" );
			setAmbientRoomReverb( "final_ledge", "wmd_final_ledge", 1, 1 );
			setAmbientRoomContext( "final_ledge", "ringoff_plr", "outdoor" );
			
		declareAmbientRoom ("avalanch");
			setAmbientRoomTone ("avalanch", "bgt_outdoor_wind_high");
			setAmbientRoomReverb( "avalanch", "wmd_first_avalanch", 1, 1 );
			setAmbientRoomContext( "avalanch", "ringoff_plr", "outdoor" );

		declareAmbientRoom ("window_breach");
			setAmbientRoomTone ("window_breach", "NULL");
			setAmbientRoomReverb( "window_breach", "wmd_window_breach", 1, 1 );
			setAmbientRoomContext( "window_breach", "ringoff_plr", "outdoor" );
			
		
		// after base jump
		declareAmbientRoom( "mg_gunner_room" );			
			setAmbientRoomTone( "mg_gunner_room", "null" );
			setAmbientRoomReverb( "mg_gunner_room", "wmd_mg_gunner_room", 1, 1 );
			setAmbientRoomContext( "mg_gunner_room", "ringoff_plr", "indoor" );
			
		declareAmbientRoom( "hangar" );			
			setAmbientRoomTone( "hangar", "null" );
			setAmbientRoomReverb( "hangar", "wmd_hangar", 1, 1 );
			setAmbientRoomContext( "hangar", "ringoff_plr", "indoor" );
			
		declareAmbientRoom( "steiners_office" );			
			setAmbientRoomTone( "steiners_office", "null" );
			setAmbientRoomReverb( "steiners_office", "wmd_steiners_office", 1, 1 );
			setAmbientRoomContext( "steiners_office", "ringoff_plr", "indoor" );
	
	//************************************************************************************************
	//                                      ACTIVATE DEFAULT AMBIENT SETTINGS
	//************************************************************************************************

//		activateAmbientPackage( 0, "_pkg", 0 );
		activateAmbientRoom( 0, "wmd_outside_high", 0 );		
		



// MUSIC STATES

	declareMusicstate("INTRO_SR71");
		musicAliasLoop("mus_sr71_intro_loop", 0, 4);
		
	declareMusicstate("SR71_RUNWAY");
		musicAlias("null", 1);	
		
	declareMusicState("SR71_GLOBE");
		musicAlias ("mus_sr71_hard_target", 1);
		musicwaittilldone();

	declareMusicstate("SR71_RTS");
		musicAliasLoop("mus_sr71_rts", 1, 2);

	declareMusicstate("ON_THE_GROUND");
		musicAliasloop("mus_snow_hide", 0, 3);

	declareMusicstate("ON_THE_GO");
		musicAliasLoop("mus_flamingdart_stealth", 0, 2);
		musicStinger ("mus_breach_stinger", 25);
		
	declareMusicState ("NONE");
		musicAliasloop("null", 2, 1);		

	declareMusicstate("WINDOW_BREACH");			
		musicAliasLoop("mus_post_breech", 0, 2);

	declareMusicstate("FIGHT");
		musicAliasLoop("mus_radar_battle", 0, 2);
		musicStinger("mus_radar_battle_stg");

	declareMusicstate("RADAR_FIGHT_DONE");
		musicAlias("null", 1);	
		musicStinger ("mus_stings04_RPG", 5, true);

	declareMusicstate("AVALANCH");
		musicAliasLoop("mus_avalanch_run", 0, 2);
		musicStinger("mus_avalanch_run_stg");

	declareMusicstate("FALLING");
		musicAlias ("mus_pentagon_falling_stg", 0);
		musicAliasLoop("NULL", 4, 2);
			
	declareMusicState ("POST_BASEJUMP");
		musicAliasLoop("mus_post_basejump", 0, 2);
		
	declareMusicState ("BASE_FIGHT");
		musicAliasLoop("mus_cia_basefight", 0, 2);
		musicStinger ("mus_building_two_fight_intro", 22, true);

	declareMusicState ("KICK_DOOR");
		musicAliasLoop("mus_basefight_loop", 0, 4);
		musicStinger ("mus_steiners_office", 55, true);
	
	declareMusicstate("STEINERS_OFFICE");
		musicAliasLoop("NULL", 4, 2);
		
	declareMusicState ("WAREHOUSE_FIGHT");
		musicAlias ("mus_melville_hangar_fight", 0);
		musicAliasloop ("mus_post_breech", 0,0);
		musicStinger ("mus_pegasus_avalanch", 0, true);		
	
	
	declareMusicstate("TRUCK");
		musicAliasLoop("NULL", 0, 2);
	
	//Numbers looper
	level thread number_looper();
		
// Start radar sounds running

	thread snd_radar_groan_loop();
	thread snd_radar_engine_loop();

// set up wind sounds for when guys come crashing in

	thread snd_window_wind_1();
	thread snd_window_wind_2();
	thread snd_window_wind_3();
	
	
// set up sounds for computer room

	//thread lower_door_breach();
	thread basejump_functions();
	
// Start SR71 sounds
	
	thread sr71_sound_start();
	thread sr71_start_up();
	thread sr71_wait_for_x();
	thread sr71_external_before_launch();
	thread sr71_fire_thrusters();
	thread sr71_second_cut();
	thread sr71_by_cut();
	thread sr71_back_in_cockpit();
	thread sr71_fade_to_space();
	thread sr71_space_snap_to_cockpit();
	thread sr71_space_go_outside();
	thread sr71_space_backin();
	thread sr71_go_to_ground();

	thread window_breach_functions();
	
	thread avalanch_snapshot();
	thread base_jump_snapshot();
	thread window_breech_reverb();
	thread post_jump_snapshot();
	thread basejump_stylized_start();

    thread hangar_random_wind_gusts();
    thread basejump_branch_breaks();
}


number_looper()
{

	num_ent = spawn (0, ((13912, -5893, 10043)), "script_origin");		
	num_ent playloopsound ("amb_num_16_d", 1);	
					
}


snd_radar_groan_loop()
{
	level waittill("start_base_sounds");
	radar_groan_ent = getent (0, "dish_groan" , "targetname");
	//TODO isDefine check for ent
	if (IsDefined(radar_groan_ent))
	{
			radar_groan_ent playloopsound ("amb_radar_creak_loop", 1 );
			level waittill ("radar_disabled");
			radar_groan_ent stoploopsound (0.5);
			playsound (0, "evt_radar_groan_stop", radar_groan_ent.origin );
	}
	else 
	{
//		iprintlnbold ("Could not find sound groan entity");
	}


}

snd_radar_engine_loop()
{
	level waittill("start_base_sounds");
	radar_engine_ent = getent (0, "dish_engine" , "targetname");
	//TODO isDefine check for ent
	if (IsDefined(radar_engine_ent))
	{
		radar_engine_ent playloopsound ("amb_radar_engine_loop", 1 );
		level waittill ("radar_disabled");
		
		//iprintlnbold ("HERE!");
		radar_engine_ent stoploopsound ( 0.5 );

		playsound (0, "evt_radar_engine_stop", radar_engine_ent.origin );
	}
	else 
	{
		/#
		iprintlnbold ("Could not find engine entity");
		#/
	}

}

snd_window_wind_1()
{
	level waittill("start_base_sounds");
	window_1_ent = getent (0, "window_1", "targetname");
	if (IsDefined(window_1_ent))
	{
		level waittill ("window_1");
		window_1_ent playloopsound ("evt_window_wind", 0.25);
		
		
	}
	else 
	{
		/#
		iprintlnbold ("Could not find window_1 entity");
		#/
	}
	
	
}

snd_window_wind_2()
{
	level waittill("start_base_sounds");
		window_2_ent = getent (0, "window_2", "targetname");
	if (IsDefined(window_2_ent))
	{
		level waittill ("window_2");
		window_2_ent playloopsound ("evt_window_wind", 0.25);
		
		
	}
	else 
	{
		/#
		iprintlnbold ("Could not find window_2 entity");
		#/
	}
	
}


snd_window_wind_3()
{
	level waittill("start_base_sounds");
	window_3_ent = getent (0, "window_3", "targetname");
	if (IsDefined(window_3_ent))
	{
		level waittill ("window_3");
		window_3_ent playloopsound ("evt_window_wind", 0.25);
		
		
	}
	else 
	{
		/#
		iprintlnbold ("Could not find window_3 entity");
		#/
	}	
	
}






//********SR71 Section******************

//actual sound starts server side in level gsc

sr71_sound_start()
{
	
	breathingent = Spawn( 0, (0,0,0), "script_origin" );
	
	level thread sr71_close_canopy(breathingent);
	
	level waittill("first_snap_on");
	
	Radioent = Spawn( 0, (0,0,0), "script_origin" );
	
	level thread sr71_lift_off(radioent);
		
	Radioent PlayLoopSound( "evt_tower_radio", 0 );
	
		
	breathingent PlayLoopSound( "veh_sr71_breathing", 0 );
	
	
		
	snd_set_snapshot ("wmd_sr71_ext");
	
	
}
	
sr71_close_canopy(breathingent)
{
	
	level waittill ("canopy_shut_start");
	
	playsound (0, "veh_sr71_canopy_close", (0,0,0));
	snd_set_snapshot ("wmd_sr71_close_canopy");
	
	breathingent StopLoopSound(6);
	
	level waittill ("canopy_shut_end");
	
	playsound (0, "veh_sr71_canopy_latch", (0,0,0));
	
}
	
sr71_start_up()
{
	level waittill ("clear_for_takeoff");
	playsound (0, "veh_sr71_start_lr", (0,0,0));


}
	
	
	
sr71_wait_for_x()
{

	level waittill ("wait_for_x");
	playsound (0, "veh_sr71_wait_for_x", (0,0,0) );
	
}

sr71_external_before_launch()
{
	
	level waittill ("external_before_launch");
	
	

	
	snd_set_snapshot ("wmd_sr71_takeoff_sequence_ext");
	
}
	
	
sr71_fire_thrusters()
	
{
	//start engine rolling oneshot sounds
	
	players =  getlocalplayers();
	player = players[0];

	
	level waittill ("thrusters_on");
	playsound (0, "veh_sr71_roll_int", player.origin );
	
	
	playsound (0, "veh_sr71_fire_main", (0,0,0) );
	
	
}
	
sr71_second_cut()
{
	
	level waittill ("second_cut");
	
			
	playsound (0, "veh_sr71_boost", (0,0,0) );
	
}
	
sr71_by_cut()
	
{
	
	
	level waittill ("by_cut");
	
		
	playsound (0, "veh_sr71_by", (0,0,0) );
	
}
	
sr71_back_in_cockpit()
{
	level waittill ("get_back_in_cockpit");
	
	snd_set_snapshot ("wmd_sr71_takeoff_seqence_int");
	
	
}
	
sr71_lift_off(radioent)
{
	
	level waittill ("lift_off");
	
		
	playsound (0, "veh_sr71_lift_off_int", (0,0,0) );
	
	
	
	
	radioent stoploopsound(8);
	
}
	
sr71_fade_to_space()
	
{
	
	level waittill ("white_fade_post_liftoff");
	snd_set_snapshot ("wmd_sr71_first_into_space");
	
}
	
sr71_space_snap_to_cockpit()
{
	//iprintlnbold ("setting snapshot");
	level waittill ("space_snap_into_cockpit");
	snd_set_snapshot ("wmd_sr71_space_into_cockpit");

}
	
sr71_space_go_outside()	
{
	level waittill ("space_go_outside");
	snd_set_snapshot ("wmd_sr71_cockpit_into_space");
	
}
	
sr71_space_backin()
{
	
	level waittill ("space_backin");
	snd_set_snapshot ("wmd_sr71_back_into_cockpit");
	
	
}
	
sr71_go_to_ground()
{
	level waittill ("go_to_ground");
	snd_set_snapshot ("default");

}
	

	
window_breach_functions()
{
	breach_bg_ent = Spawn( 0, (0,0,0), "script_origin" );


	
	level waittill ("breach_sound_go");
//	snd_set_snapshot ("wmd_window_breach"); // MOVED TO ALIAS
	
	breach_bg_ent playloopsound ("evt_win_breach_bg");
	
	
	playsound (0, "evt_win_breach_push", (0,0,0));
	
	level waittill ("breach_window_break");
//	playsound (0, "evt_win_breach_glass_shatter", (0,0,0));
	
	level waittill ("Breach_sound_stop");
	
//	playsound (0, "evt_win_breach_come_out", (0,0,0));
	
	breach_bg_ent stoploopsound(3);
	
	snd_set_snapshot ("default");
	
	breach_bg_ent delete();
	
	


}


//lower_door_breach()
//{
	//level waittill ("breach_begin");
	//playsound (0, "evt_door_kick", (0,0,0));

//}




//********BASEJUMP STUFF BELOW HERE******************
basejump_functions()
{
	level thread wind_sounds();
}

wind_sounds()
{	
	level waittill( "bsjsty" );

	fakeent1 = spawnfakeent(0);
	fakeent2 = spawnfakeent(0);
	fakeent3 = spawnfakeent(0);
	fakeent4 = spawnfakeent(0);
	fakeent5 = spawnfakeent(0);
	
    playloopsound( 0, fakeent1,   "evt_basejump_wind_high",    1 );
    playloopsound( 0, fakeent2,   "evt_basejump_wind_mid",   1 );
    playloopsound( 0, fakeent3,   "evt_basejump_cloth",   1 );

    level waittill( "para" );
    
	StopLoopSound( 0, fakeent1, 1);
	StopLoopSound( 0, fakeent2, 1);
	StopLoopSound( 0, fakeent3, 1);

	playloopsound( 0, fakeent4, "evt_parachute_wind", 1 );
	playloopsound( 0, fakeent5, "evt_parachute_flap", 1 );
	
	level waittill( "lnd" );
	StopLoopSound( 0, fakeent4, 1);
	StopLoopSound( 0, fakeent5, 1);
}

avalanch_snapshot()
{
	level waittill ("avalanch");	
	activateAmbientRoom( 0, "avalanch", 60 );	
	
	snd_set_snapshot( "wmd_avalanch" );	
	
}
base_jump_snapshot()
{
	level waittill ("falling");	
	deactivateAmbientRoom(0, "avalanch", 60);	
	//snd_set_snapshot( "wmd_base_jump" );	
	
}
window_breech_reverb()
{
	level waittill ("wbr");  //window breach reverb
	activateAmbientRoom( 0, "window_breach", 60 );	
	
	level waittill("Breach_sound_stop");
	deactivateAmbientRoom(0, "window_breach", 60);	
	
}

post_jump_snapshot()
{
    level waittill( "lnd" );
    snd_set_snapshot( "default" );
}

hangar_random_wind_gusts()
{
    position = [];
    position[0] = (12500, -5720, 10086);
    position[1] = (13110, -5018, 10100);
    position[2] = (13867, -6596, 10147);
    position[3] = (13224, -6538, 10142);
    position[4] = (13657, -6746, 10164);
    position[5] = (12873, -6082, 10142);
    position[6] = (12599, -5632, 10179);
    
    while(1)
    {
        num = RandomIntRange(0, position.size);
        PlaySound( 0, "amb_wind_hangar_howl", position[num] );
        wait(RandomFloatRange(1,4));
    }
}

basejump_branch_breaks()
{
    array_thread( GetEntArray( 0, "basejump_branch_break", "targetname" ), ::play_branch_break_audio );
}

play_branch_break_audio()
{
    self waittill( "trigger" );
    PlaySound( 0, "evt_branch_break", (0,0,0) );
}

basejump_stylized_start()
{
    level waittill( "bsjsty" );
    PlaySound( 0, "vox_basejump_yell", (0,0,0) );
    realWait(.5);
    PlaySound( 0, "evt_basejump_stylized", (0,0,0) );
    snd_set_snapshot( "wmd_basejump_quiet" );
    realWait(4.2);
    snd_set_snapshot( "wmd_base_jump" );
}