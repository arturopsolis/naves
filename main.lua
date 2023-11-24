--scene machine
function _init()
    p = {
        y = 96,
        x = 60,
        h = 8,
        w = 8,
        speed = 2,
        sprite = 2,
        flamespr = 5,
        blast = 0,
        bullet_timer = 0,
        invul = 0,
        score = 0,
        lives = 3
    }

    b = {}
    enemies = {}
    explosions = {}
    particules = {}
    shwaves = {}
    stars = {}
    starExtraSpeed = 0

    generate_stars()

    scenes = {
        menu = {
            init = init_menu,
            update = update_menu,
            draw = draw_menu
        },
        game = {
            init = init_game,
            update = update_game,
            draw = draw_game
        },
        wave = {
            init = init_wave,
            update = update_wave,
            draw = draw_wave
        },
        gameover = {
            init = init_gameover,
            update = update_gameover,
            draw = draw_gameover
        },

        win = {
            init = init_win,
            update = update_win,
            draw = draw_win
        }
    }

    scene = "menu"
    wave = 1
    waveTime = 80
    change_to_scene(scene)
end

function _update()
    scenes[scene].update()
end

function _draw()
    scenes[scene].draw()
end