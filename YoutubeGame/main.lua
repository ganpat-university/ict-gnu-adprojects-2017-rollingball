-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- Your code here

---------------------Database Connection--------------------------



---------------------Database Connection Over---------------------

local physics =  require("physics")
physics.start()
physics.setGravity(0,2)
--physics.setAverageCollisionPositions(true)

local background = display.newImage("bg.png",400,300)

local background2 = display.newImage("bg.png",400,900)

local tspike = display.newImage("topspike.png",400,17)
physics.addBody(tspike,"static",{density=9.0, bounce=0.0, friction=5.0})

local life = display.newImage("life2.png",700, 60)
local life2 = display.newImage("life2.png",740, 60)
local life3 = display.newImage("life2.png",780, 60)

local life_counter = 3

local speed = 5


function scrollBack(self,event)
	if self.y < -300 then
		self.y = self.y+1197	
	else
		self.y = self.y - 3
	end
end

background.enterFrame = scrollBack
Runtime:addEventListener("enterFrame",background)

background2.enterFrame = scrollBack
Runtime:addEventListener("enterFrame",background2)

ball = display.newImage("ball.png",display.contentCenterX-250,display.contentCenterY-200)
physics.addBody(ball,"dyanamic",{density=2.5, bounce=0.0, friction=5.0,radius=16})

local function rollTheBallRight(self, event)
  
	if self.y > 600 then
		--[[if life_counter ~= 0 then
			life:removeSelf()
			if life == nil then
				life2:removeSelf()
				life_counter = life_counter - 1
			elseif life2 == nil then
				life3:removeSelf()
				life_counter = life_counter - 1
			end
			life_counter = life_counter - 1]]--
    self.x = 400
    self.y = 45
  end
		--[[if life_counter == 0 then
			local over = display.newText("Game Over",display.contentCenterX, display.contentCenterY)
			Runtime:removeEventListener("enterFrame",ball)
		end
	end]]--
end

local function rollTheBallLeft(self, event)  
  
	if self.y > 600 then		
    --[[if life == nil then
      life2:removeSelf()
      life_counter = life_counter - 1
    elseif life2 == nil then
      life3:removeSelf()
      life_counter = life_counter - 1
    end
    life_counter = life_counter - 1]]--
    self.y = 45
		--[[if life_counter == 0 then
			local over = display.newText("Game Over",display.contentCenterX, display.contentCenterY)
		end
		--local over = display.newText("Game Over",display.contentCenterX, display.contentCenterY)]]--
	end
end

local x_bar = math.random(42,800)
local y_bar = math.random(60,500)

local x_bar2 = math.random(42,800)
local y_bar2 = math.random(60,500)

local x_bar3 = math.random(42,800)
local y_bar3 = math.random(60,500)

--[[local rand = 30

if (x_bar + rand == x_bar2) or (x_bar2 + rand == x_bar3) then
  if (x_bar + rand == x_bar2) then
    x_bar = x_bar + 50
  elseif (x_bar2 + rand == x_bar3) then
    x_bar2 = x_bar2 + 50
  end
end

if (y_bar + rand == y_bar2) or (y_bar2 + rand == y_bar3) then
  if (y_bar + rand == y_bar2) then
    y_bar = y_bar + 50
  elseif (y_bar2 + rand == y_bar3) then
    y_bar2 = y_bar2 + 50
  end
end
]]

local bar = display.newImage("bars.png",x_bar,y_bar)
physics.addBody(bar,"static",{density=2.0, bounce=0.0, friction=5.0})

local bar2 = display.newImage("bars.png",x_bar2,y_bar2)
physics.addBody(bar2,"static",{density=2.0, bounce=0.0, friction=5.0})

local bar3 = display.newImage("bars.png",x_bar3,y_bar3)
physics.addBody(bar3,"static",{density=2.0, bounce=0.0, friction=5.0})

local function scrollBars(self, event)
	if self.y < 40 then
		self.y = self.y+600
		self.x = math.random(50, 750)
	else
		self.y = self.y - 5
	end
end

bar.enterFrame = scrollBars
Runtime:addEventListener("enterFrame", bar)

bar2.enterFrame = scrollBars
Runtime:addEventListener("enterFrame", bar2)

bar3.enterFrame = scrollBars
Runtime:addEventListener("enterFrame", bar3)

local invBarRight = display.newImage("inv_bar.png",807,300)
physics.addBody(invBarRight,"static",{density=1, bounce=7, friction=0})
invBarRight.isVisible = false

local invBarLeft = display.newImage("inv_bar.png",-6,300)
physics.addBody(invBarLeft,"static",{density=1, bounce=7, friction=0})
invBarLeft.isVisible = false

local function onCollision(event)
  
  --physics.setGravity(0,100)
  --Runtime:removeEventListener("enterFrame", ball)
  --Runtime:addEventListener("enterFrame", ball)
  --display.newText("collision function is called with delay",display.contentCenterX+math.random(100),display.contentCenterY+math.random(100))

end

Runtime:addEventListener("collision", onCollision)

score = 0
local txt = display.newText("This function is called with delay " .. score .. "",100,55)
local function pr(event)
  score = score+10
  txt.text = string.format("Score: %d", score)
end

timer.performWithDelay( 1000, pr ,-1)

local function onPress(event)
  
	if event.keyName == "left" then 
		
    while(event.phase == "down" and event.keyName == "left") do
      ball.x = ball.x - speed
    end
    ball.enterFrame = rollTheBallLeft
    print(event.phase)
  end
 
	if event.keyName == "right" then
		
    while(event.phase == "down" and event.keyName == "right") do
      ball.x = ball.x + speed
    end
    ball.enterFrame = rollTheBallRight
    print(event.phase)
	end
  
end

Runtime:addEventListener("key", onPress)

Runtime:addEventListener("enterFrame", ball)