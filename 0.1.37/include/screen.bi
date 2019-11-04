
declare sub INIT_SCREEN()
declare sub DESTROY_SCREEN()

sub INIT_SCREEN()
	dim as integer RESOLUTION_LIST( 0 to 3, 0 to 1 )
	RESOLUTION_LIST( 0, 0 ) = 1280      ' x4
	RESOLUTION_LIST( 0, 1 ) = 720       ' x4
	RESOLUTION_LIST( 1, 0 ) = 1920      ' x6
	RESOLUTION_LIST( 1, 1 ) = 1080      ' x6
	RESOLUTION_LIST( 2, 0 ) = 2560      ' x8
	RESOLUTION_LIST( 2, 1 ) = 1440      ' x8
	RESOLUTION_LIST( 3, 0 ) = 3840      ' x12
	RESOLUTION_LIST( 3, 1 ) = 2160      ' x12
	
	dim as integer SCREEN_RESOLUTION( 0 to 1 )
	dim as integer DESKTOP_RESOLUTION( 0 to 1 )
	screeninfo DESKTOP_RESOLUTION( 0 ), DESKTOP_RESOLUTION( 1 )
	
	if ( RESOLUTION_LIST( 3, 0 ) < DESKTOP_RESOLUTION( 0 ) ) and _
     ( RESOLUTION_LIST( 3, 1 ) < DESKTOP_RESOLUTION( 1 ) ) then
		SCREEN_RESOLUTION( 0 ) = RESOLUTION_LIST( 3, 0 )
		SCREEN_RESOLUTION( 1 ) = RESOLUTION_LIST( 3, 1 )
		SCREEN_SIZE = 3
	else
		if ( RESOLUTION_LIST( 2, 0 ) < DESKTOP_RESOLUTION( 0 ) ) and _
       ( RESOLUTION_LIST( 2, 1 ) < DESKTOP_RESOLUTION( 1 ) ) then
			SCREEN_RESOLUTION( 0 ) = RESOLUTION_LIST( 2, 0 )
			SCREEN_RESOLUTION( 1 ) = RESOLUTION_LIST( 2, 1 )
			SCREEN_SIZE = 2
		else
			if ( RESOLUTION_LIST( 1, 0 ) < DESKTOP_RESOLUTION( 0 ) ) and _
         ( RESOLUTION_LIST( 1, 1 ) < DESKTOP_RESOLUTION( 1 ) ) then
				SCREEN_RESOLUTION( 0 ) = RESOLUTION_LIST( 1, 0 )
				SCREEN_RESOLUTION( 1 ) = RESOLUTION_LIST( 1, 1 )
				SCREEN_SIZE = 1
			else
				SCREEN_RESOLUTION( 0 ) = RESOLUTION_LIST( 0, 0 )
				SCREEN_RESOLUTION( 1 ) = RESOLUTION_LIST( 0, 1 )
				SCREEN_SIZE = 0
			end if
		end if
	end if
  
	SCREEN_RESOLUTION( 0 ) = 320
	SCREEN_RESOLUTION( 1 ) = 180
	SCREEN_SIZE = 99
	
	screencontrol 103, "GDI"
	screenres SCREEN_RESOLUTION( 0 ), _
            SCREEN_RESOLUTION( 1 ), _
            32,, _
            &h04
end sub

sub DESTROY_SCREEN()
	screen 0
end sub