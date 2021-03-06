﻿
sub init_CAMERA()
  CAMERA.WIDTH_HALF = DISPLAY.W / 2
  CAMERA.HEIGHT_HALF = DISPLAY.H / 2
  CAMERA.DIVIDER = 1.15
end sub

sub change_resolution_CAMERA()
  CAMERA.WIDTH_HALF = DISPLAY.W / 2
  CAMERA.HEIGHT_HALF = DISPLAY.H / 2
end sub

sub update_CAMERA()
  CAMERA.X = ( ( ( MOUSE.X - CAMERA.WIDTH_HALF ) / CAMERA.DIVIDER ) / DISPLAY.MULTIPLIER )
    CAMERA.X = CAMERA.X + CHARACTER.X + ( ( CHARACTER.CELL_ID - 10 ) * 16 )
  CAMERA.Y = ( ( ( MOUSE.Y - CAMERA.HEIGHT_HALF ) / CAMERA.DIVIDER ) - CAMERA.HEIGHT_HALF ) / DISPLAY.MULTIPLIER
    CAMERA.Y = CAMERA.Y + CHARACTER.Y
end sub