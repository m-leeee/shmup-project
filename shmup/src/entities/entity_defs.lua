ENTITY_DEFS = {
    ['player'] = {
        walkSpeed = 60,
        animations = {
            ['idle'] = {
                frames = { 1 },
                texture = 'player'
            }
        }
    }
    ,
    ['shiba'] = {
        animations = {

            ['idle'] = {
                frames = { 1 },
                texture = 'shiba'
            }
        }
    }
}

ATTACK_DEFS = {
    ['ball'] = {
        animations = {
            ['default'] = {
                frames = { 1, 2, 3,4 },
                interval = 0.1,
                texture = 'ball'

            }
        }
    },
    ['car'] = {
        animations = {
            ['1r'] = {
                frames = {1},
                texture = 'car'

            },
            ['1l'] = {
                frames = {4},
                texture = 'car'

            },
            ['2r'] = {
                frames = {2},
                texture = 'car'

            },
            ['2l'] = {
                frames = {5},
                texture = 'car'

            },
            ['3r'] = {
                frames = {3},
                texture = 'car'

            },
            ['3l'] = {
                frames = {6},
                texture = 'car'

            }
        }
    }

}