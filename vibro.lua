a=cp.Window.new("Vibro")
cp.displayWindow(a)
a.render=function(f)
  v=cp.keyState(15)*5
  if v>0 then
    cp.vibrator(v*5)
  end
  f:string(60,28,v,1,18)
end