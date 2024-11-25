# Item NPC
 Customizable NPC for Garry's Mod that players can purchase items from. This addon is made for server developers and cannot be used as-is. It was designed for DarkRP and my Half-Life Universe RP server, but it can be made to work with other gamemodes with minor tweaks. See the shared.lua file for more info.

## Hooks
### ItemNPC_CanUse
Scope: Server  
Arguments: `Player` ply, `Entity` npc  
Called immediately after the player presses their use key on the NPC. Return false to prevent the player from using the NPC.

### ItemNPC_CanBuy
Scope: Server  
Arguments: `Player` ply, `Entity` npc, `Number` itemIndex  
Called immediately after the purchase is initialized. Return false to prevent the player from purchasing the item.

### ItemNPC_ModifyPrice
Scope: Shared  
Arguments: `Player` ply, `Entity` npc, `Number` itemIndex  
Called after the purchase is initialized and before the NPC checks if the player can afford it. Return a number to set a new price for the item.

### ItemNPC_PostBuy
Scope: Server  
Arguments: `Player` ply, `Entity` npc, `Number` itemIndex, `Number` finalPrice, `Entity` spawnedItem  
Called after the purchase is completed. The finalPrice argument is what the price ends up being after ItemNPC_ModifyPrice is called. The spawnedItem argument will only be passed if the item purchased is a valid entity.

# Issues & Pull Requests
 If you would like to contribute to this repository by creating an issue or pull request, please refer to the [contributing guidelines.](https://lambdagaming.github.io/contributing.html)
