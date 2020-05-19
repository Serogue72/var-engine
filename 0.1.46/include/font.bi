
declare sub INIT_FONT()
declare sub DESTROY_FONT()
declare function CUSTOM_CONVERT_FONT( byval _SOURCE_PIXEL as uinteger, _
                                      byval _DESTINATION_PIXEL as uinteger, _
                                      byval _PARAMETER as any ptr ) as uinteger
declare function CUSTOM_DRAW_CHARACTER( byval _SOURCE_PIXEL as uinteger, _
                                        byval _DESTINATION_PIXEL as uinteger, _
                                        byval _PARAMETER as any ptr ) as uinteger
declare sub DRAW_CHARACTER( byval _X as integer, _
                            byval _Y as integer, _
                            byval _COLOR as uinteger, _
                            byref _CHARACTER as ubyte )
declare sub DRAW_STRING( byval _X as integer, _
                         byval _Y as integer, _
                         byval _COLOR as uinteger, _
                         byref _STRING as string )

sub INIT_FONT()
  FONT.FONT_PTR = imagecreate( 2048, 12 )
  FONT.W = 8
  FONT.H = 12
  dim as udt_IMAGE ptr t_FONT_PTR = imagecreate( 128, 192 )
  bload "data/font.bmp", t_FONT_PTR
  
  dim as integer J
  for I as integer = 0 to 15
    J = I * 12
    put FONT.FONT_PTR, ( I * 128, 0 ), t_FONT_PTR, ( 0, J )-( 127, J + 11 ), custom, @CUSTOM_CONVERT_FONT
  next I
  imagedestroy t_FONT_PTR
end sub

sub DESTROY_FONT()
	imagedestroy FONT.FONT_PTR
end sub

function CUSTOM_CONVERT_FONT( byval _SOURCE_PIXEL as uinteger, _
                              byval _DESTINATION_PIXEL as uinteger, _
                              byval _PARAMETER as any ptr ) as uinteger
  if _SOURCE_PIXEL = rgb( 255, 255, 255 ) then
    return _SOURCE_PIXEL
  else
    return cast( uinteger, rgb( 255, 0, 255 ) )
  end if
end function

function CUSTOM_DRAW_CHARACTER( byval _SOURCE_PIXEL as uinteger, _
                                byval _DESTINATION_PIXEL as uinteger, _
                                byval _PARAMETER as any ptr ) as uinteger
  if _SOURCE_PIXEL = rgb( 255, 0, 255 ) then
    return _DESTINATION_PIXEL
  else
    return *cptr( uinteger ptr, _PARAMETER)
  end if
end function

sub DRAW_CHARACTER( byval _X as integer, _
                    byval _Y as integer, _
                    byval _COLOR as uinteger, _
                    byref _CHARACTER as ubyte )
	static as integer CHARACTER_X
	CHARACTER_X = _CHARACTER * FONT.W
  put DISPLAY.SOURCE_PTR( 0 ), ( _X * FONT.W, _Y * FONT.H ), FONT.FONT_PTR, ( CHARACTER_X, 0 )-( CHARACTER_X + FONT.W - 1, FONT.H - 1 ), custom, @CUSTOM_DRAW_CHARACTER, @_COLOR
end sub

sub DRAW_STRING( byval _X as integer, _
                 byval _Y as integer, _
                 byval _COLOR as uinteger, _
                 byref _STRING as string )
	static as ubyte CHARACTER
	static as integer I, CHARACTER_X, STRING_LENGTH
	STRING_LENGTH = len( _STRING )
	if STRING_LENGTH <> 0 then
		for I = 1 to STRING_LENGTH
			CHARACTER = asc( mid( _STRING, I, 1 ) )
			CHARACTER_X = CHARACTER * FONT.W
      put DISPLAY.SOURCE_PTR( 0 ), ( _X * FONT.W, _Y * FONT.H ), FONT.FONT_PTR, ( CHARACTER_X, 0 )-( CHARACTER_X + FONT.W - 1, FONT.H - 1 ), custom, @CUSTOM_DRAW_CHARACTER, @_COLOR
			_X = _X + 1
		next I
	end if
end sub