
sub INIT_MOUSE()
	MOUSE.RESULT = getmouse( MOUSE.X, MOUSE.Y, MOUSE.W, MOUSE.B, MOUSE.CLIP )
	MOUSE.PREVIOUS_B = MOUSE.B
end sub

sub UPDATE_MOUSE()
  static as integer tX, tY, tW, tB, tC
  
	MOUSE.PREVIOUS_B = MOUSE.B
	MOUSE.RESULT = getmouse( tX, tY, tW, tB, tC )
  if MOUSE.RESULT = 0 then
    MOUSE.X = tX
    MOUSE.Y = tY
    MOUSE.W = tW
    MOUSE.B = tB
    MOUSE.CLIP = tC
    
		if ( ( MOUSE.B and 1 ) or ( MOUSE.B and 2 ) ) and _
			 ( MOUSE.PREVIOUS_B = 0 ) then
			MOUSE.REGISTER = true
		else
			MOUSE.REGISTER = false
		end if
  end if
  DISPLAY.CURSOR_X = MOUSE.X / DISPLAY.MULTIPLIER
  DISPLAY.CURSOR_Y = MOUSE.Y / DISPLAY.MULTIPLIER
end sub