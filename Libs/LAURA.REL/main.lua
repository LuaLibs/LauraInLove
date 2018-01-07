
-- LAURA in LOVE

-- $USE libs/killcallback
-- $USE libs/console
-- $USE libs/flow
-- $USE libs/gamevar
-- $USE libs/Anna
-- $USE libs/omusic
-- $USE libs/Lib_kthura


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


return laura