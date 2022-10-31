	// This script automaticly plays a users specified oneshot effect on all prefabs that have the 
	// specified "script_struct" and "targetname" It also excepts angles from the "script_struct" 
	// but will set a default angle of ( 0, 0, 0 ) if none is defined.
	//
	// example of the syntax: 
	// global_FX( "targetname", "fxIDname", "fxFile", "delay"

#include clientscripts\mp\_utility;
	
main()
{
	wind_initial_setting();
	r_outdoor_feather();

	level._global_fx_ents = [];	
	randomStartDelay = randomfloatrange( -20, -15);
		//_prefabs/lights/rustic_hanging.map
	global_FX( "rustic_hanging_fx_point", "rustic_hanging_global", "env/light/fx_lights_rustic", randomStartDelay, "fx_lights_rustic_flame" );

	//_prefabs/lights/rustic_sconce.map
	global_FX( "candle_flame_fx_point", "candle_flame_global", "env/light/fx_lights_candle_flame", randomStartDelay );

	//_prefabs/lights/lantern.map
	global_FX( "lantern_light_fx_point", "lantern_on_global", "env/light/fx_lights_lantern_on", randomStartDelay );
	
	//map_source/prefabs/misc_models/com_barrel_fire.map
	global_FX( "barrel_fireFX_origin", "global_barrel_fire", "fire/firelp_barrel_pm", randomStartDelay, "fire_barrel_small" );

	//map_source/prefabs/misc_models/ch_street_light_02_on.map
	//prefabs/misc_models/ch_street_wall_light_01_on.map
	global_FX( "ch_streetlight_02_FX_origin", "ch_streetlight_02_FX", "misc/lighthaze", randomStartDelay );

	//prefabs/misc_models/me_streetlight_on.map
	//prefabs/misc_models/me_streetlight_on_scaleddown80.map
	global_FX( "me_streetlight_01_FX_origin", "me_streetlight_01_FX", "misc/lighthaze_bog_a", randomStartDelay );

	//prefabs\village_assault\misc\lamp_post.map
	global_FX( "ch_street_light_01_on", "lamp_glow_FX", "misc/light_glow_white", randomStartDelay );

	//prefabs\village_assault\misc\highway_lamp_post.map
	global_FX( "highway_lamp_post", "ch_streetlight_02_FX", "misc/lighthaze_villassault", randomStartDelay );
	
	//prefabs/misc_models/cs_cargoship_spotlight_on.map
	global_FX( "cs_cargoship_spotlight_on_FX_origin", "cs_cargoship_spotlight_on_FX", "misc/lighthaze", randomStartDelay );

	//prefabs/misc_models/me_dumpster_fire.map
	global_FX( "me_dumpster_fire_FX_origin", "me_dumpster_fire_FX", "fire/firelp_med_pm", randomStartDelay, "fire_dumpster_medium" );
 
	//map_source/prefabs/misc_models/com_tires01_burning.map
	global_FX( "com_tires_burning01_FX_origin", "com_tires_burning01_FX", "fire/tire_fire_med", randomStartDelay );

	//map_source/prefabs/icbm/icbm_powerlinetower02.map
	global_FX( "icbm_powerlinetower_FX_origin", "icbm_powerlinetower_FX", "misc/power_tower_light_red_blink", randomStartDelay );

	//map_source/prefabs/icbm/icbm_powerlinetower02.map
	global_FX( "icbm_mainframe_FX_origin", "icbm_mainframe_FX", "props/icbm_mainframe_lightblink", randomStartDelay );

	//map_source/prefabs/misc_model/cs_cargoship_wall_light_red_pulse.map
	global_FX( "light_pulse_red_FX_origin", "light_pulse_red_FX", "misc/light_glow_red_generic_pulse", -2 );

	//map_source/prefabs/misc_model/cs_cargoship_wall_light_red_pulse.map
	global_FX( "light_pulse_red_FX_origin", "light_pulse_red_FX", "misc/light_glow_red_generic_pulse", -2 );

	//map_source/prefabs/misc_model/cs_cargoship_wall_light_orange_pulse.map
	global_FX( "light_pulse_orange_FX_origin", "light_pulse_orange_FX", "misc/light_glow_orange_generic_pulse", -2 );


}
r_outdoor_feather()
{
	mapname = GetDvar( "mapname" );
	
	SetSavedDvar( "r_outdoorfeather", "8" );
	
	switch( mapname )
	{
	case "mp_discovery":
		SetSavedDvar( "r_outdoorfeather", "80" );
	break;
	
	case "mp_outskirts":
		SetSavedDvar( "r_outdoorfeather", "80" );
	break;
	}
}

