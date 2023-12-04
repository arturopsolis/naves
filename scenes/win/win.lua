function init_win()
end

function update_win()
end

function draw_win()
    cls(0)
    local text_1 = "congratulations"
    local text_2 = "score " .. p.score
    -- Calcula la posición x para centrar el texto
    local x = (128 - #text_1 * 4) / 2
    local x2 = (128 - #text_2 * 4) / 2

    -- Dibuja el texto centrado en la pantalla
    print(text_1, x, 50, 7)
    print(text_2, x2, 60, 10)
end