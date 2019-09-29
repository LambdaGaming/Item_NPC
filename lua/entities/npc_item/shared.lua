
ENT.Type = "ai"
ENT.Base = "base_ai"
ENT.PrintName = "Item NPC"
ENT.Author = "Lambda Gaming"
ENT.Spawnable = true
ENT.Category = "Item NPC"

function ENT:SetupDataTables()
	self:NetworkVar( "Int", 0, "NPCType" )
end

ItemNPC = {} --Initializes the item table, don't touch
ItemNPCType = {} --Initializes the type table, don't touch

--Template Type
--[[
	ItemNPCType[1] = {
		Name = "Template NPC Type", --Name of the NPC type
		Model = "models/breen.mdl", --Model of the NPC
		MenuColor = Color( 49, 53, 61, 200 ), --Color of the menu background
		ButtonColor = Color( 230, 93, 80, 255 ), --Color of the buttons
		ButtonTextColor = color_white, --Color of the button text
		Allowed = { --Jobs that are allowed to use the NPC, leave empty brackets for all jobs
			[TEAM_MAYOR] = true,
			[TEAM_CHIEF] = true
		}
	}
]]

ItemNPCType[1] = {
	Name = "Template NPC Type",
	Model = "models/breen.mdl",
	MenuColor = Color( 49, 53, 61, 200 ),
	ButtonColor = Color( 230, 93, 80, 255 ),
	ButtonTextColor = color_white,
	Allowed = {}
}

--Template Crafting Item
--[[
	ItemNPC["weapon_crowbar"] = { --Add the entity name of the item in the brackets with quotes
	Name = "Crowbar", --Name of the item, different from the item's entity name
	Description = "Tool you can swing", --Description of the item
	Category = "Tools", --Category the item shows up in, has to match the name of a category created above
	Price = 100 --Price of the item
	SpawnFunction = --Function to spawn the item, don't modify anything outside of the entity name unless you know what you're doing
		function( ply, self ) --In this function you are able to modify the player who is crafting, the table itself, and the item that is being crafted
			local e = ents.Create( "weapon_crowbar" ) --Replace the entity name with the one at the very top inside the brackets
			e:SetPos( self:GetPos() - Vector( 0, 0, -5 ) ) --A negative Z coordinate is added here to prevent items from spawning on top of the table and being consumed, you'll have to change it if you use a different model otherwise keep it as it is
			e:Spawn()
		end
	}
]]

--On top of configuring your item here, don't forget to add the entity name to the list of allowed ents in craft_config.lua! Failure to do so will result in errors!

ItemNPC["weapon_glock2"] = {
	Name = "Glock",
	Description = "Small pistol",
	Category = "Pistols",
	Price = 100,
	SpawnFunction =
		function( ply, self )
			ply:Give( "weapon_glock2" )
		end
}

ItemNPC["weapon_m42"] = {
	Name = "M4",
	Description = "Requires 3 iron.",
	Category = "Rifles",
	Price = 600,
	SpawnFunction =
		function( ply, self )
			ply:Give( "weapon_m42" )
		end
}

ItemNPC["weapon_mac102"] = {
	Name = "MAC 10",
	Description = "Requires 2 iron.",
	Category = "SMGs",
	Price = 200,
	SpawnFunction =
		function( ply, self )
			ply:Give( "weapon_mac102" )
		end
}

ItemNPC["weapon_mp52"] = {
	Name = "MP5",
	Description = "Requires 2 iron.",
	Category = "SMGs",
	Price = 300,
	SpawnFunction =
		function( ply, self )
			ply:Give( "weapon_mp52" )
		end
}

ItemNPC["weapon_p2282"] = {
	Name = "P228",
	Description = "Requires 1 iron.",
	Category = "Pistols",
	Price = 100,
	SpawnFunction =
		function( ply, self )
			ply:Give( "weapon_p2282" )
		end
}

ItemNPC["weapon_pumpshotgun2"] = {
	Name = "Pump Shotgun",
	Description = "Requires 4 iron.",
	Category = "Shotguns",
	Price = 800,
	SpawnFunction =
		function( ply, self )
			ply:Give( "weapon_pumpshotgun2" )
		end
}

ItemNPC["lockpick"] = {
	Name = "Lockpick",
	Description = "Requires 1 iron.",
	Category = "Tools",
	Price = 150,
	SpawnFunction =
		function( ply, self )
			ply:Give( "lockpick" )
		end
}

ItemNPC["ls_sniper"] = {
	Name = "Silenced Sniper Rifle",
	Description = "Requires 5 iron.",
	Category = "Rifles",
	Price = 600,
	SpawnFunction =
		function( ply, self )
			ply:Give( "ls_sniper" )
		end
}

ItemNPC["weapon_ak472"] = {
	Name = "AK-47",
	Description = "Requires 4 iron and 2 wood.",
	Category = "Rifles",
	Price = 600,
	SpawnFunction =
		function( ply, self )
			ply:Give( "weapon_ak472" )
		end
}

ItemNPC["weapon_deagle2"] = {
	Name = "Deagle",
	Description = "Requires 2 iron.",
	Category = "Pistols",
	Price = 400,
	SpawnFunction =
		function( ply, self )
			ply:Give( "weapon_deagle" )
		end
}

ItemNPC["weapon_fiveseven2"] = {
	Name = "FiveSeven",
	Description = "Requires 1 iron.",
	Category = "Pistols",
	Price = 200,
	SpawnFunction =
		function( ply, self )
			ply:Give( "weapon_fiveseven2" )
		end
}