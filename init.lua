function init_OLED(sda,scl)
     sla = 0x3c
     i2c.setup(0, sda, scl, i2c.SLOW)
     disp = u8g.ssd1306_128x64_i2c(sla)

     disp:setFont(u8g.font_6x10)
     disp:setFontRefHeightExtendedText()
     disp:setDefaultForegroundColor()
     disp:setFontPosTop()
      
end

init_OLED(2,1)

wifi.setmode(wifi.SOFTAP)

cfg = {}
cfg.ssid ="My PM25 BOX"
cfg.pwd = "1234567890"
wifi.ap.config(cfg)

svr = net.createServer(net.TCP, 10)
svr:listen(80,function(c)
    c:on("receive", function(c,pl)
     print(pl)
     if pm25~= nil then
     c:send(tostring(dht.getTemperature()/10).."&"..tostring(dht.getHumidity()/10).."&"..tostring(pm25))
     else
     c:send(tostring(dht.getTemperature()/10).."&"..tostring(dht.getHumidity()/10))
     end
    end)
end)

    function pin2smart()
    gpio.mode(5,gpio.INPUT)
    wifi.setmode(wifi.SOFTAP)
    tmr.alarm(0,20,1,function ()
      if gpio.read(5) == false then
        tmr.stop(5)
        wifi.setmode(wifi.STATION)
        wifi.stopsmart(wifi.ESPTOUCH,function() end)
        tmr.alarm(4,30000,0,function() 
          wifi.stopsmart() 
          pin2smart()
      end) 
      end
    end)
  end

  pin2smart()

dofile("update2.lc")



