local scene = Gamestate.new()
function scene:init()
	print("this is in start")	
	local img = love.graphics.newImage("res/pic/icon.bmp");

    psystem = love.graphics.newParticleSystem(img, 1000);
    psystem:setParticleLifetime(2, 3);
    psystem:setEmissionRate(100);
    psystem:setSizeVariation(1);
    psystem:setLinearAcceleration(-50, -50, 50, 50); 
    psystem:setColors(255, 255, 255, 255, 255, 255, 255, 0); 
end 

function scene:enter()
end


function scene:draw()
	love.graphics.draw(psystem, love.graphics.getWidth() * 0.5, love.graphics.getHeight() * 0.5)
end

function scene:update(dt)
	psystem:update(dt);
end 
return scene




--[[
		init             = __NULL__,
		enter            = __NULL__,
		leave            = __NULL__,
		update           = __NULL__,
		draw             = __NULL__,
		focus            = __NULL__,
		keyreleased      = __NULL__,
		keypressed       = __NULL__,
		mousepressed     = __NULL__,
		mousereleased    = __NULL__,
		joystickpressed  = __NULL__,
		joystickreleased = __NULL__,
		quit             = __NULL__,]]

