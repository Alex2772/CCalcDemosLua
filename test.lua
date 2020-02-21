cp.input(5^2)
w=cp.Window.new("WTF")
w.render=function(f)
  for y=0,63 do
    for x=0,127 do
       if cp.random()%2==0 then
         f:rect(x,y,1,1,1)
       end
    end
  end
end
cp.displayWindow(w)