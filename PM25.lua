uart.setup(0,2400,8,0,1,0)
 
uart.on("data",function(data)

pm25 = nil

local i = 1
local counter = 0
while data:byte(i)~=nil do

if data:byte(i) == 0xaa then
start = i
break
end
i=i+1
end

if start==nil or data:byte(start+1)==nil then 
return
end

if data:byte(start+2) == nil then
return
end

counter = (data:byte(start+1)*256 + data:byte(start+2))*500/(1024)

pm25 = tostring(counter*3).."."..tostring(counter*30%10).."ug/m2"

start=nil
i=nil

end,0)
