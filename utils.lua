
function shallowcopy(tab)
    local copy = {}
    setmetatable(copy, getmetatable(tab)) 
    for k, v in pairs(tab) do
        copy[k] = v
    end
    return copy
end

lastUnique = 0

function uniqueId()
    lastUnique = lastUnique + 1
    return lastUnique
end
