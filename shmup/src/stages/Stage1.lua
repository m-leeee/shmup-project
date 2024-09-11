--[[
    This is Stage 1, which can be loaded via the PlayState.

    This stage features a shiba inu enemy and its corresponding mechanics.
]]
Stage1 = Class {}

function Stage1:init(def)
    self.player = def.player

    self.boss = Shiba {
        animations = ENTITY_DEFS['shiba'].animations,
        x = VIRTUAL_WIDTH / 2 - 8,
        y = VIRTUAL_HEIGHT / 2 - 11,
        width = 50,  -- 256,
        height = 44, -- 256,
        hboxw = 50,
        hboxh = 44,
        health = 60,
        maxhealth = 60,
        -- rendering and collision offset for spaced sprites
        offsetY = 5
    }

    self.boss.stateMachine = StateMachine {
        ['default'] = function()
            return EntityIdleState(self.boss)
        end
    }
    self.boss:changeState('default')
    self.boss:changeAnimation('idle')

    self.stage = Stage {
        player = self.player
    }

    self.stage:addEnemy(self.boss)

    self.mech1counter = 1
    self.mech2counter = 1
    self.mech3counter = 1
    self.mech4counter = 1

    self.mechdelaycount = 1 --checks whether to delay a mechanic start (for mechanic transitions)
end

function Stage1:mech1()
    -- TENNIS BALL BARRAGE
    local t = 1
    local offset = 0
    if math.random(1,2) == 2 then
        offset = 22.5
    end

    if self.mech1counter == 1 then
        self.mech1counter = self.mech1counter + 1
        Timer.after(t, function()
            local bullet1 = BossBullet {
                boss = self.boss,
                degree = 0+offset,
                radius = 11,
                damage = 1,
                speed = 40,
                animations = ATTACK_DEFS['ball'].animations
            }
            local bullet2 = BossBullet {
                boss = self.boss,
                degree = 45+offset,
                radius = 11,
                damage = 1,
                speed = 40,
                animations = ATTACK_DEFS['ball'].animations
            }
            local bullet3 = BossBullet {
                boss = self.boss,
                degree = 90+offset,
                radius = 11,
                damage = 1,
                speed = 40,
                animations = ATTACK_DEFS['ball'].animations
            }
            local bullet4 = BossBullet {
                boss = self.boss,
                degree = 135+offset,
                radius = 11,
                damage = 1,
                speed = 40,
                animations = ATTACK_DEFS['ball'].animations
            }
            local bullet5 = BossBullet {
                boss = self.boss,
                degree = 180+offset,
                radius = 11,
                damage = 1,
                speed = 40,
                animations = ATTACK_DEFS['ball'].animations
            }
            local bullet6 = BossBullet {
                boss = self.boss,
                degree = -45+offset,
                radius = 11,
                damage = 1,
                speed = 40,
                animations = ATTACK_DEFS['ball'].animations
            }
            local bullet7 = BossBullet {
                boss = self.boss,
                degree = -90+offset,
                radius = 11,
                damage = 1,
                speed = 40,
                animations = ATTACK_DEFS['ball'].animations
            }
            local bullet8 = BossBullet {
                boss = self.boss,
                degree = -135+offset,
                radius = 11,
                damage = 1,
                speed = 40,
                animations = ATTACK_DEFS['ball'].animations
            }

            self.boss:addBullet(bullet1)
            self.boss:addBullet(bullet2)
            self.boss:addBullet(bullet3)
            self.boss:addBullet(bullet4)
            self.boss:addBullet(bullet5)
            self.boss:addBullet(bullet6)
            self.boss:addBullet(bullet7)
            self.boss:addBullet(bullet8)

            self.mech1counter = 1
        end)
    end
end

