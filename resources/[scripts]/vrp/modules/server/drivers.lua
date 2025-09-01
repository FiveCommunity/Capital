Citizen.CreateThreadNow(function()
    -- oxmysql
    local ox_queries = {}
    
    local function ox_init(cfg)
        return (GetResourceState('oxmysql') ~= 'missing')
    end
    
    local function ox_prepare(name, query)
        ox_queries[name] = query
    end
    
    local function ox_query(name, params, mode)
        local query = ox_queries[name]
        if query then

            if mode == 'execute' then
                return exports['oxmysql']:update_async(query, params)

            elseif mode == 'scalar' then
                return exports['oxmysql']:scalar_async(query, params)
               
            elseif mode == 'insert' then
                return exports['oxmysql']:insert_async(query, params)

            else
                local rows = exports['oxmysql']:query_async(query, params)
                return rows, #rows
                
            end

        end
        print( debug.traceback('^1[vRP] Not prepared query: '..tostring(name)..'') )
    end
    
    vRP.registerDBDriver('oxmysql', ox_init, ox_prepare, ox_query)
end)