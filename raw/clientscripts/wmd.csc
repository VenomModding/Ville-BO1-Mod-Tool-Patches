// Test clientside script for wmd

#include clientscripts\_utility;
#include clientscripts\_filter;

main()
{

	// Keep this here for CreateFX
	clientscripts\wmd_fx::main();
	
	level._uses_crossbow = true;
	
	// _load!
	clientscripts\_load::main();
	
	register_clientflag_callback("scriptmover", 0, ::scriptmover_flag0_handler);
	register_clientflag_callback("scriptmover", 1, ::scriptmover_flag1_handler);
	register_clientflag_callback("scriptmover", 2, ::scriptmover_flag2_handler);
	register_clientflag_callback("scriptmover", 3, ::scriptmover_flag3_handler);
	register_clientflag_callback("scriptmover", 4, ::scriptmover_flag4_handler);
	register_clientflag_callback("scriptmover", 6, ::scriptmover_flag6_handler);
	register_clientflag_callback("scriptmover", 8, ::scriptmover_flag8_handler);
	register_clientflag_callback("scriptmover", 9, ::scriptmover_flag9_handler);

	//thread clientscripts\_fx::fx_init(0);
	thread clientscripts\_audio::audio_init(0);

	thread clientscripts\wmd_amb::main();

	// This needs to be called after all systems have been registered.
	thread waitforclient(0);

	println("*** Client : wmd running...");
	
	level thread setup_fullscreen_postfx();
	
	level thread handle_basejump_fov();
	level thread reset_basejump_fov(); // -- WWILLIAMS: CHANGE THE FOV BACK TO NORMAL AFTER BASE JUMP
	
	thread dyn_light_glow();
	
	level thread setup_wristwatch();

}

scriptmover_flag0_handler(localClientNum, set, newEnt)
{
	if(set)
	{				
		self mapshaderconstant( localClientNum, 0, "scriptVector1" ); // <-- the '+' reticule
		self mapshaderconstant( localClientNum, 1, "scriptVector0" ); // <-- the background overlay
		//self mapshaderconstant( localClientNum, 2, "scriptVector2" ); // <-- the ( zoom( float ), origin (x ),origin(y), zoom brightness scaler( 0) )
		
		self setshaderconstant( localClientNum, 0, 1, 1, 1, 1 );
		self setshaderconstant( localClientNum, 1, 1, 1, 1, 1 ); 
		
	}
	else
	{
		self mapshaderconstant( localClientNum, 0, "scriptVector1" );
		//self mapshaderconstant( localClientNum, 1, "scriptVector0" );
		
		self setshaderconstant( localClientNum, 0, 1, .05, 0.05, 1 );
		//self setshaderconstant( localClientNum, 1, .8, .8, .8, .7 );

	}	
}

scriptmover_flag1_handler(localClientNum, set, newEnt)
{
	if(set)
	{
		wait(.05);
		StopExtraCam(0);
		self isExtraCam(0);
		SetExtraCamFov( 0, 35 );
	}
	else
	{
		StopExtraCam(0);
	}	
}

scriptmover_flag2_handler(localClientNum, set, newEnt)
{
	if(set)
	{
		self mapshaderconstant( localClientNum, 0, "scriptVector1" ); // <-- the '+' reticule
		self setshaderconstant( localClientNum, 0, .05, 1, .05, 1 );
	}
	else
	{
		self mapshaderconstant( localClientNum, 0, "scriptVector1" ); // <-- the '+' reticule
		self setshaderconstant( localClientNum, 0, .9, .9, .6, .9 );
	}	
}


scriptmover_flag3_handler(localClientNum, set, newEnt)
{
	if(set)
	{
		self notify("stop_fov_inc");
		self thread increase_fov();
	}
	else
	{
		self notify("stop_fov_inc");
	}	
}
	
scriptmover_flag4_handler(localClientNum, set, newEnt)
{
	if(set)
	{
		self notify("stop_fov_dec");
		self thread decrease_fov();
	}
	else
	{
		self notify("stop_fov_dec");
	}
}

scriptmover_flag6_handler(localClientNum, set, newEnt)
{
	if (set)
	{
		self player_rope_scroll(localClientNum);
	}
	else
	{
		self notify("stop_player_rope_scroll");
	}	
}

