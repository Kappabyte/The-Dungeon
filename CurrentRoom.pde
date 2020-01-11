//This file is used to show the current room displayed on the bottom half of the screen, and hold the current data for that room

//The current room to be rendered.
Room currentRoom;

//Main function. this draws the current room
void drawCurrentRoom() {
    //Gets the current room
    currentRoom = map.map[map.roomX][map.roomY];
    
    //If the player is in the vaccum of space, dont draw it.
    if(currentRoom == null) {
        return;
    }
    
    //Draw room outline
    fill(0);
    strokeWeight(10);
    image(floorBackground, width / 2 - 150, height/2 + (height / 4 - 150), 300, 300);
    image(wallH, width / 2 - 150, height/2 + (height / 4 - 150));
    image(wallH, width / 2 - 150, height/2 + (height / 4 - 150) + 275);
    image(wallV, width / 2 - 150, height/2 + (height / 4 - 150));
    image(wallV, width / 2 + 125, height/2 + (height / 4 - 150));
    strokeWeight(1);
    
    //Draw the doors on the sides of the room.
    if(currentRoom.door_up) {
        rect(width / 2 - 25, height/2 + (height / 4 - 145), 50, 20);
    }
    if(currentRoom.door_down) {
        rect(width / 2 - 25, height - 60, 50, 20);
    }
    if(currentRoom.door_left) {
        rect(width / 2 - 145, height/2 + height / 4 - 25, 20, 50);
    }
    if(currentRoom.door_right) {
        rect(width / 2 + 125, height/2 + height / 4 - 25, 20, 50);
    }
    strokeWeight(1);
}

void drawRoomObjects() {
    //Gets the current room
    currentRoom = map.map[map.roomX][map.roomY];
    
    //If the player is in the vaccum of space, dont draw it.
    if(currentRoom == null) {
        println("Room has no objects!");
        return;
    }
    
    //Loop through all the objects
    for(int i = 0; i < currentRoom.objects.size(); i++) {
        //Get the general infromation about the object (texture, position).
        PImage texture = currentRoom.objects.get(i).texture;
        float x = currentRoom.objects.get(i).x;
        float y = currentRoom.objects.get(i).y;
        
        //If the texture is positioned based on its center (this is the only case right now, but in the future, it may be useful to position by corner for some objects)
        if(currentRoom.objects.get(i).posType == TexturePositionType.CENTER) {
            image(texture, (width / 2 - 150 + x) - (texture.width / 2), (height / 2 + height / 4 - 150 + y) - (texture.height / 2));
        }
    }
    
    //Draw the player
    image(player.texture, (width / 2 - 150 + player.x) - (player.texture.width / 2), (height / 2 + height / 4 - 150 + player.y) - (player.texture.height / 2));
}

//Draw the UI.
void drawUI() {
    //Health
    image(hp, 7, height/2, 48, 48);
    fill(255, 0, 0);
    textAlign(LEFT);
    textSize(20);
    text(player.health + " / " + player.maxHealth, 67, height / 2 + 36);
    
    //Leavel
    image(lvl, 7, height/2 + 64, 48, 48);
    fill(0, 128, 255);
    textAlign(LEFT);
    textSize(20);
    text(player.level, 67, height / 2 + 100);
    
    //Coins
    image(coins, width - 55, height/2, 48, 48);
    fill(194, 161, 29);
    textAlign(RIGHT);
    textSize(20);
    text(player.coins, width - 67, height / 2 + 36);
    
    //XP
    image(xp, width - 55, height/2 + 64, 48, 48);
    fill(0, 128, 0);
    text(player.xp + " / " + player.nextLevelUp, width - 67, height / 2 + 100);
    
    //Reset styles for next bit of code.
    textAlign(LEFT);
}
