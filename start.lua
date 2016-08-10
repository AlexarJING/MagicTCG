local scene = Gamestate.new()
local ui={}
local function uiSetVisible(toggle)
	ui.panel:SetVisible(toggle)
	for k,v in pairs(ui.buttons) do
		v:SetVisible(toggle)
	end
end
function scene:init()
	--loadstartUI
	ui.panel=loveframes.Create("panel")
	ui.panel:SetSize(50, 400)
	ui.panel:SetPos(50, -400)
	ui.panel.tween=tween.new(1, ui.panel, {x=50,y=50}, 'outBounce')
	

	ui.buttons={}
	
	ui.buttons.start=loveframes.Create("button")
	ui.buttons.start:SetWidth(100)
	ui.buttons.start:SetPos(-100, 100)
	ui.buttons.start:SetText("快速对决")
	ui.buttons.start.tween=tween.new(1, ui.buttons.start, {x=60,y=100}, 'outCubic')
	ui.buttons.start.OnClick = function()
		uiSetVisible(false)
		Gamestate.switch(state.game)
	end
	

	ui.buttons.edit=loveframes.Create("button")
	ui.buttons.edit:SetWidth(100)
	ui.buttons.edit:SetPos(-100, 150)
	ui.buttons.edit:SetText("卡组编辑")
	ui.buttons.edit.tween=tween.new(1, ui.buttons.edit, {x=60,y=150}, 'outCubic')
	ui.buttons.edit.OnClick = function()
		Gamestate.switch(state.game)
	end
	ui.buttons.edit.tween:set(-0.2)


	ui.buttons.league=loveframes.Create("button")
	ui.buttons.league:SetWidth(100)
	ui.buttons.league:SetPos(-100, 200)
	ui.buttons.league:SetText("锦标赛")
	ui.buttons.league.tween=tween.new(1, ui.buttons.league, {x=60,y=200}, 'outCubic')
	ui.buttons.league.OnClick = function()
		Gamestate.switch(state.game)
	end
	ui.buttons.league.tween:set(-0.4)


	ui.buttons.wiki=loveframes.Create("button")
	ui.buttons.wiki:SetWidth(100)
	ui.buttons.wiki:SetPos(-100, 250)
	ui.buttons.wiki:SetText("卡牌百科")
	ui.buttons.wiki.tween=tween.new(1, ui.buttons.wiki, {x=60,y=250}, 'outCubic')
	ui.buttons.wiki.OnClick = function()
		Gamestate.switch(state.game)
	end
	ui.buttons.wiki.tween:set(-0.6)



	ui.buttons.lab=loveframes.Create("button")
	ui.buttons.lab:SetWidth(100)
	ui.buttons.lab:SetPos(-100, 300)
	ui.buttons.lab:SetText("制作组")
	ui.buttons.lab.tween=tween.new(1, ui.buttons.lab, {x=60,y=300}, 'outCubic')
	ui.buttons.lab.OnClick = function()
		Gamestate.switch(state.game)
	end
	ui.buttons.lab.tween:set(-0.8)



	ui.buttons.quit=loveframes.Create("button")
	ui.buttons.quit:SetWidth(100)
	ui.buttons.quit:SetPos(-100, 350)
	ui.buttons.quit:SetText("退出")
	ui.buttons.quit.tween=tween.new(1, ui.buttons.quit, {x=60,y=350}, 'outCubic')
	ui.buttons.quit.OnClick = function()
		Gamestate.switch(state.game)
	end
	ui.buttons.quit.tween:set(-1)

	ui.bg = love.graphics.newImage("bg.jpg")
end 

function scene:enter()
end


function scene:draw()
	love.graphics.setColor(255, 255, 255, 255)
	love.graphics.draw(ui.bg, 0, 0, 0, 800/ui.bg:getWidth(), 600/ui.bg:getHeight())
	love.graphics.setFont(fontbig)
	love.graphics.setColor(0, 0, 0, 255)
	love.graphics.print("占星大师", 335, 185)
	love.graphics.setColor(255, 20, 20, 255)
	love.graphics.print("占星大师", 330, 180)
	loveframes.draw()
end

function scene:update(dt)
	ui.panel.tween:update(dt)
	for k,v in pairs(ui.buttons) do
		v.tween:update(dt)
	end
end 

function scene:keypressed(key)
	--if key=="a" then  Gamestate.switch(state.game) end
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

