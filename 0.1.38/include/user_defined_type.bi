
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
	X as integer
	Y as integer
	W as integer
	B as integer
	PREVIOUS_B as integer
	CLIP as integer
	RESULT as long
	
	REGISTER as boolean
end type

type udt_CAMERA
  DIVIDER as single
  WIDTH_HALF as integer
  HEIGHT_HALF as integer
  X as integer
  Y as integer
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
  WALL_Y_TOP( 0 to 1 ) as integer
  WALL_SLOPE_TOP as single
  WALL_Y_BOTTOM( 0 to 1 ) as integer
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
  X as integer
  Y as integer
end type

type udt_DISPLAY
  as integer SOURCE_W
  as integer SOURCE_H
  as integer MULTIPLIER
  as integer W
  as integer H
end type



dim shared as udt_FRAME_RATE FRAME_RATE

dim shared as udt_CAMERA CAMERA
dim shared as udt_CHUNK CHUNK( 0 to 9 )
dim shared as udt_CHARACTER CHARACTER

dim shared as udt_MOUSE MOUSE

dim shared as udt_DISPLAY DISPLAY
dim shared as udt_IMAGE ptr SOURCE_BUFFER

dim shared as udt_IMAGE ptr FONT_SMALL
dim shared as udt_IMAGE ptr FONT_LARGE
dim shared as integer DRAW_CHARACTER_W( 0 to 1 )
dim shared as integer DRAW_CHARACTER_H( 0 to 1 )