scriptmover_flag8_handler(localClientNum, set, newEnt)
{
	if(set)
	{
		self mapshaderconstant( localClientNum, 2, "scriptVector2" ); // <-- the ( zoom( float ), origin (x ),origin(y), zoom brightness scaler( 0) )
		self setshaderconstant( 0, 2, 0, 0.75,0.25,0);
	}	
}

scriptmover_flag9_handler(localClientNum, set, newEnt)
{
	if(set)
	{
		self mapshaderconstant( localClientNum, 2, "scriptVector2" );
		zoom_in_out_brightness();
	}
	else
	{
		self mapshaderconstant( localClientNum, 2, "scriptVector2" );
		self thread brightness_decrease();
	}	
}

setup_fullscreen_postfx()
{
	waitforclient(0);
	
	init_filter_scope( getlocalplayers()[0] );
	init_filter_frost( getlocalplayers()[0] );
	//init_filter_superflare( getlocalplayers()[0] );
	//enable_filter_superflare( getlocalplayers()[0], 1 );
			

	level thread jump_goggles_listener();
	level thread frost_overlay();
}



jump_goggles_listener()
{
	level thread jump_goggles_cleanup();
	
	jump_goggles = false;
	
	while( 1 )
	{
		level waittill( "toggle_jump_goggles" );
		
		if( !jump_goggles )
		{
			level thread do_jump_frost_update();
			enable_filter_frost( getlocalplayers()[0], 0, 0.0 );
			
			jump_goggles = true;
		}
		else
		{
			level notify( "kill_jump_goggles" );
			//disable_filter_frost( getlocalplayers()[0], 0 );
			jump_goggles = false;
		}
		wait( 0.05 );
	}
}

do_jump_frost_update()
{
	level endon( "kill_jump_goggles" );
	
	start_opacity = 0.0;
	final_opacity = 0.3; // -- WWILLIAMS: ORIGINAL - 0.4
	time_to_max = 4; // -- WWILLIAMS: ORIGINAL - 3
	curr_time = 0;
	
	while( 1 )
	{
		opacity = start_opacity + (final_opacity - start_opacity) * curr_time / time_to_max;
		
		if( opacity < start_opacity )
		{
			opacity = start_opacity;
		}
		if( opacity > final_opacity )
		{
			opacity = final_opacity;
		}
		
		curr_time += 0.02;
		PrintLn( "opacity: "+opacity );
		set_filter_frost_opacity( getlocalplayers()[0], 0, opacity );
		wait( 0.02 );
	}
}


do_frost_diminish()
{
	opacity = 0.3;
	inc = 0.01;
	
	while(opacity > 0)
	{
		opacity -= inc;
		PrintLn( "opacity: "+opacity );
		set_filter_frost_opacity( getlocalplayers()[0], 0, opacity );
		wait(0.05);
	}
}


jump_goggles_cleanup()
{
	while( 1 )
	{
		level waittill( "kill_jump_goggles" );
		
		do_frost_diminish();
		
		disable_filter_frost( getlocalplayers()[0], 0 );
	}
}


frost_overlay()
{
	level waittill("frost_overlay_on");
	
	enable_filter_frost( getlocalplayers()[0], 0, 0.0 );
	
	level waittill("frost_overlay_off");
	
	disable_filter_frost( getlocalplayers()[0], 0 );
}

// -- WWILLIAMS: CHANGES THE FOV FOR THE PLAYER DURING THE BASE JUMP
handle_basejump_fov()
{
	level waittill( "start_basejump_fov" );
	fov = 65;
	fov_min = 55;
	inc = 25;
	target = 95;
	timestep = 0.01;
	level.current_fov = 0;
	
	wait( 1.5 );
	
	/*
	while( fov > fov_min )
	{
		fov -= inc*timestep;
		PrintLn( "current fov: "+fov );
		SetClientDvar( "cg_fov", fov );
		wait( timestep );
	}
	*/
	
	while( fov < target ) // while the fov is lower than the target number
	{
		fov += inc*timestep; // add the result of inc*timestep to fov
		PrintLn( "current fov: "+fov ); // tell me what the fov will change to
		level.current_fov = fov; // save the current fov in order to change it back later
		SetClientDvar( "cg_fov", fov ); // change the fov
		wait( timestep ); // wait the timestep amount before looping back up
	}
}

