w=cp.Window.new("Indicator")
t={}

function r(v)
  if t[v]==nil then
    t[v]=0.5
  end
  t[v]=math.max(math.min(((cp.random()%16384)/8192-1)*0.05+t[v],1),0)
  return t[v]
end
r(0)
m=false
w.keyDown=function(c)
  m=not m
end
w.render=function(f)
  cp.indicator(r(0),r(1),r(2))
  --[[
  if m then
    cp.indicator(0.1,0,0)
  else
    cp.indicator(0,0,0.1)
  end
]]--
end
--cp.displayWindow(w)

while true do
  w.render()
  cp.sleep(50)
end