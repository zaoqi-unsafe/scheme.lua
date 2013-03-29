local math = math

return {
    -- Basic arithmetic {{{
    ["+"] = function (env, ...)
        local arg = { ... }
        local sum = env:_eval(arg[1]) or 0
        for i = 2, #arg do
            sum = sum + env:_eval(arg[i])
        end
        return sum
    end,

    ["-"] = function (env, ...)
        local arg = { ... }
        local dif = env:_eval(arg[1]) or 0

        if #arg < 2 then
            return -dif
        end

        for i = 2, #arg do
            dif = dif - env:_eval(arg[i])
        end
        return dif
    end,

    ["*"] = function (env, ...)
        local arg = { ... }
        local mul = env:_eval(arg[1]) or 1
        for i = 2, #arg do
            mul = mul * env:_eval(arg[i])
        end
        return mul
    end,

    ["/"] = function (env, ...)
        local arg = { ... }
        local div = env:_eval(arg[1]) or 1

        if #arg < 2 then
            return 1 / div
        end

        for i = 2, #arg do
            div = div / env:_eval(arg[i])
        end
        return div
    end,

    div = function (env, a, b)
        return math.floor(env:_eval(a) / env:_eval(b))
    end,

    mod = function (env, a, b)
        return env:_eval(a) % env:_eval(b)
    end,
    -- }}}

    -- Arithmetic predicates {{{
    ["="] = function (env, ...)
        local exprs = { ... }

        exprs[1] = env:_eval(exprs[1])
        for i = 2, #exprs do
            exprs[i] = env:_eval(exprs[i])
            if exprs[i - 1] ~= exprs[i] then return false end
        end

        return true
    end,

    [">"] = function (env, a, b)
        return env:_eval(a) > env:_eval(b)
    end,

    ["<"] = function (env, a, b)
        return env:_eval(a) < env:_eval(b)
    end,

    [">="] = function (env, a, b)
        return env:_eval(a) >= env:_eval(b)
    end,

    ["<="] = function (env, a, b)
        return env:_eval(a) <= env:_eval(b)
    end,

    ["zero?"] = function (env, a)
        return env:_eval(a) == 0
    end,

    ["positive?"] = function (env, a)
        return env:_eval(a) > 0
    end,

    ["negative?"] = function (env, a)
        return env:_eval(a) < 0
    end,

    ["odd?"] = function (env, a)
        return env:_eval(a) % 2 ~= 0
    end,

    ["even?"] = function (env, a)
        return env:_eval(a) % 2 == 0
    end,
    -- }}}

    -- Constants {{{
    ["+inf.0"] = 1/0,
    ["-inf.0"] = -1/0,
    ["+nan.0"] = -(0/0),

    pi = math.pi,
    e = math.exp(1),
    -- }}}

    ln = function (env, num)
        return math.log(env:_eval(num))
    end,
    log = function (env, num, base)
        return math.log(env:_eval(num), env:_eval(base))
    end,
    
    -- Trigonometry {{{
    sin = function (env, arg)
        return math.sin(env:_eval(arg))
    end,
    asin = function (env, arg)
        return math.asin(env:_eval(arg))
    end,

    cos = function (env, arg)
        return math.cos(env:_eval(arg))
    end,
    acos = function (env, arg)
        return math.acos(env:_eval(arg))
    end,

    tan = function (env, arg)
        return math.tan(env:_eval(arg))
    end,
    atan = function (env, arg)
        return math.atan(env:_eval(arg))
    end,
    atan2 = function (env, a, b)
        return math.atan2(env:_eval(a), env:_eval(b))
    end,
    -- }}}

    min = function (env, arg, ...)
        local result = env:_eval(arg)
        for _, a in ipairs({ ... }) do
            a = env:_eval(a)
            if a < result then
                result = a
            end
        end

        return result
    end,

    max = function (env, arg, ...)
        local result = env:_eval(arg)
        for _, a in ipairs({ ... }) do
            a = env:_eval(a)
            if a > result then
                result = a
            end
        end

        return result
    end,
}
