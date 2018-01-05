
-- LAURA in LOVE

-- $USE libs/killcallback
-- $USE libs/console
-- $USE libs/flow
-- $USE libs/gamevar
-- $USE libs/Anna
-- $USE libs/omusic
-- $USE libs/lib_kthura


local laura = {}


function laura.starttext()
   -- for k,v in spairs(console) do print("console."..k) end
   console.writeln("LAURA in LOVE",0,180,255)
   console.writeln("Written by: Jeroen P. Broks",255,180,0)
   console.writeln("Copyright Jeroen P. Broks - Licensed under the terms of the MPL 2.0",180,255,0)
   console.writeln("")
end





return laura