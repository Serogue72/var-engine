
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
  frame_counter += 1
  
  cycle_timer = timer
  cycle_timer_difference = cycle_timer - cycle_timer_previous
  if cycle_timer_difference > 1 then
    cycle_timer_previous += 1
    frame_counter_sum = frame_counter
    frame_counter = 0
  end if
  
  sleep_time = sleep_time_previous + ( ( fps_resolution - cycle_timer + frame_timer_previous ) * 1000 )
  frame_timer_previous = cycle_timer
  if sleep_time < 1 then
    sleep_time = 1
  elseif sleep_time > sleep_time_default then
    sleep_time = sleep_time_default
  end if
  
  sleep sleep_time, 1
  sleep_time_previous = sleep_time
end sub