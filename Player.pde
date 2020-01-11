//The current Player
Player player;

public class Player extends Entity {
    //Current Player Stats
    int coins, xp, hp = 0;

    //Stores how much xp you need in order to level up.
    int nextLevelUp = 100;

    //Your current level
    int level = 0;
    
    //The speed the player moves
    float moveSpeed = 5;
    
    //Player position in the current room
    float x, y;

    //Your inventory. See 'Inventory' Tab for more.
    Inventory inv;

    //The texture used when the player is battling.
    PImage battleTexture;

    Player() {
        //Initial room position.
        x = 150;
        y = 150;

        //Initial health.
        health = 100;

        //Load textures.
        texture = loadImage("player.png");
        battleTexture = loadImage("entities/player.png");

        //Create the inventory
        inv = new Inventory();
    }

    boolean Move(int direction) {
        //Check collition with objects
        for (int i = 0; i < currentRoom.objects.size(); i++) {
            float newX = x;
            float newY = y;
            if (direction == LEFT) {
                newX -= moveSpeed;
            }
            if (direction == RIGHT) {
                newX += moveSpeed;
            }
            if (direction == UP) {
                newY -= moveSpeed;
            }
            if (direction == DOWN) {
                newY += moveSpeed;
            }

            RoomObject obj = currentRoom.objects.get(i);

            if (!obj.collition) {
                continue;
            }

            //This if statement check if ther player where to move, would they be inside the object. Checks each vert of the rectangle
            if (newX - texture.width / 2 > obj.x - obj.texture.width / 2 && newX - texture.width / 2 < obj.x + obj.texture.width / 2 && newY + texture.height / 2 > obj.y - obj.texture.height / 2 && newY + texture.height / 2 < obj.y + obj.texture.height / 2) {
                return false; //Cancel out of the funtion
            }

            if (newX + texture.width / 2 > obj.x - obj.texture.width / 2 && newX + texture.width / 2 < obj.x + obj.texture.width / 2 && newY - texture.height / 2 > obj.y - obj.texture.height / 2 && newY - texture.height / 2 < obj.y + obj.texture.height / 2) {
                return false; //Cancel out of the funtion
            }

            if (newX - texture.width / 2 > obj.x - obj.texture.width / 2 && newX - texture.width / 2 < obj.x + obj.texture.width / 2 && newY - texture.height / 2 > obj.y - obj.texture.height / 2 && newY - texture.height / 2 < obj.y + obj.texture.height / 2) {
                return false; //Cancel out of the funtion
            }

            if (newX + texture.width / 2 > obj.x - obj.texture.width / 2 && newX + texture.width / 2 < obj.x + obj.texture.width / 2 && newY + texture.height / 2 > obj.y - obj.texture.height / 2 && newY + texture.height / 2 < obj.y + obj.texture.height / 2) {
                return false; //Cancel out of the funtion
            }

            //Extra checks for middle of player collition box sides
            if (newX + texture.width / 2 > obj.x - obj.texture.width / 2 && newX + texture.width / 2 < obj.x + obj.texture.width / 2 && newY > obj.y - obj.texture.height / 2 && newY < obj.y + obj.texture.height / 2) {
                return false; //Cancel out of the funtion
            }
            if (newX - texture.width / 2 > obj.x - obj.texture.width / 2 && newX - texture.width / 2 < obj.x + obj.texture.width / 2 && newY > obj.y - obj.texture.height / 2 && newY < obj.y + obj.texture.height / 2) {
                return false; //Cancel out of the funtion
            }

            if (newX > obj.x - obj.texture.width / 2 && newX < obj.x + obj.texture.width / 2 && newY + texture.height / 2 > obj.y - obj.texture.height / 2 && newY + texture.height / 2 < obj.y + obj.texture.height / 2) {
                return false; //Cancel out of the funtion
            }
            if (newX > obj.x - obj.texture.width / 2 && newX < obj.x + obj.texture.width / 2 && newY - texture.height / 2 > obj.y - obj.texture.height / 2 && newY - texture.height / 2 < obj.y + obj.texture.height / 2) {
                return false; //Cancel out of the funtion
            }
        }
        //Check collition with walls. If statement pass if you can move. The player will than move. Then trys to start a battle. (1 in 150 chance).
        if (direction == LEFT && x > 0 + texture.width / 2) {
            x -= moveSpeed;
            if (int(random(1, 100)) == 5 && map.roomY != map.teleportRoomX && map.roomY != map.teleportRoomY && map.layer != 3) {
                InitiateBattle(generateRandomEntity());
            }
            return true;
        } else if (direction == RIGHT && x < 300 - texture.width / 2) {
            x += moveSpeed;
            if (int(random(1, 100)) == 5 && map.roomY != map.teleportRoomX && map.roomY != map.teleportRoomY && map.layer != 3) {
                InitiateBattle(generateRandomEntity());
            }
            return true;
        } else if (direction == UP && y > 0 + texture.height / 2) {
            y -= moveSpeed;
            if (int(random(1, 100)) == 5 && map.roomY != map.teleportRoomX && map.roomY != map.teleportRoomY && map.layer != 3) {
                InitiateBattle(generateRandomEntity());
            }
            return true;
        } else if (direction == DOWN && y < 300 - texture.width / 2) {
            y += moveSpeed;
            if (int(random(1, 100)) == 5 && map.roomY != map.teleportRoomX && map.roomY != map.teleportRoomY && map.layer != 3) {
                InitiateBattle(generateRandomEntity());
            }
            return true;
        }

        return false;
    }

