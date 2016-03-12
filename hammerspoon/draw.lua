-- Draw UI

borderColor={["red"]=250,["green"]=250,["blue"]=0,["alpha"]=1} -- {["red"]=250,["green"]=0,["blue"]=0,["alpha"]=1} -- red
mouseColor={["red"]=250,["green"]=250,["blue"]=0,["alpha"]=1}

local border = nil -- drawn border around focused window

-- Highlight mouse
function mouseHighlight()
  if mouseCircle then
      mouseCircle:delete()
      if mouseCircleTimer then
          mouseCircleTimer:stop()
      end
  end
  mousepoint = hs.mouse.getAbsolutePosition()
  mouseCircle = hs.drawing.circle(hs.geometry.rect(mousepoint.x-20, mousepoint.y-20, 40, 40))
  mouseCircle:setStrokeColor(mouseColor)
  mouseCircle:setFill(false)
  mouseCircle:setStrokeWidth(5)
  mouseCircle:bringToFront(true)
  mouseCircle:show(0.5)

  mouseCircleTimer = hs.timer.doAfter(1, function()
      mouseCircle:hide(0.5)
      hs.timer.doAfter(0.6, function() mouseCircle:delete() end)
  end)
end

-- Erase border from drawBorder()
function eraseHighlight()
    if border then 
        border:delete() 
    end
end

-- Draw border around focused window
function windowHighlight()
    eraseHighlight()
    local win = (hs.window.focusedWindow() and hs.window.focusedWindow() or hs.window.frontmostWindow()) 
    if win == nil or win:isFullScreen() or win:isMinimized() or (not win:isStandard()) or (not win:isVisible()) then 
        return
    end

    local f = win:frame()
    local fx = f.x - 0
    local fy = f.y - 0
    local fw = f.w + 0
    local fh = f.h + 0

    border = hs.drawing.rectangle(hs.geometry.rect(fx, fy, fw, fh))
    border:setStrokeWidth(5)
    border:setStrokeColor(borderColor)
    border:setRoundedRectRadii(5.0, 5.0)
    border:setStroke(true):setFill(false)
    border:setLevel("floating")
    border:show()
end

-- EOF