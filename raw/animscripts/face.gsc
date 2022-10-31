// face.gsc
// Supposed to handle all facial and dialogue animations from regular scripts.
//#using_animtree ("generic_human"); - This file doesn't call animations directly.

#include common_scripts\utility;

SayGenericDialogue(typeString)
{
	switch (typeString)
	{
	case "kill_melee":
		importance = 0.5;
		break;
	case "flashbang":
		importance = 0.7;
		break;
	case "pain":
		importance = 0.4;
		break;
	case "death":
		wait(.01); //make sure dialog system has had a chance to deal with death before we play another line.
		importance = 1.5;
		break;
	default:
		println ("Unexpected generic dialog string: "+typeString);
		importance = 0.3;
		break;
	}

	SayGenericDialogueWithImportance(typeString, importance);
}

// Makes a character say the specified line in his voice, if he's not already saying something more 
// important.  
SayGenericDialogueWithImportance(typeString, importance)
{
	soundAlias = "dds_";

	if( IsDefined( self.dds_characterID ) )
	{
		soundAlias += self.dds_characterID;
	}
	else
	{
		printLn( "this AI does not have a dds_characterID" );
		return;
	}

	soundAlias += "_" + typeString;

	if(SoundExists(soundAlias))
	{
		self thread PlayFaceThread (undefined, soundAlias, importance);
	}
}

SetIdleFaceDelayed(facialAnimationArray)
{
	//self animscripts\battleChatter::playBattleChatter();
	
	self.a.idleFace = facialAnimationArray;
}

// Sets the facial expression to return to when not saying dialogue.
// The array is animation1, weight1, animation2, weight2, etc.  The animations will play in turn - each time 
// one finishes a new one will be chosen randomly based on weight.
SetIdleFace(facialAnimationArray)
{
	if (!anim.useFacialAnims)
	{
		return;
	}

	//self animscripts\battleChatter::playBattleChatter();
	
	self.a.idleFace = facialAnimationArray;
	self PlayIdleFace();
}

// Makes the character play the specified sound and animation.  The anim and the sound are optional - you 
// can just defined one if you don't have both.
// Generally, importance should be in the range of 0.6-0.8 for scripted dialogue.
// Importance is a float, from 0 to 1.  
// 0.0 - Idle expressions
// 0.1-0.5 - most generic dialogue
// 0.6-0.8 - most scripted dialogue 
// 0.9 - pain
// 1.0 - death
// Importance can also be one of these strings: "any", "pain" or "death", which specfies what sounds can 
// interrupt this one.
SaySpecificDialogue(facialanim, soundAlias, importance, notifyString, waitOrNot, timeToWait)
{
	///("SaySpecificDialog, facial: ",facialanim,", sound: ",soundAlias,", importance: "+importance+", notify: ",notifyString, ", WaitOrNot: ", waitOrNot, ", timeToWait: ", timeToWait);#/
	self thread PlayFaceThread (facialanim, soundAlias, importance, notifyString, waitOrNot, timeToWait);
}

// Takes an array with a set of "anim" entries and a corresponding set of "weight" entries.
ChooseAnimFromSet( animSet )
{
	return;	// Facial animations are now part of full body aniamtions
/*
	if (!anim.useFacialAnims)
		return;
	// First, normalize the weights.
	totalWeight = 0;
	numAnims = animSet["anim"].size;
	for ( i=0 ; i<numAnims ; i++ )
	{
		totalWeight += animSet["weight"][i];
	}
	for ( i=0 ; i<numAnims ; i++ )
	{
		animSet["weight"][i] = animSet["weight"][i] / totalWeight;
	}

	// Now choose an animation.
	rand = RandomFloat(1);
	runningTotal = 0;
	chosenAnim = undefined;
	for ( i=0 ; i<numAnims ; i++ )
	{
		runningTotal += animSet["weight"][i];
		if (runningTotal >= rand)
		{
			chosenAnim = i;
			break;
		}
	}
	assertEX(IsDefined(chosenAnim), "Logic error in ChooseAnimFromSet.  Rand is " + rand + ".");
	return animSet["anim"][chosenAnim];
*/
}



