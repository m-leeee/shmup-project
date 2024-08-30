--[[
    This the player state for when the player is knocked back. It handles the displacement as well as locks the player
    from their controls until they leave the state.

    Note: As of current time, this is a subclass of BaseState and not an Entity state such as EntityIdleState.
]]


PlayerKnockbackState = Class { __includes = BaseState }

function PlayerKnockbackState:init(player)
    self.player = player
    self.direction = 0 --give this in degrees, similar to BossBullet. radians are not real to me
    self.duration = 0  --how many seconds to KB for


    self.speed = 300
    -- render offset for spaced character sprite; negated in render function of state
    self.player.offsetY = 5
    self.player.offsetX = 0
    --self.player:changeAnimation('idle') --TODO: update animation when i have it

    self.timercheck = 0
end

function PlayerKnockbackState:update(dt)
    self.direction = self.player.knockbacktracker[1]
    self.duration = self.player.knockbacktracker[2]
    self.rad = math.rad(self.direction)
    self.player.y = self.player.y + math.cos(self.rad) * self.speed * dt
    self.player.x = self.player.x + math.sin(self.rad) * self.speed * dt

    if self.timercheck == 0 then
        self.timercheck = 1
        Timer.after(self.duration, function() --self.duration, function()
            self.player:changeState('default')
        end)
    end

    local hx = self.player.width / 2
    local hy = self.player.height / 2
    if self.player.hitx < 0 then
        self.player.x = 0 - hx
    elseif self.player.hitx > VIRTUAL_WIDTH then
        self.player.x = VIRTUAL_WIDTH - hx
    elseif self.player.hity < 0 then
        self.player.y = 0 - hy
    elseif self.player.hity > VIRTUAL_HEIGHT then
        self.player.y = VIRTUAL_HEIGHT - hy
    end

end

function PlayerKnockbackState:render()
    local anim = self.player.currentAnimation

    love.graphics.draw(gTextures[anim.texture], gFrames[anim.texture][anim:getCurrentFrame()], self.player.x,
        self.player.y,
        0, 1, 1, 1, 1)
end
