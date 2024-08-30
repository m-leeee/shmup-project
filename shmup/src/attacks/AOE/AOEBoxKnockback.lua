--[[
    Box AOE that puts player into knockback state
]]

AOEBoxKnockback = Class { __includes = AOEBox }

function AOEBoxKnockback:init(def)
    AOEBox.init(self, def)
    self.degree = def.degree     --direction for knockback
    self.duration = def.duration -- effect duration if applicable
    
    self.bonusanim = {} --to slide this across the screen
    for k, animationDef in pairs(def.bonusanim) do
        self.bonusanim[k] = Animation {
            texture = animationDef.texture,
            frames = animationDef.frames,
            interval = animationDef.interval
        }
    end

    self.bonusanimstart = false
    Timer.after(self.snaptime, function()
        if not self.done then
            self.bonusanimstart = true
        end
    end)
    self.animname = def.animname
    self.baxstart = def.baxstart
    self.baystart = def.baystart
    self.baxend = def.baxend
    self.bayend = def.bayend

end


function AOEBoxKnockback:hits(target)
    if AOEBox.hits(self, target) then
        self.player.knockbacktracker = { self.degree, self.duration }
        self.player:changeState('kb')
    end
end

function AOEBoxKnockback:update(dt)
    

    if self.bonusanimstart then
        Timer.tween(0.4, { [self] = {baxstart = self.baxend, baystart = self.bayend} })
        self.bonusanimstart = false
    end

    if self.snapshot then
        self:hits(self.player)
    end
end

function AOEBoxKnockback:render()
    AOEBox.render(self)

    love.graphics.setColor(255, 255, 255) --reset to white
    local anim2 = self.bonusanim[self.animname]
    love.graphics.draw(gTextures[anim2.texture], gFrames[anim2.texture][anim2:getCurrentFrame()], self.baxstart,
        self.baystart,
        0, 1, 1, 1, 1) 

end
