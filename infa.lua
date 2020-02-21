inp=cp.TextArea.new()
inp.w=127
inp.x=0
inp.y=49
fun=nil
inp.keyUp=function(c) 
  e="return function(x,y,z,w) return "..inp:getText().." end"
  l=load(e)
  if l ~= nil then
    fun=l()
  else
    fun=nil
  end
end

w=cp.Window.new("64")
w:addView(inp)
val={{false,false},{false,true},{true,true},{true,false}}
function tob(n)
  return n>0
end
function ton(n)
  if n then
    return 1
  end
  return 0
end
w.render=function(f)
  if fun~=nil then
    for x=1,4 do
      for y=1,4 do
        f:string(10+x*10,2+y*10,ton(fun(val[x][1],val[x][2],val[y][1],val[y][2])),1,3)
      end
    end
  end
end
cp.displayWindow(w)