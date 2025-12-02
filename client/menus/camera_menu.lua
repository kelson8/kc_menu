


function CreateCameraMenu()
    lib.registerMenu({
        id = 'camera_options',
        title = 'Camera options',
        position = Config.MenuPosition,

        onClose = function(keyPressed)
            CloseMenu(false, keyPressed, 'kcnet_menu')
        end,

        onSideScroll = function(selected, scrollIndex, args)
        end,

        onSelected = function(selected, secondary, args)
            if not secondary then
                -- print("Normal button")
            else
                if args.isCheck then
                    -- print("Check button")
                end

                if args.isScroll then
                    -- print("Scroll button")
                end
            end
            -- print(selected, secondary, json.encode(args, {indent=true}))
        end,

        onCheck = function(selected, checked, args)
            -- print("Check: ", selected, checked, args)
        end,

        -- TODO Setup debug display for these.
        options = {
            { label = 'First Person cam', description = 'Print if first person camera is enabled in the console.', args = { 'first_person_cam' } },

            -- TODO Make this go from 0-3 if possible, I don't think this works right
            { label = 'Aim controls', values = {'Assisted Aim (Full)', 'Assisted Aim (Partial)', 'Free Aim - Assisted', 'Free Aim'},
            defaultIndex = 0,
            description = 'Change aiming mode.', args = { 'change_aim_mode' } },

        }

    }, function(selected, scrollIndex, args)
        if not args or not args[1] then return end

        if args[1] == 'first_person_cam' then
            -- https://nativedb.dotindustries.dev/gta5/natives/0xA4FF579AC0E3AAAE?search=GET_FOLLOW_VEHICLE_CAM_VIEW_MODE
            local cameraMode = GetFollowPedCamViewMode()
            -- if(IsFirstPersonAimCamActive()) then
            if (cameraMode == 4) then
                lib.notify({
                    description = "First person cam active"
                })
            else
                lib.notify({
                    description = "First person cam inactive"
                })
            end

        -- TODO Make this start at 0 if possible
        elseif args[1] == 'change_aim_mode' then
            SetPlayerTargetingMode(scrollIndex)
        end


    end)
end