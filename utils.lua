
function shallowcopy(orig)
    local copy
    if type(orig) == 'table' then
        copy = {}
        setmetatable(copy, getmetatable(orig)) 
        for k, v in pairs(orig) do
            copy[k] = v
        end
    else
        copy = orig
    end
    return copy
end


function copy1(tab)
    local copy
    if type(orig) == 'table' then
        copy = {}
        setmetatable(copy, shallowcopy(getmetatable(orig)) )
        for k, v in pairs(orig) do
            copy[shallowcopy(k)] = shallowcopy(v)
        end
    else
        copy = orig
    end
    return copy
end

function copy2(tab)
    local copy
    if type(orig) == 'table' then
        copy = {}
        setmetatable(copy, copy1(getmetatable(orig)))
        for k, v in pairs(orig) do
            copy[copy1(k)] = copy1(v)
        end
    else
        copy = orig
    end
    return copy
end

function copystate(state)
    local copy = {}
    setmetatable(copy, shallowcopy(getmetatable(state)))
    for k, v in pairs(state) do
        copy[shallowcopy(k)] = shallowcopy(v)
    end
    return copy
end

function deepcopy(orig)
    local orig_type = type(orig)
    local copy
    if orig_type == 'table' then
        copy = {}
        for orig_key, orig_value in next, orig, nil do
            copy[deepcopy(orig_key)] = deepcopy(orig_value)
        end
        setmetatable(copy, deepcopy(getmetatable(orig)))
    else -- number, string, boolean, etc
        copy = orig
    end
    return copy
end

lastUnique = 0

function uniqueId()
    lastUnique = lastUnique + 1
    return lastUnique
end

function drawFilledBar(x, y, width, height, proportion, fgcolor, bgcolor, linecolor, caption, textcolor)
    bgcolor = bgcolor or {0,0,0,255}
    fgcolor = fgcolor or {255,255,255,255}
    linecolor = linecolor or bgcolor
    textcolor = textcolor or {255,255,255,255}

    resetDraw(
        function ()
            love.graphics.setColor(bgcolor)
            love.graphics.rectangle("fill", x, y, width, height)

            love.graphics.setColor(fgcolor)
            love.graphics.rectangle("fill", x, y, proportion * width, height)

            love.graphics.setColor(linecolor)
            love.graphics.rectangle("line", x-1, y-1, width+1, height+1)

            if caption then
                local strWidth = love.graphics.getFont():getWidth(caption)
                love.graphics.print(caption, x + width/2 - strWidth/2, y + height/2 - 7)
            end
        end)
end

function resetDraw(func)
    r, g, b, a = love.graphics.getColor()
    func()
    love.graphics.setColor(r, g, b, a)
end