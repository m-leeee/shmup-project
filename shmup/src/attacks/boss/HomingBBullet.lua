--[[
    Bullets that enemies shoot. Follows a given direction linearly.
]]
HomingBBullet = Class { __includes = BossBullet }

function HomingBBullet:init(def)
    BossBullet.init(self, def) -- does not need direction defined like BossBullet does. Should it be defined, it will be ignored. 
    self.player=def.player --tracks a given player 
    self.tracktimer = def.tracktimer --how long the homing bullet will track the player 
    self.tracking = true
    Timer.after(self.tracktimer, function()
        self.tracking = false
    end)
    self.donetimer = false --checks if timer for deletion has started
    self.behavior = def.behavior --'stop','lockon' 
    self.tx = 0
    self.ty = 0
    self.locktime = def.locktime
end

function HomingBBullet:collides(target)
    BossBullet.collides(self, target)
end

function HomingBBullet:update(dt)

    if self.tracking then
        self.tx = self.player.hitx
        self.ty = self.player.hity
        local sx = self.x
        local sy = self.y
        local dx = self.tx - sx
        local dy = self.ty - sy 
        local dtotal = math.abs(dx) + math.abs(dy)
        self.x = self.x + self.speed * dx/dtotal * dt
        self.y = self.y + self.speed * dy/dtotal * dt

    elseif self.behavior == 'stop' then
        if self.donetimer == false then
            Timer.after(.1, function()
                self.done = true
            end)
            self.donetimer = true
        end
    elseif self.behavior == 'lockon' then

        Timer.tween(self.locktime, { [self] = {x = self.tx, y = self.ty} })
        if self.donetimer == false then
            Timer.after(self.locktime, function()
                self.done = true
            end)
            self.donetimer = true
        end

    end


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

function HomingBBullet:render() --(adjacentOffsetX,adjacentOffsetY)

    --This is for debug/visualization purposes. Uncomment if needed. 
--[[      love.graphics.setColor(100, 0, 0, 225)
    love.graphics.circle("fill", self.x , self.y , self.radius)  ]]

    love.graphics.setColor(255, 255, 255) --reset to white
    local anim = self.animations['default']
    love.graphics.draw(gTextures[anim.texture], gFrames[anim.texture][anim:getCurrentFrame()], self.x-self.radius,
        self.y-self.radius,
        0, 1, 1, 1, 1) 
end