// -- WWILLIAMS: CHANGES THE FOV BACK TO NORMAL AFTER THE BASE JUMP IS COMPLETE
reset_basejump_fov()
{
	level waittill( "reset_fov" );
	
	default_fov = 65;
	inc = 25;
	timestep = 0.01;
	
	while( level.current_fov > default_fov )
	{
		level.current_fov -= inc*timestep; // reduce the current fov by inc*timestep(.25)
		PrintLn( "current_fov: " + level.current_fov );
		SetClientDvar( "cg_fov", level.current_fov ); // actually changes the fov
		wait( timestep );
	}
	
	PrintLn( "FOV should be back to normal" );
}

brightness_decrease()
{
	self endon("end_decrease");
	level endon("end_rts");
				
	if(!isDefined(self.is_decreasing ))
	{
		self.is_decreasing = 1;
		for(i=11;i>0;i--)
		{
			self mapshaderconstant( 0, 2, "scriptVector2" ); // <-- the ( zoom( float ), origin (x ),origin(y), zoom brightness scaler( 0) )
			val = i*.1;
			if(i * .1 < 0)
			{
				val = 0;
			}
			self setshaderconstant( 0, 2, 1, 0.75,0.25,val);
			wait(.05);
		}
		self.is_decreasing = undefined;
	}
}

brightness_set()
{
	level endon("end_rts");
	for(i=0;i<10;i++)
	{
		self mapshaderconstant( 0, 2, "scriptVector2" ); // <-- the ( zoom( float ), origin (x ),origin(y), zoom brightness scaler( 0) )
		self setshaderconstant( 0, 2, 1, 0.75,0.25,i * .1);
		wait(.05);
	}
}


zoom_in_out_brightness()
{
	self notify("end_decrease");
	self mapshaderconstant( 0, 2, "scriptVector2" ); // <-- the ( zoom( float ), origin (x ),origin(y), zoom brightness scaler( 0) )
	self setshaderconstant( 0, 2, 1, 0.75,0.25,.75);
}

increase_fov()
{
	level endon("end_rts");
	self endon("stop_fov_inc");
	if(!isDefined(self.cur_fov))
	{
		self.cur_fov = 35;
	}				

	while(1 )
	{
		if(self.cur_fov + .5 < 60)
		{
			self.cur_fov += .5;	
		}
			else
		{
			self.cur_fov = 60;
		}
		SetExtraCamFov( 0,self.cur_fov);
		wait(.01);
	}			
}

decrease_fov()
{
	self endon("stop_fov_dec");	
	level endon("end_rts");
		
	if(!isDefined(self.cur_fov))
	{
		self.cur_fov = 35;
	}
				
	while(1)
	{
		if(self.cur_fov - .5 > 15)
		{
			self.cur_fov -= .5;
		}
		else
		{
			self.cur_fov = 15;
		}
		SetExtraCamFov( 0,self.cur_fov);
		wait(.01);
	}
		
	
}

// glow fx for dyn light in window breach room
dyn_light_glow()
{
	dent = getdynent( "swing_lamp" );
      
	PlayFXOnDynEnt( level._effect["dyn_light_glow"], dent );
}

//-- self = rope model
player_rope_scroll(localClientNum)
{
	self endon("stop_player_rope_scroll");
	self thread stop_player_rope_scroll();

	self MapShaderConstant(localClientNum, 3, "scriptVector3");

	//IPrintLnBold("scrolling rope");

	while (true)
	{
		//IPrintLnBold("player height: " + self.origin[2]);
		self SetShaderConstant( localClientNum, 3, self.origin[2], 0, 0, 0 );
		wait .01;
		waitforclient(0);	// make sure that we're set up properly following a save/restore.  DSL
	}
}

stop_player_rope_scroll()
{
	self waittill("stop_player_rope_scroll");
	//IPrintLnBold("STOP scrolling rope");
}

setup_wristwatch()
{
	while (1)
	{
		waitforclient(0);
		//setup the ui3d and wristwatch
		ui3dsetwindow( 0, 0, 0, 0.125, 0.25 );
		ui3dsetwindow( 1, 0.25, 0, 0.25, 0.5 );
		ui3dsetwindow( 2, 0.5, 0, 0.5, 0.5 );
		ui3dsetwindow( 3, 0, 0.5, 0.25, 0.5 );
		ui3dsetwindow( 4, 0.25, 0.5, 0.25, 0.5 );
		ui3dsetwindow( 5, 0.5, 0.5, 0.5, 0.5 );
		showUI(0, "WristWatch", 1);
		getlocalplayers()[0] SetWatchStyle(1);
		level waittill("save_restore");
	}
}
