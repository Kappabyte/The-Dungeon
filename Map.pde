
//Stores the current map of the dungeon, as well as all the rooms.
public class Map {
    //Design of the map
    int gridSize = 75;
    int roomSize = 20;
    int hallSize = 2;
    
    //The current room
    int roomX = 50;
    int roomY = 50;
    
    //The current layer
    int layer = 1;
    
    //Positioning and scale of the map
    float scale = 1.0;
    float offsetX = -3500;
    float offsetY = -3500;
    
    //The rooms in the map
    Room[][] map = new Room[100][100];
    
    //The teleport room location, and tha actual room.
    int teleportRoomX = 0;
    int teleportRoomY = 0;
    Room teleportRoom = null;
    
    //The number of ruins on pedesals in the teleport room
    int ruinCount = 0;
}

//Draws the UI of the map.
public void drawMapUI() {
    //Map text
    text("MAP", 10, 20);
    
    //Rectange below the map, to cover it up. (this is where the current room is drawn)
    fill(0);
    stroke(255);
    rect(-10, height / 2, width + 20, height / 2 + 20);
}

//Function called to return to the dungeon from any other state.
public void backToDungeon() {
    currentText.title = ""; //Hides the current text
    state = GameState.DUNGEON;
}

//Draws the map
void drawMap() {
    fill(255, 255, 255);
    
    //These draw the rooms and the hallways
    for (int x = 0; x < map.map.length; x++) {
        for (int y = 0; y < map.map.length; y++) {
            //Check if the room exists
            if (map.map[x][y] != null) {
                //Draw the room
                rect((map.gridSize * x - map.hallSize / 2) * map.scale + map.offsetX, (map.gridSize * y - map.roomSize / 2) * map.scale + map.offsetY, map.roomSize * map.scale, map.roomSize * map.scale);
                
                //Check the doors, to see if there should be a hallway.
                if (map.map[x][y].door_up) {
                    rect((map.gridSize * x + map.roomSize / 2) * map.scale + map.offsetX - map.hallSize / 2, (map.gridSize * y) * map.scale + map.offsetY, map.hallSize * map.scale, (-map.gridSize - map.roomSize / 2) * map.scale); //width = size of hall / height = the gid size (-)
                }
                if (map.map[x][y].door_down) {
                    rect((map.gridSize * x + map.roomSize / 2) * map.scale + map.offsetX - map.hallSize / 2, (map.gridSize * y) * map.scale + map.offsetY, map.hallSize * map.scale, (map.gridSize - map.roomSize / 2) * map.scale);
                }
                if (map.map[x][y].door_left) {
                    rect((map.gridSize * x + map.roomSize / 2) * map.scale + map.offsetX - map.hallSize / 2, (map.gridSize * y) * map.scale + map.offsetY, (-map.gridSize - map.roomSize / 2) * map.scale, map.hallSize * map.scale);
                }
                if (map.map[x][y].door_right) {
                    rect((map.gridSize * x + map.roomSize / 2) * map.scale + map.offsetX - map.hallSize / 2, (map.gridSize * y) * map.scale + map.offsetY, (map.gridSize - map.roomSize / 2) * map.scale, map.hallSize * map.scale);
                }
            }
        }
    }
    
    //Player and teleporter room colouring
    fill(0, 128, 255);
    rect((map.gridSize * map.teleportRoomX - map.hallSize / 2) * map.scale + map.offsetX, (map.gridSize * map.teleportRoomY - map.roomSize / 2) * map.scale + map.offsetY, map.roomSize * map.scale, map.roomSize * map.scale);
    fill(255, 0, 0);
    rect((map.gridSize * map.roomX - map.hallSize / 2) * map.scale + map.offsetX, (map.gridSize * map.roomY - map.roomSize / 2) * map.scale + map.offsetY, map.roomSize * map.scale, map.roomSize * map.scale);
    fill(255);
}
