local function sign(x)
    if x > 0 then
        return 1
    elseif x < 0 then
        return -1
    else
        return 0
    end
end

local function valueTo(current, desired, d)
    if current == desired then
        return current
    elseif current > desired then
        return math.max(current - d, desired)
    else
        return math.min(current + d, desired)
    end
end

return {
    sign = sign,
    valueTo = valueTo
}
