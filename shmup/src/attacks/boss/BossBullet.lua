--[[
    Bullets that enemies shoot. Follows a given direction linearly.
]]
BossBullet = Class {}

function BossBullet:init(def)
    self.boss = def.boss

    self.x = self.boss.x + self.boss.width / 2
    self.y = self.boss.y + self.boss.height / 2
    self.degree = def.degree -- direction of the bullet, 0 is +Y, 90 is +X

    self.radius = def.radius
    self.width = self.radius * 2
    self.height = self.radius * 2

    self.damage = def.damage
    --self.traveled = 0 --for projectiles with a limit
    self.speed = def.speed
    self.done = false --check for deletion

    --self.animations = self:createAnimations(def.animations)
    self.animations = {}

    for k, animationDef in pairs(def.animations) do
        self.animations[k] = Animation {
            texture = animationDef.texture,
            frames = animationDef.frames,
            interval = animationDef.interval
        }
    end

    self.currentAnimation = self.animations['default']

end

function BossBullet:collides(target)
    local centerx = self.x 
    local centery = self.y 
    if ((target.hitx - centerx) ^ 2 + (target.hity - centery) ^ 2) ^ (1 / 2) < self.radius then
        target.health = target.health - self.damage
        self.done = true
        return true --if radius < distance, then true
    end

    return false
end

function BossBullet:update(dt)
    --position update

    local rad = math.rad(self.degree)
    self.y = self.y + math.cos(rad) * self.speed * dt
    self.x = self.x + math.sin(rad) * self.speed * dt


    if (self.x + self.width <= 0) or
        (self.x >= VIRTUAL_WIDTH) or
        (self.y + self.height <= 0) or
        (self.y >= VIRTUAL_HEIGHT) then
        self.done = true
    end

    if self.currentAnimation then
        self.currentAnimation:update(dt)
    end
end

function BossBullet:render() --(adjacentOffsetX,adjacentOffsetY)

    --This is for debug/visualization purposes. Uncomment if needed. 
--[[      love.graphics.setColor(100, 0, 0, 225)
    love.graphics.circle("fill", self.x , self.y , self.radius)  ]]

    love.graphics.setColor(255, 255, 255) --reset to white
    local anim = self.animations['default']
    love.graphics.draw(gTextures[anim.texture], gFrames[anim.texture][anim:getCurrentFrame()], self.x-self.radius,
        self.y-self.radius,
        0, 1, 1, 1, 1) 
end
