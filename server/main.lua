

Citizen.CreateThread(function()
	

RegisterServerEvent('tt_score:findkillcount')
AddEventHandler('tt_score:findkillcount', function(myid)
	local identifier = GetPlayerIdentifiers(source)[1]
	MySQL.Async.fetchScalar('SELECT kills FROM users WHERE identifier = @identifier', {
		['@identifier'] = identifier
	}, function(data) 
        TriggerClientEvent('tt_score:retrievekillcount', myid, data)
	end)
end)

RegisterServerEvent('tt_score:finddeathcount')
AddEventHandler('tt_score:finddeathcount', function(myid)
	local identifier = GetPlayerIdentifiers(source)[1]
	MySQL.Async.fetchScalar('SELECT deaths FROM users WHERE identifier = @identifier', {
		['@identifier'] = identifier
	}, function(data2) 
        TriggerClientEvent('tt_score:retrievedeathcount', myid, data2)
	end)
end)

RegisterServerEvent('tt_score:AddKill')
AddEventHandler('tt_score:AddKill', function()

	local identifier = GetPlayerIdentifiers(source)[1]
	MySQL.Sync.execute('UPDATE users SET kills = kills + 1 WHERE identifier = @identifier', {
		['@identifier'] = identifier
	})
end)

RegisterServerEvent('tt_score:AddDeath')
AddEventHandler('tt_score:AddDeath', function()
	local identifier = GetPlayerIdentifiers(source)[1]


	MySQL.Sync.execute('UPDATE users SET deaths = deaths + 1 WHERE identifier = @identifier', {
		['@identifier'] = identifier
	})
end)

Wait(10500)
--print("^4      𝓟 𝓸 𝔀 𝓮 𝓻 𝓮 𝓭  𝓫 𝔂  𝓣 𝓣 𝓢 𝓬 𝓻 𝓲 𝓹 𝓽       ^0")
end)