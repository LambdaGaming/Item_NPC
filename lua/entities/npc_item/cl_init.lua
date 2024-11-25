include( "shared.lua" )

surface.CreateFont( "ItemNPCTitleFont", {
	font = "Arial",
	size = 22,
	antialias = true
} )

function ENT:Draw()
	self:DrawModel()
end

local defaultMenuColor = Color( 49, 53, 61, 200 )
local defaultMenuTextColor = color_white
local defaultButtonColor = Color( 230, 93, 80, 255 )
local defaultButtonTextColor = color_white
local function DrawItemMenu( ent ) --Panel that draws the main menu
	local type = ent:GetNPCType()
	local ply = LocalPlayer()
	local menuColor = ItemNPCType[type].MenuColor or defaultMenuColor
	local menuTextColor = ItemNPCType[type].MenuTextColor or defaultMenuTextColor
	local buttonColor = ItemNPCType[type].ButtonColor or defaultButtonColor
	local buttonTextColor = ItemNPCType[type].ButtonTextColor or defaultButtonTextColor
	local name = ItemNPCType[type].Name or "Invalid NPC"
	local mainframe = vgui.Create( "DFrame" )
	mainframe:SetTitle( name )
	mainframe:SetSize( 500, 800 )
	mainframe:Center()
	mainframe:MakePopup()
	mainframe.Paint = function( self, w, h )
		draw.RoundedBox( 0, 0, 0, w, h, menuColor )
	end

	local listframe = vgui.Create( "DScrollPanel", mainframe )
	listframe:Dock( FILL )
	for k,v in pairs( ItemNPC ) do
		if v.Type != type then
			continue
		end
		local itemName = v.Name or "Invalid Item"
		local itembackground = vgui.Create( "DPanel", listframe )
		itembackground:SetPos( 0, 10 )
		itembackground:SetSize( 450, 100 )
		itembackground:Dock( TOP )
		itembackground:DockMargin( 0, 0, 0, 10 )
		itembackground:Center()
		itembackground.Paint = function()
			draw.RoundedBox( 0, 0, 0, itembackground:GetWide(), itembackground:GetTall(), Color( menuColor.r, menuColor.g, menuColor.b, 255 ) )
		end

		local mainbuttons = vgui.Create( "DButton", itembackground )
		mainbuttons:SetText( itemName )
		mainbuttons:SetTextColor( buttonTextColor )
		mainbuttons:SetFont( "ItemNPCTitleFont" )
		mainbuttons:Dock( TOP )
		mainbuttons.Paint = function( self, w, h )
			draw.RoundedBox( 0, 0, 0, w, h, buttonColor )
		end
		mainbuttons.DoClick = function()
			net.Start( "CreateItem" )
			net.WriteEntity( ent )
			net.WriteInt( k, 15 ) --Max 16k items
			net.SendToServer()
			mainframe:Close()
		end

		if v.Model then
			local itemicon = vgui.Create( "SpawnIcon", itembackground )
			itemicon:SetPos( 10, 30 )
			itemicon:SetModel( v.Model )
			itemicon:SetToolTip( false )
			itemicon:SetSize( 60, 60 )
			itemicon.DoClick = function()
				mainframe:ToggleVisible()

				local modelpanel = vgui.Create( "DFrame" )
				modelpanel:SetTitle( itemName )
				modelpanel:SetSize( 350, 350 )
				modelpanel:Center()
				modelpanel:MakePopup()
				modelpanel.OnClose = function()
					mainframe:ToggleVisible()
				end
				modelpanel.Paint = function( self, w, h )
					draw.RoundedBox( 0, 0, 0, w, h, menuColor )
				end

				local modelpanel2 = vgui.Create( "DAdjustableModelPanel", modelpanel )
				modelpanel2:SetPos( 0, 0 )
				modelpanel2:SetSize( 320, 320 )
				modelpanel2:SetLookAt( Vector( 0, 0, 10 ) )
				modelpanel2:SetCamPos( Vector( -10, 0, 0 ) )
				modelpanel2:SetModel( v.Model )
			end
		end

		local itemprice = vgui.Create( "DLabel", itembackground )
		itemprice:SetFont( "Trebuchet24" )
		itemprice:SetColor( menuTextColor )
		if v.Price and v.Price > 0 then
			itemprice:SetText( "Price: $"..v.Price )
		else
			itemprice:SetText( "Price: Free" )
		end
		itemprice:SizeToContents()

		local itemdesc = vgui.Create( "DLabel", itembackground )
		itemdesc:SetFont( "Trebuchet18" )
		itemdesc:SetColor( menuTextColor )
		itemdesc:SetText( "Description: "..( v.Description or "No description available." ) )
		itemdesc:SetWrap( true )

		if v.Model then
			itemprice:SetPos( 85, 30 )
			itemdesc:SetSize( 240, 100 )
			itemdesc:SetPos( 225, 0 )
		else
			itemprice:SetPos( 5, 30 )
			itemdesc:SetSize( 320, 110 )
			itemdesc:SetPos( 150, -8 )
		end
	end
end

net.Receive( "ItemNPCMenu", function( len, ply ) --Receiving the net message to open the menu
	local ent = net.ReadEntity()
	DrawItemMenu( ent )
end )
