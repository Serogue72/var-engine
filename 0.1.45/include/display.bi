
declare sub init_DISPLAY()
declare sub destroy_DISPLAY()
declare sub clear_buffer_DISPLAY()
declare sub scale_step_DISPLAY()
declare sub flip_DISPLAY()

sub init_DISPLAY()
  DISPLAY.SOURCE_W = 320
  DISPLAY.SOURCE_H = 180
  
  dim as integer resolution_lift( 1 to 12, 0 to 1 )
  for i as integer = 1 to 12
    resolution_lift( i, 0 ) = DISPLAY.SOURCE_W * i
    resolution_lift( i, 1 ) = DISPLAY.SOURCE_H * i
  next i
  
  dim as integer desktop_w, desktop_h
  screeninfo desktop_w, desktop_h
  
  for j as integer = 12 to 1 step -1
    if ( resolution_lift( j, 0 ) < desktop_w ) and _
      ( resolution_lift( j, 1 ) < desktop_h ) then
      DISPLAY.W = resolution_lift( j, 0 )
      DISPLAY.H = resolution_lift( j, 1 )
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
  
  DISPLAY.W = 2240
  DISPLAY.H = 1260
  DISPLAY.MULTIPLIER = 7
  
  DISPLAY.W = 2560
  DISPLAY.H = 1440
  DISPLAY.MULTIPLIER = 8
  
  DISPLAY.W = 2880
  DISPLAY.H = 1620
  DISPLAY.MULTIPLIER = 9
  
  DISPLAY.W = 3200
  DISPLAY.H = 1800
  DISPLAY.MULTIPLIER = 10
  
  DISPLAY.W = 3520
  DISPLAY.H = 1980
  DISPLAY.MULTIPLIER = 11
  
  DISPLAY.W = 3840
  DISPLAY.H = 2160
  DISPLAY.MULTIPLIER = 12
  '/
  
  scale_step_DISPLAY()
  
  screencontrol 103, "GDI"
  screenres DISPLAY.W, _
            DISPLAY.H, _
            32,, _
            &h04
  
  DISPLAY.SOURCE_PTR( 0 ) = imagecreate( DISPLAY.SOURCE_W, DISPLAY.SOURCE_H )
  DISPLAY.SOURCE_PTR( 1 ) = imagecreate( DISPLAY.SOURCE_W, DISPLAY.SOURCE_H )
  DISPLAY.SHADOW_LAYER_PTR = imagecreate( DISPLAY.SOURCE_W, DISPLAY.SOURCE_H )
  if DISPLAY.SOURCE_PTR( 0 ) = 0 or DISPLAY.SOURCE_PTR( 1 ) = 0 or DISPLAY.SHADOW_LAYER_PTR = 0 then end
  
  DISPLAY.ALPHA_VALUE( 0 ) = 255
  DISPLAY.ALPHA_VALUE( 1 ) = 255
end sub

sub destroy_DISPLAY()
  imagedestroy DISPLAY.SOURCE_PTR( 0 )
  imagedestroy DISPLAY.SOURCE_PTR( 1 )
  imagedestroy DISPLAY.SHADOW_LAYER_PTR
  screen 0
end sub

sub clear_buffer_DISPLAY()
  line DISPLAY.SOURCE_PTR( 0 ), ( 0, 0 )-( DISPLAY.W - 1, DISPLAY.H - 1 ), rgb( 0, 0, 0), bf
  line DISPLAY.SHADOW_LAYER_PTR, ( 0, 0 )-( DISPLAY.W - 1, DISPLAY.H - 1 ), rgb( 0, 0, 0), bf 'clear SHADOW_LAYER
  circle DISPLAY.SHADOW_LAYER_PTR, ( 159, 89 ), 66, rgb( 255, 0, 255 ), , , , F
end sub

sub scale_step_DISPLAY()
  DISPLAY.SCALE_STEP = ( 1 / DISPLAY.MULTIPLIER ) * 65536
end sub

sub flip_DISPLAY()
  static as udt_IMAGE ptr buffer_ptr
  if DISPLAY.ALPHA_VALUE( 0 ) = 255 then
    put DISPLAY.SOURCE_PTR( 0 ), ( 0, 0 ), DISPLAY.SHADOW_LAYER_PTR, trans
    buffer_ptr = DISPLAY.SOURCE_PTR( 0 )
  elseif DISPLAY.ALPHA_VALUE( 1 ) = 255 then
    put DISPLAY.SOURCE_PTR( 1 ), ( 0, 0 ), DISPLAY.SOURCE_PTR( 0 ), pset
    put DISPLAY.SOURCE_PTR( 0 ), ( 0, 0 ), DISPLAY.SHADOW_LAYER_PTR, trans
    buffer_ptr = DISPLAY.SOURCE_PTR( 0 )
  else
    put DISPLAY.SOURCE_PTR( 1 ), ( 0, 0 ), DISPLAY.SOURCE_PTR( 0 ), alpha, DISPLAY.ALPHA_VALUE( 0 )
    put DISPLAY.SOURCE_PTR( 1 ), ( 0, 0 ), DISPLAY.SHADOW_LAYER_PTR, trans
    buffer_ptr = DISPLAY.SOURCE_PTR( 1 )
  end if
  DISPLAY.ALPHA_VALUE( 1 ) = DISPLAY.ALPHA_VALUE( 0 )
  
  static as integer scale_counter_x, scale_counter_y
  static as integer scale_x_step = 0
  static as integer scale_y_step = 0
  static as ulong ptr scale_source_ptr
  static as ulong ptr scale_source_temp_ptr
  static as ulong ptr screen_ptr
  
  scale_source_ptr = cptr( ulong ptr, buffer_ptr ) + 8
  scale_source_temp_ptr = scale_source_ptr
  screen_ptr = screenptr()
  
  select case DISPLAY.MULTIPLIER
    case is = 1
      put ( 0, 0 ), buffer_ptr, pset
    case is > 1
      for scale_counter_y = 0 to ( DISPLAY.H - 1 )
        scale_source_temp_ptr = scale_source_ptr + ( scale_y_step shr 16 ) * DISPLAY.SOURCE_W
          for scale_counter_x = 0 to ( DISPLAY.W - 1 )
            *screen_ptr = scale_source_temp_ptr[ scale_x_step shr 16 ]
            screen_ptr += 1
            scale_x_step += DISPLAY.SCALE_STEP
          next scale_counter_x
            scale_y_step += DISPLAY.SCALE_STEP
            scale_x_step = 0
        next scale_counter_y
        scale_source_ptr = cptr( ulong ptr, buffer_ptr ) + 8
        scale_y_step = 0
    case is < 1
      line ( 0, 0 )-( DISPLAY.W - 1, DISPLAY.H - 1 ), rgb( 255, 0, 255 ), bf
  end select
end sub