
declare sub INIT_CHUNK()
declare sub SWAP_CHUNKS( _direction as integer )

sub INIT_CHUNK()
  dim as integer I, J
  
	CHUNK( 4 ).CELL( 0 ).WALL_Y_TOP( 0 ) = 64
	CHUNK( 4 ).CELL( 0 ).WALL_Y_TOP( 1 ) = 64
	CHUNK( 4 ).CELL( 0 ).WALL_SLOPE_TOP = 0
	CHUNK( 4 ).CELL( 0 ).WALL_Y_BOTTOM( 0 ) = 175
	CHUNK( 4 ).CELL( 0 ).WALL_Y_BOTTOM( 1 ) = 175
	CHUNK( 4 ).CELL( 0 ).WALL_SLOPE_BOTTOM = 0

	for I = 1 to 8
		CHUNK( 4 ).CELL( I ).WALL_Y_TOP( 0 ) = CHUNK( 4 ).CELL( I - 1 ).WALL_Y_TOP( 1 )
		CHUNK( 4 ).CELL( I ).WALL_Y_TOP( 1 ) = CHUNK( 4 ).CELL( I ).WALL_Y_TOP( 0 ) + 2
		CHUNK( 4 ).CELL( I ).WALL_SLOPE_TOP = ( CHUNK( 4 ).CELL( I ).WALL_Y_TOP( 1 ) - CHUNK( 4 ).CELL( I ).WALL_Y_TOP( 0 ) ) / 16
		CHUNK( 4 ).CELL( I ).WALL_Y_BOTTOM( 0 ) = CHUNK( 4 ).CELL( I - 1 ).WALL_Y_BOTTOM( 1 )
		CHUNK( 4 ).CELL( I ).WALL_Y_BOTTOM( 1 ) = CHUNK( 4 ).CELL( I ).WALL_Y_BOTTOM( 0 ) - 4
		CHUNK( 4 ).CELL( I ).WALL_SLOPE_BOTTOM = ( CHUNK( 4 ).CELL( I ).WALL_Y_BOTTOM( 1 ) - CHUNK( 4 ).CELL( I ).WALL_Y_BOTTOM( 0 ) ) / 16
	next I
	for I = 9 to 10
		CHUNK( 4 ).CELL( I ).WALL_Y_TOP( 0 ) = CHUNK( 4 ).CELL( I - 1 ).WALL_Y_TOP( 1 )
		CHUNK( 4 ).CELL( I ).WALL_Y_TOP( 1 ) = CHUNK( 4 ).CELL( I ).WALL_Y_TOP( 0 )
		CHUNK( 4 ).CELL( I ).WALL_SLOPE_TOP = ( CHUNK( 4 ).CELL( I ).WALL_Y_TOP( 1 ) - CHUNK( 4 ).CELL( I ).WALL_Y_TOP( 0 ) ) / 16
		CHUNK( 4 ).CELL( I ).WALL_Y_BOTTOM( 0 ) = CHUNK( 4 ).CELL( I - 1 ).WALL_Y_BOTTOM( 1 )
		CHUNK( 4 ).CELL( I ).WALL_Y_BOTTOM( 1 ) = CHUNK( 4 ).CELL( I ).WALL_Y_BOTTOM( 0 )
		CHUNK( 4 ).CELL( I ).WALL_SLOPE_BOTTOM = ( CHUNK( 4 ).CELL( I ).WALL_Y_BOTTOM( 1 ) - CHUNK( 4 ).CELL( I ).WALL_Y_BOTTOM( 0 ) ) / 16
	next I
	for I = 11 to 18
		CHUNK( 4 ).CELL( I ).WALL_Y_TOP( 0 ) = CHUNK( 4 ).CELL( I - 1 ).WALL_Y_TOP( 1 )
		CHUNK( 4 ).CELL( I ).WALL_Y_TOP( 1 ) = CHUNK( 4 ).CELL( I ).WALL_Y_TOP( 0 ) - 2
		CHUNK( 4 ).CELL( I ).WALL_SLOPE_TOP = ( CHUNK( 4 ).CELL( I ).WALL_Y_TOP( 1 ) - CHUNK( 4 ).CELL( I ).WALL_Y_TOP( 0 ) ) / 16
		CHUNK( 4 ).CELL( I ).WALL_Y_BOTTOM( 0 ) = CHUNK( 4 ).CELL( I - 1 ).WALL_Y_BOTTOM( 1 )
		CHUNK( 4 ).CELL( I ).WALL_Y_BOTTOM( 1 ) = CHUNK( 4 ).CELL( I ).WALL_Y_BOTTOM( 0 ) + 4
		CHUNK( 4 ).CELL( I ).WALL_SLOPE_BOTTOM = ( CHUNK( 4 ).CELL( I ).WALL_Y_BOTTOM( 1 ) - CHUNK( 4 ).CELL( I ).WALL_Y_BOTTOM( 0 ) ) / 16
	next I
	
	CHUNK( 4 ).CELL( 19 ).WALL_Y_TOP( 0 ) = 64
	CHUNK( 4 ).CELL( 19 ).WALL_Y_TOP( 1 ) = 64
	CHUNK( 4 ).CELL( 19 ).WALL_SLOPE_TOP = 0
	CHUNK( 4 ).CELL( 19 ).WALL_Y_BOTTOM( 0 ) = 175
	CHUNK( 4 ).CELL( 19 ).WALL_Y_BOTTOM( 1 ) = 175
	CHUNK( 4 ).CELL( 19 ).WALL_SLOPE_BOTTOM = 0
  
	CHUNK( 5 ).CELL( 0 ).WALL_Y_TOP( 0 ) = 64
	CHUNK( 5 ).CELL( 0 ).WALL_Y_TOP( 1 ) = 64
	CHUNK( 5 ).CELL( 0 ).WALL_SLOPE_TOP = 0
	CHUNK( 5 ).CELL( 0 ).WALL_Y_BOTTOM( 0 ) = 175
	CHUNK( 5 ).CELL( 0 ).WALL_Y_BOTTOM( 1 ) = 175
	CHUNK( 5 ).CELL( 0 ).WALL_SLOPE_BOTTOM = 0

	for I = 1 to 19
		CHUNK( 5 ).CELL( I ).WALL_Y_TOP( 0 ) = CHUNK( 5 ).CELL( I - 1 ).WALL_Y_TOP( 1 )
		CHUNK( 5 ).CELL( I ).WALL_Y_TOP( 1 ) = CHUNK( 5 ).CELL( I ).WALL_Y_TOP( 0 )
		CHUNK( 5 ).CELL( I ).WALL_SLOPE_TOP = ( CHUNK( 5 ).CELL( I ).WALL_Y_TOP( 1 ) - CHUNK( 5 ).CELL( I ).WALL_Y_TOP( 0 ) ) / 16
		CHUNK( 5 ).CELL( I ).WALL_Y_BOTTOM( 0 ) = CHUNK( 5 ).CELL( I - 1 ).WALL_Y_BOTTOM( 1 )
		CHUNK( 5 ).CELL( I ).WALL_Y_BOTTOM( 1 ) = CHUNK( 5 ).CELL( I ).WALL_Y_BOTTOM( 0 )
		CHUNK( 5 ).CELL( I ).WALL_SLOPE_BOTTOM = ( CHUNK( 5 ).CELL( I ).WALL_Y_BOTTOM( 1 ) - CHUNK( 5 ).CELL( I ).WALL_Y_BOTTOM( 0 ) ) / 16
	next I

	CHUNK( 6 ).CELL( 0 ).WALL_Y_TOP( 0 ) = 64
	CHUNK( 6 ).CELL( 0 ).WALL_Y_TOP( 1 ) = 64
	CHUNK( 6 ).CELL( 0 ).WALL_SLOPE_TOP = 0
	CHUNK( 6 ).CELL( 0 ).WALL_Y_BOTTOM( 0 ) = 175
	CHUNK( 6 ).CELL( 0 ).WALL_Y_BOTTOM( 1 ) = 175
	CHUNK( 6 ).CELL( 0 ).WALL_SLOPE_BOTTOM = 0

	for I = 1 to 8
		CHUNK( 6 ).CELL( I ).WALL_Y_TOP( 0 ) = CHUNK( 6 ).CELL( I - 1 ).WALL_Y_TOP( 1 )
		CHUNK( 6 ).CELL( I ).WALL_Y_TOP( 1 ) = CHUNK( 6 ).CELL( I ).WALL_Y_TOP( 0 ) - 1
		CHUNK( 6 ).CELL( I ).WALL_SLOPE_TOP = ( CHUNK( 6 ).CELL( I ).WALL_Y_TOP( 1 ) - CHUNK( 6 ).CELL( I ).WALL_Y_TOP( 0 ) ) / 16
		CHUNK( 6 ).CELL( I ).WALL_Y_BOTTOM( 0 ) = CHUNK( 6 ).CELL( I - 1 ).WALL_Y_BOTTOM( 1 )
		CHUNK( 6 ).CELL( I ).WALL_Y_BOTTOM( 1 ) = CHUNK( 6 ).CELL( I ).WALL_Y_BOTTOM( 0 ) + 6
		CHUNK( 6 ).CELL( I ).WALL_SLOPE_BOTTOM = ( CHUNK( 6 ).CELL( I ).WALL_Y_BOTTOM( 1 ) - CHUNK( 6 ).CELL( I ).WALL_Y_BOTTOM( 0 ) ) / 16
	next I
	for I = 9 to 10
		CHUNK( 6 ).CELL( I ).WALL_Y_TOP( 0 ) = CHUNK( 6 ).CELL( I - 1 ).WALL_Y_TOP( 1 )
		CHUNK( 6 ).CELL( I ).WALL_Y_TOP( 1 ) = CHUNK( 6 ).CELL( I ).WALL_Y_TOP( 0 )
		CHUNK( 6 ).CELL( I ).WALL_SLOPE_TOP = ( CHUNK( 6 ).CELL( I ).WALL_Y_TOP( 1 ) - CHUNK( 6 ).CELL( I ).WALL_Y_TOP( 0 ) ) / 16
		CHUNK( 6 ).CELL( I ).WALL_Y_BOTTOM( 0 ) = CHUNK( 6 ).CELL( I - 1 ).WALL_Y_BOTTOM( 1 )
		CHUNK( 6 ).CELL( I ).WALL_Y_BOTTOM( 1 ) = CHUNK( 6 ).CELL( I ).WALL_Y_BOTTOM( 0 )
		CHUNK( 6 ).CELL( I ).WALL_SLOPE_BOTTOM = ( CHUNK( 6 ).CELL( I ).WALL_Y_BOTTOM( 1 ) - CHUNK( 6 ).CELL( I ).WALL_Y_BOTTOM( 0 ) ) / 16
	next I
	for I = 11 to 18
		CHUNK( 6 ).CELL( I ).WALL_Y_TOP( 0 ) = CHUNK( 6 ).CELL( I - 1 ).WALL_Y_TOP( 1 )
		CHUNK( 6 ).CELL( I ).WALL_Y_TOP( 1 ) = CHUNK( 6 ).CELL( I ).WALL_Y_TOP( 0 ) + 1
		CHUNK( 6 ).CELL( I ).WALL_SLOPE_TOP = ( CHUNK( 6 ).CELL( I ).WALL_Y_TOP( 1 ) - CHUNK( 6 ).CELL( I ).WALL_Y_TOP( 0 ) ) / 16
		CHUNK( 6 ).CELL( I ).WALL_Y_BOTTOM( 0 ) = CHUNK( 6 ).CELL( I - 1 ).WALL_Y_BOTTOM( 1 )
		CHUNK( 6 ).CELL( I ).WALL_Y_BOTTOM( 1 ) = CHUNK( 6 ).CELL( I ).WALL_Y_BOTTOM( 0 ) - 6
		CHUNK( 6 ).CELL( I ).WALL_SLOPE_BOTTOM = ( CHUNK( 6 ).CELL( I ).WALL_Y_BOTTOM( 1 ) - CHUNK( 6 ).CELL( I ).WALL_Y_BOTTOM( 0 ) ) / 16
	next I
	
	CHUNK( 6 ).CELL( 19 ).WALL_Y_TOP( 0 ) = 64
	CHUNK( 6 ).CELL( 19 ).WALL_Y_TOP( 1 ) = 64
	CHUNK( 6 ).CELL( 19 ).WALL_SLOPE_TOP = 0
	CHUNK( 6 ).CELL( 19 ).WALL_Y_BOTTOM( 0 ) = 175
	CHUNK( 6 ).CELL( 19 ).WALL_Y_BOTTOM( 1 ) = 175
	CHUNK( 6 ).CELL( 19 ).WALL_SLOPE_BOTTOM = 0
end sub

sub SWAP_CHUNKS( _direction as integer )
  dim as udt_CHUNK buffer
  select case _direction
  case 4
    buffer = CHUNK( 6 )
    CHUNK( 6 ) = CHUNK( 5 )
    CHUNK( 5 ) = CHUNK( 4 )
    CHUNK( 4 ) = buffer
  case 6
    buffer = CHUNK( 4 )
    CHUNK( 4 ) = CHUNK( 5 )
    CHUNK( 5 ) = CHUNK( 6 )
    CHUNK( 6 ) = buffer
  end select
end sub