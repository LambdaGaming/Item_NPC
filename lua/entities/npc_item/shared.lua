ENT.Type = "ai"
ENT.Base = "base_ai"
ENT.PrintName = "Item NPC"
ENT.Author = "OPGman"
ENT.Spawnable = false

function ENT:SetupDataTables()
	self:NetworkVar( "Int", 0, "NPCType" )
end

ItemNPC = {} --Initializes the item table, don't touch
ItemNPCType = {} --Initializes the type table, don't touch

--Template NPC Type. All items are optional and will be set to a default value or ignored if not provided.
--[[
ItemNPCType[1] = {
	Name = "DarkRP Weapon Dealer", 				 --Name of the NPC
	Model = "models/breen.mdl",					 --Model of the NPC
	MenuColor = Color( 49, 53, 61, 200 ),		--Color of the menu background
	MenuTextColor = color_white, 				 --Color of the menu background text
	ButtonColor = Color( 230, 93, 80, 255 ),	--Color of the buttons
	ButtonTextColor = color_white, 				 --Color of the button text
	CanUse = function( ply ) return true end,	 --Function to check if player can use NPC
	Anim = 20									 --Animation sequence of the model
}
]]

--Template Item. All items are optional and will be set to a default value or ignored if not provided.
--[[
ItemNPC[1] = {
	Name = "Crowbar",					--Name of the item, different from the item's entity name
	Description = "Tool you can swing",	--Description of the item
	Price = 100,						--Price of the item (DarkRP only)
	Max = 20,							--Amount of this item that players are allowed to purchase
	Type = 1,							--NPC type that this item will be associated with
	CanBuy = function( ply, self )		--Function to check if players can purchase the item
		return ply:Team() != TEAM_MAYOR
	end,
	Give = "weapon_crowbar",			--Class of the weapon that the player should receive upon purchase, don't use for regular entities
	SpawnClass = "weapon_shipment",		--Entity class that should be spawned upon purchase, not recommended for weapons
	SpawnOffset = Vector( 0, 0, 10 ),	--Offset vector that the item should spawn at, relative to the NPC; Useful for big items that tend to spawn under the map
	SpawnFunc = function( ply, item )	--Function to make further modifications to the item after spawning
		item:SetColor( Color( 0, 255, 0 ) )
	end
}
]]
