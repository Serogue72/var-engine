﻿
' VAR Engine
' Version 0.1.43
' May 18, 2020

windowtitle "VAR Engine 0.1.43"

#include "include/macros.bi"
#include "include/definitions.bi"
#include "include/user_defined_type.bi"
#include "include/variables.bi"
#include "include/frame_rate.bi"
#include "include/display.bi"
#include "include/font.bi"
#include "include/load_cell.bi"
#include "include/mouse.bi"
#include "include/keyboard.bi"
#include "include/character.bi"
#include "include/camera.bi"
#include "include/rand.bi"

INIT_DISPLAY()
INIT_FONT()
INIT_CHUNK()
INIT_MOUSE()
INIT_KEYBOARD()
INIT_CHARACTER()
INIT_CAMERA()

dim as integer I, J, K
dim as ubyte L, M
dim as ubyte alpha_value





randomize, 3
FRAME_RATE.START()
do
  UPDATE_KEYBOARD()
  UPDATE_OBJECTS()
  UPDATE_MOUSE()
  UPDATE_CHARACTER()
  UPDATE_CAMERA()
  
  screenlock
    CLEAR_BUFFER_DISPLAY()
    
    ' dummy chunk
		for I = 0 to 19
			K = I * 13
			M = L + K
			for J = 0 to 15
				line DISPLAY.SOURCE_PTR( 0 ), ( ( I * 16 ) - CAMERA.X + J - 320, CHUNK( 4 ).CELL( I ).WALL_Y_TOP( 0 ) - CAMERA.Y + ( J * CHUNK( 4 ).CELL( I ).WALL_SLOPE_TOP ) )-( ( I * 16 ) - CAMERA.X + J - 320, CHUNK( 4 ).CELL( I ).WALL_Y_BOTTOM( 0 ) - CAMERA.Y + ( J * CHUNK( 4 ).CELL( I ).WALL_SLOPE_BOTTOM ) ), rgb( 255-M, 0, 0 )
			next J
			'line DISPLAY.SOURCE_PTR( 0 ), ( ( I * 16 ) - CAMERA.X - 320, CHUNK( 4 ).CELL( I ).WALL_Y_TOP( 0 ) - CAMERA.Y )-( ( I * 16 ) - CAMERA.X - 320, CHUNK( 4 ).CELL( I ).WALL_Y_BOTTOM( 0 ) - CAMERA.Y ), rgb( 31, 31, 31 )
			'line DISPLAY.SOURCE_PTR( 0 ), ( ( ( I + 1 ) * 16 ) - CAMERA.X - 320, CHUNK( 4 ).CELL( I ).WALL_Y_TOP( 1 ) - CAMERA.Y )-( ( ( I + 1 ) * 16 ) - CAMERA.X - 320, CHUNK( 4 ).CELL( I ).WALL_Y_BOTTOM( 1 ) - CAMERA.Y ), rgb( 31, 31, 31 )
			'line DISPLAY.SOURCE_PTR( 0 ), ( ( I * 16 ) - CAMERA.X - 320, CHUNK( 4 ).CELL( I ).WALL_Y_TOP( 0 ) - CAMERA.Y )-( ( ( I + 1 ) * 16 ) - CAMERA.X - 1 - 320, CHUNK( 4 ).CELL( I ).WALL_Y_TOP( 1 ) - CAMERA.Y ), rgb( 31, 31, 255 )
			'line DISPLAY.SOURCE_PTR( 0 ), ( ( I * 16 ) - CAMERA.X - 320, CHUNK( 4 ).CELL( I ).WALL_Y_BOTTOM( 0 ) - CAMERA.Y )-( ( ( I + 1 ) * 16 ) - CAMERA.X - 1 - 320, CHUNK( 4 ).CELL( I ).WALL_Y_BOTTOM( 1 ) - CAMERA.Y ), rgb( 31, 255, 31 )
		next I
		for I = 0 to 19
			K = I * 12
			M = L + K
			for J = 0 to 15
			  line DISPLAY.SOURCE_PTR( 0 ), ( ( I * 16 ) - CAMERA.X + J, CHUNK( 5 ).CELL( I ).WALL_Y_TOP( 0 ) - CAMERA.Y + ( J * CHUNK( 5 ).CELL( I ).WALL_SLOPE_TOP ) )-( ( I * 16 ) - CAMERA.X + J, CHUNK( 5 ).CELL( I ).WALL_Y_BOTTOM( 0 ) - CAMERA.Y + ( J * CHUNK( 5 ).CELL( I ).WALL_SLOPE_BOTTOM ) ), rgb( 0, 255-M, 0 )
			next J
			'line DISPLAY.SOURCE_PTR( 0 ), ( ( I * 16 ) - CAMERA.X, CHUNK( 5 ).CELL( I ).WALL_Y_TOP( 0 ) - CAMERA.Y )-( ( I * 16 ) - CAMERA.X, CHUNK( 5 ).CELL( I ).WALL_Y_BOTTOM( 0 ) - CAMERA.Y ), rgb( 31, 31, 31 )
			'line DISPLAY.SOURCE_PTR( 0 ), ( ( ( I + 1 ) * 16 ) - CAMERA.X, CHUNK( 5 ).CELL( I ).WALL_Y_TOP( 1 ) - CAMERA.Y )-( ( ( I + 1 ) * 16 ) - CAMERA.X, CHUNK( 5 ).CELL( I ).WALL_Y_BOTTOM( 1 ) - CAMERA.Y ), rgb( 31, 31, 31 )
			'line DISPLAY.SOURCE_PTR( 0 ), ( ( I * 16 ) - CAMERA.X, CHUNK( 5 ).CELL( I ).WALL_Y_TOP( 0 ) - CAMERA.Y )-( ( ( I + 1 ) * 16 ) - CAMERA.X - 1, CHUNK( 5 ).CELL( I ).WALL_Y_TOP( 1 ) - CAMERA.Y ), rgb( 31, 31, 255 )
			'line DISPLAY.SOURCE_PTR( 0 ), ( ( I * 16 ) - CAMERA.X, CHUNK( 5 ).CELL( I ).WALL_Y_BOTTOM( 0 ) - CAMERA.Y )-( ( ( I + 1 ) * 16 ) - CAMERA.X - 1, CHUNK( 5 ).CELL( I ).WALL_Y_BOTTOM( 1 ) - CAMERA.Y ), rgb( 31, 255, 31 )
		next I
		for I = 0 to 19
			K = I * 12
			M = L + K
			for J = 0 to 15
			  line DISPLAY.SOURCE_PTR( 0 ), ( ( I * 16 ) - CAMERA.X + J + 320, CHUNK( 6 ).CELL( I ).WALL_Y_TOP( 0 ) - CAMERA.Y + ( J * CHUNK( 6 ).CELL( I ).WALL_SLOPE_TOP ) )-( ( I * 16 ) - CAMERA.X + J + 320, CHUNK( 6 ).CELL( I ).WALL_Y_BOTTOM( 0 ) - CAMERA.Y + ( J * CHUNK( 6 ).CELL( I ).WALL_SLOPE_BOTTOM ) ), rgb( 0, 0, 255-M )
			next J
			'line DISPLAY.SOURCE_PTR( 0 ), ( ( I * 16 ) - CAMERA.X + 320, CHUNK( 6 ).CELL( I ).WALL_Y_TOP( 0 ) - CAMERA.Y )-( ( I * 16 ) - CAMERA.X + 320, CHUNK( 6 ).CELL( I ).WALL_Y_BOTTOM( 0 ) - CAMERA.Y ), rgb( 31, 31, 31 )
			'line DISPLAY.SOURCE_PTR( 0 ), ( ( ( I + 1 ) * 16 ) - CAMERA.X + 320, CHUNK( 6 ).CELL( I ).WALL_Y_TOP( 1 ) - CAMERA.Y )-( ( ( I + 1 ) * 16 ) - CAMERA.X + 320, CHUNK( 6 ).CELL( I ).WALL_Y_BOTTOM( 1 ) - CAMERA.Y ), rgb( 31, 31, 31 )
			'line DISPLAY.SOURCE_PTR( 0 ), ( ( I * 16 ) - CAMERA.X + 320, CHUNK( 6 ).CELL( I ).WALL_Y_TOP( 0 ) - CAMERA.Y )-( ( ( I + 1 ) * 16 ) - CAMERA.X - 1 + 320, CHUNK( 6 ).CELL( I ).WALL_Y_TOP( 1 ) - CAMERA.Y ), rgb( 31, 31, 255 )
			'line DISPLAY.SOURCE_PTR( 0 ), ( ( I * 16 ) - CAMERA.X + 320, CHUNK( 6 ).CELL( I ).WALL_Y_BOTTOM( 0 ) - CAMERA.Y )-( ( ( I + 1 ) * 16 ) - CAMERA.X - 1 + 320, CHUNK( 6 ).CELL( I ).WALL_Y_BOTTOM( 1 ) - CAMERA.Y ), rgb( 31, 255, 31 )
		next I
    ' 
    ' dummy character
		'console( CHARACTER.CELL_ID )
    if MOUSE.REGISTER then line DISPLAY.SOURCE_PTR( 0 ), ( ( CHARACTER.CELL_ID * 16 ) + CHARACTER.X - CAMERA.X, CHARACTER.Y - CAMERA.Y )-( DISPLAY.CURSOR_X, DISPLAY.CURSOR_Y ), RGB( 255, 191, 0 )
    line DISPLAY.SOURCE_PTR( 0 ), ( ( CHARACTER.CELL_ID * 16 ) + CHARACTER.X - CAMERA.X - 5, CHARACTER.Y - CAMERA.Y - 7 )-( ( CHARACTER.CELL_ID * 16 ) + CHARACTER.X - CAMERA.X + 5, CHARACTER.Y - CAMERA.Y + 16 ), rgb( 255, 255, 255 ), bf
    circle DISPLAY.SOURCE_PTR( 0 ), ( ( CHARACTER.CELL_ID * 16 ) + CHARACTER.X - CAMERA.X, CHARACTER.Y - CAMERA.Y ), 3, rgb( 255, 0, 0 ), , , , f
    
    draw string DISPLAY.SOURCE_PTR(0 ), ( 1, 2 ), "FPS:" & FRAME_RATE.frame_counter_sum, rgb( 255, 127, 0 )
    'draw string DISPLAY.SOURCE_PTR( 0 ), ( 1, 14 ), "VERTICAL:" & cast( byte, CHARACTER.V_VEL ), rgb( 255, 127, 0 )
    'if CHARACTER.IS_JUMP then draw string DISPLAY.SOURCE_PTR( 0 ), ( 1, 26 ), "JUMP", rgb( 255, 127, 0 )
    
	if KEYBOARD.KEY_STATE( 4 ) = 1 then
	  alpha_value = 83
	else
	  alpha_value = 191
	end if
    FLIP_DISPLAY( alpha_value )
  screenunlock
  L = L + 6
  FRAME_RATE.REGULATE()
loop until( KEYBOARD.KEY_STATE( 0 ) )

'DESTROY_CAMERA()
'DESTROY_MOUSE()
DESTROY_FONT()
DESTROY_DISPLAY()
