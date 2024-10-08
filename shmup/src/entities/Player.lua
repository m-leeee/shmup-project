--[[
    This defines the main player controlled unit in game. 
]]

Player = Class { __includes = Entity }

function Player:init(def)
    Entity.init(self, def)
    self.gcdspeed = 1.5
    self.gcdrolled = false
    self.gcdangle = 270
    self.bullets = {}
    self.knockbacktracker = {}
    self.melee = PlayerMelee(self)
    self.lasthp = self.health
end

function Player:update(dt)
    Entity.update(self, dt)

    for k, bullet in pairs(self.bullets) do
        bullet:update(dt)
    end

    for k, bullet in pairs(self.bullets) do
        if bullet.done then
            table.remove(self.bullets, k)
        end
    end

    self.melee:update(dt)
    self.melee.x = self.hitx
    self.melee.y = self.hity

    if self.health < self.lasthp then
        gSounds['hit']:stop()
        gSounds['hit']:play()
        self.flashing = true
    end
    self.lasthp = self.health
    if self.dead then
        self:changeState('dead')
    end
end

function Player:collides(target)
    local selfY, selfHeight = self.y + self.height / 2, self.height - self.height / 2

    return not (self.x + self.width < target.x or self.x > target.x + target.width or
        selfY + selfHeight < target.y or selfY > target.y + target.height)
end

function Player:render()
    self.melee:render()
    Entity.render(self)

    --hitbox
    love.graphics.setColor(255, 0, 255, 255)
    love.graphics.rectangle("fill", self.hitx, self.hity, 1, 1)

    for k, bullet in pairs(self.bullets) do
        bullet:render()
    end

    --gcdroll 
    love.graphics.setColor(255, 0, 255, .7)
    love.graphics.arc( "fill", self.hitx+20, self.hity+20, 15, math.rad(270),math.rad(self.gcdangle))



end
