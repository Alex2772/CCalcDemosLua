-- Bicycle speedometer with external hall sensor

function spinbox(title, val, mi, ma, callback)
  w = cp.Window.new(title)
  sp = cp.SpinBox.new()
  sp.min = mi
  sp.max = ma
  sp:setValue(val)
  w:addView(sp)
  w.onClose = function()
    s = sp:getValue()
    callback(s)
  end
  sp.y = 15
  cp.displayWindow(w)
end

function saveConfig()
  config = io.open("/spiffs/bicycle.cfg", "w")
  config:write(wheel, "\n")
  config:close()
end
mw = cp.Window.new("Bicycle")
speed = 0.0
wheel = 1.5
ticks = 0
max_speed = 20
avr = 0
graph = {}
for i=0,60 do
	graph[i] = 0
end

underline = {}

function add_underline(name, val, form)
  underline[name] = {value = val, get_string = form}
end
add_underline("DST", 0, function(v)
  if v < 2000 then
    return string.format("%dm", v)
  end
  return string.format("%.2fkm", v / 1000)
end
)

config = io.open("/spiffs/bicycle.cfg", "r")
if config then
  wheel = config:read()
  config:close()
else
  saveConfig()
end
wheel=2.074
mw.render = function(f)
    -- Ticks
	ticks = ticks + 1
	if ticks > 60 then
	  speed = 0
	end
	-- Speedometer
	s = tostring(math.floor(speed))
	f:string(110 - s:len() * 16, 13, s, 1, 17, false);
	f:string(114, 16, math.floor(speed * 10) % 10, 1, 9, false);
	f:string(112, 32, "km/h", 1, 3, false);
	-- Underline
	x = 0
	for k,v in pairs(underline) do
	  y_o = 47
	  f:rect(x, y_o, k:len() * 6 + 2, 12, 1)
	  f:string(x + 1, y_o + 2, k, 0, 0, false)
	  x = x + k:len() * 6 + 5
	  gs = v.get_string(v.value)
	  f:string(x, y_o + 2, gs, 1, 0, false)
	  x = x + gs:len() * 6 + 7
	end
	-- Graph
	f:line(0, 45, 60, 45, 1)
	f:line(60, 14, 60, 45, 1)
	f:string(62, 14, string.format("%.1f", max_speed), 1, 3, false)
	f:string(62, 24, string.format("%.1f", avr), 1, 3, false)
	f:string(62, 38, "0.0", 1, 3, false)
	prev = graph[0]
	for i=0,60 do
	  f:line(i - 1, (1 - prev / max_speed) * 31 + 14, i, (1 - graph[i] / max_speed) * 31 + 14, 1)
	  prev = graph[i]
	end
end

mw.keyLongDown = function(k)
  if k == 15 then
    set = cp.WindowList.new("Settings")
    l = cp.ListItem.new()
    --l:setTitle("Wheel length")
    --l:setText(wheel * 100 .. " cm")
    --set:addView(l)
	set.itemSelected = function(k)
	  if k == 0 then
	    c = function(val)
		  wheel = val / 100
		  saveConfig()
		  l:setText(wheel * 100 .. " cm")
		end
	    spinbox("Wheel length", cp.round(wheel * 100), 10, 400, c)
    end
  end
  cp.displayWindow(set)
  end
end
mw.sleepLock = function()
  return true
end
mw.event = function(e)
	el = e.param / 1000 / 1000
	ticks = 0
	prev = cp.millis()
	spd = wheel / el * 3.6
	if spd < 100 then
		speed = spd
		if max_speed < speed then
			max_speed = speed
		end
		underline.DST.value = underline.DST.value + wheel
	end
end
mw:timer(function()
    sum = 0
	for i=1,60 do
		graph[i - 1] = graph[i]
		sum = sum + graph[i - 1]
	end
	graph[60] = speed
	avr = (sum + speed) / 60
end, 1000)
cp.displayWindow(mw)
