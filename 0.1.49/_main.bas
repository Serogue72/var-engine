
' VAR Engine
' Version 0.1.49
' May 21, 2020

windowtitle "VAR Engine 0.1.49"

#include "include/macros.bi"
#include "include/definitions.bi"
#include "include/declarations.bi"
#include "include/user_defined_type.bi"
#include "include/variables.bi"
#include "include/frame_rate.bi"
#include "include/display.bi"
#include "include/font.bi"
#include "include/load_cell.bi"
#include "include/mouse.bi"
#include "include/scancodes.bi"
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





FRAME_RATE.START()
do
  KEYBOARD.lock()
  if FRAME_RATE.RENDER = true then
    if KEYBOARD.pressed( SC_TILDE ) then
      if DISPLAY.SCREENRES_FLAG = 44 then
        DISPLAY.W = 1920
        DISPLAY.H = 1080
        DISPLAY.MULTIPLIER = 6
        DISPLAY.SCREENRES_FLAG = 37
      else
        DISPLAY.W = 320
        DISPLAY.H = 180
        DISPLAY.MULTIPLIER = 1
        DISPLAY.SCREENRES_FLAG = 44
      end if
      change_resolution_DISPLAY()
    end if
    
    UPDATE_OBJECTS()
    UPDATE_MOUSE()
    UPDATE_CHARACTER()
    UPDATE_CAMERA()
    
    screenlock
      CLEAR_BUFFER_DISPLAY()
      
      put DISPLAY.SOURCE_PTR( 0 ), ( -CAMERA.X - 320, -CAMERA.Y ), CHUNK( 4 ).LAYER( 0 ), trans
      put DISPLAY.SOURCE_PTR( 0 ), ( -CAMERA.X, -CAMERA.Y ), CHUNK( 5 ).LAYER( 0 ), trans
      put DISPLAY.SOURCE_PTR( 0 ), ( -CAMERA.X + 320, -CAMERA.Y ), CHUNK( 6 ).LAYER( 0 ), trans
      
      if MOUSE.B then line DISPLAY.SOURCE_PTR( 0 ), ( ( CHARACTER.CELL_ID * 16 ) + CHARACTER.X - CAMERA.X, CHARACTER.Y - CAMERA.Y + 2 )-( DISPLAY.CURSOR_X, DISPLAY.CURSOR_Y ), RGB( 255, rnd * 255, rnd * 255 )
      if MOUSE.X < CAMERA.WIDTH_HALF then
        CHARACTER.SPRITE_IS_LEFT = true
        put DISPLAY.SOURCE_PTR( 0 ), ( ( CHARACTER.CELL_ID * 16 ) + CHARACTER.X - CAMERA.X - 7, CHARACTER.Y - CAMERA.Y - 3 ), CHARACTER.SPRITE_PTR, ( CHARACTER.SPRITE_FRAME * 16, 21 )-( CHARACTER.SPRITE_FRAME * 16 + 15, 41 ), trans
        'line DISPLAY.SOURCE_PTR( 0 ), ( ( CHARACTER.CELL_ID * 16 ) + CHARACTER.X - CAMERA.X - 7, CHARACTER.Y - CAMERA.Y - 3 )-( ( CHARACTER.CELL_ID * 16 ) + CHARACTER.X - CAMERA.X + 8, CHARACTER.Y - CAMERA.Y + 17 ), rgb( 255, 0, 255 ), b
      else
        CHARACTER.SPRITE_IS_LEFT = false
        put DISPLAY.SOURCE_PTR( 0 ), ( ( CHARACTER.CELL_ID * 16 ) + CHARACTER.X - CAMERA.X - 7, CHARACTER.Y - CAMERA.Y - 3 ), CHARACTER.SPRITE_PTR, ( CHARACTER.SPRITE_FRAME * 16, 0 )-( CHARACTER.SPRITE_FRAME * 16 + 15, 20 ), trans
        'line DISPLAY.SOURCE_PTR( 0 ), ( ( CHARACTER.CELL_ID * 16 ) + CHARACTER.X - CAMERA.X - 7, CHARACTER.Y - CAMERA.Y - 3 )-( ( CHARACTER.CELL_ID * 16 ) + CHARACTER.X - CAMERA.X + 8, CHARACTER.Y - CAMERA.Y + 17 ), rgb( 255, 0, 255 ), b
      end if
      DRAW_STRING( 13, 13, rgb( 255, 127, 0 ), "RENDER FPS:" & FRAME_RATE.GFX.FRAME_COUNTER_SUM )
      DRAW_STRING( 13, 14, rgb( 255, 127, 0 ), " INPUT FPS:" & FRAME_RATE.INPUT.FRAME_COUNTER_SUM )
      
      ' below is showing off the visual blur effect
      if KEYBOARD.is_down( SC_LSHIFT ) then ' SHIFT KEY
        DISPLAY.ALPHA_VALUE( 0 ) = 127
      elseif KEYBOARD.is_down( SC_CONTROL ) then ' CTRL KEY
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
loop until( KEYBOARD.pressed( SC_ESCAPE ) )

'destroy_CAMERA()
'destroy_MOUSE()
destroy_CHARACTER()
destroy_CHUNKS()
destroy_FONT()
destroy_DISPLAY()