--[[
    This is the base class for all Entities, which is inclusive of the player and all enemies/bosses.
]]

Entity = Class {}

function Entity:init(def)
    -- in top-down games, there are four directions instead of two
    self.direction = 'down'

    self.animations = self:createAnimations(def.animations)
    -- put this back in when theres actual animations

    -- dimensions
    self.x = def.x
    self.y = def.y
    self.width = def.width
    self.height = def.height

    self.hitx = self.x + (self.width / 2)
    self.hity = self.y + (self.height / 2)

    -- drawing offsets for padded sprites
    self.offsetX = def.offsetX or 0
    self.offsetY = def.offsetY or 0

    self.walkSpeed = def.walkSpeed

    self.health = def.health
    self.maxhealth = def.maxhealth
    self.hppercent = self.health / self.maxhealth

    -- flags for flashing the entity when hit
    --TODO: Delete me later, likely will not be used
    self.invulnerable = false
    self.invulnerableDuration = 0
    self.invulnerableTimer = 0

    -- timer for turning transparency on and off, flashing
    self.flashTimer = 0
    self.flashing = false --

    self.dead = false
    self.dopacity = 255
    self.drops = false
    self.currentAnimName = 'name'

    self.flashing = false
    self.flashtime = 0
end

function Entity:createAnimations(animations)
    local animationsReturned = {}

    for k, animationDef in pairs(animations) do
        animationsReturned[k] = Animation {
            texture = animationDef.texture or 'entities',
            frames = animationDef.frames,
            interval = animationDef.interval
        }
    end

    return animationsReturned
end

--[[
    AABB with some slight shrinkage of the box on the top side for perspective.
]]
function Entity:collides(target)
    return not (self.x + self.width < target.x or self.x > target.x + target.width or
        self.y + self.height < target.y or self.y > target.y + target.height)
end

function Entity:damage(dmg)
    self.health = self.health - dmg
end

function Entity:goInvulnerable(duration)
    self.invulnerable = true
    self.invulnerableDuration = duration
end

function Entity:changeState(name)
    self.stateMachine:change(name)
end

function Entity:changeAnimation(name)
    self.currentAnimName = name
    self.currentAnimation = self.animations[name]
end

function Entity:update(dt)
    if self.invulnerable then
        self.flashTimer = self.flashTimer + dt
        self.invulnerableTimer = self.invulnerableTimer + dt

        if self.invulnerableTimer > self.invulnerableDuration then
            self.invulnerable = false
            self.invulnerableTimer = 0
            self.invulnerableDuration = 0
            self.flashTimer = 0
        end
    end

    self.stateMachine:update(dt)

    if self.currentAnimation then
        self.currentAnimation:update(dt)
    end

    self.hppercent = self.health / self.maxhealth


    self.hitx = self.x + (self.width / 2)
    self.hity = self.y + (self.height / 2)

    if self.health <= 0 then
        self.dead = true
    end

    if self.flashing then
        self.flashtime = self.flashtime + dt
    end

    if self.dead then
        Timer.tween(1, { [self] = { dopacity = 0 } })
    end
end

function Entity:processAI(params, dt)
    self.stateMachine:processAI(params, dt)
end

function Entity:render(adjacentOffsetX, adjacentOffsetY)
    -- draw sprite slightly transparent if invulnerable every 0.04 seconds
    --TODO: will delete this later if its unnecessary
    if self.invulnerable and self.flashTimer > 0.06 then
        self.flashTimer = 0
        love.graphics.setColor(1, 1, 1, 64 / 255)
    end

    if self.flashing then
        if self.flashtime < .06 then 
            love.graphics.setColor(1, 1, 1, 124 / 255)
        elseif self.flashtime < .12 then 
            love.graphics.setColor(255, 255, 255)
        elseif self.flashtime < .18 then 
            love.graphics.setColor(1, 1, 1, 124 / 255)
        elseif self.flashtime < .24 then
            love.graphics.setColor(255, 255, 255)
        elseif self.flashtime < .30 then
            love.graphics.setColor(1, 1, 1, 124 / 255)
        else
            love.graphics.setColor(255, 255, 255)
            self.flashtime = 0
            self.flashing = false
        end

    else
        love.graphics.setColor(255, 255, 255)
    end

    if self.dead then
        love.graphics.setColor(255, 255, 255,self.dopacity/255)
    end

    self.x, self.y = self.x + (adjacentOffsetX or 0), self.y + (adjacentOffsetY or 0)
    self.stateMachine:render()
    love.graphics.setColor(1, 1, 1, 1)
    self.x, self.y = self.x - (adjacentOffsetX or 0), self.y - (adjacentOffsetY or 0)



    --rudimentary hp bar implementation: white backing at 100pix, purple front scaled to %
    love.graphics.setColor(255, 255, 255, 255)
    love.graphics.rectangle('line', self.x, self.y-5, 40, 1)
    love.graphics.setColor(255, 0, 255, 255)
    if self.health > 0 then
        love.graphics.rectangle('line', self.x, self.y-5, self.hppercent * 40, 1)
        love.graphics.setColor(255, 255, 255, 255)
    end
end
