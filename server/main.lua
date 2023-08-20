

Citizen.CreateThread(function()
	
	local topUsers = {}
	
	RegisterServerEvent('tt_score:findkillcount')
	AddEventHandler('tt_score:findkillcount', function(myid)
		local identifier = GetPlayerIdentifiers(source)[1]
		MySQL.Async.fetchScalar('SELECT Kills FROM users WHERE identifier = @identifier', {
			['@identifier'] = identifier 
		}, function(data) 
			TriggerClientEvent('tt_score:retrievekillcount', myid, data)
		end)
	end)
        
    RegisterServerEvent('tt_score:updateleaderboard')
	AddEventHandler('tt_score:updateleaderboard', function()
		MySQL.Async.fetchAll('SELECT * FROM users', function(data)
                        
        local function sortByKDRatio(user1, user2)
            local kd1 = (user1.Kills or 0) / math.max(user1.Deaths or 1, 1)
            local kd2 = (user2.Kills or 0) / math.max(user2.Deaths or 1, 1)
            return kd1 > kd2 
        end

        table.sort(data, sortByKDRatio)


        local maxUsersToShow = 10
        for i, user in ipairs(data) do
            if i > maxUsersToShow then
                break
            end
            local name = user.name
            local kills = user.Kills or 0
            local deaths = user.Deaths or 1
            local kdratio = kills / math.max(deaths, 1)
            local formattedKDRatio = string.format("%.2f", kdratio)


            local userData = {
                Rank = i,
                User = name,
                Kills = kills,
                Deaths = deaths,
                KDRatio = formattedKDRatio
            }

            table.insert(topUsers, userData)

        end

                       
		end)
	end)
	
        
    RegisterServerEvent('tt_score:getTopStats')
    AddEventHandler('tt_score:getTopStats', function()
        TriggerClientEvent('tt_score:sendTopStats', source, topUsers)
    end)
        
        
	RegisterServerEvent('tt_score:finddeathcount')
	AddEventHandler('tt_score:finddeathcount', function(myid)
		local identifier = GetPlayerIdentifiers(source)[1]
		MySQL.Async.fetchScalar('SELECT Deaths FROM users WHERE identifier = @identifier', {
			['@identifier'] = identifier
		}, function(data2) 
			TriggerClientEvent('tt_score:retrievedeathcount', myid, data2)
		end)
	end)
	
	RegisterServerEvent('tt_score:AddKill')
	AddEventHandler('tt_score:AddKill', function()
	
		local identifier = GetPlayerIdentifiers(source)[1]
		MySQL.Sync.execute('UPDATE users SET Kills = Kills + 1 WHERE identifier = @identifier', {
			['@identifier'] = identifier
		})
	end)
	
	RegisterServerEvent('tt_score:AddDeath')
	AddEventHandler('tt_score:AddDeath', function()
		local identifier = GetPlayerIdentifiers(source)[1]
	
	
		MySQL.Sync.execute('UPDATE users SET Deaths = Deaths + 1 WHERE identifier = @identifier', {
			['@identifier'] = identifier
		})
	end)
        
    while true do
        TriggerEvent('tt_score:updateleaderboard')
		Citizen.Wait(100000)
	end
end)