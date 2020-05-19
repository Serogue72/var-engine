
constructor udt_KEYBOARD()
  this.constructor( 128 )
end constructor

constructor udt_KEYBOARD( byval aNumberOfKeys as integer )
  dim as integer _
    keys => iif( aNumberOfKeys < 128, 128, aNumberOfKeys )
 
  redim _state( 0 to keys - 1 )
  redim _prevState( 0 to keys - 1 )
  redim _heldStartTime( 0 to keys - 1 )
  redim _repeatedStartTime( 0 to keys - 1 )
 
  _mutex => mutexCreate()
end constructor

destructor udt_KEYBOARD()
  mutexDestroy( _mutex )
end destructor

sub udt_KEYBOARD.lock()
  mutexLock( _mutex )
end sub

sub udt_KEYBOARD.unlock()
  mutexUnlock( _mutex )
end sub

function udt_KEYBOARD.pressed( byval scanCode as long ) as boolean
  if( multiKey( scanCode ) ) then
    _prevState( scanCode ) = _state( scanCode )
   
    if( cbool( _prevState( scanCode ) = KeyState.None ) or not cbool( _prevState( scanCode ) and KeyState.Pressed ) ) then
      _state( scanCode ) or= KeyState.Pressed
    end if
  else
    _state( scanCode ) = _state( scanCode ) and not KeyState.Pressed
  end if
  
  return( not cbool( _prevState( scanCode ) and KeyState.Pressed ) and cbool( _state( scanCode ) and KeyState.Pressed ) )
end function

function udt_KEYBOARD.released( byval scanCode as long ) as boolean
  if( not multiKey( scanCode ) ) then
    _prevState( scanCode ) = _state( scanCode )
    
    if( not cbool( _prevState( scanCode ) and KeyState.ReleasedInitialized ) and _
      not cbool( _state( scanCode ) and KeyState.ReleasedInitialized ) ) then
      _state( scanCode ) or= KeyState.ReleasedInitialized
    end if
    
    _state( scanCode ) or= KeyState.Released
  else
    _state( scanCode ) = _state( scanCode ) and not KeyState.Released
  end if
 
  return( cbool( _state( scanCode ) and KeyState.Released ) and _
    not cbool( _prevState( scanCode ) and KeyState.Released ) and _
    cbool( _state( scanCode ) and KeyState.ReleasedInitialized ) and _
    cbool( _prevState( scanCode ) and KeyState.ReleasedInitialized ) )
end function

function udt_KEYBOARD.held( byval scanCode as long, _
  byval interval as double = 0.0 ) as boolean
  
  if( multiKey( scanCode ) ) then
    _prevState( scanCode ) = _state( scanCode )
    
    if( not cbool( _prevState( scanCode ) and KeyState.HeldInitialized ) and _
      not cbool( _state( scanCode ) and KeyState.HeldInitialized ) ) then
      
      _state( scanCode ) or= KeyState.HeldInitialized
      _heldStartTime( scanCode ) = timer()
    end if
    
    if( cbool( _prevState( scanCode ) and KeyState.Held ) or _
      cbool( _prevState( scanCode ) and KeyState.HeldInitialized ) ) then
      
      _state( scanCode ) or= KeyState.Held
      
      dim as double _
        elapsed => ( timer() - _heldStartTime( scanCode ) ) * 1000.0
      
      if( interval > 0.0 and _
        elapsed >= interval ) then
        
        _state( scanCode ) = _state( scanCode ) and not KeyState.Held
      end if
    end if
  else
    _state( scanCode ) = _state( scanCode ) and not KeyState.Held
    _state( scanCode ) = _state( scanCode ) and not KeyState.HeldInitialized
  end if
 
  return( cbool( _prevState( scanCode ) and KeyState.Held ) and _
    cbool( _state( scanCode ) and KeyState.Held ) )
end function

function udt_KEYBOARD.repeated( byval scanCode as long, _
  byval interval as double => 0.0 ) as boolean
 
  dim as boolean isPressed => multiKey( scanCode )
 
  if( isPressed ) then
    _prevState( scanCode ) = _state( scanCode )
    
    if( not cbool( _prevState( scanCode ) and KeyState.RepeatedInitialized ) and _
      not cbool( _state( scanCode ) and KeyState.RepeatedInitialized ) ) then
      
      _state( scanCode ) or=> KeyState.RepeatedInitialized
      _repeatedStartTime( scanCode ) = timer()
    end if
    
    if( _
      cbool( _prevState( scanCode ) and KeyState.Repeated ) or _
      cbool( _prevState( scanCode ) and KeyState.RepeatedInitialized ) ) then
      
      _state( scanCode ) => _state( scanCode ) and not KeyState.Repeated
      
      dim as double elapsed = ( timer() - _repeatedStartTime( scanCode ) ) * 1000.0
      
      if( interval > 0.0 ) then
        if( elapsed >= interval ) then
          _state( scanCode ) or= KeyState.Repeated
          _state( scanCode ) = _state( scanCode ) and not KeyState.RepeatedInitialized
        end if
      else
        return( isPressed )
      end if
    end if
  else
    _state( scanCode ) = _state( scanCode ) and not KeyState.Repeated
    _state( scanCode ) = _state( scanCode ) and not KeyState.RepeatedInitialized
  end if
 
  return( not cbool( _prevState( scanCode ) and KeyState.Repeated ) and _
    cbool( _state( scanCode ) and KeyState.Repeated ) )
end function
