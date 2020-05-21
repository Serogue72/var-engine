
declare sub init_CAMERA()
declare sub change_resolution_CAMERA()
declare sub update_CAMERA()

declare sub init_CHARACTER()
declare sub update_CHARACTER()
declare sub destroy_CHARACTER()
declare sub update_OBJECTS

declare sub init_DISPLAY()
declare sub change_resolution_DISPLAY()
declare sub destroy_DISPLAY()
declare sub clear_buffer_DISPLAY()
declare sub scale_step_DISPLAY()
declare sub flip_DISPLAY()

declare sub INIT_FONT()
declare sub DESTROY_FONT()
declare function CUSTOM_CONVERT_FONT( byval _SOURCE_PIXEL as uinteger, _
                                      byval _DESTINATION_PIXEL as uinteger, _
                                      byval _PARAMETER as any ptr ) as uinteger
declare function CUSTOM_DRAW_CHARACTER( byval _SOURCE_PIXEL as uinteger, _
                                        byval _DESTINATION_PIXEL as uinteger, _
                                        byval _PARAMETER as any ptr ) as uinteger
declare sub DRAW_CHARACTER( byval _X as integer, _
                            byval _Y as integer, _
                            byval _COLOR as uinteger, _
                            byref _CHARACTER as ubyte )
declare sub DRAW_STRING( byval _X as integer, _
                         byval _Y as integer, _
                         byval _COLOR as uinteger, _
                         byref _STRING as string )

declare sub INIT_CHUNK()
declare sub SWAP_CHUNKS( _direction as integer )
declare sub DESTROY_CHUNKS()

declare sub INIT_MOUSE()
declare sub UPDATE_MOUSE()

