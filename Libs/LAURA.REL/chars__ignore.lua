--[[
        chars__ignore.lua
	(c) 2018 Jeroen Petrus Broks.
	
	This Source Code Form is subject to the terms of the 
	Mozilla Public License, v. 2.0. If a copy of the MPL was not 
	distributed with this file, You can obtain one at 
	http://mozilla.org/MPL/2.0/.
        Version: 18.01.27
]]
local chars={}
--[[

    This file *CAN* be used by LAURA in LOVE to attach to statistics. 
    Please note, the "__ignore" suffix. It will NOT automatically be included when LAURA is imported.
    This is done to make it possible to include it with the module without HAVING to use it in LAURA.
    
]]

-- $USE libs/rpg


function chars.Stat(ch,st)
    local prefs = {"BASE_","EQP_","BUFF_","DEBUFF_","PWRUP_"}
    if not laura.assert(prefixed(st,"END_"),"Illegal Stat",{ch=ch,st=st}) then return 0 end
    local stat = right(st,#st-4)
    local ret = 0
    for k in each(prefs) do
        local keer = 1
        if k=="DEBUFF_" then keer=0-1 end
        ret = ret + ( rpg:Stat(ch,k..stat) * keer )        
    end 
    return ret
end

function chars.Enemy(ch,st)
    local prefs = {"BASE_","BUFF_"}
    if not laura.assert(prefixed(st,"END_"),"Illegal Stat",{ch=ch,st=st}) then return 0 end
    local stat = right(st,#st-4)
    local ret = 0
    for k in each(prefs) do
        local keer = 1
        --if k=="DEBUFF_" then keer=0-1 end
        ret = ret + ( rpg:Stat(ch,k..stat) * keer )        
    end 
    return ret
end
chars.stat=chars.Stat

return chars
