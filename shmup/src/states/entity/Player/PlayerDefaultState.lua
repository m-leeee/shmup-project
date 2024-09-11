--[[
    This is the default state for the player, defining animation and stardard controls.
]]
PlayerDefaultState = Class {
    __includes = EntityIdleState
}

function PlayerDefaultState:enter(params)
    self.entity:changeAnimation('idle')
end

function PlayerDefaultState:update(dt)
    if love.keyboard.isDown('left') then -- TODO: Update with animations whenever I get the assets done
        self.entity.direction = 'left'
        self.entity.x = self.entity.x - self.entity.walkSpeed * dt
        -- self.entity:changeAnimation('walk-left')
    elseif love.keyboard.isDown('right') then
        self.entity.direction = 'right'
        self.entity.x = self.entity.x + self.entity.walkSpeed * dt
        -- self.entity:changeAnimation('walk-right')
    elseif love.keyboard.isDown('up') then
        self.entity.direction = 'up'
        self.entity.y = self.entity.y - self.entity.walkSpeed * dt
        -- self.entity:changeAnimation('walk-up')
    elseif love.keyboard.isDown('down') then
        self.entity.direction = 'down'
        self.entity.y = self.entity.y + self.entity.walkSpeed * dt
        -- self.entity:changeAnimation('walk-down')
    end

    --check for wall collisions with hitbox and reset player position if so
    local hx = self.entity.width / 2
    local hy = self.entity.height / 2
    if self.entity.hitx < 0 then
        self.entity.x = 0 - hx
    elseif self.entity.hitx > VIRTUAL_WIDTH then
        self.entity.x = VIRTUAL_WIDTH - hx
    elseif self.entity.hity < 0 then
        self.entity.y = 0 - hy
    elseif self.entity.hity > VIRTUAL_HEIGHT then
        self.entity.y = VIRTUAL_HEIGHT - hy
    end


    if love.keyboard.isDown('e') then
        if self.entity.gcdrolled == false then
            local bullet = PlayerBullet(self.entity)

            table.insert(self.entity.bullets, bullet)

            self.entity.gcdrolled = true -- caps the number of attack actions you can send
            Timer.after(self.entity.gcdspeed, function()
                self.entity.gcdrolled = false
                self.entity.gcdangle = 270
            end)

            Timer.tween(self.entity.gcdspeed-.05, { [self.entity] = {gcdangle = 630}}) --slight offset to prevent graphical glitches
            


        end
    end
    if love.keyboard.isDown('w') then
        if self.entity.gcdrolled == false then
            self.entity.melee.active = true

            self.entity.gcdrolled = true -- caps the number of attack actions you can send
            Timer.after(self.entity.gcdspeed, function()
                self.entity.gcdrolled = false
                self.entity.gcdangle = 270
            end)

            Timer.tween(self.entity.gcdspeed-.05, { [self.entity] = {gcdangle = 630}})
        end
    end
end
