local down={}
down.magicPower=5
down.magicLVL=10
down.hp=20
down.hp_max=30
down.userName="test2"
down.heroFace={}
down.heroFace.x=20
down.heroFace.y=430
down.heroFace.texture=texture.Face2

down.magic={}
down.magic.x=50
down.magic.y=570
down.magic.p=love.graphics.newParticleSystem(texture.magic, 32);
down.magic.p:setParticleLifetime(1, 2); 
down.magic.p:setEmissionRate(40);
down.magic.p:setSizeVariation(1);
down.magic.p:setLinearAcceleration(-20, -20, 20, 20); 
down.magic.p:setColors(255, 255, 255, 255, 255, 255, 255, 50); 

down.health={}
down.health.p=love.graphics.newParticleSystem(texture.GoodEff, 32);
down.health.p:setParticleLifetime(1, 2); 
down.health.p:setEmissionRate(40);
down.health.p:setSizeVariation(1);
down.health.p:setLinearAcceleration(-20, -20, 20, 20); 
down.health.p:setColors(255, 255, 255, 255, 255, 255, 255, 50); 


down.graveyard={}
down.highLightSlot=nil
-----------------------------------------------------------
local function getPosInGroup(card,tab)
	if not card.group then card.group=tab end
	for k,v in pairs(card.group) do
		if v==card then
			return k
		end
	end
end


local function reGroup(card,toGroup,index)
	table.remove(card.group, getPosInGroup(card))
	if index then
		toGroup[index]=card
	else
		table.insert(toGroup,card)
	end
	card.group=toGroup
end


local function addLog(txt)
	state.game.gameLog=state.game.gameLog.."\n"..txt

end



down.slots={}
down.slots.mask={}
for i=1,6 do
	down.slots.mask[i]={
		x=50+(i-1)*90,y=320,
		texture=texture.creatmask
	}
end
down.slots.cards={}

function down.slots.selectSlot()
	state.game.highLightSlot=nil
	local card=state.game.selectedCard
	local pos
	if love.keyboard.isDown("escape") and #card.tween==0 then  
		state.game.state="normal"
		card:moveTo({x=card.x+10,y=card.y+50,rollx=card.rollx-2*math.pi,size=card.size-0.5},0.3,"outQuad")
		state.game.selectedCard=nil
	end
	for k,v in pairs(down.slots.mask) do --如果鼠标悬停在空位上，则空位高亮
		if math.abs(state.game.mx-v.x-45)<=45 and math.abs(state.game.my-v.y-45)<=45 then
			state.game.highLightSlot=v
			pos=k
		end
	end
	if state.game.highLightSlot and gameInput=="clicked" or gameInput=="held" and down.slots.cards[pos]==nil then --如果在高亮出点击且位置为空则进入
		local h=state.game.highLightSlot
		card:moveTo({x=h.x+45,y=h.y+45,rollx=card.rollx-2*math.pi,size=card.size-0.5},0.3,"outQuad")
		reGroup(card,down.slots.cards,k)
		state.game.state="normal"
		down.hand.reRange()
	end
end

function down.slots.selectCard(dt,parent)
	for i=#down.slots.cards,1,-1 do
		down.slots.cards[i]:update(dt,parent)
		if down.slots.cards[i].isHover then 
			state.game.highLightCard=down.slots.cards[i] 
			if (gameInput=="clicked" or gameInput=="held") and state.game.state=="normal" then
				--使用法术
				print("select")
			elseif gameInput=="clicked" or gameInput=="held" and state.game.state=="selectCard" then
				--选择目标
			end
		end
	end
end


down.hand={}
down.hand.x={}
down.hand.y=500
down.hand.cards={}




function down.hand.reRange()
	local cardCount=#down.hand.cards
	if cardCount==0 then return end
	if cardCount<=5 then down.hand.x[1]=350-40*(cardCount-1) else down.hand.x[1]=350-40*4 end
	down.hand.cards[1]:moveTo({x=down.hand.x[1],y=down.hand.y},0.5,"outCubic")
	for i=2,cardCount do
		if cardCount<=5 then 
			down.hand.x[i]=down.hand.x[i-1]+90 
		else
			down.hand.x[i]=down.hand.x[i-1]+400/cardCount
		end
		down.hand.cards[i]:moveTo({x=down.hand.x[i],y=down.hand.y},0.5,"outCubic")
	end
