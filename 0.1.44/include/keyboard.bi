type _
  KeyboardInput
 
  public:
    declare constructor()
    declare constructor( _
      byval as integer )
    declare destructor()
   
    declare sub _
      lock()
    declare sub _
      unlock()
   
    declare function _
      pressed( _
        byval as long ) _
      as boolean
    declare function _
      released( _
        byval as long ) _
      as boolean
    declare function _
      held( _
        byval as long, _
        byval as double => 0.0 ) _
      as boolean
    declare function _
      repeated( _
        byval as long, _
        byval as double => 0.0 ) _
      as boolean
   
  private:
    enum _
      KeyState
        None
        Pressed => 1
        Released => 2
        ReleasedInitialized => 4
        Held => 8
        HeldInitialized => 16
        Repeated => 32
        RepeatedInitialized => 64
    end enum
   
    '' These will store the bitflags for the key states
    as ubyte _
      _state( any ), _
      _prevState( any )
   
    /'
      Caches when a key started being held/repeated
    '/
    as double _
      _heldStartTime( any ), _
      _repeatedStartTime( any )
   
    /'
      For using the abstraction in a multithread engine
    '/
    as any ptr _
      _mutex
end type

constructor _
  KeyboardInput()
 
  this.constructor( 128 )
end constructor

constructor _
  KeyboardInput( _
    byval aNumberOfKeys as integer )
 
  dim as integer _
    keys => iif( aNumberOfKeys < 128, _
      128, aNumberOfKeys )
 
  redim _
    _state( 0 to keys - 1 )
  redim _
    _prevState( 0 to keys - 1 )
  redim _
    _heldStartTime( 0 to keys - 1 )
  redim _
    _repeatedStartTime( 0 to keys - 1 )
 
  _mutex => mutexCreate()
end constructor

destructor _
  KeyboardInput()
 
  mutexDestroy( _mutex )
end destructor

/'
  If you are using this in a multithreaded engine, you'll probably have to
  acquire the lock before the keyboard is handled, and release it after the
  handling with this instance has ended. This will prevent some very nasty
  hangs, depending on what method you use to render the screen.
'/
sub _
  KeyboardInput.lock()
 
  mutexLock( _mutex )
end sub

sub _
  KeyboardInput.unlock()
 
  mutexUnlock( _mutex )
end sub

/'
  Returns whether or not a key was pressed.
 
  'Pressed' in this context means that the method will return 'true'
  *once* upon a key press. If you press and hold the key, it will
  not report 'true' until you release the key and press it again.
'/
function _
  KeyboardInput.pressed( _
    byval scanCode as long ) _
  as boolean
 
  if( multiKey( scanCode ) ) then
    _prevState( scanCode ) => _state( scanCode )
   
    if( _
      cbool( _prevState( scanCode ) = KeyState.None ) orElse _
      not cbool( _prevState( scanCode ) and KeyState.Pressed ) ) then
     
      _state( scanCode ) or=> KeyState.Pressed
    end if
  else
    _state( scanCode ) => _state( scanCode ) and not KeyState.Pressed
  end if
 
  return( _
    not cbool( _prevState( scanCode ) and KeyState.Pressed ) andAlso _
    cbool( _state( scanCode ) and KeyState.Pressed ) )
end function

/'
  Returns whether or not a key was released.
 
  'Released' means that a key has to be pressed and then released for
  this method to return 'true' once, just like the 'pressed()' method
  above.
'/
function _
  KeyboardInput.released( _
    byval scanCode as long ) _
  as boolean
 
  if( not multiKey( scanCode ) ) then
    _prevState( scanCode ) => _state( scanCode )
   
    if( _
      not cbool( _prevState( scanCode ) and KeyState.ReleasedInitialized ) andAlso _
      not cbool( _state( scanCode ) and KeyState.ReleasedInitialized ) ) then
     
      _state( scanCode ) or=> KeyState.ReleasedInitialized
    end if
   
    _state( scanCode ) or=> KeyState.Released
  else
    _state( scanCode ) => _state( scanCode ) and not KeyState.Released
  end if
 
  return( _
    cbool( _state( scanCode ) and KeyState.Released ) andAlso _
    not cbool( _prevState( scanCode ) and KeyState.Released ) andAlso _
    cbool( _state( scanCode ) and KeyState.ReleasedInitialized ) andAlso _
    cbool( _prevState( scanCode ) and KeyState.ReleasedInitialized ) )
