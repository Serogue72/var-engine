﻿
constructor udt_XORSHIFT()
  SEED = timer
end constructor

function udt_XORSHIFT.RND() as ulong
  SEED = SEED xor ( SEED shr 13 )
  SEED = SEED xor ( SEED shl 17 )
  SEED = SEED xor ( SEED shr 5 )
  return SEED
end function
