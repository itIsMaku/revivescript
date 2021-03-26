ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('revivescript:getConnectedEMS', function(source, cb)
	local xPlayers = ESX.GetPlayers()
	local amount = 0

	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		if xPlayer.job.name == 'ambulance' then
			amount = amount + 1
		end
	end
		
	cb(amount)
		
end)
ESX.RegisterServerCallback('revivescript:checkMoney', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.getMoney() >= Config.Price then
		cb(true)
	else
		cb(false)
	end
end)

RegisterServerEvent('revivescript:pay')
AddEventHandler('revivescript:pay', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeMoney(Config.Price)
	TriggerClientEvent('esx:showNotification', source, 'You paid $' .. Config.Price .. ' to doctors for revive.')

	if Config.GiveSocietyMoney then
		TriggerEvent('esx_addonaccount:getSharedAccount', Config.Society, function(account)
			account.addMoney(Config.Price)
		end)
	end
end)
