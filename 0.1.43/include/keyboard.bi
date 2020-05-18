
type event field = 1
    type as long
    union
        type
            SCANCODE as long
            ascii as long
        end type
        type
            x as long
            y as long
            dx as long
            dy as long
        end type
        button as long
        z as long
        w as long
    end union
end type

type udt_KEYBOARD
  NUM_KEYS as ubyte
  KEY_ID( 0 to 5 ) as ubyte
  KEY_STATE( 0 to 5 ) as ubyte
end type

dim shared as event E
dim shared as udt_KEYBOARD KEYBOARD
declare sub INIT_KEYBOARD()
declare sub UPDATE_KEYBOARD()

sub INIT_KEYBOARD()
  KEYBOARD.NUM_KEYS = 5
  KEYBOARD.KEY_ID( 0 ) = 1	 'ESCAPE
  KEYBOARD.KEY_ID( 1 ) = 30  'A
  KEYBOARD.KEY_ID( 2 ) = 32  'D
  KEYBOARD.KEY_ID( 3 ) = 18  'W
  KEYBOARD.KEY_ID( 4 ) = 31  'S
  KEYBOARD.KEY_ID( 5 ) = 57  'SPACEBAR
end sub

sub UPDATE_KEYBOARD()
  static as ubyte I
  while screenevent(@E)
    if E.TYPE = 1 then 'EVENT_KEY_PRESS
      for I = 0 to KEYBOARD.NUM_KEYS
        if E.SCANCODE = KEYBOARD.KEY_ID( I ) then KEYBOARD.KEY_STATE( I ) = 1
      next I
    elseif E.TYPE = 2 then 'EVENT_KEY_RELEASE
      for I = 0 to KEYBOARD.NUM_KEYS
        if E.SCANCODE = KEYBOARD.KEY_ID( I ) then KEYBOARD.KEY_STATE( I ) = 0
      next I
    end if
  wend
end sub