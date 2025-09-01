local vCLIENT = Tunnel.getInterface('Taskbar')

Task = function(source, amount, speed)
    return vCLIENT.Task(source, amount, speed)
end
exports('Task', Task)
