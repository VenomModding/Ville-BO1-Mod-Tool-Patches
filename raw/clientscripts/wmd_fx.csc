//
// file: wmd_fx.gsc
// description: clientside fx script for wmd: setup, special fx functions, etc.
// scripter: 		(initial clientside work - laufer)
//

#include clientscripts\_utility; 


// load fx used by util scripts
precache_util_fx()
{	

}

precache_scripted_fx()
{
}


// --- BARRY'S SECTION ---//
precache_createfx_fx()
{

	level._effect["rocks_falling"]					        = loadfx("env/dirt/fx_rock_debris_ropebridge");
	level._effect["wind_gusts"]					            = loadfx("env/weather/fx_clouds_mountaintop_blowing");
	level._effect["clouds_os"]					            = loadfx("env/weather/fx_clouds_basejump_cl_layer");
	level._effect["clouds_cl"]					            = loadfx("env/weather/fx_clouds_basejump_cl_layer");
	level._effect["clouds_os2_only"]				      	= loadfx("env/weather/fx_clouds_basejump_cl_layer");
	level._effect["cloud_layers"] 						      = loadfx("env/weather/fx_clouds_basejump_cl_layer");
  level._effect["vis_blocker"] 					        	= loadfx("env/weather/fx_clouds_basejump_cl_layer");
  level._effect["freefall_cloud_layer1"] 					= loadfx("maps/wmd/fx_basejump_cloud_layer"); 
  level._effect["freefall_cloud_layer2"] 					= loadfx("maps/wmd/fx_basejump_cloud_layer2");    
     
  
  level._effect["snow_tree_fall_big"] 						= loadfx("env/foliage/fx_snow_falling_tree_big");
  level._effect["snow_tree_fall_big_spawner"] 		= loadfx("env/foliage/fx_snow_falling_tree_big_spawner");    
  level._effect["snow_tree_fall_light"] 					= loadfx("env/foliage/fx_snow_falling_tree_light");
  level._effect["snow_tree_fall_small"] 					= loadfx("env/foliage/fx_snow_falling_tree_small");
  level._effect["snow_flakes_windy_blizzard"] 		= loadfx("env/weather/fx_snow_blizzard_intense");
  level._effect["snow_flakes_windy_mild"] 		    = loadfx("env/weather/fx_snow_blizzard_mild");    
  level._effect["snow_flakes_windy_blizzard2"] 		= loadfx("env/weather/fx_snow_blizzard_intense2");   
  level._effect["snow_flakes_windy_sm"] 					= loadfx("env/weather/fx_snow_flakes_windy_small");
  level._effect["snow_ground_rolling_dist"] 			= loadfx("env/weather/fx_snow_ground_rolling_dist");
  level._effect["snow_gust_wind_burst"] 					= loadfx("env/weather/fx_snow_gust_wind_burst");
  level._effect["snow_windy_fast_door_os"] 				= loadfx("env/weather/fx_snow_windy_fast_door_os");
  level._effect["snow_windy_fast_sm_os"] 					= loadfx("env/weather/fx_snow_windy_fast_sm_os");
  level._effect["snow_windy_fast_lg_os"] 					= loadfx("env/weather/fx_snow_windy_fast_lg_os"); 
  level._effect["snow_windy_fast_xlg_os"] 				= loadfx("env/weather/fx_snow_windy_fast_xlg_os");    
  level._effect["snow_windy_heavy_md"] 			    	= loadfx("env/weather/fx_snow_windy_heavy_md");
  level._effect["snow_windy_heavy_md_rts"] 		   	= loadfx("env/weather/fx_snow_windy_heavy_md_rts");  
  level._effect["snow_windy_heavy_sm"] 						= loadfx("env/weather/fx_snow_windy_heavy_sm");
  level._effect["snow_windy_heavy_xsm"] 					= loadfx("env/weather/fx_snow_windy_heavy_xsm");    
  level._effect["snow_fog_field_lg"] 						  = loadfx("env/weather/fx_snow_fog_field_lg");
  level._effect["snow_gust_ground_lg"] 					  = loadfx("env/weather/fx_snow_gust_ground_lg");
  level._effect["snow_gust_wind_dense"] 				  = loadfx("env/weather/fx_snow_gust_wind_dense"); 
  level._effect["snow_fall_off_rock_hvy"] 			  = loadfx("env/weather/fx_snow_wall_hvy");
	level._effect["snow_fall_off_rock_hvy_loop"] 	  = loadfx("env/weather/fx_snow_wall_hvy_loop");	
	level._effect["snow_fall_off_rock_hvy_loop_direct"] 	  = loadfx("env/weather/fx_snow_wall_hvy_loop_direct");	
	level._effect["snow_fall_off_rock_hvy_loop_sm"] = loadfx("env/weather/fx_snow_wall_hvy_loop_sm");	
	level._effect["snow_fall_avalanche_base"]     	= loadfx("maps/wmd/fx_avalanche_base_sm");	
	level._effect["snow_fall_avalanche_base_move"]	= loadfx("maps/wmd/fx_avalanche_base");	
	level._effect["snow_fall_avalanche_base_start"] = loadfx("maps/wmd/fx_avalanche_base_slide");			
	level._effect["snow_fall_avalanche_base_start2"] = loadfx("maps/wmd/fx_avalanche_base_slide2");		  
	level._effect["snow_fall_avalanche"] 			    	= loadfx("env/weather/fx_snow_wall_avalanche");	
	level._effect["snow_fall_avalanche2"] 			   	= loadfx("env/weather/fx_snow_wall_avalanche2");
	level._effect["snow_fall_avalanche3"] 			   	= loadfx("env/weather/fx_snow_wall_avalanche3");				
	level._effect["snow_fall_avalanche4"] 			   	= loadfx("env/weather/fx_snow_wall_avalanche4");	
	level._effect["snow_fall_avalanche5"] 			   	= loadfx("env/weather/fx_snow_wall_avalanche5");	
	level._effect["snow_fall_avalanche6"] 			   	= loadfx("env/weather/fx_snow_wall_avalanche6");					
	level._effect["snow_fall_avalanche_elem1"] 			= loadfx("env/weather/fx_snow_wall_avalanche_elem");	
	level._effect["snow_fall_avalanche_elem2"] 			= loadfx("env/weather/fx_snow_wall_avalanche_elem2");		
	level._effect["snow_fall_avalanche_elem3"] 			= loadfx("env/weather/fx_snow_wall_avalanche_elem3");	 
  level._effect["snow_debris_plume_sm"] 			    = loadfx("env/weather/fx_snow_debris_plume_sm");
  level._effect["snow_debris_plume_md"] 			    = loadfx("env/weather/fx_snow_debris_plume_md");      
  level._effect["snow_gust_kickup1"] 					    = loadfx("env/weather/fx_snow_gust_kickup1");
	level._effect["snow_gust_kickup2"] 				  	  = loadfx("env/weather/fx_snow_gust_kickup2");	
  level._effect["cloud_layer_rolling3_lg"] 			  = loadfx("maps/wmd/fx_cloud_layer_rolling_3_lg");	
  level._effect["cloud_layer_rolling3_md"] 			  = loadfx("maps/wmd/fx_cloud_layer_rolling_3_md");		  
  level._effect["cloud_layer_rolling2"] 				  = loadfx("maps/wmd/fx_cloud_layer_rolling_2");
  level._effect["cloud_layer_rolling2_sm"] 			  = loadfx("maps/wmd/fx_cloud_layer_rolling_2_sm");  
  level._effect["cloud_layer_rolling2_xsm"] 			= loadfx("maps/wmd/fx_cloud_layer_rolling_2_xsm"); 
  level._effect["cloud_layer_rolling2_xsm_det_left"]	  = loadfx("maps/wmd/fx_cloud_layer_rolling_2_xsm_detail_l");  
  level._effect["cloud_layer_rolling2_xsm_det_right"] 	= loadfx("maps/wmd/fx_cloud_layer_rolling_2_xsm_detail_r");    
  level._effect["cloud_layer_rolling2_lg"] 			  = loadfx("maps/wmd/fx_cloud_layer_rolling_2_lg");    
  level._effect["debris_papers_windy"]            = loadfx("env/debris/fx_debris_papers_windy"); 
  level._effect["ambience_swirling1"]             = loadfx("maps/wmd/fx_wmd_room_swirling_ambience" );    
  level._effect["godray_md"]                      = loadfx("maps/wmd/fx_light_godray_wmd_md");
  level._effect["godray_md_long"]                 = loadfx("maps/wmd/fx_light_godray_wmd_md2");      
  level._effect["godray_sm"]                      = loadfx("maps/wmd/fx_light_godray_wmd_sm");        
  level._effect["light_lamp_glow_white"]          = loadfx("maps/wmd/fx_wmd_lamp_white_light_glow"); 
  level._effect["light_lamp_glow_red"]            = loadfx("maps/wmd/fx_wmd_lamp_red_light_glow");    
  level._effect["light_glow_red"]                 = loadfx("maps/wmd/fx_wmd_tower_red_light_glow");  
  level._effect["light_glow_green"]               = loadfx("maps/wmd/fx_wmd_tower_green_light_glow");  
  level._effect["light_glow_amber"]               = loadfx("maps/wmd/fx_wmd_tower_amber_light_glow"); 
  level._effect["base_explosion_stage_4"]         = loadfx("maps/wmd/fx_explosion_fuel_tank_stage4"); 
  level._effect["base_explosion_stage_5"]         = loadfx("maps/wmd/fx_explosion_fuel_tank_stage5"); 
  level._effect["base_explosion_stage_6"]         = loadfx("maps/wmd/fx_explosion_fuel_tank_stage6");      
  level._effect["fuel_tank_fire_lg"]              = loadfx("maps/wmd/fx_vehicle_fuel_tank_fire1");
  level._effect["fuel_tank_fire_sm"]              = loadfx("maps/wmd/fx_vehicle_fuel_tank_fire2");   
  level._effect["fuel_tank_fire_xsm"]             = loadfx("maps/wmd/fx_vehicle_fuel_tank_fire3"); 
  level._effect["snow_door_fallen_puff"]          = loadfx("maps/wmd/fx_snow_door_fallen_puff");     
  level._effect["breech_wind_gust_loop"]          = loadfx("maps/wmd/fx_wmd_breech_wind_gust"); 
  level._effect["snow_building_impact"]           = loadfx("maps/wmd/fx_snow_building_impact");    
  level._effect["snow_building_impact_sm"]        = loadfx("maps/wmd/fx_snow_building_impact_sm");    
  level._effect["snow_falling_drift_small"]       = loadfx("maps/wmd/fx_snow_falling_drift");  
  level._effect["snow_falling_curtain"]           = loadfx("maps/wmd/fx_snow_falling_curtain");   
  level._effect["light_flare_player"]             = loadfx("maps/wmd/fx_wmd_light_flare_player"); 
  level._effect["radar_wire_sparks"]              = loadfx("maps/wmd/fx_wmd_sparks_impact_burst2"); 
  level._effect["fire_indoor_sm"]                 = loadfx("maps/wmd/fx_fire_indoor_sm"); 
  level._effect["embers_indoor_sm"]               = loadfx("maps/wmd/fx_embers_indoor_sm");  
  level._effect["embers_indoor_lg"]               = loadfx("maps/wmd/fx_embers_indoor_lg");                                         
  level._effect["sparks_element1"]                = loadfx("env/electrical/fx_elec_burst_shower_sm_os");
  level._effect["dyn_light_glow"]                 = loadfx("maps/wmd/fx_wmd_lamp_breech_light_glow");
  level._effect["light_glow_spot_3"]              = LoadFX("maps/vorkuta/fx_light_glow_spot_3" );    
  
}


footsteps()
{
	clientscripts\_utility::setFootstepEffect( "snow", LoadFx( "bio/player/fx_footstep_snow" ) );
}


main()
{
	clientscripts\createfx\wmd_fx::main();
	clientscripts\_fx::reportNumEffects();
	
	precache_util_fx();
	precache_createfx_fx();
	
	footsteps();
		
	disableFX = GetDvarInt( #"disable_fx" );
	if( !IsDefined( disableFX ) || disableFX <= 0 )
	{
		precache_scripted_fx();
	}
	
	
	
}
