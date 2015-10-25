require 'camera'

camera = image.Camera{idx=0, width=320, height=240}

for i = 1,500 do
    sys.tic()
    a = camera:forward()
    sys.toc(true)
    d = image.display{image=a, win=d, zoom=1}
end
camera:stop()
