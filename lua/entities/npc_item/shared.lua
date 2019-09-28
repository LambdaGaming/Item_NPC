
ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Item NPC"
ENT.Author = "Lambda Gaming"
ENT.Spawnable = true
ENT.Category = "Item NPC"

CraftingTable = {} --Initializes the item table, don't touch
CraftingCategory = {} --Initializes the category table, don't touch

--Template Category
--[[
	CraftingCategory[1] = { --Be sure to change the number, the lower the number, the higher up in the list it is
		Name = "Pistols", --Name of the category
		Color = Color( 49, 53, 61, 255 ) --Color of the category box
	}
]]

CraftingCategory[1] = {
	Name = "Pistols",
	Color = Color( 49, 53, 61, 255 )
}

CraftingCategory[2] = {
	Name = "SMGs",
	Color = Color( 49, 53, 61, 255 )
}

CraftingCategory[3] = {
	Name = "Rifles",
	Color = Color( 49, 53, 61, 255 )
}

CraftingCategory[4] = {
	Name = "Shotguns",
	Color = Color( 49, 53, 61, 255 )
}

CraftingCategory[5] = {
	Name = "Tools",
	Color = Color( 49, 53, 61, 255 )
}

--Template Crafting Item
--[[
	CraftingTable["weapon_crowbar"] = { --Add the entity name of the item in the brackets with quotes
	Name = "Crowbar", --Name of the item, different from the item's entity name
	Description = "Requires 1 ball.", --Description of the item
	Category = "Tools", --Category the item shows up in, has to match the name of a category created above
	Materials = { --Entities that are required to craft this item, make sure you leave the entity names WITHOUT quotes!
		iron = 2,
		wood = 1
	},
	SpawnFunction = --Function to spawn the item, don't modify anything outside of the entity name unless you know what you're doing
		function( ply, self ) --In this function you are able to modify the player who is crafting, the table itself, and the item that is being crafted
			local e = ents.Create( "weapon_crowbar" ) --Replace the entity name with the one at the very top inside the brackets
			e:SetPos( self:GetPos() - Vector( 0, 0, -5 ) ) --A negative Z coordinate is added here to prevent items from spawning on top of the table and being consumed, you'll have to change it if you use a different model otherwise keep it as it is
			e:Spawn()
		end
	}
]]

--On top of configuring your item here, don't forget to add the entity name to the list of allowed ents in craft_config.lua! Failure to do so will result in errors!

CraftingTable["weapon_glock2"] = {
	Name = "Glock",
	Description = "Requires 1 iron.",
	Category = "Pistols",
	Materials = {
		iron = 1
	},
	SpawnFunction =
		function( ply, self )
			local e = ents.Create( "weapon_glock2" )
			e:SetPos( self:GetPos() + Vector( 0, 0, -5 ) )
			e:Spawn()
		end
}

CraftingTable["weapon_m42"] = {
	Name = "M4",
	Description = "Requires 3 iron.",
	Category = "Rifles",
	Materials = {
		iron = 3
	},
	SpawnFunction =
		function( ply, self )
			local e = ents.Create( "weapon_m42" )
			e:SetPos( self:GetPos() + Vector( 0, 0, -5 ) )
			e:Spawn()
		end
}

CraftingTable["weapon_mac102"] = {
	Name = "MAC 10",
	Description = "Requires 2 iron.",
	Category = "SMGs",
	Materials = {
		iron = 2
	},
	SpawnFunction =
		function( ply, self )
			local e = ents.Create( "weapon_mac102" )
			e:SetPos( self:GetPos() + Vector( 0, 0, -5 ) )
			e:Spawn()
		end
}

CraftingTable["weapon_mp52"] = {
	Name = "MP5",
	Description = "Requires 2 iron.",
	Category = "SMGs",
	Materials = {
		iron = 2
	},
	SpawnFunction =
		function( ply, self )
			local e = ents.Create( "weapon_mp52" )
			e:SetPos( self:GetPos() + Vector( 0, 0, -5 ) )
			e:Spawn()
		end
}

CraftingTable["weapon_p2282"] = {
	Name = "P228",
	Description = "Requires 1 iron.",
	Category = "Pistols",
	Materials = {
		iron = 1
	},
	SpawnFunction =
		function( ply, self )
			local e = ents.Create( "weapon_p2282" )
			e:SetPos( self:GetPos() + Vector( 0, 0, -5 ) )
			e:Spawn()
		end
}

CraftingTable["weapon_pumpshotgun2"] = {
	Name = "Pump Shotgun",
	Description = "Requires 4 iron.",
	Category = "Shotguns",
	Materials = {
		iron = 4
	},
	SpawnFunction =
		function( ply, self )
			local e = ents.Create( "weapon_pumpshotgun2" )
			e:SetPos( self:GetPos() + Vector( 0, 0, -5 ) )
			e:Spawn()
		end
}

CraftingTable["lockpick"] = {
	Name = "Lockpick",
	Description = "Requires 1 iron.",
	Category = "Tools",
	Materials = {
		iron = 1
	},
	SpawnFunction =
		function( ply, self )
			local e = ents.Create( "lockpick" )
			e:SetPos( self:GetPos() + Vector( 0, 0, -5 ) )
			e:Spawn()
		end
}

CraftingTable["ls_sniper"] = {
	Name = "Silenced Sniper Rifle",
	Description = "Requires 5 iron.",
	Category = "Rifles",
	Materials = {
		iron = 5
	},
	SpawnFunction =
		function( ply, self )
			local e = ents.Create( "ls_sniper" )
			e:SetPos( self:GetPos() + Vector( 0, 0, -5 ) )
			e:Spawn()
		end
}

CraftingTable["weapon_ak472"] = {
	Name = "AK-47",
	Description = "Requires 4 iron and 2 wood.",
	Category = "Rifles",
	Materials = {
		iron = 4,
		wood = 2
	},
	SpawnFunction =
		function( ply, self )
			local e = ents.Create( "weapon_ak472" )
			e:SetPos( self:GetPos() + Vector( 0, 0, -5 ) )
			e:Spawn()
		end
}

CraftingTable["weapon_deagle2"] = {
	Name = "Deagle",
	Description = "Requires 2 iron.",
	Category = "Pistols",
	Materials = {
		iron = 2
	},
	SpawnFunction =
		function( ply, self )
			local e = ents.Create( "weapon_deagle" )
			e:SetPos( self:GetPos() + Vector( 0, 0, -5 ) )
			e:Spawn()
		end
}

CraftingTable["weapon_fiveseven2"] = {
	Name = "FiveSeven",
	Description = "Requires 1 iron.",
	Category = "Pistols",
	Materials = {
		iron = 1
	},
	SpawnFunction =
		function( ply, self )
			local e = ents.Create( "weapon_fiveseven2" )
			e:SetPos( self:GetPos() + Vector( 0, 0, -5 ) )
			e:Spawn()
		end
}