ENTITY_DEFS = {
    ['player'] = {
        walkSpeed = 120,
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
    },
    ['bomb'] = {
        animations = {
            ['default'] = {
                frames = { 1, 2, 3 },
                interval = 0.1,
                texture = 'bomb'

            }
        }
    },
    ['frisbee'] = {
        animations = {
            ['default'] = {
                frames = { 1, 2},
                interval = 0.2,
                texture = 'frisbee'

            }
        }
    }

}