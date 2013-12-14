
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
