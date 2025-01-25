--[[
          .="   "=._.---.
        ."         c ' Y'`p
       /   ,       `.  w_/
       |   '-.   /     /
 _,..._|      )_-\ \_=.\
`-....-'`------)))`=-'"`'"

        BOBBER
                KURWA
TAGS: AUTOFISH, AUTO FISH, FISHES, FISHING
Experimental fix for opus auto-fisher.
It sometimes doesn't detect the depth properly, decrease/increase it to your liking to fix that LOL
Made by CodingInMyDream
]]

local depth = -1.8

local neural = require('neural.interface')
local sensor = peripheral.wrap("back")

neural.assertModules({
    'plethora:kinetic',
    'plethora:introspection',
    'plethora:sensor',
})

local function isHoldingRod()
    local owner = neural.getMetaOwner()
    local heldItem = owner.heldItem and owner.heldItem.getMetadata()
    return heldItem and heldItem.rawName == 'item.minecraft.fishing_rod'
end

local function fish()
    if isHoldingRod() then
        local bobberFound = false
        for _, entity in pairs(sensor.sense()) do
            if entity.name == "Fishing Bobber" then
                bobberFound = true

                if entity.y < depth then
                    print("Le bobber found le fishe.. food ^_^" .. entity.y)
                    neural.use(0.2)
                    break
                end
            end
        end

        if not bobberFound then
            print("No bobber found, casting rod...")
            neural.use(0.1)
        end
    else
        print("You are not holding a fishing rod!")
    end
end

while true do
    fish()
    os.sleep(1)
end
