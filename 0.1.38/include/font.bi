
declare sub INIT_FONT()
declare sub DESTROY_FONT()
declare function CUSTOM_CONVERT_FONT( byval _SOURCE_PIXEL as uinteger, _
                                      byval _DESTINATION_PIXEL as uinteger, _
                                      byval _PARAMETER as any ptr ) as uinteger
declare function CUSTOM_DRAW_CHARACTER( byval _SOURCE_PIXEL as uinteger, _
                                        byval _DESTINATION_PIXEL as uinteger, _
                                        byval _PARAMETER as any ptr ) as uinteger
declare sub DRAW_CHARACTER( byval _SIZE as integer, _
                            byval _X as integer, _
                            byval _Y as integer, _
                            byval _COLOR as uinteger, _
                            byref _CHARACTER as ubyte )
declare sub DRAW_STRING( byval _SIZE as integer, _
                         byval _X as integer, _
                         byval _Y as integer, _
                         byval _COLOR as uinteger, _
                         byref _STRING as string )

sub INIT_FONT()
	dim as integer I, J
	select case DISPLAY.MULTIPLIER
	case 0
		DRAW_CHARACTER_W( 0 ) = 8
		DRAW_CHARACTER_H( 0 ) = 12
		DRAW_CHARACTER_W( 1 ) = 16
		DRAW_CHARACTER_H( 1 ) = 24
		FONT_SMALL = imagecreate( 2048, 12 )
		FONT_LARGE = imagecreate( 4096, 24 )
		dim as udt_IMAGE ptr T_SMALL = imagecreate( 128, 192 )
		dim as udt_IMAGE ptr T_LARGE = imagecreate( 256, 384 )
		bload "font/font_192.bmp", T_SMALL
		bload "font/font_384.bmp", T_LARGE
		for I = 0 to 15
			J = I * 12
			put FONT_SMALL, ( I * 128, 0 ), T_SMALL, ( 0, J )-( 127, J + 11 ), custom, @CUSTOM_CONVERT_FONT
		next I
		for I = 0 to 15
			J = I * 24
			put FONT_LARGE, ( I * 256, 0 ), T_LARGE, ( 0, J )-( 255, J + 23 ), custom, @CUSTOM_CONVERT_FONT
		next I
		imagedestroy T_SMALL
		imagedestroy T_LARGE
	case 1
		DRAW_CHARACTER_W( 0 ) = 12
		DRAW_CHARACTER_H( 0 ) = 18
		DRAW_CHARACTER_W( 1 ) = 24
		DRAW_CHARACTER_H( 1 ) = 36
		FONT_SMALL = imagecreate( 3072, 18 )
		FONT_LARGE = imagecreate( 6144, 36 )
		dim as udt_IMAGE ptr T_SMALL = imagecreate( 192, 288 )
		dim as udt_IMAGE ptr T_LARGE = imagecreate( 384, 576 )
		bload "font/font_288.bmp", T_SMALL
		bload "font/font_576.bmp", T_LARGE
		for I = 0 to 15
			J = I * 18
			put FONT_SMALL, ( I * 192, 0 ), T_SMALL, ( 0, J )-( 191, J + 17 ), custom, @CUSTOM_CONVERT_FONT
		next I
		for I = 0 to 15
			J = I * 36
			put FONT_LARGE, ( I * 384, 0 ), T_LARGE, ( 0, J )-( 383, J + 35 ), custom, @CUSTOM_CONVERT_FONT
		next I
		imagedestroy T_SMALL
		imagedestroy T_LARGE
	case 2
		DRAW_CHARACTER_W( 0 ) = 16
		DRAW_CHARACTER_H( 0 ) = 24
		DRAW_CHARACTER_W( 1 ) = 32
		DRAW_CHARACTER_H( 1 ) = 48
		FONT_SMALL = imagecreate( 4096, 24 )
		FONT_LARGE = imagecreate( 8192, 48 )
		dim as udt_IMAGE ptr T_SMALL = imagecreate( 256, 384 )
		bload "font/font_384.bmp", T_SMALL
		for I = 0 to 15
			J = I * 24
			put FONT_SMALL, ( I * 256, 0 ), T_SMALL, ( 0, J )-( 255, J + 23 ), custom, @CUSTOM_CONVERT_FONT
		next I
		for I = 0 to 4095
			for J = 0 to 23
				line FONT_LARGE, ( I * 2, J * 2 )-( ( I * 2 ) + 1, ( J * 2 ) + 1 ), point( I, J, FONT_SMALL ), B
			next J
		next I
		imagedestroy T_SMALL
	case 3
		DRAW_CHARACTER_W( 0 ) = 24
		DRAW_CHARACTER_H( 0 ) = 36
		DRAW_CHARACTER_W( 1 ) = 48
		DRAW_CHARACTER_H( 1 ) = 72
		FONT_SMALL = imagecreate( 6144, 36 )
		FONT_LARGE = imagecreate( 12288, 72 )
		dim as udt_IMAGE ptr T_SMALL = imagecreate( 384, 576 )
		bload "font/font_576.bmp", T_SMALL
		for I = 0 to 15
			J = I * 36
			put FONT_SMALL, ( I * 384, 0 ), T_SMALL, ( 0, J )-( 383, J + 35 ), custom, @CUSTOM_CONVERT_FONT
		next I
		for I = 0 to 6143
			for J = 0 to 35
				line FONT_LARGE, ( I * 2, J * 2 )-( ( I * 2 ) + 1, ( J * 2 ) + 1 ), point( I, J, FONT_SMALL ), B
			next J
		next I
		imagedestroy T_SMALL
	case 99
		DRAW_CHARACTER_W( 0 ) = 2
		DRAW_CHARACTER_H( 0 ) = 3
		DRAW_CHARACTER_W( 1 ) = 4
		DRAW_CHARACTER_H( 1 ) = 6
		FONT_SMALL = imagecreate( 512, 3 )
		FONT_LARGE = imagecreate( 1024, 6 )
		dim as udt_IMAGE ptr T_SMALL = imagecreate( 32, 48 )
		dim as udt_IMAGE ptr T_LARGE = imagecreate( 64, 96 )
		bload "font/font_48.bmp", T_SMALL
		bload "font/font_96.bmp", T_LARGE
		for I = 0 to 15
			J = I * 3
			put FONT_SMALL, ( I * 32, 0 ), T_SMALL, ( 0, J )-( 31, J + 2 ), custom, @CUSTOM_CONVERT_FONT
		next I
		for I = 0 to 15
			J = I * 6
			put FONT_LARGE, ( I * 64, 0 ), T_LARGE, ( 0, J )-( 63, J + 5 ), custom, @CUSTOM_CONVERT_FONT
		next I
		imagedestroy T_SMALL
		imagedestroy T_LARGE
  end select