//-----------------------------------------------------
// Housekeeping functions - these are for internal use
//-----------------------------------------------------

// PlayIdleFace doesn't force an idle animation to play - it will interrupt a current idle animation, but it 
// won't play over a more important animation, like dialogue.
PlayIdleFace()
{
	return;	// Idle facial animations are now in the full-body animations.
}

// PlayFaceThread is the workhorse of the system - it checks the importance, and if it's high enough, it 
// plays the animation and/or sound specified.
// The waitOrNot parameter specifies what to do if another animation/sound is already playing.
// Options: "wait" or undefined.  TimeToWait is an optional timeout time for waiting.
// Waiting faces are queued.
PlayFaceThread(facialanim, soundAlias, importance, notifyString, waitOrNot, timeToWait)
{
	//NOTE most of the described functionality was removed in COD2 (!)
	//Talk about misleading comments...
	//This must be called in it's own thread.
	//
	//The behavior has been simplifed greatly
	//  lines never wait
	//  a line stops the current line if at equal or higher priority
	//  a line doesn't play if at lower priority
	//SBM 8/3/08
	
	
	if(!IsDefined(soundAlias))
	{
		wait(1);
		self notify(notifyString);
		return; //no sound, don't do anything facials are now included into the main anims
	}

	if(!IsDefined(level.NumberOfImportantPeopleTalking))
	{
		level.NumberOfImportantPeopleTalking = 0;
	}

	if(!IsDefined(level.TalkNotifySeed))
	{
		level.TalkNotifySeed = 0;
	}

	if(!IsDefined(notifyString))
	{
		
		notifyString = "PlayFaceThread "+soundAlias;
	}

	if( !IsDefined( self.a ) )
	{
		self.a = SpawnStruct();
	}

	if(!IsDefined(self.a.facialSoundDone))
	{		
		self.a.facialSoundDone = true;
	}

	if(!IsDefined(self.isTalking))
	{
		self.isTalking = false;
	}

	if(self.isTalking) //currently talking
	{
		//TUEY added equal to, so that the system won't spam the same notifies
		if(importance < self.a.currentDialogImportance)
		{
			wait(1);
			self notify(notifyString);
			return; //skip it cause its not important
		}
		else if(importance == self.a.currentDialogImportance)
		{
			if(self.a.facialSoundAlias==soundAlias)
			{
				return; //playing same alias twice? probably a script error somewhere
			}

			println("WARNING: delaying alias "+self.a.facialSoundAlias+" to play "+soundAlias);

			while(IsDefined(self) && self.isTalking)  //while is to fix a race condition
			{
				self waittill("done speaking" ); //wait currently playing thread to finish
			}

			if(!IsDefined(self))
			{
				return;
			}
		}
		else
		{
			println("WARNING: interrupting alias "+self.a.facialSoundAlias+" to play "+soundAlias);
			self stopSound(self.a.facialSoundAlias);
			self notify("cancel speaking");

			while(IsDefined(self) && self.isTalking) //while is to fix a race condition
			{
				self waittill("done speaking"); //wait currently playing thread to finish
			}

			if(!IsDefined(self))
			{
				return;
			}
		}
	}

	assert(self.a.facialSoundDone);
	assert(self.a.facialSoundAlias == undefined);
	assert(self.a.facialSoundNotify == undefined);
	assert(self.a.currentDialogImportance == undefined);
	assert(!self.isTalking);

	self.isTalking = true;
	self.a.facialSoundDone = false;
	self.a.facialSoundNotify = notifyString;
	self.a.facialSoundAlias = soundAlias;
	self.a.currentDialogImportance = importance;

	if(importance == 1.0)
	{
		level.NumberOfImportantPeopleTalking += 1;
	}

	if(level.NumberOfImportantPeopleTalking > 1)
	{
		println("WARNING: multiple high priority dialogs are happening at once "+ soundAlias);
	}

	// MikeD (8/22/2007): This will print on top of the self's head what we want to be here.
	//self thread temp_dialogue_print( soundAlias );

	uniqueNotify = notifyString + " "+level.TalkNotifySeed;

	level.TalkNotifySeed += 1;

	play_sound = true;

	if(!SoundExists(soundAlias))
	{
		println("Warning: "+soundAlias+" does not exist");

		if( IsString( soundAlias ) && ( "vox_" != GetSubStr( soundAlias, 0, 4 ) ) ) //do not want to display alias names
		{
			play_sound = false;
			self thread display_vo(soundAlias, uniqueNotify);
		}
	}

	if (play_sound)
	{
		self PlaySound(soundAlias, uniqueNotify, true);
	}

	self waittill_any("death", "cancel speaking", uniqueNotify);

	if(importance == 1.0)
	{
		level.NumberOfImportantPeopleTalking -= 1;
		level.ImportantPeopleTalkingTime = GetTime();
	}

	if(IsDefined(self))
	{
		self.isTalking = false;
		self.a.facialSoundDone = true;
		self.a.facialSoundNotify = undefined;
		self.a.facialSoundAlias = undefined;
		self.a.currentDialogImportance = undefined;
		self.lastSayTime = GetTime();
	}

	self notify( "done speaking"  );
	self notify(notifyString);
}

