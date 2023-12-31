function init_gameover()
end

function update_gameover()
    if btnp(🅾️) then
        change_to_scene("game")
    end
end

function draw_gameover()
    draw_game()

    local rect_width = 60
    local rect_height = 30
    local rect_x = 128 - rect_width
    local rect_y = 128 - rect_height

    local text_1 = "game over"
    local text_2 = "score " .. p.score
    -- Calcula la posición x para centrar el texto
    local x = (128 - #text_1 * 4) / 2
    local x2 = (128 - #text_2 * 4) / 2

    -- Dibuja el texto centrado en la pantalla
    rectfill(40, 40, 87, 70, 0)
    -- Dibuja el rectángulo negro
    print(text_1, x, 50, 8)
    print(text_2, x2, 60, 10)
end