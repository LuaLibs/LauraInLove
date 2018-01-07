

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
           local ucmd = upper(cmd)
           if dc.commands[ucmd] then
              dc.commands[ucmd](para)
           else
              console.write("I don't understand the command: "..cmd)
           end
         end            
end

flow.define("_dc_",dc)

return true