end function

/'
  Returns whether or not a key is being held.
 
  'Held' means that the key was pressed and is being held pressed, so the
  method behaves pretty much like a call to 'multiKey()', if the 'interval'
  parameter is unspecified.
 
  If an interval is indeed specified, then the method will report the 'held'
  status up to the specified interval, then it will stop reporting 'true'
  until the key is released and held again.
 
  Both this and the 'released()' method expect their intervals to be expressed
  in milliseconds.
'/
function _
  KeyboardInput.held( _
    byval scanCode as long, _
    byval interval as double => 0.0 ) _
  as boolean
 
  if( multiKey( scanCode ) ) then
    _prevState( scanCode ) => _state( scanCode )
 
    if( _
      not cbool( _prevState( scanCode ) and KeyState.HeldInitialized ) andAlso _
      not cbool( _state( scanCode ) and KeyState.HeldInitialized ) ) then
     
      _state( scanCode ) or=> KeyState.HeldInitialized
      _heldStartTime( scanCode ) => timer()
    end if
   
    if( _
      cbool( _prevState( scanCode ) and KeyState.Held ) orElse _
      cbool( _prevState( scanCode ) and KeyState.HeldInitialized ) ) then
     
      _state( scanCode ) or=> KeyState.Held
     
      dim as double _
        elapsed => ( timer() - _heldStartTime( scanCode ) ) * 1000.0
     
      if( _
        interval > 0.0 andAlso _
        elapsed >= interval ) then
       
        _state( scanCode ) => _state( scanCode ) and not KeyState.Held
      end if
    end if
  else
    _state( scanCode ) => _state( scanCode ) and not KeyState.Held
    _state( scanCode ) => _state( scanCode ) and not KeyState.HeldInitialized
  end if
 
  return( _
    cbool( _prevState( scanCode ) and KeyState.Held ) andAlso _
    cbool( _state( scanCode ) and KeyState.Held ) )
end function

/'
  Returns whether or not a key is being repeated.
 
  'Repeated' means that the method will intermittently report the 'true'
  status once 'interval' milliseconds have passed. It can be understood
  as the autofire functionality of some game controllers: you specify the
  speed of the repetition using the 'interval' parameter.
 
  Bear in mind, however, that the *first* repetition will be reported
  AFTER one interval has elapsed. In other words, the reported pattern is
  [pause] [repeat] [pause] instead of [repeat] [pause] [repeat].
 
  If no interval is specified, the method behaves like a call to
  'multiKey()'.
'/
function _
  KeyboardInput.repeated( _
    byval scanCode as long, _
    byval interval as double => 0.0 ) _
  as boolean
 
  dim as boolean _
    isPressed => multiKey( scanCode )
 
  if( isPressed ) then
    _prevState( scanCode ) => _state( scanCode )
 
    if( _
      not cbool( _prevState( scanCode ) and KeyState.RepeatedInitialized ) andAlso _
      not cbool( _state( scanCode ) and KeyState.RepeatedInitialized ) ) then
     
      _state( scanCode ) or=> KeyState.RepeatedInitialized
      _repeatedStartTime( scanCode ) => timer()
    end if
   
    if( _
      cbool( _prevState( scanCode ) and KeyState.Repeated ) orElse _
      cbool( _prevState( scanCode ) and KeyState.RepeatedInitialized ) ) then
     
      _state( scanCode ) => _state( scanCode ) and not KeyState.Repeated
     
      dim as double _
        elapsed => ( timer() - _repeatedStartTime( scanCode ) ) * 1000.0
     
      if( interval > 0.0 ) then
        if( elapsed >= interval ) then
          _state( scanCode ) or=> KeyState.Repeated
          _state( scanCode ) => _state( scanCode ) and not KeyState.RepeatedInitialized
        end if
      else
        return( isPressed )
      end if
    end if
  else
    _state( scanCode ) => _state( scanCode ) and not KeyState.Repeated
    _state( scanCode ) => _state( scanCode ) and not KeyState.RepeatedInitialized
  end if
 
  return( _
    not cbool( _prevState( scanCode ) and KeyState.Repeated ) andAlso _
    cbool( _state( scanCode ) and KeyState.Repeated ) )
end function

dim shared as KeyboardInput KEYBOARD