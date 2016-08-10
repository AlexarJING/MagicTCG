local up={}
up.magicPower=5
up.magicLVL=10
up.hp=30
up.hp_max=30
up.heroFace={}
up.heroFace.x=20
up.heroFace.y=10
up.heroFace.texture=texture.Face1
up.userName="test"
up.magic={}
up.health={}
up.magic.x=50
up.magic.y=140
up.magic.p=love.graphics.newParticleSystem(texture.magic, 32);
up.magic.p:setParticleLifetime(1, 2); 
up.magic.p:setEmissionRate(40);
up.magic.p:setSizeVariation(1);
up.magic.p:setLinearAcceleration(-20, -20, 20, 20); 
up.magic.p:setColors(255, 255, 255, 255, 255, 255, 255, 50); 
up.health.p=love.graphics.newParticleSystem(texture.GoodEff, 32);
up.health.p:setParticleLifetime(1, 2); 
up.health.p:setEmissionRate(40);
up.health.p:setSizeVariation(1);
up.health.p:setLinearAcceleration(-20, -20, 20, 20); 
up.health.p:setColors(255, 255, 255, 255, 255, 255, 255, 50); 
up.graveyard={}
up.highLightSlot=nil




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



up.slots={}
up.slots.mask={}
for i=1,6 do
	up.slots.mask[i]={
		x=50+(i-1)*90,y=160,
		texture=texture.creatmask
	}
end
up.slots.cards={}

function up.slots.selectSlot()
	state.game.highLightSlot=nil
	local card=state.game.selectedCard
	local pos
	if love.keyboard.isDown("escape") and #card.tween==0 then  
		state.game.state="normal"
		card:moveTo({x=card.x+10,y=card.y-50,rollx=card.rollx-2*math.pi,size=card.size-0.5},0.3,"outQuad")
		state.game.selectedCard=nil
	end
	for k,v in pairs(up.slots.mask) do --如果鼠标悬停在空位上，则空位高亮
		if math.abs(state.game.mx-v.x-45)<=45 and math.abs(state.game.my-v.y-45)<=45 then
			state.game.highLightSlot=v
			pos=k
		end
	end
	if state.game.highLightSlot and gameInput=="clicked" or gameInput=="held" and up.slots.cards[pos]==nil then --如果在高亮出点击且位置为空则进入
		local h=state.game.highLightSlot
		card:moveTo({x=h.x+45,y=h.y+45,rollx=card.rollx-2*math.pi,size=card.size-0.5},0.3,"outQuad")
		reGroup(card,up.slots.cards,k)
		state.game.state="normal"
		up.hand.reRange()
	end
end

function up.slots.selectCard(dt,parent)
	for i=#up.slots.cards,1,-1 do
		up.slots.cards[i]:update(dt,parent)
		if up.slots.cards[i].isHover then 
			state.game.highLightCard=up.slots.cards[i] 
			if (gameInput=="clicked" or gameInput=="held") and state.game.state=="normal" then
				--使用法术
				print("select")
			elseif gameInput=="clicked" or gameInput=="held" and state.game.state=="selectCard" then
				--选择目标
			end
		end
	end
end


up.hand={}
up.hand.x={}
up.hand.y=60
up.hand.cards={}




function up.hand.reRange()
	local cardCount=#up.hand.cards
	if cardCount==0 then return end
	if cardCount<=5 then up.hand.x[1]=350-40*(cardCount-1) else up.hand.x[1]=350-40*4 end
	up.hand.cards[1]:moveTo({x=up.hand.x[1],y=up.hand.y},0.5,"outCubic")
	for i=2,cardCount do
		if cardCount<=5 then 
			up.hand.x[i]=up.hand.x[i-1]+90 
		else
			up.hand.x[i]=up.hand.x[i-1]+400/cardCount
		end
		up.hand.cards[i]:moveTo({x=up.hand.x[i],y=up.hand.y},0.5,"outCubic")
	end
end


function up.hand.refill()
	addLog(up.userName.."抓牌")
	if #up.hand.cards<8 then
		makeCard("WaterElemental","creature","elemental",100,100,1,3,5,10,"名称：水元素\n生命值:10\n攻击技能：3\n技能：消耗【1】魔法，冻结指定生物此处结束",up.hand.cards)
	else --当前卡牌限制为8 超过8则排行最靠前的进入墓地，再加入一个牌
		local dieCard=up.hand.cards[1]
		dieCard:moveTo({x=dieCard.x-10,y=dieCard.y+100},1,"inOutQuad")
		dieCard:moveTo({alpha=0},1,"inCubic")
		--card:moveTo(state,inTime,style,delay,callBack,...)
		dieCard.isDestroy=true
		reGroup(dieCard,up.graveyard)
		makeCard("WaterElemental","creature","elemental",300,300,1,3,5,10,"名称：水元素\n生命值:10\n攻击技能：3\n技能：消耗【1】魔法，冻结指定生物此处结束",up.hand.cards)
	end
end

function up.hand.cast(card)
	if card.class=="creature" then
		card:moveTo({x=card.x-10,y=card.y+50,rollx=card.rollx+2*math.pi,size=card.size+0.5},0.3,"inQuad")
		state.game.selectedCard=card
		state.game.state="selectSlot"
	elseif card.class=="magic" then
--法术有有无target及target限制
	end
end

function up.hand.select(dt,parent)
	for i=#up.hand.cards,1,-1 do
		up.hand.cards[i]:update(dt,parent)
		if up.hand.cards[i].isHover then 
			state.game.highLightCard=up.hand.cards[i] 
			if (gameInput=="clicked" or gameInput=="held") and state.game.state=="normal" then
				up.hand.cast(up.hand.cards[i])
			elseif gameInput=="clicked" or gameInput=="held" and state.game.state=="selectCard" then
				--选择手牌
			end
		end
	end
end



function up.update(dt,parent)
	up.magic.p:update(dt)
	up.health.p:update(dt)
	up.hand.select(dt,parent)
	up.slots.selectCard(dt,parent)
	if state.game.state=="selectSlot" then up.slots.selectSlot() end
	for i=#up.graveyard,1,-1 do
		up.graveyard[i]:update(dt,parent)
		if up.graveyard[i].alpha==0 then table.remove(up.graveyard,i) end
	end

end

function up.draw()
	love.graphics.setColor(255, 255, 255, 255)
	love.graphics.draw(up.heroFace.texture, up.heroFace.x, up.heroFace.y)
	love.graphics.draw(up.magic.p, up.magic.x, up.magic.y)
	love.graphics.draw(up.health.p,up.magic.x, up.magic.y+13)
	love.graphics.setFont(font)
	love.graphics.print(up.magicPower.."/"..up.magicLVL, up.magic.x+20, up.magic.y-5)
	love.graphics.print(up.hp.."/"..up.hp_max, up.magic.x+20, up.magic.y+8)
	love.graphics.setColor(255, 255, 255, 155)
	for k,v in pairs(up.slots.mask) do
		love.graphics.draw(v.texture, v.x, v.y)
	end
	if state.game.highLightSlot then
		local v=state.game.highLightSlot
		love.graphics.setColor(255, 255, 255, 200)
		love.graphics.draw(v.texture, v.x, v.y)
	end
	for k,v in pairs(up.hand.cards) do
		v:draw()
	end
	for k,v in pairs(up.slots.cards) do
		v:draw()
	end	
	for k,v in pairs(up.graveyard) do
		v:draw()
	end
	if state.game.selectedCard then 
		state.game.selectedCard:draw()
	end
end


return up