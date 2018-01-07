--[[
        sillyroutines.lua
	(c) 2018 Jeroen Petrus Broks.
	
	This Source Code Form is subject to the terms of the 
	Mozilla Public License, v. 2.0. If a copy of the MPL was not 
	distributed with this file, You can obtain one at 
	http://mozilla.org/MPL/2.0/.
        Version: 18.01.07
]]
function pctype()
    local ret
    -- $IF $WINDOWS
    ret = 'Windows pc'
    -- $FI
    -- $IF $MAC
    ret = 'Mac'
    -- $FI
    -- $IF $LINUX
    ret = 'Linux'
    -- $FI
    -- $IF $IOS
    ret = 'iPhone or iPad or other cheap Apple device'
    -- $FI
    -- $IF $ANDROID
    ret = 'Android mobile device'
    -- $FI
    ret = ret or 'unknown computer thing'
    print('Computer recognised as a '..ret)
    Var.D('$PCTYPE',ret)
    return ret
end    
