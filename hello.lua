w=cp.Window.new("Hello")
w.render=function(f)
  f:string(0,14,"Hello world",1,10)
end
cp.displayWindow(w)