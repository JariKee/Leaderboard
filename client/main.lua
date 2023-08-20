local deathCount = 0
local killCount = 0

function OpenLeaderboard(killCount, deathCount, TopUsers)
    SendNUIMessage({
        toggleUI = true,
		killCount1 = killCount,
		deathCount1 = deathCount,
        TopUsers1 = TopUsers
    })
    SetNuiFocus(true, true)
end

RegisterNUICallback("CloseCrosshairConfig", function(data)
    CloseCrosshairConfig()
end)

function CloseCrosshairConfig()
    SetNuiFocus(false, false)
end

RegisterCommand("leaderboard", function()
   TriggerServerEvent('vt_leaderboard:getTopStats')
   Citizen.Wait(100)
   OpenLeaderboard(killCount, deathCount, TopUsers)
end, false)

Citizen.CreateThread(function()

	
	RegisterCommand('score', function()
		TriggerEvent('chat:addMessage', {
			color = {0,89,255},
			multiline = true,
			args = {'Score:' .. '\n' .. '^2Kills' .. ': '.. killCount .. '\n' .. '^1Deaths' .. ': '.. deathCount}
		})
	end)
	
     RegisterNetEvent('vt_leaderboard:sendTopStats')
        AddEventHandler('vt_leaderboard:sendTopStats', function(topUsers)
            TopUsers = topUsers
        end)
   
        
	local myid = GetPlayerServerId(NetworkGetEntityOwner(GetPlayerPed(-1)))
	TriggerServerEvent('vt_leaderboard:findkillcount', myid)
	TriggerServerEvent('vt_leaderboard:finddeathcount', myid)
	
	RegisterNetEvent('vt_leaderboard:retrievekillcount')
	AddEventHandler('vt_leaderboard:retrievekillcount', function(data)
	killCount = data
	end)
	
	RegisterNetEvent('vt_leaderboard:retrievedeathcount')
	AddEventHandler('vt_leaderboard:retrievedeathcount', function(data2)
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
	TriggerServerEvent('vt_leaderboard:AddKill')
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
		TriggerServerEvent('vt_leaderboard:AddDeath')
		Citizen.Wait(5000)
		end
	end
	end
	end)

end)
	