function Stage1:mech2()
    if self.boss.movementactive == false then
        self.boss:trafficMove()
    end

    -- TRAFFIC
    local r = math.random(1, 5)
    local t
    if r == 1 then
        t = { .5, 1.3, .5, .5, 1.3 }
    elseif r == 2 then
        t = { 1.3, .5, 1.3, .5, .5 }
    elseif r == 3 then
        t = { 1.3, .5, 1.3, 1.3, .5 }
    elseif r == 4 then
        t = { .5, 1.3, .5, 1.3, .5 }
    elseif r == 5 then
        t = { .5, .5, 1.3, 1.3, .5 }
    end
    if self.mech2counter == 1 then
        self.mech2counter = self.mech2counter + 1
        
        local r1 = math.random(1,3) .. 'r'
        local r2 = math.random(1,3) .. 'l'
        local r3 = math.random(1,3) .. 'r'
        local r4 = math.random(1,3) .. 'l'
        local r5 = math.random(1,3) .. 'r'


        Timer.after(t[1], function()
            local aoe1 = AOEBoxKnockback {

                -- coordinates
                x = -1,
                y = -1,

                xlength = VIRTUAL_WIDTH,     
                ylength = VIRTUAL_HEIGHT / 5 + 1,
                damage = 5,                   -- how much damage this AOE will inflict
                snaptime = 1.5,               -- time telegraph will show/when the snapshot occurs
                player = self.player,

                degree = -90,         -- direction for knockback
                duration = .7,         -- effect duration 

                bonusanim = ATTACK_DEFS['car'].animations,
                animname = r1,
                baxstart = VIRTUAL_WIDTH,
                baystart = VIRTUAL_HEIGHT / 10 - 20,
                baxend = -125,
                bayend = VIRTUAL_HEIGHT / 10 -20
            }
            self.stage:addAOE(aoe1)
        end)
        Timer.after(t[2], function()
            local aoe1 = AOEBoxKnockback {

                -- coordinates
                x = -1,
                y = VIRTUAL_HEIGHT / 5,

                xlength = VIRTUAL_WIDTH,
                ylength = VIRTUAL_HEIGHT / 5,

                damage = 5,                   -- how much damage this AOE will inflict
                snaptime = 1.5,               -- time telegraph will show/when the snapshot occurs
                player = self.player,

                degree = 90,          -- direction for knockback
                duration = .7,         -- effect duration 

                bonusanim = ATTACK_DEFS['car'].animations,
                animname = r2,
                baxstart = -125,
                baystart = VIRTUAL_HEIGHT / 5 + VIRTUAL_HEIGHT / 10 - 20,
                baxend = VIRTUAL_WIDTH,
                bayend = VIRTUAL_HEIGHT / 5 + VIRTUAL_HEIGHT / 10 -20
            }
            self.stage:addAOE(aoe1)
        end)
        Timer.after(t[3], function()
            local aoe1 = AOEBoxKnockback {

                -- coordinates
                x = -1,
                y = VIRTUAL_HEIGHT / 5 * 2,

                xlength = VIRTUAL_WIDTH,
                ylength = VIRTUAL_HEIGHT / 5,

                damage = 5,                   -- how much damage this AOE will inflict
                snaptime = 1.5,               -- time telegraph will show/when the snapshot occurs
                player = self.player,
                degree = -90,         -- direction for knockback
                duration = .7,         -- effect duration 

                bonusanim = ATTACK_DEFS['car'].animations,
                animname = r3,
                baxstart = VIRTUAL_WIDTH,
                baystart = VIRTUAL_HEIGHT / 5 * 2 + VIRTUAL_HEIGHT / 10 -20,
                baxend = -125,
                bayend = VIRTUAL_HEIGHT / 5 * 2 + VIRTUAL_HEIGHT / 10 -20
            }
            self.stage:addAOE(aoe1)
        end)
        Timer.after(t[4], function()
            local aoe1 = AOEBoxKnockback {

                -- coordinates
                x = -1,
                y = VIRTUAL_HEIGHT / 5 * 3,

                xlength = VIRTUAL_WIDTH,
                ylength = VIRTUAL_HEIGHT / 5,

                damage = 5,                   -- how much damage this AOE will inflict
                snaptime = 1.5,               -- time telegraph will show/when the snapshot occurs
                player = self.player,
                degree = 90,          -- direction for knockback
                duration = .7,         -- effect duration 

                bonusanim = ATTACK_DEFS['car'].animations,
                animname = r4,
                baxstart = -125,
                baystart = VIRTUAL_HEIGHT / 5 * 3 + VIRTUAL_HEIGHT / 10 -20,
                baxend = VIRTUAL_WIDTH,
                bayend = VIRTUAL_HEIGHT / 5 * 3 + VIRTUAL_HEIGHT / 10 -20

            }
            self.stage:addAOE(aoe1)
        end)
        Timer.after(t[5], function()
            local aoe1 = AOEBoxKnockback {

                -- coordinates
                x = -1,
                y = VIRTUAL_HEIGHT / 5 * 4,

                xlength = VIRTUAL_WIDTH,
                ylength = VIRTUAL_HEIGHT / 5,

                damage = 5,                   -- how much damage this AOE will inflict
                snaptime = 1.5,               -- time telegraph will show/when the snapshot occurs
                player = self.player,

                degree = -90,         -- direction for knockback
                duration = .7,         -- effect duration 

                bonusanim = ATTACK_DEFS['car'].animations,
                animname = r5,
                baxstart = VIRTUAL_WIDTH,
                baystart = VIRTUAL_HEIGHT / 5 * 4 + VIRTUAL_HEIGHT / 10 -20,
                baxend = -125,
                bayend = VIRTUAL_HEIGHT / 5 * 4 + VIRTUAL_HEIGHT / 10 -20

            }
            self.stage:addAOE(aoe1)
        end)
        Timer.after(2.6, function()
            self.mech2counter = 1
        end)
    end
