
' VAR Engine
' Version 0.1.47
' May 20, 2020

windowtitle "VAR Engine 0.1.47"

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
#include "include/xorshift.bi"

INIT_DISPLAY()
INIT_FONT()
INIT_CHUNK()
INIT_MOUSE()
INIT_CHARACTER()
INIT_CAMERA()

dim as integer I, J, K
dim as ubyte L, M





FRAME_RATE.START()
do
  KEYBOARD.lock()
  if FRAME_RATE.RENDER = true then
    UPDATE_OBJECTS()
    UPDATE_MOUSE()
    UPDATE_CHARACTER()
    UPDATE_CAMERA()
    
    screenlock
      CLEAR_BUFFER_DISPLAY()
      
      put DISPLAY.SOURCE_PTR( 0 ), ( -CAMERA.X - 320, -CAMERA.Y ), CHUNK( 4 ).LAYER( 0 ), trans
      put DISPLAY.SOURCE_PTR( 0 ), ( -CAMERA.X, -CAMERA.Y ), CHUNK( 5 ).LAYER( 0 ), trans
      put DISPLAY.SOURCE_PTR( 0 ), ( -CAMERA.X + 320, -CAMERA.Y ), CHUNK( 6 ).LAYER( 0 ), trans
      
      if MOUSE.REGISTER then line DISPLAY.SOURCE_PTR( 0 ), ( ( CHARACTER.CELL_ID * 16 ) + CHARACTER.X - CAMERA.X, CHARACTER.Y - CAMERA.Y )-( DISPLAY.CURSOR_X, DISPLAY.CURSOR_Y ), RGB( 255, 191, 0 )
      line DISPLAY.SOURCE_PTR( 0 ), ( ( CHARACTER.CELL_ID * 16 ) + CHARACTER.X - CAMERA.X - 5, CHARACTER.Y - CAMERA.Y - 7 )-( ( CHARACTER.CELL_ID * 16 ) + CHARACTER.X - CAMERA.X + 5, CHARACTER.Y - CAMERA.Y + 16 ), rgb( 255, 255, 255 ), bf
      circle DISPLAY.SOURCE_PTR( 0 ), ( ( CHARACTER.CELL_ID * 16 ) + CHARACTER.X - CAMERA.X, CHARACTER.Y - CAMERA.Y ), 3, rgb( 255, 0, 0 ), , , , f
      DRAW_STRING( 13, 13, rgb( 255, 127, 0 ), "RENDER FPS:" & FRAME_RATE.GFX.FRAME_COUNTER_SUM )
      DRAW_STRING( 13, 14, rgb( 255, 127, 0 ), " INPUT FPS:" & FRAME_RATE.INPUT.FRAME_COUNTER_SUM )
      
      ' below is showing off the visual blur effect
      if KEYBOARD.held( 42 ) then ' SHIFT KEY
        DISPLAY.ALPHA_VALUE( 0 ) = 127
      elseif KEYBOARD.held( 29 ) then ' CTRL KEY
        DISPLAY.ALPHA_VALUE( 0 ) = 31
      else
        DISPLAY.ALPHA_VALUE( 0 ) = 255
      end if
      
      FLIP_DISPLAY()
      FRAME_RATE.RENDER = false
    screenunlock
  end if
  KEYBOARD.unlock()
  FRAME_RATE.REGULATE()
loop until( KEYBOARD.is_down( 1 ) )

'DESTROY_CAMERA()
'DESTROY_MOUSE()
DESTROY_CHUNKS()
DESTROY_FONT()
DESTROY_DISPLAY()