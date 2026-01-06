--// Signal service
type SignalClass = {
	Connections: {
		[number]: (...any) -> nil	
	},
	Fire: (SignalClass, ...any) -> nil,
	GetConnections: (SignalClass) -> table,
	Connect: (SignalClass, (...any) -> nil) -> table,
	DisconnectConnections: (SignalClass) -> nil,
}

type table = {
    [any]: any
}

local Signal = {} :: SignalClass
Signal.__index = Signal

local Wrappers = loadstring(game:HttpGet('https://raw.githubusercontent.com/xataxell/Immediate-Mode-Graphical-User-Interface/refs/heads/main/src/classes/Wrappers.lua'))()

function Signal:Fire(...)
	local Connections = self:GetConnections()
	if #Connections <= 0 then return end

	for _, Connection in next, Connections do
		Connection(...)
	end
end
function Signal:GetConnections(): table
	local Connections = self.Connections
	return Connections
end
function Signal:Connect(Func: (...any) -> nil)
	local Connections = self:GetConnections()
	table.insert(Connections, Func)
end
function Signal:DisconnectConnections()
	local Connections = self:GetConnections()
	table.clear(Connections)
end

function Signal:NewSignal(): SignalClass
	return Wrappers:NewClass(Signal, {
		Connections = {}
	})
end


return Signal
