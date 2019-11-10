
declare sub INIT_DISPLAY()
declare sub DESTROY_DISPLAY()
declare sub FLIP_DISPLAY()

sub INIT_DISPLAY()
  DISPLAY.SOURCE_W = 320
  DISPLAY.SOURCE_H = 180
  'DISPLAY.SOURCE_PTR = imagecreate( DISPLAY.SOURCE_W, DISPLAY.SOURCE_H, 0, 32 )
  'if DISPLAY.SOURCE_PTR = 0 then end
  
  dim as integer RESOLUTION_LIST( 1 to 12, 0 to 1 )
  for i as integer = 1 to 12
    RESOLUTION_LIST( i, 0 ) = DISPLAY.SOURCE_W * i
    RESOLUTION_LIST( i, 1 ) = DISPLAY.SOURCE_H * i
  next i
  
  dim as integer DESKTOP_W, DESKTOP_H
  screeninfo DESKTOP_W, DESKTOP_H
  
  for j as integer = 12 to 1 step -1
    if ( RESOLUTION_LIST( j, 0 ) < DESKTOP_W ) and _
      ( RESOLUTION_LIST( j, 1 ) < DESKTOP_H ) then
      DISPLAY.W = RESOLUTION_LIST( j, 0 )
      DISPLAY.H = RESOLUTION_LIST( j, 1 )
      DISPLAY.MULTIPLIER = j
      exit for
    end if
  next j
  /'
  DISPLAY.W = 320
  DISPLAY.H = 180
  DISPLAY.MULTIPLIER = 1
  
  DISPLAY.W = 640
  DISPLAY.H = 360
  DISPLAY.MULTIPLIER = 2
  
  DISPLAY.W = 960
  DISPLAY.H = 540
  DISPLAY.MULTIPLIER = 3
  
  DISPLAY.W = 1280
  DISPLAY.H = 720
  DISPLAY.MULTIPLIER = 4
  
  DISPLAY.W = 1600
  DISPLAY.H = 900
  DISPLAY.MULTIPLIER = 5
  
  DISPLAY.W = 1920
  DISPLAY.H = 1080
  DISPLAY.MULTIPLIER = 6
  '/
  
  DISPLAY.W = 960
  DISPLAY.H = 540
  DISPLAY.MULTIPLIER = 3
  
  screencontrol 103, "GDI"
  screenres DISPLAY.W, _
            DISPLAY.H, _
            32,, _
            &h04

  DISPLAY.SOURCE_PTR = imagecreate( DISPLAY.SOURCE_W, DISPLAY.SOURCE_H )
  if DISPLAY.SOURCE_PTR = 0 then end
end sub

sub DESTROY_DISPLAY()
  imagedestroy DISPLAY.SOURCE_PTR
  screen 0
end sub

sub FLIP_DISPLAY()
  static as integer scale_counter_x, scale_counter_y
  static as integer scale_step
  static as integer scale_x_step = 0
  static as integer scale_y_step = 0
  static as ulong ptr scale_source_ptr
  static as ulong ptr scale_source_temp_ptr
  static as ulong ptr screen_ptr
  
  scale_step = ( 1 / DISPLAY.MULTIPLIER ) * 65536
  scale_source_ptr = cptr( ulong ptr, DISPLAY.SOURCE_PTR ) + 8
  scale_source_temp_ptr = scale_source_ptr
  screen_ptr = screenptr()
  
	select case DISPLAY.MULTIPLIER
	case is = 1
		put ( 0, 0 ), DISPLAY.SOURCE_PTR, pset
	case is > 1
		for scale_counter_y = 0 to ( DISPLAY.H - 1 )
			scale_source_temp_ptr = scale_source_ptr + ( scale_y_step shr 16 ) * DISPLAY.SOURCE_W
			for scale_counter_x = 0 to ( DISPLAY.W - 1 )
				*screen_ptr = scale_source_temp_ptr[ scale_x_step shr 16 ]
				screen_ptr += 1
				scale_x_step += scale_step
			next scale_counter_x
			scale_y_step += scale_step
			scale_x_step = 0
		next scale_counter_y
		scale_source_ptr = cptr( ulong ptr, DISPLAY.SOURCE_PTR ) + 8
		screen_ptr = screenptr()
		scale_y_step = 0
	case is < 1
		line ( 0, 0 )-( DISPLAY.W - 1, DISPLAY.H - 1 ), rgb( 255, 0, 255 ), bf
	end select
end sub