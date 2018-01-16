--[[
        main.lua
	(c) 2018 Jeroen Petrus Broks.
	
	This Source Code Form is subject to the terms of the 
	Mozilla Public License, v. 2.0. If a copy of the MPL was not 
	distributed with this file, You can obtain one at 
	http://mozilla.org/MPL/2.0/.
        Version: 18.01.16
]]

-- LAURA in LOVE

-- $USE libs/killcallback
-- $USE libs/console
-- $USE libs/flow
-- $USE libs/gamevar
-- $USE libs/Anna
-- $USE libs/omusic
-- $USE libs/Lib_kthura
-- $USE libs/rpg


RPG=rpg

local laura = {}

-- $IF $TEST
   console.stdoutput = true
-- $FI

function laura.starttext()
   -- for k,v in spairs(console) do print("console."..k) end
   console.writeln("LAURA in LOVE",0,180,255)
   console.writeln("Written by: Jeroen P. Broks",255,180,0)
   console.writeln("Copyright Jeroen P. Broks - Licensed under the terms of the MPL 2.0",180,255,0)
   console.writeln("")
end

function laura.error(emsg,edata)
     local w,h = love.graphics.getDimensions( )
    local stopit = function() quitdontask=true love.event.quit() end
    local dp = function(m1,m2) console.write(m1,255,255,255) console.curx=w/2 console.writeln(m2,0,255,255) end
    local errorflow = {
        draw = console.show,
        keypressed = stopit,
        mousepressed = stopit        
    }
    console.writeln("FATAL ERROR!",255,0,0)
    console.writeln(emsg,255,255,0)
    ;(({
        ['string']   = function(edata) CSay(edata) end,
        ['number']   = function(edata) dp('Data Value:',edata) end,
        ['function'] = function(edata) CSay('Extra function data returned') CSay(serialize('xfd',edata())) end,
        ['table']    = function(edata) CSay('Extra data found') for k,v in spairs(edata) do console.writeln("- "..serialize(k,v),180,0,255) end end
    })[type(edata)] or function() CSay('unprintable data included') end)(edata)
    console.writeln("If you wanna report this, please screenshot this screen and send it along with you bug report.",255,255,255)
    console.writeln("Press any key or mouse button (or touch the screen if you have touch screen) to end this program!",0,180,255)
    flow.set(errorflow)
end    

function laura.assert(condition,emsg,edata)
   if not condition then laura.error(emsg,edata) return false end
   return true
end   

-- Will go to the console if it's activated and loaded. If it's not there, this feature will be ignored.
function laura.goconsole() 
    if not flow.exists("_dc_") then return end
    local b = flow.get()
    flow.set("_dc_")
    flow.get("_dc_").backflow = b
end    

-- This routine sets up a character following my standard procedure for this. 
-- You may use an other setup if you like, but please note, if you use my sub engines, this is the quickest way to go :P
function laura.makechar(name,level)
    if not laura.assert(not rpg:CharExists(name),"Character "..name.." already exists!") then return end
    rpg:CreateChar(name)
    rpg:SetName(name,name)
    if level then
       console.writeln("Setting "..name.." to level "..level)
       print("Setting "..name.." to level "..level)
       laura.setlevel(name,level)
    end
end

function laura.setlevel(ch,level)
       local lvllines = JCR_Lines("Data/Levels/"..ch)
       local scanlevel
       RPGJCRDIR = ""
       for l in each(lvllines) do
           local sl = mysplit(l," ")
           --print(sl[1],scanlevel==level,prefixed(sl[1] or "","STAT."),type(scanlevel),type(level))
           if sl[1]=='LEVEL' then scanlevel=tonumber(sl[2]) or 0 --; print( "Data found for level "..scanlevel)
           elseif scanlevel==level and prefixed(sl[1] or "","STAT.") then
                  local v = tonumber(sl[2]) or 0
                  local gs = mysplit(sl[1],".")
                  local st = gs[2]
                  console.writeln("Defining stat: "..st)
                  print("Defining stat: "..st)
                  rpg:DefStat(ch,"BASE_"..st,v)
                  for k in each({"EQP_","BUFF_","DEBUFF_","PWRUP_","END_"}) do rpg:DefStat(ch,k..st,0) end
                  rpg:ScriptStat(ch,"END_"..st,"libs/laura.rel/chars__ignore.lua","stat")
           end
       end
       rpg:Points(ch,"HP",1).MaxCopy="END_HP"
       rpg:Points(ch,"AP",1).MaxCopy="END_AP"
       rpg:Points(ch,"VIT",1).Maximum=100
       rpg:Points(ch,"HP").Have=rpg:Points(ch,"HP").Maximum
       rpg:Points(ch,"AP").Have=rpg:Points(ch,"AP").Maximum
       rpg:Points(ch,"VIT").Have=rpg:Points(ch,"VIT").Maximum
       CSay(ch.." has "..rpg:Points(ch,"HP").Have.."/"..rpg:Points(ch,"HP").Maximum.." Hit Points")
       CSay(ch.." has "..rpg:Points(ch,"AP").Have.."/"..rpg:Points(ch,"AP").Maximum.." Ability Points")
       CSay(ch.." has "..rpg:Points(ch,"VIT").Have.."/"..rpg:Points(ch,"VIT").Maximum.." Vitality Points")
end
return laura
