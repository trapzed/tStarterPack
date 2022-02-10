ESX = nil

TriggerEvent(Config.Events["esx:getSharedObject"], function(obj) ESX = obj end)

RegisterServerEvent('tStarterPack:checkIfNoStarterPack')
AddEventHandler('tStarterPack:checkIfNoStarterPack', function()
	local player = source 
	local identifier = GetPlayerIdentifiers(player)[1]
	MySQL.Async.fetchAll('SELECT starterpack FROM users WHERE identifier=@id', {['@id'] = identifier}, function(result)
		if result[1].starterpack == "0" then
			TriggerClientEvent('tStarterPack:openMenu', player)
        else
            TriggerClientEvent(Config.Events["esx:showNotification"], player, "~r~Vous avez déjà selectionné un starterpack")
        end
	end)
end)

RegisterServerEvent('tStarterPack:legalPack')
AddEventHandler('tStarterPack:legalPack', function()
	local player = source 
	local identifier = GetPlayerIdentifiers(player)[1]
	MySQL.Async.fetchAll('SELECT starterpack FROM users WHERE identifier=@id', {['@id'] = identifier}, function(result)
	if result[1].starterpack == "0" then
		local xPlayer = ESX.GetPlayerFromId(player)
		xPlayer.addMoney(Config.LegalMoneyNumber)
		xPlayer.addInventoryItem(Config.LegalItem1, 10)
		xPlayer.addInventoryItem(Config.LegalItem2, 10)
		MySQL.Async.execute(
				'UPDATE users SET starterpack=@starterpack WHERE identifier=@id',
				{ 
					['@id'] 				  = identifier ,
					['@starterpack']          = "legal",
				},
				function ()
		end)
		TriggerClientEvent(Config.Events["esx:showNotification"], player, "Vous avez selectionné le pack ~g~Legal")
	else
		TriggerClientEvent(Config.Events["esx:showNotification"], player, "Vous avez déjà selectionné un starterpack")
	end
	end)
end)

RegisterServerEvent('tStarterPack:illegalPack')
AddEventHandler('tStarterPack:illegalPack', function()
	local player = source 
	local identifier = GetPlayerIdentifiers(player)[1]
	MySQL.Async.fetchAll('SELECT starterpack FROM users WHERE identifier=@id', {['@id'] = identifier}, function(result)
	if result[1].starterpack == "0" then
		local xPlayer = ESX.GetPlayerFromId(player)
		--local blackMoney = xPlayer.getAccount(Config.ArgentSale)

		xPlayer.addAccountMoney(Config.ArgentSale, Config.IllegalMoneyNumber)

		-- Si vos armes NE SONT PAS en ITEMS :
        -- xPlayer.addWeapon(Config.ArmeIllegale, 1)

        -- Si vos armes sont en ITEMS :
        xPlayer.addInventoryItem(Config.ArmeIllegale, 1)
		MySQL.Async.execute(
				'UPDATE users SET starterpack=@starterpack WHERE identifier=@id',
				{ 
					['@id'] 				  = identifier ,
					['@starterpack']          = "illegal",
				},
				function ()
		end)
		TriggerClientEvent(Config.Events["esx:showNotification"], player, "Vous avez selectionné le pack ~r~Illegal")
	else
		TriggerClientEvent(Config.Events["esx:showNotification"], player, "Vous avez déjà selectionné un starterpack")
	end
	end)
end)

RegisterServerEvent('tStarterPack:aucunPack')
AddEventHandler('tStarterPack:aucunPack', function()
	local player = source 
	local identifier = GetPlayerIdentifiers(player)[1]
	MySQL.Async.fetchAll('SELECT starterpack FROM users WHERE identifier=@id', {['@id'] = identifier}, function(result)
	if result[1].starterpack == "0" then
		MySQL.Async.execute(
				'UPDATE users SET starterpack=@starterpack WHERE identifier=@id',
				{ 
					['@id'] 				  = identifier ,
					['@starterpack']          = "aucun",
				},
				function ()
		end)
		TriggerClientEvent(Config.Events["esx:showNotification"], player, "Vous avez choisi de démarrer sans pack")
	else
		TriggerClientEvent(Config.Events["esx:showNotification"], player, "Vous avez déjà selectionné un starterpack")
	end
	end)
end)

print("")
print("[^5tStarterPack^7] - Made by TrapZed#1725^7")
print("")