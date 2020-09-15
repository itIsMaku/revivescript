ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


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
