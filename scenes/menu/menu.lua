function init_menu()
    menu_text = "press ❎ button"
end

function update_menu()
    if btnp(❎) then
        change_to_scene("wave")
    end
end

function draw_menu()
    cls(0)
    print(menu_text, 34, 60, 10)
end