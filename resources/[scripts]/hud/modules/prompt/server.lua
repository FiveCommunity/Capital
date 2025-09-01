local prompts = {}

prompt = function(source, questions)
    local async_response = async()
    prompts[source] = async_response
    vCLIENT.createPrompt(source, questions)
    return async_response:wait()
end
exports('prompt', prompt)

srv.resultPrompt = function(responses)
    if (not responses) then responses = ''; end;

    local prompt = prompts[source]
    if (prompt) then
        prompt(responses)
        prompts[source] = nil
    end
end