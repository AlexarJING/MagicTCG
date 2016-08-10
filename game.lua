local scene = Gamestate.new()
local ui={}
scene.gameTable={}
local gameTable=scene.gameTable
local bg = love.graphics.newImage("abstract1.jpg")
local bgr=0

scene.highLightCard={}
scene.gameLog="欢迎来到卡牌大师"
scene.state="normal" --"selectCard" --"selectSlot"

gameTable.up=require("up")
gameTable.down=require("down")


function gameTable.getPosInGroup(card) --获取卡牌在表中位置
	for k,v in pairs(card.group) do
		if v==card then
			return k
		end
	end
end

function gameTable.update()
	if scene.highLightCard.txt then  --高亮卡牌
		ui.cardInfoText:SetText(scene.highLightCard.txt)
	else
		ui.cardInfoText:SetText("欢迎")
	end
	if scene.highLightCard.texture then --高亮卡牌图片
		ui.image:SetImage(scene.highLightCard.texture)
	else
		ui.image:SetImage(texture.unknown)
	end
	ui.cardProcText:SetText(scene.gameLog) --设置游戏log
end



function gameTable.reGroup(card,toGroup) --将卡片从原分组移动到另一个
	table.remove(card.group, gameTable.getPosInGroup(card))
	table.insert(toGroup,card)
	card.group=toGroup
end

function scene:init()
	ui.list=loveframes.Create("list") --卡牌描述区
	ui.list:SetPos(600, -100)
	ui.list:SetSize(180, 280)
	ui.list:SetPadding(15)
	ui.list:SetSpacing(15)
	ui.list.tween=tween.new(1, ui.list, {x=600,y=10}, 'outCubic')


	ui.cardInfoText = loveframes.Create("text",ui.list)
	if scene.highLightCard.txt then 
		ui.cardInfoText:SetText(scene.highLightCard.txt) --卡牌描述文字
	else
		ui.cardInfoText:SetText("欢迎")
	end


	loveframes.Create("text",ui.list)

	ui.image = loveframes.Create("image",ui.list) --卡牌描述图片
	if scene.highLightCard.texture then
		ui.image:SetImage(scene.highLightCard.texture)
	else
		ui.image:SetImage(texture.unknown)
	end
	ui.image:SetScale(1.8,1.8)


	ui.list2=loveframes.Create("list") --游戏日志
	ui.list2:SetAutoScroll(true)
	ui.list2:SetPos(600, 0)
	ui.list2:SetSize(180, 280)
	ui.list2:SetPadding(15)
	ui.list2:SetSpacing(15)
	ui.list2.tween=tween.new(1, ui.list2, {x=600,y=310}, 'outCubic')

	--local gameproc="此处写游戏日志"

	ui.cardProcText = loveframes.Create("text",ui.list2)
	ui.cardProcText:SetText(scene.gameLog)

	ui.turnOver=loveframes.Create("button")
	ui.turnOver:SetPos(10,280)
	ui.turnOver:SetSize(100, 30)
	ui.turnOver:SetText("回合结束")
	ui.turnOver.tween=tween.new(30, ui.turnOver, {x=510,y=280})
end 

function scene:enter()
end


function scene:draw()
	love.graphics.setColor(255, 255, 255, 255) --游戏背景图片
	love.graphics.draw(bg, 300, 300, bgr, 1200/bg:getWidth(), 1200/bg:getHeight(),300, 300)
	love.graphics.line(10, 295, 600, 295) --游戏上下分割
	loveframes.draw() --ui
	gameTable.up.draw() --上部
	gameTable.down.draw() --下部
end

function scene:update(dt)
	gameTable.update() --更新ui
	self.mx,self.my= love.mouse.getPosition()
	ui.list.tween:update(dt) --ui的缓动
	ui.list2.tween:update(dt)
	ui.turnOver.tween:update(dt)
	ui.turnOver:SetText("回合结束 "..tostring(30-math.floor(ui.turnOver.tween.clock)))
	gameTable.up.update(dt,self)
	gameTable.down.update(dt,self)
	bgr=bgr+0.01 --游戏背景图片旋转
end 

function scene:keypressed(key)
	if key=="a" then gameTable.up.hand.refill() end
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