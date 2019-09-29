
include('shared.lua')

function ENT:Draw()
	self:DrawModel()
end

local function DrawItemMenu( ent ) --Panel that draws the main menu
	local type = ent:GetNPCType()
	local ply = LocalPlayer()
	local mainframe = vgui.Create( "DFrame" )
	mainframe:SetTitle( ItemNPCType[type].Name )
	mainframe:SetSize( 500, 800 )
	mainframe:Center()
	mainframe:MakePopup()
	mainframe.Paint = function( self, w, h )
		draw.RoundedBox( 0, 0, 0, w, h, ItemNPCType[type].MenuColor )
	end
	local mainframescroll = vgui.Create( "DScrollPanel", mainframe )
	mainframescroll:Dock( FILL )
	for a,b in ipairs( CraftingCategory ) do
		local categorybutton = vgui.Create( "DButton", mainframescroll )
		categorybutton:SetSize( nil, 35 ) --X is ignored since it's docked to the frame already
		categorybutton:SetText( b.Name )
		categorybutton:SetFont( "Trebuchet24" )
		categorybutton:SetTextColor( ItemNPCType[type].ButtonTextColor )
		categorybutton:Dock( TOP )
		categorybutton:DockMargin( 0, 15, 0, 5 )
		categorybutton.Paint = function( self, w, h )
			draw.RoundedBox( 0, 0, 0, w, h, b.Color )
		end
		for k,v in pairs( CraftingTable ) do --Looks over all recipes in the main CraftingTable table
			if v.Category != b.Name then --Puts items into their respective categories
				continue
			end
			local mainbuttons = vgui.Create( "DButton", mainframescroll )
			mainbuttons:SetText( v.Name )
			mainbuttons:SetTextColor( ItemNPCType[type].ButtonTextColor )
			mainbuttons:Dock( TOP )
			mainbuttons:DockMargin( 0, 0, 0, 5 )
			mainbuttons.Paint = function( self, w, h )
				draw.RoundedBox( 0, 0, 0, w, h, ItemNPCType[type].ButtonColor )
			end
			mainbuttons.DoClick = function()
				chat.AddText( Color( 100, 100, 255 ), "[Crafting Table]: ", Color( 100, 255, 100 ), "<"..v.Name.."> ", Color( 255, 255, 255 ), v.Description )
				surface.PlaySound( "ui/buttonclickrelease.wav" )
				mainframe:Close()
			end
		end
	end
end

net.Receive( "ItemNPCMenu", function( len, ply ) --Receiving the net message to open the main crafting table menu
	local ent = net.ReadEntity()
	DrawItemMenu( ent )
end )
