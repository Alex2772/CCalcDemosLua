sum=0
for i=1,9999 do
  s=tostring(i)
  p=0
  for c in s do
    if p==c then
      sum=sum-1
      break
    end
  end
end
cp.message(9999+sum)