    //Gets a value between 0 and 1. This value represents how much damage will be taken off an attack twords the player. (Based on their armor stats)
    float getProtectionModifier() {
        float protection = 0.0;
        try {
            protection += player.inv.head.protectionModifier / 8; //Get helmet protection modifier.
        } 
        catch (Exception e) {
        }
        try {
            protection += player.inv.body.protectionModifier / 8; //Get chestplate protection modifier.
        } 
        catch (Exception e) {
        }
        try {
            protection += player.inv.legs.protectionModifier / 8; //Get leggings protection modifier.
        } 
        catch (Exception e) {
        }
        try {
            protection += player.inv.boots.protectionModifier / 8; //Get boots protection modifier.
        } 
        catch (Exception e) {
        }

        //Turn from percent into decimal.
        protection /= 100; 

        //Make sure we never return a value grater than 1 (this would heal the player).
        if (protection > 0.99) {
            protection = 0.99;
        }

        return protection;
    }

    void update() {
        //Should the player level up?
        if (xp >= nextLevelUp) {
            //Increse the players max health
            maxHealth += 50;
            //Set them back to full health
            health = maxHealth;
            //Reset XP
            xp -= nextLevelUp;
            nextLevelUp *= 2;
            level++;
        }
    }

    void playerInputs() {
        //Check movement inputs
        if (key == 'w') {
            Move(UP);
        } else if (key == 'a') {
            Move(LEFT);
        } else if (key == 's') {
            Move(DOWN);
        } else if (key == 'd') {
            Move(RIGHT);
        }
        
        //Skip implemented for testing and marking
        if(keyCode == 35) { //Keycode for END
            ((Teleporter)map.teleportRoom.objects.get(0)).activated = true;
            ((Teleporter)map.teleportRoom.objects.get(0)).OnClick();
        } else if(keyCode == 36) {//Keycode for HOME
            player.inv.head = new Helmet();
            player.inv.head.name = "Cheater Helmet";
            player.inv.head.protectionModifier = 999999;
            player.inv.head.updateDesc();
            player.inv.head.rarity = Rarity.DEVELOPER;
            
            player.inv.body = new Chestplate();
            player.inv.body.name = "Cheater Chestplate";
            player.inv.body.protectionModifier = 999999;
            player.inv.body.updateDesc();
            player.inv.body.rarity = Rarity.DEVELOPER;
            
            player.inv.legs = new Leggings();
            player.inv.legs.name = "Cheater Leggings";
            player.inv.legs.protectionModifier = 999999;
            player.inv.legs.updateDesc();
            player.inv.legs.rarity = Rarity.DEVELOPER;
            
            player.inv.boots = new Boots();
            player.inv.boots.name = "Cheater Boots";
            player.inv.boots.protectionModifier = 999999;
            player.inv.boots.updateDesc();
            player.inv.boots.rarity = Rarity.DEVELOPER;
            
            player.inv.mainWeapon = new Sword();
            player.inv.mainWeapon.name = "Cheater Sword";
            player.inv.mainWeapon.maxAttack = 999999;
            player.inv.mainWeapon.updateDesc();
            player.inv.mainWeapon.rarity = Rarity.DEVELOPER;
            
            player.inv.secondaryWeapon = new Bow();
            player.inv.secondaryWeapon.name = "Cheater Bow";
            player.inv.secondaryWeapon.maxAttack = 999999;
            player.inv.secondaryWeapon.updateDesc();
            player.inv.secondaryWeapon.rarity = Rarity.DEVELOPER;
            
            player.inv.arrows.amount = 999;
        }
        //Should a player go through a door?
        if ((key == 'w' || key == 'W') && currentRoom.door_up    && x > 125 && x < 175 && y < 25 ) { //NORTH
            player.y = 300 - player.y;
            map.roomY--;
        } else if ((key == 's' || key == 'S') && currentRoom.door_down  && x > 125 && x < 175 && y > 275) { //SOUTH
            player.y = 300 - player.y;
            map.roomY++;
        } else if ((key == 'a' || key == 'A') && currentRoom.door_left  && x < 25  && y > 125 && y < 175) { //WEST
            player.x = 300 - player.x;
            map.roomX--;
        } else if ((key == 'd' || key == 'D') && currentRoom.door_right && x > 275 && y > 125 && y < 175) { //EAST
            player.x = 300 - player.x;
            map.roomX++;
        }

        //Interacting with objects
        if (key == 'e' || key == 'E') {
            //Loop through all the objects
            for (int i = 0; i < currentRoom.objects.size(); i++) {
                RoomObject obj = currentRoom.objects.get(i);
                //Check if the player is in range
                if (obj.collition && x > obj.x - (obj.texture.width * 1.5 + player.texture.width / 2) && x < obj.x + (obj.texture.width * 1.5 + player.texture.width / 2) && y > obj.y - (obj.texture.height * 1.5 + player.texture.height / 2) && y < obj.y + (obj.texture.height * 1.5 + player.texture.height / 2)) {
                    //Run the nessisary code for that object.
                    obj.OnClick();
                } else if (!obj.collition && x > obj.x - obj.texture.width / 2 && x < obj.x + obj.texture.width / 2 && y > obj.y - obj.texture.height / 2 && y < obj.y + obj.texture.height / 2) {
                    obj.OnClick();
                }
            }
        }

        //Opening Inventory
        if (key == 'i' || key == 'I') {
            state = GameState.INVENTORY;
        }
    }
}
