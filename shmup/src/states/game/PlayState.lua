--[[
    This is the play state which handles which stages to load.
]]

PlayState = Class { __includes = BaseState }

function PlayState:init()
    self.player = Player {
        animations = ENTITY_DEFS['player'].animations,
        walkSpeed = ENTITY_DEFS['player'].walkSpeed,

        x = VIRTUAL_WIDTH / 2 - 8,
        y = VIRTUAL_HEIGHT / 2 - 11,

        width = 26,  --256,
        height = 41, --256,
        hboxw = 13,
        hboxh = 13,

        health = 10,
        maxhealth = 10,

        -- rendering and collision offset for spaced sprites
        offsetY = 5
    }

     --Set the stage level here
     --self.stage = Stage1{player=self.player}
     --self.stage = Sandbox{player = self.player}
    self.stage = Stage1 { player = self.player }


    self.player.stateMachine = StateMachine {
        ['default'] = function() return PlayerDefaultState(self.player) end,
        ['kb'] = function() return PlayerKnockbackState(self.player) end,
        ['dead'] = function() return PlayerDeadState(self.player) end,
    }
    self.player:changeState('default')
    self.resetcheck = true
end

function PlayState:update(dt)
    if love.keyboard.wasPressed('escape') then
        love.event.quit()
    end

    self.player:update(dt)
    self.stage:update(dt)

    if self.player.dead and self.resetcheck then
        self.resetcheck = false
        Timer.after(2, function() 
            gStateMachine:change('game-over')
        end)
    end
end

function PlayState:render()
    love.graphics.push()

    self.stage:render()
    self.player:render()


    love.graphics.pop()

    -- TODO: draw UI here
end