end

function Stage1:mech3()
    -- FRISBEE BOMB TOSS
    local t = 1.3
    if self.mech3counter == 1 then
        
        local bullet1 = HomingBBullet {
            boss = self.boss,
            radius = 11,
            damage = 1,
            speed = 150,
            animations = ATTACK_DEFS['frisbee'].animations,
            player = self.player,
            tracktimer = t,
            behavior = 'lockon',
            locktime = 1
        }
        self.boss:addBullet(bullet1)
        
        Timer.after(t, function()
            local aoe1 = AOECircle {

                -- coordinates
                x = self.player.hitx,
                y = self.player.hity,

                radius = 45,

                damage = 3,   -- how much damage this AOE will inflict
                snaptime = 1, -- time telegraph will show/when the snapshot occurs
                player = self.player

            }
            self.stage:addAOE(aoe1)

            local bullet2 = HomingBBullet {
                boss = self.boss,
                radius = 11,
                damage = 1,
                speed = 150,
                animations = ATTACK_DEFS['frisbee'].animations,
                player = self.player,
                tracktimer = t,
                behavior = 'lockon',
                locktime = 1
            }
            self.boss:addBullet(bullet2)


        end)
        self.mech3counter = self.mech3counter + 1
    elseif self.mech3counter == 2 then

        Timer.after(t * 2, function()
            local aoe1 = AOECircle {

                -- coordinates
                x = self.player.hitx,
                y = self.player.hity,

                radius = 45,

                damage = 3,   -- how much damage this AOE will inflict
                snaptime = 1, -- time telegraph will show/when the snapshot occurs
                player = self.player

            }
            self.stage:addAOE(aoe1)

            local bullet3 = HomingBBullet {
                boss = self.boss,
                radius = 11,
                damage = 1,
                speed = 150,
                animations = ATTACK_DEFS['bomb'].animations,
                player = self.player,
                tracktimer = t,
                behavior = 'lockon',
                locktime = 1
            }
            self.boss:addBullet(bullet3)

        end)
        self.mech3counter = self.mech3counter + 1
    elseif self.mech3counter == 3 then

        local xx = self.player.hitx
        local yy = self.player.hity
        Timer.after(t * 3, function()
            xx = self.player.hitx
            yy = self.player.hity
            local aoe1 = AOECircle {

                -- coordinates
                x = xx,
                y = yy,

                radius = 45,

                damage = 3,   -- how much damage this AOE will inflict
                snaptime = 1, -- time telegraph will show/when the snapshot occurs
                player = self.player

            }
            self.stage:addAOE(aoe1)
        end)
        self.mech3counter = self.mech3counter + 1
        Timer.after((t * 3) + 1, function()
            local aoe2 = AOEDonut {

                -- coordinates
                x = xx,
                y = yy,

                radius = 270,
                inradius = 38,

                damage = 3,      -- how much damage this AOE will inflict
                snaptime = 1,    -- time telegraph will show/when the snapshot occurs
                player = self.player
            }
            self.stage:addAOE(aoe2)
        end)

        Timer.after((t * 3) + 3, function()
            self.mech3counter = 1
        end)
    end
end

