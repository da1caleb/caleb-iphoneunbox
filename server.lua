local ox_inventory = exports.ox_inventory

RegisterNetEvent('iphone:unbox', function()
    local src = source
    if ox_inventory:Search(src, 'count', 'iphone_box') > 0 then
        ox_inventory:RemoveItem(src, 'iphone_box', 1)

        ox_inventory:AddItem(src, 'iphone', 1)
        ox_inventory:AddItem(src, 'charger', 1)
        ox_inventory:AddItem(src, 'earbuds', 1)
        ox_inventory:AddItem(src, 'sim_card', 1)
        ox_inventory:AddItem(src, 'iphone_manual', 1)

        TriggerClientEvent('iphone:notify', src)
    else
        TriggerClientEvent('ox_lib:notify', src, {
            title = 'iPhone',
            description = 'You don\'t have an iPhone box to unbox.',
            type = 'error'
        })
    end
end)