end sub

sub DESTROY_FONT()
	imagedestroy FONT_SMALL
	imagedestroy FONT_LARGE
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

sub DRAW_CHARACTER( byval _SIZE as integer, _
                    byval _X as integer, _
                    byval _Y as integer, _
                    byval _COLOR as uinteger, _
                    byref _CHARACTER as ubyte )
	static as integer CHARACTER_X
	CHARACTER_X = _CHARACTER * DRAW_CHARACTER_W( _SIZE )
  if _SIZE = 0 then
  	put( _X * DRAW_CHARACTER_W( _SIZE ), _Y * DRAW_CHARACTER_H( _SIZE ) ), FONT_SMALL, ( CHARACTER_X, 0 )-( CHARACTER_X + DRAW_CHARACTER_W( _SIZE ) - 1, DRAW_CHARACTER_H( _SIZE ) - 1 ), custom, @CUSTOM_DRAW_CHARACTER, @_COLOR
  else
    put( _X * DRAW_CHARACTER_W( _SIZE ), _Y * DRAW_CHARACTER_H( _SIZE ) ), FONT_LARGE, ( CHARACTER_X, 0 )-( CHARACTER_X + DRAW_CHARACTER_W( _SIZE ) - 1, DRAW_CHARACTER_H( _SIZE ) - 1 ), custom, @CUSTOM_DRAW_CHARACTER, @_COLOR
  end if
end sub

sub DRAW_STRING( byval _SIZE as integer, _
                 byval _X as integer, _
                 byval _Y as integer, _
                 byval _COLOR as uinteger, _
                 byref _STRING as string )
	static as ubyte CHARACTER
	static as integer I, CHARACTER_X, STRING_LENGTH
	STRING_LENGTH = len( _STRING )
	if STRING_LENGTH <> 0 then
		for I = 1 to STRING_LENGTH
			CHARACTER = asc( mid( _STRING, I, 1 ) )
			CHARACTER_X = CHARACTER * DRAW_CHARACTER_W( _SIZE )
      if _SIZE = 0 then
  			put( _X * DRAW_CHARACTER_W( _SIZE ), _Y * DRAW_CHARACTER_H( _SIZE ) ), FONT_SMALL, ( CHARACTER_X, 0 )-( CHARACTER_X + DRAW_CHARACTER_W( _SIZE ) - 1, DRAW_CHARACTER_H( _SIZE ) - 1 ), custom, @CUSTOM_DRAW_CHARACTER, @_COLOR
      else
        put( _X * DRAW_CHARACTER_W( _SIZE ), _Y * DRAW_CHARACTER_H( _SIZE ) ), FONT_LARGE, ( CHARACTER_X, 0 )-( CHARACTER_X + DRAW_CHARACTER_W( _SIZE ) - 1, DRAW_CHARACTER_H( _SIZE ) - 1 ), custom, @CUSTOM_DRAW_CHARACTER, @_COLOR
      end if
			_X = _X + 1
		next I
	end if
end sub