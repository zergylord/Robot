require 'io'
require 'sys'
f = io.open('/dev/ttyUSB0','wb')
sensors = io.open('/dev/ttyUSB0','rb')
f:write(string.char(128))
f:flush()
f:write(string.char(131))
f:flush()
--[[
f:write(string.char(129,11))
f:flush()
--]]
VELOCITYCHANGE = 200
ROTATIONCHANGE = 300
velo = VELOCITYCHANGE
rotation = -ROTATIONCHANGE
vr = velo + (rotation/2) 
vl = velo - (rotation/2) 
if vr < 0 then
    vr_mag = math.min(255,-vr)
    vr_sign = 255
else
    vr_mag = math.min(255,vr)
    vr_sign = 0
end
if vl < 0 then
    vl_mag = math.min(255,-vl)
    vl_sign = 255
else
    vl_mag = math.min(255,vl)
    vl_sign = 0
end
print(vr_mag,vl_mag)
--[[
f:write(string.char(145,vr_sign,vr_mag,vl_sign,vl_mag))
f:flush()
--]]
--f:write(string.char(140,3,1,64,16,141,3))
--f:flush()
sys.sleep(1.5)
f:write(string.char(145,0,0,0,0))
f:flush()

--f:write(string.char(148,1,7))
--f:flush()

count = 0
while true do
    count = count + 1
    f:write(string.char(142,7))
    f:flush()
    sys.sleep(.1)
    x = nil
    while not x do
        x  = sensors:read("*all")
    end
    print('---------')
    bump_state = string.byte(x:sub(#x,#x))-225
    if bump_state == 0 then
        print('both')
    elseif bump_state == 1 then
        print('left')
    elseif bump_state == 2 then
        print('right')
    else
        print('neither')
    end
end
