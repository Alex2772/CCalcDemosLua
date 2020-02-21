w=cp.WindowList.new("Lucas")
l0=2
l1=1
for i=1,10 do
  l=cp.TextView.new()
  l:setText(i.." "..l0)
  w:addView(l)
  t=l0+l1
  l0=l1
  l1=t
end
cp.displayWindow(w)