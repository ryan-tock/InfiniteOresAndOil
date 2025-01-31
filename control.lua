-- Called each time an ore patch runs out
function refillOre(event)
    -- Checks which ore ran out
    if event.entity.name == "iron-ore" then
        resetOre("iron",event)
    elseif event.entity.name == "coal" then
        resetOre("coal",event)
    elseif event.entity.name == "copper-ore" then
        resetOre("copper",event)
    elseif event.entity.name == "stone" then
        resetOre("stone",event)
    elseif event.entity.name == "uranium-ore" then
        resetOre("uranium",event)
    elseif event.entity.name == "calcite" then
        resetOre('calcite',event)
    elseif event.entity.name == "tungsten-ore" then
        resetOre('tungsten',event)
    elseif event.entity.name == "scrap" then
        resetOre('scrap',event)
    elseif event.entity.name == "lithium-brine" then
        resetOre('lithium',event)
    else
        resetOre("modded-ores",event)
    end
end

function resetOre(name, event)
    -- Refills the given ore patch if the appropriate setting is enabled
    if settings.global["refill-"..name].value == true then
        event.entity.amount=100000
    end    
end

-- Called each tick
function tick(event)
    -- Ensures data has been initialized
    if #storage.i_resource_surface == 0 then
        return
    end

    -- Picks one infinite resource entity and grabs the mods data about that resource
    index = (event.tick % #storage.i_resource_surface) + 1
    x = storage.i_resource_x[index]
    y = storage.i_resource_y[index]
    surface = storage.i_resource_surface[index]

    entity = game.surfaces[surface].find_entities_filtered({type="resource", area={{x, y}, {x+1, y+1}}})[1]

    if not entity then
        return
    end

    -- Checks settings and refills it appropriately
    if entity.name=="crude-oil" and settings.global["refill-oil"].value then
        entity.amount = settings.global["oil-yield"].value * 3000
    elseif script.active_mods['space-age'] and entity.name=="sulfuric-acid-geyser" and settings.global["refill-sulfuric-acid"].value then
        entity.amount = settings.global["sulfuric-acid-yield"].value * 3000
    elseif script.active_mods['space-age'] and entity.name=="fluorine-vent" and settings.global["refill-fluorine"].value then
        entity.amount = settings.global["fluorine-yield"].value * 1000
    elseif settings.global["refill-modded-infinite"].value then
        entity.amount = settings.global["modded-yield"].value * 3000
    end
end

-- Called whenever a new chunk is generated, finds all infinite resources in that chunk and adds it to the mods stored data
function chunk_load(event)
    for _, entity in pairs(event.surface.find_entities_filtered({type="resource", area=event.area})) do
        if entity.initial_amount ~= nil then
            storage.i_resource_x[#storage.i_resource_x + 1] = entity.selection_box.left_top.x
            storage.i_resource_y[#storage.i_resource_y + 1] = entity.selection_box.left_top.y
            storage.i_resource_surface[#storage.i_resource_surface + 1] = entity.surface.name
        end
    end
end

-- Initializes all mod data, called when new world is created, this mod is loaded onto a save for the first time, or a new mod is added/updated
function init()
    -- Resets all stored data about where infinite resources are on the map
    storage.i_resource_x = {}
    storage.i_resource_y = {}
    storage.i_resource_surface = {}

    -- Loops through all surfaces to find all resources
    for _, surface in pairs(game.surfaces) do
        for _, entity in pairs(surface.find_entities_filtered({type="resource"})) do

            -- Checks if the resource is infinite and adds it to the mods stored data if it is
            if entity.initial_amount ~= nil then
                storage.i_resource_x[#storage.i_resource_x + 1] = entity.selection_box.left_top.x
                storage.i_resource_y[#storage.i_resource_y + 1] = entity.selection_box.left_top.y
                storage.i_resource_surface[#storage.i_resource_surface + 1] = entity.surface.name
            end
        end
    end
end

script.on_event(defines.events.on_tick, tick)

script.on_event(defines.events.on_resource_depleted, refillOre);

script.on_event(defines.events.on_chunk_generated, chunk_load);

script.on_init(init)

script.on_configuration_changed(init)