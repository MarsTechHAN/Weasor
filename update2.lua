require("FontBase")

dht = require("dht_lib")

local mq2 = require("AirQuality_Sensor")
mq2.init()

local function update_dht11(pin)

 dht.read(pin)

 disp:firstPage()
 repeat
   draw_dht11()                         
 until disp:nextPage() == false
end

function draw_dht11()

    disp:drawBitmap( 10, 0, 2, 16, bitmap_lib["wen"] )
    disp:drawBitmap( 26, 0, 2, 16, bitmap_lib["du4"] )
    disp:drawBitmap( 10, 22, 2, 16, bitmap_lib["shi"] )
    disp:drawBitmap( 26, 22, 2, 16, bitmap_lib["du4"] )
    disp:drawBitmap( 10, 44, 1, 16, bitmap_lib["P"] )
    disp:drawBitmap( 18, 44, 1, 16, bitmap_lib["M"] )
    disp:drawBitmap( 26, 44, 1, 16, bitmap_lib["2"] )
    disp:drawBitmap( 34, 44, 1, 16, bitmap_lib["5"] )
    disp:drawBitmap( 42, 44, 2, 16, bitmap_lib["du2"] )
    disp:drawBitmap( 58, 44, 2, 16, bitmap_lib["shu"] )
    
 disp:drawStr(52-6,9,tostring(dht.getTemperature()/10))
 disp:drawBitmap( 70-6, 3, 1, 8, bitmap_lib["du_C"] )

 disp:drawStr(52-6,31,tostring(dht.getHumidity()/10).." %")

 if pm25 ~= nil then
  disp:drawStr(75,50,pm25)
  else
   disp:drawStr(78,50,"No Data")
 end

  disp:drawStr(75,58,tostring(node.heap()/1000).."."..tostring(node.heap()%1000).."KB")
  
  disp:setFont(u8g.font_chikita)
  disp:drawStr(76,6,"MQ2 Sensor Data")

  local wrd = mq2.getSlope()
  
  if wrd ~= -1 then
  disp:drawStr(76,16,wrd)
  disp:drawStr(76,26,"Data: "..tostring(mq2.getSensorValue()))
  end

  disp:setFont(u8g.font_6x10)
end
  -- dofile("PM25.lc")
 update_dht11(3)
  

--tmr.alarm()

tmr.alarm(0,10000,1,function()
update_dht11(3)
print(node.heap())
print(tostring(dht.getTemperature()/10),tostring(dht.getHumidity()/10).." %",ad0, Vot_BAT)
pm25=nil
end)
