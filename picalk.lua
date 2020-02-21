w=cp.WindowList.new("Pi")
t=cp.TextView.new()
t:setText("4556")
it=cp.TextView.new()
w:addView(t)
w:addView(it)
cp.displayWindow(w)

pi=0
c=0
while c<1000000000 do
  v=4/(c*2+1)
  if c%2==0 then
    pi=pi+v
  else
    pi=pi-v
  end
  c=c+1
  if c%10000==0 then
    t:setText(pi)
    it:setText(c)
  end
end