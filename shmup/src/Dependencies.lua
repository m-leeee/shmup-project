Class = require 'lib/class'
Event = require 'lib/knife.event'
push = require 'lib/push'
Timer = require 'lib/knife.timer'

require 'src/Animation'
require 'src/Constants'
require 'src/StateMachine'
require 'src/Util'

require 'src/states/BaseState'
require 'src/states/game/StartState'
require 'src/states/game/PlayState'
require 'src/states/game/GameOverState'

require 'src/entities/Entity'
require 'src/entities/entity_defs'
require 'src/entities/Player'
require 'src/entities/bosses/Boss'
require 'src/entities/bosses/Shiba'

require 'src/states/entity/EntityIdleState'
require 'src/states/entity/player/PlayerDefaultState'
require 'src/states/entity/player/PlayerKnockbackState'

require 'src/stages/Stage'
require 'src/stages/Sandbox'
require 'src/stages/Stage1'

require 'src/attacks/AOE/AOE'
require 'src/attacks/AOE/AOEBox'
require 'src/attacks/AOE/AOEBoxKnockback'
require 'src/attacks/AOE/AOECircle'
require 'src/attacks/AOE/AOEDonut'
require 'src/attacks/AOE/AOETriangle'

require 'src/attacks/boss/BossBullet'
require 'src/attacks/boss/HomingBBullet'

require 'src/attacks/player/PlayerBullet'
require 'src/attacks/player/PlayerMelee'



gTextures = {
    ['player'] = love.graphics.newImage('graphics/player.png'),
    ['shiba'] = love.graphics.newImage('graphics/shib.png'),
    ['car'] = love.graphics.newImage('graphics/carsheet.png'),
    ['ball'] = love.graphics.newImage('graphics/ballsheet.png'),
    ['bomb'] = love.graphics.newImage('graphics/bombsheet.png'),
    ['frisbee'] = love.graphics.newImage('graphics/frisbeesheet.png')
}

gFrames = {
    ['player'] = GenerateQuads(gTextures['player'], 26, 41),
    ['shiba'] = GenerateQuads(gTextures['shiba'], 50, 45),
    ['car'] = GenerateQuads(gTextures['car'], 125, 39),
    ['ball'] = GenerateQuads(gTextures['ball'], 24, 24),
    ['bomb'] = GenerateQuads(gTextures['bomb'], 25, 31),
    ['frisbee'] = GenerateQuads(gTextures['frisbee'], 25, 13)
}

gFonts = {
    ['small'] = love.graphics.newFont('fonts/font.ttf', 8),
    ['medium'] = love.graphics.newFont('fonts/font.ttf', 16),
    ['large'] = love.graphics.newFont('fonts/font.ttf', 32)
}

gSounds = {
    ['pop'] = love.audio.newSource('sounds/pop.wav', 'static')
}