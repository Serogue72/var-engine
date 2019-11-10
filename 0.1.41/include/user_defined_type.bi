
type udt_RGB
	R as ubyte
	G as ubyte
	B as ubyte
end type

type udt_IMAGE_OLD_HEADER field = 1
	BPP : 3 as ushort
	W : 13 as ushort
	H as ushort
end type

type udt_IMAGE field = 1
	union
		OLD as udt_IMAGE_OLD_HEADER
		OLD_TYPE as ulong
	end union
	BPP as long
	W as ulong
	H as ulong
	PITCH as ulong
	RESERVED( 1 to 12 ) as ubyte
end type

type udt_MOUSE
	X as long
	Y as long
	W as long
	B as long
	PREVIOUS_B as long
	CLIP as long
	RESULT as long
	
	REGISTER as boolean
end type

type udt_CAMERA
  DIVIDER as single
  WIDTH_HALF as long
  HEIGHT_HALF as long
  X as long
  Y as long
end type

type udt_FRAME_RATE
  as ubyte fps_cap
  as double fps_resolution
  
  as double frame_timer_previous
  
  as double cycle_timer_difference
  as double cycle_timer_previous
  as double cycle_timer
  
  as ubyte frame_counter_sum
  as ubyte frame_counter
  
  as long sleep_time_default
  as long sleep_time_previous
  as long sleep_time
  
  declare constructor()
  declare sub START()
  declare sub REGULATE()
end type

type udt_CELL
  WALL_Y_TOP( 0 to 1 ) as long
  WALL_SLOPE_TOP as single
  WALL_Y_BOTTOM( 0 to 1 ) as long
  WALL_SLOPE_BOTTOM as single
  
  'WALL_TYPE( 0 to 1 ) as byte
  'WALL_LENGTH( 0 to 1 ) as byte ' how many iterations of gfxtile should be drawn if 
  'WALL_GFX_TILE_REFERENCE( 0 to 1 ) as byte ' only 256 possible gfx tiles
  'WALL_GFX_TILE_OFFSET( 0 to 1 ) as byte ' vertical offset
  
  'TOP_GFX_TILE_REFERENCE as byte
  'TOP_GFX_TILE_OFFSET as byte ' vertical offset
  'BOTTOM_GFX_TILE_REFERENCE as byte
  'BOTTOM_GFX_TILE_OFFSET as byte ' vertical offset
end type

type udt_CHUNK
  CELL( 0 to 19 ) as udt_CELL
end type

type udt_CHARACTER
  CELL_ID as byte
  X as long
  Y as long
  H_ACC as single
  H_TH as single
  H_VEL as single
  IS_GROUND as byte
  IS_JUMP as byte
  JUMP_COUNTER_DEFAULT as ubyte
  JUMP_COUNTER as ubyte
  JUMP_TH as single
  GRAVITY_ACC as single
  GRAVITY_TH as single
  V_VEL as single
end type

type udt_FONT
  as udt_IMAGE ptr FONT_PTR
  as long W
  as long H
end type

type udt_DISPLAY
  as long SOURCE_W
  as long SOURCE_H
  as udt_IMAGE ptr SOURCE_PTR
  as long MULTIPLIER
  as long W
  as long H
  as long CURSOR_X
  as long CURSOR_Y
end type



