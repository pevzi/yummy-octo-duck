local function sign(x)
    if x > 0 then
        return 1
    elseif x < 0 then
        return -1
    else
        return 0
    end
end

local function valueTo(current, desired, delta)
    if current == desired then
        return current
    elseif current > desired then
        return math.max(current - delta, desired)
    else
        return math.min(current + delta, desired)
    end
end

return {
    sign = sign,
    valueTo = valueTo
}
