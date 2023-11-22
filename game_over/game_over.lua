function init_gameover()
    gameover_texts = {
        "game over",
        "score ",
        "press 🅾️/(z)"
    }
end

function update_gameover()
    if btnp(🅾️) then
        change_to_scene("game")
    end
end

function draw_gameover()
    cls(0)
    print(gameover_texts[1], 34, 60, 8)
    print(gameover_texts[2] .. p.score, 34, 68, 10)
end