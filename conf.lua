function love.conf(t)
    -- Magic hack to work with versions other than 0.9.0
    t.window = t.window or t.screen
    t.screen = t.screen or t.window

    t.window.width = 800
    t.window.height = 600
    t.window.title = "You Only Get Juan"

    t.version = "0.9.0"
end
