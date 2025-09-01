local webhook = config.webhooks

vRP.webhook = function(url, data)
    local body = '```prolog\n['..data.title:upper()..']'
    for _, v in ipairs(data.descriptions) do
        body = body..'\n['..string.upper(v[1])..']: '..string.upper(v[2])
    end
    body = body..os.date('\n[DATE]: %d/%m/%Y [HOUR]: %H:%M:%S')..'```'

    if (body) and (url and url ~= '') then
        PerformHttpRequest((webhook[url] or url), function(err, text, headers) end,
            'POST', 
            json.encode({
                embeds = {{
                    color = 15418782,
                    description = body
                }}
            }),
            { ['Content-Type'] = 'application/json' }
        )
    end
end