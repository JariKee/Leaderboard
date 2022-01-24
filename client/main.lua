local deathCount = 0
local killCount = 0


Citizen.CreateThread(function()


	
	RegisterCommand('score', function()
		TriggerEvent('chat:addMessage', {
			color = {0,89,255},
			multiline = true,
			args = {'Score:' .. '\n' .. '^2Kills' .. ': '.. killCount .. '\n' .. '^1Deaths' .. ': '.. deathCount}
		})
	end)
	
	local myid = GetPlayerServerId(NetworkGetEntityOwner(GetPlayerPed(-1)))
	TriggerServerEvent('tt_score:findkillcount', myid)
	TriggerServerEvent('tt_score:finddeathcount', myid)
	
	RegisterNetEvent('tt_score:retrievekillcount')
	AddEventHandler('tt_score:retrievekillcount', function(data)
	killCount = data
	end)
	
	RegisterNetEvent('tt_score:retrievedeathcount')
	AddEventHandler('tt_score:retrievedeathcount', function(data2)
	deathCount = data2
	end)

AddEventHandler('gameEventTriggered', function (name, args)
	if name == 'CEventNetworkEntityDamage' then
		if IsEntityAPed(args[1]) and IsEntityAPed(args[2]) then
			if args[6] == 1 then
				TriggerEvent('gameEvent:KilledPlayer', args[1], args[2], args[7])
				TriggerEvent('gameEvent:PlayerDied', args[1], args[2], args[7])
			elseif args[6] == 0 then
				TriggerEvent('gameEvent:KilledPlayer', args[1], args[2], args[7])
				TriggerEvent('gameEvent:PlayerDied', args[1], args[2], args[7])
			end
		end
	end
end)


AddEventHandler('gameEvent:KilledPlayer', function(victimid, killerid, weaponHash)
if GetEntityHealth(victimid) == 0 then
	if IsPedAPlayer(victimid) then
if killerid == PlayerPedId() then
	if killerid ~= victimid then
	killCount = killCount + 1
	TriggerServerEvent('tt_score:AddKill')
	Citizen.Wait(5000)
	end
end
end
end
end)

AddEventHandler('gameEvent:PlayerDied', function(victimid, killerid, weaponHash)
	if GetEntityHealth(victimid) == 0 then
	if victimid == PlayerPedId() then
		if killerid ~= victimid then
		deathCount = deathCount + 1
		TriggerServerEvent('tt_score:AddDeath')
		Citizen.Wait(5000)
		end
	end
	end
	end)

end)
	
