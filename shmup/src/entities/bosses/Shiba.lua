--[[
    This defines the Shiba boss. Currently similar to the base Boss, but specifics will be implemented later (such as visual assets.)
]]

Shiba = Class { __includes = Boss }

function Shiba:init(def)
        Boss.init(self, def)
        self.hitradius = 15
        self.movementactive = false
end

function Shiba:trafficMove()
        self.movementactive = true
        local targetx1 = VIRTUAL_WIDTH/4 - self.width/2
        local targety1 = VIRTUAL_HEIGHT/5 -20
        local targetx2 = VIRTUAL_WIDTH/4*3 - self.width/2
        local targety2 = VIRTUAL_HEIGHT/5 + 10

        local roll1 = math.random(1,2)
        local roll2 = math.random(1,2)

        local targetx
        local targety

        if roll1 == 1 then
                targetx = targetx1
        else
                targetx = targetx2
        end
        if roll2 == 1 then
                targety = targety1
        else
                targety = targety2
        end

        Timer.tween(.1, { [self] = {x = targetx, y = targety} })
        Timer.after(1, function()
                self.movementactive = false
            end)

end

function Shiba:recenterMove()
        self.movementactive = true
        local targetx = VIRTUAL_WIDTH/2 - self.width/2
        local targety = VIRTUAL_HEIGHT/2 - self.height/2

        Timer.tween(.1, { [self] = {x = targetx, y = targety} })
        self.movementactive = false
end


function Shiba:update(dt)
        Boss.update(self, dt)
end

function Shiba:render()
        Boss.render(self)
end