wind_initial_setting()
{
	mapname = GetDvar( "mapname" );

	SetSavedDvar( "enable_global_wind", 1 );				// enable wind for your level
	SetSavedDvar( "wind_global_vector", "-110 -150 -110" );	// change "0 0 0" to your wind vector
	SetSavedDvar( "wind_global_low_altitude", -175 );		// change 0 to your wind's lower bound
	SetSavedDvar( "wind_global_hi_altitude", 4000 );		// change 10000 to your wind's upper bound
	SetSavedDvar( "wind_global_low_strength_percent", .5 );	// change 0.5 to your desired wind strength percentage
	SetSavedDvar( "r_outdoorfeather", "8" );
	
	switch( mapname )
	{
		case "mp_cosmodrome":
		case "mp_nuked":
			SetSavedDvar( "wind_global_vector", "1 0 0" );
			SetSavedDvar( "wind_global_low_altitude", 0 );
			SetSavedDvar( "wind_global_hi_altitude", 0 );	
			SetSavedDvar( "wind_global_low_strength_percent", 1 );
		break;

		case "mp_cracked":
		case "mp_crisis":
			SetSavedDvar( "wind_global_vector", "-110 -100 -110" );
		break;

		case "mp_duga":
			SetSavedDvar( "wind_global_vector", "-90 -100 -90" );
		break;
			
		case "mp_firingrange":
			SetSavedDvar( "wind_global_vector", "-125 -175 -125" );
		break;

		case "mp_hanoi":
			SetSavedDvar( "wind_global_vector", "-80 -90 -80" );
		break;

		case "mp_havoc":
			SetSavedDvar( "wind_global_vector", "-95 -125 -95" );
		break;

		case "mp_radiation":
			SetSavedDvar( "wind_global_vector", "-90 -80 -80" );
		break;

		case "mp_russianbase":
			SetSavedDvar( "wind_global_vector", "-110 -160 -140" );
		break;

		case "mp_villa":
			SetSavedDvar( "wind_global_vector", "-125 -150 -125" );
		break;
					
		case "mp_stadium":
			SetSavedDvar( "wind_global_vector", "-115 -115 -115" );
		break;
				
		case "mp_discovery":
			SetSavedDvar( "wind_global_vector", "-120 -85 -120" );		
		break;
		
		case "mp_outskirts":
			SetSavedDvar( "wind_global_vector", "-120 -115 -120" );		
		break;
		
		case "mp_hotel":
			SetSavedDvar( "wind_global_vector", "-120 -115 -120" );		
		break;
		
		case "mp_gridlock":
			SetSavedDvar( "wind_global_vector", "-125 -115 -125" );		
		break;
		
		case "mp_zoo":
			SetSavedDvar( "wind_global_vector", "-125 -115 -125" );		
		break;
		
		case "mp_area51":
			SetSavedDvar( "wind_global_vector", "-125 -115 -125" );		
		break;
		
		case "mp_golfcourse":
			SetSavedDvar( "wind_global_vector", "-140 -115 -140" );		
		break;
		
		case "mp_drivein":
			SetSavedDvar( "wind_global_vector", "-100 -100 -100" );		
		break;
		
		case "mp_silo":
			SetSavedDvar( "wind_global_vector", "-125 -115 -125" );		
		break;
	}
}

global_FX( targetname, fxName, fxFile, delay, soundalias )
{
	// script_structs
	ents = getstructarray(targetname,"targetname");
	if ( !isdefined( ents ) )
		return;
	if ( ents.size <= 0 )
		return;
	
/#
	if( getdvarint( #"debug_fx" ) > 0 )
	{
	println("*** Client : _global_FX - creating " + ents.size + " globalFX " + fxName);
	}	
#/			
	
	for ( i = 0 ; i < ents.size ; i++ )
	{
		ent = ents[i] global_FX_create( fxName, fxFile, delay, soundalias );
		if ( !isdefined( ents[ i ].script_noteworthy ) )
			continue;
			
		note = ents[ i ].script_noteworthy;
		if ( !isdefined( level._global_fx_ents[ note ] ) )
		{
			level._global_fx_ents[ note ] = [];
		}
		
		level._global_fx_ents[ note ][ level._global_fx_ents[ note ].size ] = ent;
	}
}

global_FX_create( fxName, fxFile, delay, soundalias )
{
	if ( !isdefined( level._effect ) )
		level._effect = [];
	if ( !isdefined( level._effect[ fxName ] ) )
		level._effect[ fxName ]	= LoadFX( fxFile );
	
	// default effect angles if they dont exist
	if ( !isdefined( self.angles ) )
		self.angles = ( 0, 0, 0 );
	
	ent = clientscripts\mp\_fx::createOneshotEffect( fxName );
	ent.v[ "origin" ] = ( self.origin );
	ent.v[ "angles" ] = ( self.angles );
	ent.v[ "fxid" ] = fxName;
	ent.v[ "delay" ] = delay;
	if ( isdefined( soundalias ) )
	{
		ent.v[ "soundalias" ] = soundalias;
	}
	return ent;	
}
	