function Stage1:mech4()
    -- SANDSTORM
    local t = 1
    if self.mech4counter == 1 then
        self.mech4counter = self.mech4counter + 1
        Timer.after(t, function()
            local aoe1 = AOETriangle {

                -- coordinates
                x = VIRTUAL_WIDTH / 2,
                y = VIRTUAL_HEIGHT / 2,

                x2 = 0,
                y2 = VIRTUAL_HEIGHT,
                x3 = VIRTUAL_WIDTH,
                y3 = VIRTUAL_HEIGHT,

                damage = 3,          -- how much damage this AOE will inflict
                snaptime = 1,        -- time telegraph will show/when the snapshot occurs
                player = self.player

            }
            self.stage:addAOE(aoe1)
        end)
    elseif self.mech4counter == 2 then
        self.mech4counter = self.mech4counter + 1
        Timer.after(t * 2, function()
            local aoe1 = AOETriangle {

                -- coordinates
                x = VIRTUAL_WIDTH / 2,
                y = VIRTUAL_HEIGHT / 2,

                x2 = 0,
                y2 = 0,
                x3 = 0,
                y3 = VIRTUAL_HEIGHT,

                damage = 3,          -- how much damage this AOE will inflict
                snaptime = 1,        -- time telegraph will show/when the snapshot occurs
                player = self.player

            }
            self.stage:addAOE(aoe1)
        end)
    elseif self.mech4counter == 3 then
        self.mech4counter = self.mech4counter + 1
        Timer.after(t * 3, function()
            local aoe1 = AOETriangle {

                -- coordinates
                x = VIRTUAL_WIDTH / 2,
                y = VIRTUAL_HEIGHT / 2,

                x2 = 0,
                y2 = 0,
                x3 = VIRTUAL_WIDTH,
                y3 = 0,

                damage = 3,         -- how much damage this AOE will inflict
                snaptime = 1,       -- time telegraph will show/when the snapshot occurs
                player = self.player

            }
            self.stage:addAOE(aoe1)
        end)
    elseif self.mech4counter == 4 then
        self.mech4counter = self.mech4counter + 1
        Timer.after(t * 4, function()
            local aoe1 = AOETriangle {

                -- coordinates
                x = VIRTUAL_WIDTH / 2,
                y = VIRTUAL_HEIGHT / 2,

                x2 = VIRTUAL_WIDTH,
                y2 = 0,
                x3 = VIRTUAL_WIDTH,
                y3 = VIRTUAL_HEIGHT,

                damage = 3,          -- how much damage this AOE will inflict
                snaptime = 1,        -- time telegraph will show/when the snapshot occurs
                player = self.player

            }
            self.stage:addAOE(aoe1)

            Timer.after(t, function()
                self.mech4counter = 1
            end)
        end)
    end
end

function Stage1:update(dt)
    self.stage:update(dt)

    if self.boss.hppercent > .9 then
        self.boss.phase = 1
    elseif self.boss.hppercent > .75 then
        self.boss.phase = 2
    elseif self.boss.hppercent > .60 then
        self.boss.phase = 3
    elseif self.boss.hppercent > .50 then
        self.boss.phase = 4
    elseif self.boss.hppercent > .40 then
        self.boss.phase = 5
    elseif self.boss.hppercent > .30 then
        self.boss.phase = 2
    elseif self.boss.hppercent > .15 then
        self.boss.phase = 6
    else
        self.boss.phase = 7
    end

    if self.boss.phase == 1 then     -- TENNIS BALLS BARRAGE
        self.boss:recenterMove()
        self:mech1()
    elseif self.boss.phase == 2 then -- TRAFFIC
        if self.mechdelaycount == 1 then
            Timer.after(2, function() 
                self:mech2()
                self.mechdelaycount = 2
            end)
        else
            self:mech2()
        end
    elseif self.boss.phase == 3 then -- BOMB TOSS
        self.boss:recenterMove()
        if self.mechdelaycount == 2 then
            Timer.after(2, function() 
                self:mech3()
                self.mechdelaycount = 3
            end)
        else
            self:mech3()
        end
    elseif self.boss.phase == 4 then -- DUSTSTORM
        if self.mechdelaycount == 3 then
            Timer.after(2, function() 
                self:mech4()
                self.mechdelaycount = 4
            end)
        else
            self:mech4()
        end
    elseif self.boss.phase == 5 then -- TENNIS BALLS & BOMB TOSS
        if self.mechdelaycount == 4 then
            Timer.after(2, function() 
                self:mech1()
                self:mech3()
                self.mechdelaycount = 5
            end)
        else
            self:mech1()
            self:mech3()
        end
    elseif self.boss.phase == 6 then -- TENNIS BALLS & DUSTSTORM
        if self.mechdelaycount == 5 then
            Timer.after(2, function() 
                self:mech1()
                self:mech4()
                self.mechdelaycount = 6
            end)
        else
            self:mech1()
            self:mech4()
        end
    elseif self.boss.phase == 7 then -- BOMB TOSS & DUSTSTORM
        if self.mechdelaycount == 6 then
            Timer.after(2, function() 
                self:mech3()
                self:mech4()
                self.mechdelaycount = 7
            end)
        else
            self:mech3()
            self:mech4()
        end
    end
end

function Stage1:render()
    self.stage:render()
end