end


function down.hand.refill()
	addLog(down.userName.."抓牌")
	if #down.hand.cards<8 then
		makeCard("WaterElemental","creature","elemental",100,100,1,3,5,10,"名称：水元素\n生命值:10\n攻击技能：3\n技能：消耗【1】魔法，冻结指定生物此处结束",down.hand.cards)
	else --当前卡牌限制为8 超过8则排行最靠前的进入墓地，再加入一个牌
		local dieCard=down.hand.cards[1]
		dieCard:moveTo({x=dieCard.x-10,y=dieCard.y+100},1,"inOutQuad")
		dieCard:moveTo({alpha=0},1,"inCubic")
		--card:moveTo(state,inTime,style,delay,callBack,...)
		dieCard.isDestroy=true
		reGroup(dieCard,down.graveyard)
		makeCard("WaterElemental","creature","elemental",300,300,1,3,5,10,"名称：水元素\n生命值:10\n攻击技能：3\n技能：消耗【1】魔法，冻结指定生物此处结束",down.hand.cards)
	end
end

function down.hand.cast(card)
	if card.class=="creature" then
		card:moveTo({x=card.x-10,y=card.y-50,rollx=card.rollx+2*math.pi,size=card.size+0.5},0.3,"inQuad")
		state.game.selectedCard=card
		state.game.state="selectSlot"
	elseif card.class=="magic" then
--法术有有无target及target限制
	end
end

function down.hand.select(dt,parent)
	for i=#down.hand.cards,1,-1 do
		down.hand.cards[i]:update(dt,parent)
		if down.hand.cards[i].isHover then 
			state.game.highLightCard=down.hand.cards[i] 
			if (gameInput=="clicked" or gameInput=="held") and state.game.state=="normal" then
				down.hand.cast(down.hand.cards[i])
			elseif gameInput=="clicked" or gameInput=="held" and state.game.state=="selectCard" then
				--选择手牌
			end
		end
	end
end



function down.update(dt,parent)
	down.magic.p:update(dt)
	down.health.p:update(dt)
	down.hand.select(dt,parent)
	down.slots.selectCard(dt,parent)
	if state.game.state=="selectSlot" then down.slots.selectSlot() end
	for i=#down.graveyard,1,-1 do
		down.graveyard[i]:update(dt,parent)
		if down.graveyard[i].alpha==0 then table.remove(down.graveyard,i) end
	end

end

function down.draw()
	love.graphics.setColor(255, 255, 255, 255)
	love.graphics.draw(down.heroFace.texture, down.heroFace.x, down.heroFace.y)
	love.graphics.draw(down.magic.p, down.magic.x, down.magic.y)
	love.graphics.draw(down.health.p,down.magic.x, down.magic.y+13)
	love.graphics.setFont(font)
	love.graphics.print(down.magicPower.."/"..down.magicLVL, down.magic.x+20, down.magic.y-5)
	love.graphics.print(down.hp.."/"..down.hp_max, down.magic.x+20, down.magic.y+8)
	love.graphics.setColor(255, 255, 255, 155)
	for k,v in pairs(down.slots.mask) do
		love.graphics.draw(v.texture, v.x, v.y)
	end
	if state.game.highLightSlot then
		local v=state.game.highLightSlot
		love.graphics.setColor(255, 255, 255, 200)
		love.graphics.draw(v.texture, v.x, v.y)
	end
	for k,v in pairs(down.hand.cards) do
		v:draw()
	end
	for k,v in pairs(down.slots.cards) do
		v:draw()
	end	
	for k,v in pairs(down.graveyard) do
		v:draw()
	end
	if state.game.selectedCard then 
		state.game.selectedCard:draw()
	end
end

return down