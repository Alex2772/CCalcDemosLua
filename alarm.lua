w=cp.Window.new("B")
e=cp.millis()/1000/1000+300
w.render=function(f)
  t=cp.millis()/1000/1000
  if t > e then
    cp.vibrator(15)
  end
  f:string(0,25,e-t,1,14)
end
w.sleepLock=function()
  return true
end
cp.displayWindow(w)