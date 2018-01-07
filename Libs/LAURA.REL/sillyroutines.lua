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