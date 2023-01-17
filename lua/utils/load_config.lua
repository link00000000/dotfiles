return function (config)
    local package = 'configs.' .. config
    print(package)

    return function ()
        require(package)
    end
end
