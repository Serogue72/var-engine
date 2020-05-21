
sub INIT_CHUNK()
  dim as integer I, J
  
  ' set chunks 4,5,6 to maximum size
  for I = 0 to 19
	CHUNK( 4 ).CELL( I ).WALL_Y_TOP( 0 ) = 0
	CHUNK( 4 ).CELL( I ).WALL_Y_TOP( 1 ) = 0
	CHUNK( 4 ).CELL( I ).WALL_SLOPE_TOP = 0
	CHUNK( 4 ).CELL( I ).WALL_Y_BOTTOM( 0 ) = 191
	CHUNK( 4 ).CELL( I ).WALL_Y_BOTTOM( 1 ) = 191
	CHUNK( 4 ).CELL( I ).WALL_SLOPE_BOTTOM = 0
  next I
  CHUNK( 5 ) = CHUNK( 4 )
  CHUNK( 6 ) = CHUNK( 4 )
  
  CHUNK( 4 ).LAYER( 0 ) = imagecreate( DISPLAY.SOURCE_W, 192 )
  CHUNK( 5 ).LAYER( 0 ) = imagecreate( DISPLAY.SOURCE_W, 192 )
  CHUNK( 6 ).LAYER( 0 ) = imagecreate( DISPLAY.SOURCE_W, 192 )
  CHUNK_BUFFER.LAYER( 0 ) = imagecreate( DISPLAY.SOURCE_W, 192 )
  if CHUNK( 4 ).LAYER( 0 ) = 0 or _
     CHUNK( 5 ).LAYER( 0 ) = 0 or _
     CHUNK( 6 ).LAYER( 0 ) = 0 or _
     CHUNK_BUFFER.LAYER( 0 ) = 0 then end
  
  line CHUNK( 4 ).LAYER( 0 ), ( 0, 0 )-( 319, 191 ), rgb( 255, 0, 255 ), bf
  line CHUNK( 5 ).LAYER( 0 ), ( 0, 0 )-( 319, 191 ), rgb( 255, 0, 255 ), bf
  line CHUNK( 6 ).LAYER( 0 ), ( 0, 0 )-( 319, 191 ), rgb( 255, 0, 255 ), bf
  line CHUNK_BUFFER.LAYER( 0 ), ( 0, 0 )-( 319, 191 ), rgb( 255, 0, 255 ), bf
  
  for I = 0 to 19
    for J = 0 to 11
      CHUNK_TILE( 4 ).TILE( I, J ).REF = rnd * 1
      CHUNK_TILE( 5 ).TILE( I, J ).REF = rnd * 1
      CHUNK_TILE( 6 ).TILE( I, J ).REF = rnd * 1
      if CHUNK_TILE( 4 ).TILE( I, J ).REF then line CHUNK( 4 ).LAYER( 0 ), ( I * 16, J * 16 )-( I * 16 + 15, J * 16 + 15 ), rgb( rnd * 31, rnd * 31 + 31, rnd * 31 ), bf
      if CHUNK_TILE( 5 ).TILE( I, J ).REF then line CHUNK( 5 ).LAYER( 0 ), ( I * 16, J * 16 )-( I * 16 + 15, J * 16 + 15 ), rgb( rnd * 31 + 31, rnd * 31, rnd * 31 ), bf
      if CHUNK_TILE( 6 ).TILE( I, J ).REF then line CHUNK( 6 ).LAYER( 0 ), ( I * 16, J * 16 )-( I * 16 + 15, J * 16 + 15 ), rgb( rnd * 31, rnd * 31, rnd * 31 + 31 ), bf
    next J
  next I
  
  
end sub

sub SWAP_CHUNKS( _direction as integer )
  select case _direction
  case 4
    CHUNK_BUFFER = CHUNK( 6 )
    CHUNK( 6 ) = CHUNK( 5 )
    CHUNK( 5 ) = CHUNK( 4 )
    CHUNK( 4 ) = CHUNK_BUFFER
  case 6
    CHUNK_BUFFER = CHUNK( 4 )
    CHUNK( 4 ) = CHUNK( 5 )
    CHUNK( 5 ) = CHUNK( 6 )
    CHUNK( 6 ) = CHUNK_BUFFER
  end select
end sub

sub DESTROY_CHUNKS()
  imagedestroy CHUNK( 4 ).LAYER( 0 )
  imagedestroy CHUNK( 5 ).LAYER( 0 )
  imagedestroy CHUNK( 6 ).LAYER( 0 )
  imagedestroy CHUNK_BUFFER.LAYER( 0 )
end SUB
