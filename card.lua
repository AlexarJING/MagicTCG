local card=class{
	init=function(self,name,class,subclass,x,y,size,cost,atk,hp,txt,group)
		self.name=name --卡牌名称
		self.class=class --类别 派系
		self.subclass=subclass --子类别 种族

		self.texture=texture[self.name]
		if self.class=="creature" then
			self.frame=texture.ramka --
			self.mask=texture.creatmask --
		end
		self.back=texture.unknown
		---------------位置--------------------
		self.x=x --位置
		self.y=y
		self.size=size --大小
		self.rot=0 --旋转角度
		self.rollx=0 --翻转角度
		self.rolly=0 --翻转轴角度
		---------------面板数值-----------------
		self.cost=cost --花费水晶数
		self.atk=atk --攻击
		self.hp=hp --血量
		------------杂项------------------------
		self.price=price --组卡价格
		self.inSlot=0 --所处slot
		self.isSelected=false --是否选择了
		self.txt=txt --卡牌描述
		self.ability=ability --卡牌技能
		self.ability_cost=ab_cost --技能消耗
		self.isHover=false
		self.isDestroy=false
		--self.color=nil
		self.alpha=255
		self.tween={}
		self.group=group
		if group then
			table.insert(group,self)
		end
		self.target=nil
	end
}

function card:update(dt,parent)
	if #self.tween>0 then 
		for k,v in pairs(self.tween) do
			v:update(dt)
		end
	end
	self.isHover=self:mouseTest(parent) and #self.tween==0
end

local function getRelativePos(x,y,rot)
	local x1=math.cos(rot)*x-math.sin(rot)*y
	local y1=math.cos(rot)*y+math.sin(rot)*x
	return x1,y1
end

function card:mouseTest(parent)
	local mx,my = parent.mx,parent.my
	local rox=(mx-self.x)/self.size/math.cos(self.rollx)
	local roy=(my-self.y)/self.size/math.cos(self.rolly)
	local rtx,rty=getRelativePos(rox,roy,-self.rot)
	if rtx<45 and rtx>-45 and rty<45 and rty>-45 then
		parent.mx=0;parent.my=0
		return true
	end
end
function card:draw()
	tempCardCanvas:clear() 
	if math.cos(self.rollx)*math.cos(self.rolly)>0 then --画正面
		love.graphics.setCanvas( tempCardCanvas )
		love.graphics.setColor(255, 255, 255, 255)
		if self.mask then love.graphics.draw(self.mask,0,0) end
		love.graphics.draw(self.texture,2,10)
		if self.frame then love.graphics.draw(self.frame,0,0) end
		love.graphics.setColor(255, 255, 255, 255)
		love.graphics.setFont(font)
		love.graphics.printf(self.cost, 77, 5, 2, "center")
		love.graphics.printf(self.atk, 10, 88, 2, "center")
		love.graphics.printf(self.hp, 77, 88, 2, "center")
		love.graphics.setColor(255, 255, 255, 255)
		love.graphics.setCanvas()
	else --画背面
		love.graphics.setCanvas( tempCardCanvas )
		love.graphics.setColor(255,255,255)
		love.graphics.draw(self.back,2,10)
		love.graphics.setCanvas()
	end
	if self.isHover then
	love.graphics.setColor(255, 255, 255, 255)
	love.graphics.draw(tempCardCanvas, self.x, self.y, self.rot, self.size*math.cos(self.rollx), self.size*math.cos(self.rolly),85/2,85/2)
	elseif self.isDestroy then
	love.graphics.setColor(255, 255, 255, self.alpha)
	love.graphics.draw(tempCardCanvas, self.x, self.y, self.rot, self.size*math.cos(self.rollx), self.size*math.cos(self.rolly),85/2,85/2)	
	else
	love.graphics.setColor(200, 200, 200, 255)
	love.graphics.draw(tempCardCanvas, self.x, self.y, self.rot, self.size*math.cos(self.rollx), self.size*math.cos(self.rolly),85/2,85/2)
	end
end

function card:moveTo(state,inTime,style,delay,callBack,...)
	style=style or "linear"
	delay=delay or 0
	table.insert(self.tween,tween.new(inTime, self, state, style))
	self.tween[#self.tween]:set(-delay)--开始延迟
	local f=function(self,tween,callBack,...) 
		for k,v in pairs(self.tween) do
			if v==tween then
				table.remove(self.tween, k)
			end
		end
		if callBack then callBack(...) end 
	end
	self.tween[#self.tween]:setCallback(f,self,self.tween[#self.tween],callBack,...)
end

function card:select()

end

return card