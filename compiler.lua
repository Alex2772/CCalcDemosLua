n=cp.file()
f=io.open(n.."c","wb")
f:write(string.dump(assert(loadfile(n))))
f:close()