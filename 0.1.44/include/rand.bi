
type udt_XORSHIFT
  as ulong SEED
  declare constructor()
  declare function RND overload () as ulong
  declare function RND overload ( byval _min as ulong, _
                                  byval _max as ulong ) as ulong
end type

dim as udt_XORSHIFT XORSHIFT

constructor udt_XORSHIFT()
  SEED = timer
end constructor

function udt_XORSHIFT.RND() as ulong
  SEED = SEED xor ( SEED shr 13 )
  SEED = SEED xor ( SEED shl 17 )
  SEED = SEED xor ( SEED shr 5 )
  return SEED
end function