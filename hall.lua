w=cp.Window.new("Vector")
w.render=function(f)
  v=cp.keyState(15)
  if v > 0 then
    f=(v)/15
    cp.toast(f)
    cp.indicator(f,0,0)
  end
end
cp.displayWindow(w)