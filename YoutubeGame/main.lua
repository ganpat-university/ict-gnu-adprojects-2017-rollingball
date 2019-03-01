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
physics.setGravity()

local background = display.newImage("bg.png",400,300)

local background2 = display.newImage("bg.png",400,900)

local tspike = display.newImage("topspike.png",400,17)
physics.addBody(tspike,"static",{density=.1, bounce=0, friction=.5,radius=35})

local life = display.newImage("life2.png",700, 60)
local life2 = display.newImage("life2.png",740, 60)
local life3 = display.newImage("life2.png",780, 60)

local life_counter = 3

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
physics.addBody(ball,"dynamic",{density=.1, bounce=0.2, friction=.5,radius=16})

local function rollTheBallRight(self, event)
	self:applyForce(0.5, 0, self.x, self.y)
	if self.y > 600 then
		--[[display.remove(life)
		life = nil
		if life == nil then
			display.remove(life2)
			life2 = nil
			life_counter = life_counter - 1
		else if life2 == nil then
			display.remove(life3)
			life3 = nil
			life_counter = life_counter - 1
		end
		life_counter = life_counter - 1
		if life_counter == 0 then
			local over = display.newText("Game Over",display.contentCenterX, display.contentCenterY)
		end]]
		self.y = 40
			--local over = display.newText("Game Over",display.contentCenterX, display.contentCenterY)
	end
	if self.x > 800 then
		self.x = 0
	end
	if self.x < 0 then
		self.x = 800
	end
	--print("rollTheBallRight function : " ..event.name)
end

local function rollTheBallLeft(self, event)
	self:applyForce(-0.5, 0, self.x, self.y)
	if self.y > 600 then
		--[[display.remove(life)
		life = nil
		if life == nil then
			display.remove(life2)
			life2 = nil
			life_counter = life_counter - 1
		else if life2 == nil then
			display.remove(life3)
			life3 = nil
			life_counter = life_counter - 1
		end
		life_counter = life_counter - 1
		if life_counter == 0 then
			local over = display.newText("Game Over",display.contentCenterX, display.contentCenterY)
		end]]
		self.y = 40
		--local over = display.newText("Game Over",display.contentCenterX, display.contentCenterY)
	end

	if self.x > 800 then
		self.x = 0
	end
	if self.x < 0 then
		self.x = 800
	end
	--print("rollTheBallLeft function : " ..event.name)
end

local bar = display.newImage("bars.png",math.random(42,800),math.random(60,500))
physics.addBody(bar,"static",{density=.1, bounce=0, friction=.5})

local bar2 = display.newImage("bars.png",math.random(42,800),math.random(60,500))
physics.addBody(bar2,"static",{density=.1, bounce=0, friction=.5})

local bar3 = display.newImage("bars.png",math.random(42,800),math.random(60,500))
physics.addBody(bar3,"static",{density=.1, bounce=0, friction=.5})

local function scrollBars(self, event)
	if self.y < 40 then
		self.y = self.y+600
		self.x = math.random(50, 750)
	else
		self.y = self.y - 3
	end
end

bar.enterFrame = scrollBars
Runtime:addEventListener("enterFrame", bar)

bar2.enterFrame = scrollBars
Runtime:addEventListener("enterFrame", bar2)

bar3.enterFrame = scrollBars
Runtime:addEventListener("enterFrame", bar3)

local function onCollision(event)
	if event.phase == "began" then
		ball.bodyType = "static"
	end
	Runtime:removeEventListener("enterFrame", ball)
end

Runtime:addEventListener("collision", onCollision)

local function onPress(event)
	if event.keyName == "left" then 
		ball.enterFrame = rollTheBallLeft
		Runtime:addEventListener("enterFrame", ball)
		print("onPress function 1st if : " ..event.name)
		print("Key phase 1st if : " ..event.phase)
	end
	if event.keyName == "right" then
		ball.enterFrame = rollTheBallRight
		Runtime:addEventListener("enterFrame", ball)
	end
	if event.phase == "up" then
			Runtime:removeEventListener("enterFrame", ball)
			print("onPress function 2nd if : " ..event.name)
			print("Key phase 2nd if : " ..event.phase)
	end

	--local txt = display.newText("Key pressed : " ..event.keyName, display.contentCenterX, display.contentCenterY+70)
end

Runtime:addEventListener("key", onPress)