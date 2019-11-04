
declare sub INIT_MOUSE()
'declare sub DESTROY_MOUSE()
declare sub UPDATE_MOUSE()

sub INIT_MOUSE()
	MOUSE.RESULT = getmouse( MOUSE.X, MOUSE.Y, MOUSE.W, MOUSE.B, MOUSE.CLIP )
	MOUSE.PREVIOUS_B = MOUSE.B
end sub

'sub DESTROY_MOUSE()
'end sub

sub UPDATE_MOUSE()
	MOUSE.PREVIOUS_B = MOUSE.B
	MOUSE.RESULT = getmouse( MOUSE.X, MOUSE.Y, MOUSE.W, MOUSE.B, MOUSE.CLIP )
	
	if MOUSE.RESULT = 0 then
		if ( ( MOUSE.B and 1 ) or ( MOUSE.B and 2 ) ) and _
			 ( MOUSE.PREVIOUS_B = 0 ) then
			MOUSE.REGISTER = true
		else
			MOUSE.REGISTER = false
		end if
	end if
end sub