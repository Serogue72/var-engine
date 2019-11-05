
' VAR Engine
' Version 0.1.38
' November 4 2019

#include "include/definitions.bi"
#include "include/user_defined_type.bi"
#include "include/shell.bi"
#include "include/frame_rate.bi"
#include "include/screen.bi"
#include "include/font.bi"
#include "include/load_cell.bi"
#include "include/mouse.bi"
#include "include/keyboard.bi"
#include "include/character.bi"
#include "include/camera.bi"

INIT_SCREEN()
INIT_FONT()
INIT_CHUNK()
INIT_MOUSE()
INIT_CHARACTER()
INIT_CAMERA()

dim as integer I, J, K
dim as ubyte L, M
dim as string KEY

SOURCE_BUFFER = imagecreate( DISPLAY.SOURCE_W, DISPLAY.SOURCE_H, 0, 32 )
if SOURCE_BUFFER = 0 then end

dim as integer scale_counter_x, scale_counter_y
dim as integer scale_step = ( 1 / DISPLAY.MULTIPLIER ) * 65536
dim as integer scale_x_step = 0
dim as integer scale_y_step = 0
dim as ulong ptr scale_source_ptr = cptr( ulong ptr, SOURCE_BUFFER ) + 8
dim as ulong ptr scale_source_temp_ptr = scale_source_ptr
dim as ulong ptr screen_ptr = screenptr()