display_vo(vo_string, uniqueNotify)
{
	if (!IsDefined(level.vo_hud))
	{
		level.vo_hud = NewHudElem();
		level.vo_hud.fontscale = 2;
		level.vo_hud.horzAlign = "center";
		level.vo_hud.vertAlign = "middle";
		level.vo_hud.alignX = "center"; 
		level.vo_hud.alignY = "middle";
		level.vo_hud.y = 180;
	}

	name = "";
	if (IsDefined(self.name))
	{
		name = self.name;
	}
	else if (IsDefined(self.animname))
	{
		name = self.animname;
	}

	level.vo_hud SetText(name + ": " + vo_string);

	wait (vo_string.size / 6);
	
	level.vo_hud SetText("");

	self notify(uniqueNotify);
}

// MikeD (8/22/2007): This will print on top of the self's head what we want to be here.
///# // <- MikeD: Put this back in before we ship!
temp_dialogue_print( soundAlias )
{
	self endon( "death" );

	new_string = "";
	if( IsSubStr( soundAlias, "print:" ) )
	{
		// Take out the print:
		if( IsDefined( self.name ) )
		{
			name = self.name + ": ";
		}
		else
		{
			name = "NO-NAMER: ";				
		}

		for( i = 6; i < soundAlias.size; i++ )
		{
			new_string = new_string + soundAlias[i];
		}

		/#
		iprintln( name + new_string );
		#/
		println( "^3TEMP DIALOGUE - " + name + new_string );		
	}
	else
	{
		new_string = soundAlias;
	}

	self notify( "stop_temp_dialogue_print" );
	self endon( "stop_temp_dialogue_print" );

	// Now print over self's head
	size = new_string.size;

	time = GetTime() + 3000;
	if( size > 25 )
	{
		time = GetTime() + ( size * 0.1 * 1000 );
	}

	while( GetTime() < time )
	{
		Print3d( self.origin + ( 0, 0, 72 ), new_string );
		wait( 0.05 );
	}
}

PlayFace_WaitForNotify(waitForString, notifyString, killmeString)
{
	self endon ("death");
	self endon (killmeString);
	self waittill (waitForString);
	self.a.faceWaitForResult = "notify";
	self notify (notifyString);
}

PlayFace_WaitForTime(time, notifyString, killmeString)
{
	self endon ("death");
	self endon (killmeString);
	wait (time);
	self.a.faceWaitForResult = "time";
	self notify (notifyString);
}

#using_animtree ("generic_human"); // This section of the file calls animations directly since it's only used on AI.
InitLevelFace()
{
}