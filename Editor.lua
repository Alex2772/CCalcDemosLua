a=cp.Window.new("Privet, Kotsuba!")
file=io.open(cp.file(), "rb")
content=file:read("*all")
file:close()
cp.displayWindow(a)
sx=0
ssx=0
sy=0
ssy=0
r=0
a.render=function(f)
  sx=sx+cp.keyState(6)-cp.keyState(4)+cp.keyState(2)+cp.keyState(10)-cp.keyState(0)-cp.keyState(8)
  ssx=ssx+(sx-ssx)*0.2
  sy=sy+cp.keyState(9)-cp.keyState(1)-cp.keyState(0)-cp.keyState(2)+cp.keyState(8)+cp.keyState(10)
  ssy=ssy+(sy-ssy)*0.2
  r=r+cp.keyState(15)-cp.keyState(11)
  r=math.min(18,math.max(r,3))
  y=0
  maxl=0
  for i in content:gmatch("[^\n]+") do
    f:string(-ssx,12-ssy+y*(r+5),i,1,r)
    maxl=math.max(i:len(),maxl)
    y=y+1
  end
  sx=math.min(maxl*(r+1)-128,math.max(0,sx))
  h=12+y*(r+5)
  sy=math.min(h-64,math.max(0,sy))
end