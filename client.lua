local function playUnboxAnim()
    local playerPed = PlayerPedId()

    -- Create iPhone Box Prop
    local boxModel = `prop_cs_cardbox_01`
    RequestModel(boxModel)
    while not HasModelLoaded(boxModel) do
        Wait(10)
    end
    local coords = GetEntityCoords(playerPed)
    local boxProp = CreateObject(boxModel, coords.x, coords.y, coords.z + 0.2, true, true, true)
    AttachEntityToEntity(boxProp, playerPed, GetPedBoneIndex(playerPed, 57005), 0.15, 0.0, -0.02, 100.0, 270.0, 0.0, true, true, false, true, 1, true)

    -- Camera zoom for immersion
    local cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", true)
    SetCamCoord(cam, coords.x, coords.y - 0.5, coords.z + 0.6)
    PointCamAtEntity(cam, playerPed, 0, 0, 0, true)
    SetCamActive(cam, true)
    RenderScriptCams(true, true, 1000, true, true)

    -- Step 1: Hold box
    RequestAnimDict("anim@heists@box_carry@")
    while not HasAnimDictLoaded("anim@heists@box_carry@") do
        Wait(10)
    end
    TaskPlayAnim(playerPed, "anim@heists@box_carry@", "idle", 8.0, -8.0, 2500, 49, 0, false, false, false)
    Wait(2500)

    -- Step 2: Open box with sound
    RequestAnimDict("anim@heists@ornate_bank@grab_cash")
    while not HasAnimDictLoaded("anim@heists@ornate_bank@grab_cash") do
        Wait(10)
    end
    TaskPlayAnim(playerPed, "anim@heists@ornate_bank@grab_cash", "intro", 8.0, -8.0, 2000, 0, 0, false, false, false)
    Wait(500)
    PlaySoundFromEntity(-1, "PICK_UP", playerPed, "HUD_FRONTEND_DEFAULT_SOUNDSET", true, 0)
    Wait(1500)

    -- Delete box prop
    DeleteEntity(boxProp)

    -- Step 3: Show phone in hand
    local phoneModel = `prop_amb_phone`
    RequestModel(phoneModel)
    while not HasModelLoaded(phoneModel) do
        Wait(10)
    end
    local phoneProp = CreateObject(phoneModel, coords.x, coords.y, coords.z + 0.2, true, true, true)
    AttachEntityToEntity(phoneProp, playerPed, GetPedBoneIndex(playerPed, 57005), 0.03, 0.0, 0.02, 0.0, 0.0, 0.0, true, true, false, true, 1, true)

    RequestAnimDict("amb@code_human_wander_idles@male@phone@base")
    while not HasAnimDictLoaded("amb@code_human_wander_idles@male@phone@base") do
        Wait(10)
    end
    TaskPlayAnim(playerPed, "amb@code_human_wander_idles@male@phone@base", "static", 8.0, -8.0, 3000, 49, 0, false, false, false)
    Wait(3000)

    -- Clear animations and delete phone
    ClearPedTasks(playerPed)
    DeleteEntity(phoneProp)

    -- Restore camera
    RenderScriptCams(false, true, 1000, true, true)
    DestroyCam(cam, false)
end

RegisterNetEvent('iphone:notify', function()
    lib.notify({
        title = '📱 Your iPhone is Ready!',
        description = 'Hold the power button until you see the Apple logo.\nGo to Settings → Verify iPhone to activate it.',
        type = 'inform',
        duration = 7000
    })
    lib.notify({
        title = '💡 Tip',
        description = 'Insert the SIM card before powering on for full service.',
        type = 'inform',
        duration = 5000
    })
end)

exports('useIphoneBox', function(data, slot)
    playUnboxAnim()
    TriggerServerEvent('iphone:unbox')
end)