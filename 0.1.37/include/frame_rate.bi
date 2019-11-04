
type udt_FRAME_RATE
  as ubyte fps_cap
  as double fps_resolution
  
  as double cycle_timer_difference
  as double cycle_timer_previous
  as double cycle_timer
  
  as long sleep_time_default
  as long sleep_time_previous
  as long sleep_time
  
  declare constructor()
  declare sub START()
  declare sub REGULATE()
end type

dim shared as udt_FRAME_RATE FRAME_RATE

constructor udt_FRAME_RATE()
  fps_cap = 30
  fps_resolution = 1 / fps_cap
  
  sleep_time_default = 1000 / fps_cap
  sleep_time_previous = sleep_time_default
end constructor

sub udt_FRAME_RATE.START()
  cycle_timer_previous = timer
end sub

sub udt_FRAME_RATE.REGULATE()
  cycle_timer = timer
  sleep_time = sleep_time_previous + ( ( fps_resolution - cycle_timer + cycle_timer_previous ) * 1000 )
  cycle_timer_previous = cycle_timer
  
  if sleep_time < 1 then
    sleep_time = 1
  elseif sleep_time > sleep_time_default then
    sleep_time = sleep_time_default
  end if
  
  sleep sleep_time, 1
  sleep_time_previous = sleep_time
end sub