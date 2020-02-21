w=cp.Window.new("Indicator")
function r(v)
  return cp.keyState(v)/15.0
end
w.render=function(f)
  cp.indicator(r(0),r(1),r(2))
end
cp.displayWindow(w)