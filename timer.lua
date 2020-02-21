w=cp.Window.new("Timer")
t=cp.millis()
w.render=function(f)
  s=os.date("%X",(cp.millis()-t)/1000/1000)
  f:string(64-s:len()*7/2,32,s,1,8)
end
w.sleepLock=function()
  return true
end
cp.displayWindow(w)