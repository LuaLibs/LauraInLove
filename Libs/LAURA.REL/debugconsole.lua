--[[
        debugconsole.lua
	(c) 2018 Jeroen Petrus Broks.
	
	This Source Code Form is subject to the terms of the 
	Mozilla Public License, v. 2.0. If a copy of the MPL was not 
	distributed with this file, You can obtain one at 
	http://mozilla.org/MPL/2.0/.
        Version: 18.01.08
]]


-- $USE libs/console
-- $USE libs/flow

local dc = {}


--[[
         This code allows you to set up a debug console. This allows you to debug the game.
         Please note, that since Ryanna and all these Libs are just Lua Scripts of which 
         the source code is freely available it will not be so hard for an experienced
         individual to reach it, no matter how well you hide it or disable it.
         
         Of course, since you can easily replace the real 'jcrx' with an alternate tool
         you can put in a few more ways to obfoscate things, but even that is not always
         safe. I guess that's the woe of using a system based on a Lua engine.
         
         You can however if you are really fearful make sure this source is not included and then
         at least this console is unreachable.
         If you stick the "official" routines that is safe. ;)

]]

dc.commands = {}
dc.commands.CSAY = CSay
dc.commands.SAY = CSay
dc.commands.BYE = function () quitdontask = true; love.event.quit() end
dc.commands.EXIT = dc.commands.BYE
dc.commands.QUIT = dc.commands.BYE
dc.commands.FUCK = function () console.writeln("Do you want your mother to hear you say such words?") end
dc.commands.SHIT = dc.commands.FUCK

function dc.commands.FULLSTATS(ch)
    if not rpg:CharExists(ch) then 
       console.write  ("ERROR! ",255,0,0)
       console.writeln("Character '"..ch.."' does not exist")
       return
    end
    local lst = rpg:StatFields(ch)
    for k in each(lst) do
        console.write  (k,255,255,0)
        console.write  (" = ",255,0,0)
        console.writeln(rpg:Stat(ch,k),0,255,255)
    end    
end

dc.commands.VARS = function()
     local k=mysplit(VarList(),"\n")
     for i,v in ipairs(k) do
       local r=255
       local g=0
       local b=math.floor((i/#k)*255)
       console.writeln(v,r,g,b)
     end
end        

dc.draw = console.show


dc.textinput = console.addcmd



function dc.keypressed(keycode,scan)
        if keycode=='backspace' then console.backspace() return end
        if keycode=='escape' then 
           if not laura.assert(dc.backflow,"I have no backflow to return to") then return end
           flow.set(dc.backflow)
        end
        if keycode=='enter' or keycode=='return' then 
           local p=nil
           local c = console.grabcommand()
           console.writeln(">"..c,255,255,255)
           for i=1,#c do
               if (not p) and mid(c,i,1)==" " then p=i end
           end
           local cmd,para
           if p then
              cmd = left(c,p-1)
              para = mid(c,p+1,#c-p)
           else
              cmd=c
              para = ""
           end
           local ucmd = upper(cmd or '') -- No nil           
           if dc.backflow.consolecommands and dc.backflow.consolecommands[ucmd] then
              dc.backflow.consolecommands[ucmd](dc.backflow,para)
           elseif dc.commands[ucmd] then
              dc.commands[ucmd](para)
           else
              console.writeln("I don't understand the command: "..cmd,255,0,0)
           end
         end            
end

flow.define("_dc_",dc)

return true
