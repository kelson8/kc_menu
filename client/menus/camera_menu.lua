


function CreateCameraMenu()
    lib.registerMenu({
        id = 'camera_options',
        title = 'Camera options',
        position = Config.MenuPosition,

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

        onClose = function(keyPressed)
        end,

        options = {
            { label = 'First Person cam', description = 'Print if first person camera is enabled in the console.', args = { 'first_person_cam' } },

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
        end
    end)
end