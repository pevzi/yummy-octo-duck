local function sign(x)
    if x > 0 then
        return 1
    elseif x < 0 then
        return -1
    else
        return 0
    end
end

local function valueTo(current, desired, speed, dt)
    if current == desired then
        return current
    end

    -- the difference we need to eliminate
    local diff = desired - current

    -- the value that we can add/subtract during this frame
    local d = speed * dt

    -- if we don't have enough time during this frame to fully compensate the difference...
    if math.abs(diff) > d then
        -- ...then return the value changed towards desired as much as we can
        return current + sign(diff) * d
    -- otherwise just return the desired value
    else
        return desired
    end
end

return {
    sign = sign,
    valueTo = valueTo
}
