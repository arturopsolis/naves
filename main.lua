--scene machine
function _init()
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
        gameover = {
            init = init_gameover,
            update = update_gameover,
            draw = draw_gameover
        }
    }

    scene = "menu"
    change_to_scene(scene)
end

function _update()
    scenes[scene].update()
end

function _draw()
    scenes[scene].draw()
end