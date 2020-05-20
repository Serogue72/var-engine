
type udt_RGB
  R as ubyte
  G as ubyte
  B as ubyte
end type

type udt_IMAGE_OLD_HEADER field = 1
  BPP as ushort
  W as ushort
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

type udt_KEYBOARD
  declare constructor()
  declare constructor( byval as integer )
  declare destructor()
  
  declare sub lock()
  declare sub unlock()
  
  declare function pressed( byval as long ) as boolean
  declare function released( byval as long ) as boolean
  declare function is_down( byval as long ) as boolean
  declare function held( byval as long, _
                         byval as double = 0.0 ) as boolean
  declare function repeated( byval as long, _
                             byval as double = 0.0 ) as boolean
  
  enum KEYSTATE
    None
    Pressed = 1
    Released = 2
    ReleasedInitialized = 4
    Held = 8
    HeldInitialized = 16
    Repeated = 32
    RepeatedInitialized = 64
  end enum
  
  as ubyte _state( any ), _prevState( any )
  as double _heldStartTime( any ), _repeatedStartTime( any )
  as any ptr _mutex
end type

type udt_CAMERA
  DIVIDER as single
  WIDTH_HALF as long
  HEIGHT_HALF as long
  X as long
  Y as long
end type

type udt_FRAME_RATE_STUFF
  FPS_CAP as ubyte
  FPS_RESOLUTION as double
  FRAME_TIMER_PREVIOUS as double
  CYCLE_TIMER_DIFFERENCE as double
  CYCLE_TIMER_PREVIOUS as double
  CYCLE_TIMER as double
  FRAME_COUNTER_SUM as ubyte
  FRAME_COUNTER as ubyte
end type

type udt_FRAME_RATE
  INPUT as udt_FRAME_RATE_STUFF
  GFX as udt_FRAME_RATE_STUFF
  
  SLEEP_TIME_DEFAULT as long
  SLEEP_TIME_PREVIOUS as long
  SLEEP_TIME as long
  
  RENDER as boolean
  
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
  LAYER( 0 ) as udt_IMAGE ptr
  BUFFER_LAYER( 0 ) as udt_IMAGE ptr
end type

type udt_TILE
  REF as ubyte
end type

type udt_CHUNK_TILE
  TILE( 0 to 19, 0 to 11 ) as udt_TILE
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
  FONT_PTR as udt_IMAGE ptr
  W as long
  H as long
end type

type udt_DISPLAY
  SOURCE_W as long
  SOURCE_H as long
  SOURCE_PTR( 0 to 1 ) as udt_IMAGE ptr
  SHADOW_LAYER_PTR as udt_IMAGE ptr
  MULTIPLIER as long
  SCALE_STEP as integer
  W as long
  H as long
  CURSOR_X as long
  CURSOR_Y as long
  ALPHA_VALUE( 0 to 1 ) as ubyte
end type