randomize, 3
FRAME_RATE.START()
do
  KEY = inkey
  select case KEY
  case chr( 255 ) & "K" 'left
    CHARACTER.X = CHARACTER.X - 11
    if CHARACTER.X < 0 then
      CHARACTER.CELL_ID = CHARACTER.CELL_ID - 1
      CHARACTER.X = CHARACTER.X + 16
      if CHARACTER.CELL_ID = -1 then
        CHARACTER.CELL_ID = 19
        SWAP_CHUNKS( 4 )
      end if
    end if
  case chr( 255 ) & "M" 'right
    CHARACTER.X = CHARACTER.X + 11
    if CHARACTER.X > 15 then
      CHARACTER.CELL_ID = CHARACTER.CELL_ID + 1
      CHARACTER.X = CHARACTER.X - 16
      if CHARACTER.CELL_ID = 20 then
        CHARACTER.CELL_ID = 0
        SWAP_CHUNKS( 6 )
      end if
    end if
  end select
  if MOUSE.REGISTER then
    CHARACTER.CELL_ID = CHARACTER.CELL_ID + 1
    if CHARACTER.CELL_ID = 20 then
      CHARACTER.CELL_ID = 0
    end if
  end if
	UPDATE_MOUSE()
  UPDATE_CHARACTER()
  UPDATE_CAMERA()
  screenlock
    cls
    
    ' dummy chunk
		for I = 0 to 19
			K = I * 12
			M = L + K
			for J = 0 to 15
				line SOURCE_BUFFER, ( ( I * 16 ) - CAMERA.X + J - 320, CHUNK( 4 ).CELL( I ).WALL_Y_TOP( 0 ) - CAMERA.Y + ( J * CHUNK( 4 ).CELL( I ).WALL_SLOPE_TOP ) )-( ( I * 16 ) - CAMERA.X + J - 320, CHUNK( 4 ).CELL( I ).WALL_Y_BOTTOM( 0 ) - CAMERA.Y + ( J * CHUNK( 4 ).CELL( I ).WALL_SLOPE_BOTTOM ) ), rgb( 255-M, M, M )
			next J
			line SOURCE_BUFFER, ( ( I * 16 ) - CAMERA.X - 320, CHUNK( 4 ).CELL( I ).WALL_Y_TOP( 0 ) - CAMERA.Y )-( ( I * 16 ) - CAMERA.X - 320, CHUNK( 4 ).CELL( I ).WALL_Y_BOTTOM( 0 ) - CAMERA.Y ), rgb( 31, 31, 31 )
			line SOURCE_BUFFER, ( ( ( I + 1 ) * 16 ) - CAMERA.X - 320, CHUNK( 4 ).CELL( I ).WALL_Y_TOP( 1 ) - CAMERA.Y )-( ( ( I + 1 ) * 16 ) - CAMERA.X - 320, CHUNK( 4 ).CELL( I ).WALL_Y_BOTTOM( 1 ) - CAMERA.Y ), rgb( 31, 31, 31 )
			line SOURCE_BUFFER, ( ( I * 16 ) - CAMERA.X - 320, CHUNK( 4 ).CELL( I ).WALL_Y_TOP( 0 ) - CAMERA.Y )-( ( ( I + 1 ) * 16 ) - CAMERA.X - 1 - 320, CHUNK( 4 ).CELL( I ).WALL_Y_TOP( 1 ) - CAMERA.Y ), rgb( 31, 31, 255 )
			line SOURCE_BUFFER, ( ( I * 16 ) - CAMERA.X - 320, CHUNK( 4 ).CELL( I ).WALL_Y_BOTTOM( 0 ) - CAMERA.Y )-( ( ( I + 1 ) * 16 ) - CAMERA.X - 1 - 320, CHUNK( 4 ).CELL( I ).WALL_Y_BOTTOM( 1 ) - CAMERA.Y ), rgb( 31, 255, 31 )
		next I
		for I = 0 to 19
			K = I * 12
			M = L + K
			for J = 0 to 15
				line SOURCE_BUFFER, ( ( I * 16 ) - CAMERA.X + J, CHUNK( 5 ).CELL( I ).WALL_Y_TOP( 0 ) - CAMERA.Y + ( J * CHUNK( 5 ).CELL( I ).WALL_SLOPE_TOP ) )-( ( I * 16 ) - CAMERA.X + J, CHUNK( 5 ).CELL( I ).WALL_Y_BOTTOM( 0 ) - CAMERA.Y + ( J * CHUNK( 5 ).CELL( I ).WALL_SLOPE_BOTTOM ) ), rgb( M, 255-M, M )
			next J
			line SOURCE_BUFFER, ( ( I * 16 ) - CAMERA.X, CHUNK( 5 ).CELL( I ).WALL_Y_TOP( 0 ) - CAMERA.Y )-( ( I * 16 ) - CAMERA.X, CHUNK( 5 ).CELL( I ).WALL_Y_BOTTOM( 0 ) - CAMERA.Y ), rgb( 31, 31, 31 )
			line SOURCE_BUFFER, ( ( ( I + 1 ) * 16 ) - CAMERA.X, CHUNK( 5 ).CELL( I ).WALL_Y_TOP( 1 ) - CAMERA.Y )-( ( ( I + 1 ) * 16 ) - CAMERA.X, CHUNK( 5 ).CELL( I ).WALL_Y_BOTTOM( 1 ) - CAMERA.Y ), rgb( 31, 31, 31 )
			line SOURCE_BUFFER, ( ( I * 16 ) - CAMERA.X, CHUNK( 5 ).CELL( I ).WALL_Y_TOP( 0 ) - CAMERA.Y )-( ( ( I + 1 ) * 16 ) - CAMERA.X - 1, CHUNK( 5 ).CELL( I ).WALL_Y_TOP( 1 ) - CAMERA.Y ), rgb( 31, 31, 255 )
			line SOURCE_BUFFER, ( ( I * 16 ) - CAMERA.X, CHUNK( 5 ).CELL( I ).WALL_Y_BOTTOM( 0 ) - CAMERA.Y )-( ( ( I + 1 ) * 16 ) - CAMERA.X - 1, CHUNK( 5 ).CELL( I ).WALL_Y_BOTTOM( 1 ) - CAMERA.Y ), rgb( 31, 255, 31 )
		next I
		for I = 0 to 19
			K = I * 12
			M = L + K
			for J = 0 to 15
				line SOURCE_BUFFER, ( ( I * 16 ) - CAMERA.X + J + 320, CHUNK( 6 ).CELL( I ).WALL_Y_TOP( 0 ) - CAMERA.Y + ( J * CHUNK( 6 ).CELL( I ).WALL_SLOPE_TOP ) )-( ( I * 16 ) - CAMERA.X + J + 320, CHUNK( 6 ).CELL( I ).WALL_Y_BOTTOM( 0 ) - CAMERA.Y + ( J * CHUNK( 6 ).CELL( I ).WALL_SLOPE_BOTTOM ) ), rgb( M, M, 255-M )
			next J
			line SOURCE_BUFFER, ( ( I * 16 ) - CAMERA.X + 320, CHUNK( 6 ).CELL( I ).WALL_Y_TOP( 0 ) - CAMERA.Y )-( ( I * 16 ) - CAMERA.X + 320, CHUNK( 6 ).CELL( I ).WALL_Y_BOTTOM( 0 ) - CAMERA.Y ), rgb( 31, 31, 31 )
			line SOURCE_BUFFER, ( ( ( I + 1 ) * 16 ) - CAMERA.X + 320, CHUNK( 6 ).CELL( I ).WALL_Y_TOP( 1 ) - CAMERA.Y )-( ( ( I + 1 ) * 16 ) - CAMERA.X + 320, CHUNK( 6 ).CELL( I ).WALL_Y_BOTTOM( 1 ) - CAMERA.Y ), rgb( 31, 31, 31 )
			line SOURCE_BUFFER, ( ( I * 16 ) - CAMERA.X + 320, CHUNK( 6 ).CELL( I ).WALL_Y_TOP( 0 ) - CAMERA.Y )-( ( ( I + 1 ) * 16 ) - CAMERA.X - 1 + 320, CHUNK( 6 ).CELL( I ).WALL_Y_TOP( 1 ) - CAMERA.Y ), rgb( 31, 31, 255 )
			line SOURCE_BUFFER, ( ( I * 16 ) - CAMERA.X + 320, CHUNK( 6 ).CELL( I ).WALL_Y_BOTTOM( 0 ) - CAMERA.Y )-( ( ( I + 1 ) * 16 ) - CAMERA.X - 1 + 320, CHUNK( 6 ).CELL( I ).WALL_Y_BOTTOM( 1 ) - CAMERA.Y ), rgb( 31, 255, 31 )
		next I
    ' 
    if MOUSE.REGISTER <> 0 then end
    ' dummy character
		'console( CHARACTER.CELL_ID )
    line SOURCE_BUFFER, ( ( CHARACTER.CELL_ID * 16 ) + CHARACTER.X - CAMERA.X - 5, CHARACTER.Y - CAMERA.Y - 7 )-( ( CHARACTER.CELL_ID * 16 ) + CHARACTER.X - CAMERA.X + 5, CHARACTER.Y - CAMERA.Y + 16 ), rgb( 255, 255, 255 ), bf
    circle SOURCE_BUFFER, ( ( CHARACTER.CELL_ID * 16 ) + CHARACTER.X - CAMERA.X, CHARACTER.Y - CAMERA.Y ), 3, rgb( 255, 0, 0 ), , , , f
    
    line SOURCE_BUFFER, ( 4, 3 )-( 99, 35 ), rgb( 0, 0, 0 ), bf
    draw string SOURCE_BUFFER, ( 4, 4 ), "FPS cap : " & FRAME_RATE.fps_cap, rgb( 255, 127, 0 )
    draw string SOURCE_BUFFER, ( 4, 16 ),  "FPS old : " & FRAME_RATE.frame_counter_sum, rgb( 255, 127, 0 )
    draw string SOURCE_BUFFER, ( 4, 28 ),  "FPS new : " & FRAME_RATE.frame_counter, rgb( 255, 127, 0 )
    
    DISPLAY_SCREEN()
    
    line SOURCE_BUFFER, ( 0, 0 )-( DISPLAY.W - 1, DISPLAY.H - 1 ), rgb( 0, 0, 0), bf
  screenunlock
  L = L + 3
  FRAME_RATE.REGULATE()
loop until( KEY = chr( 27 ) )

'DESTROY_CAMERA()
'DESTROY_MOUSE()
DESTROY_FONT()
DESTROY_SCREEN()