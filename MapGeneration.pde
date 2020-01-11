/*                                                        -----[ THIS FILE IS REALLY COMPLEX ]-----
    - Basicly what it does, is randomly select doors for the first room. For EACH door, it generates a room beside it, and randomly selects doors for that room. This repeats until depth = 0
    - I then run fixDoors() which is reponsible for making sure that when you go through a door, a door exists back to the previous room.
    - Random objects are then generated in each room, until all of the rooms are populated.
    - The teleport room is assigned to a random room, and the objects in that room are replaced with the teleporter and the pedestals. 
    - We than set the state back to GameState.DUNGEON using backToDungeon();
    
    The code below is uncommented, as I ran out of time to do that. If you want to understand the code better, feel free to talk to me during robotics, or during comm tech in semester 2.
*/

Map map = new Map();

void startGeneration(int depth) {
    map.map[50][50] = new Room(true, true, false, false, false);
    generateRoomsBeside(50, 50, depth--);
    println(map.map[50][50].door_up + " / " + map.map[50][50].door_down + " / " + map.map[50][50].door_left + " / " + map.map[50][50].door_right + " / ");
    fixDoors();
    generateObjects();
    
    if(map.layer != 0) {
        chooseTeleportRoom();
    }
    
    map.map[50][50].objects.add(new Shop());
    
    backToDungeon();
}

void updateScale(float deltaScale) {
    map.scale *= deltaScale / 10;
}

void generateRoomsBeside(int x, int y, int depth) {
    if (depth > 1) {
        //Up
        if (map.map[x][y].door_up) {
            if(map.map[x][y - 1] == null) {
                map.map[x][y - 1] = new Room(depth > 0, false, true, false, false);
            } else {
                map.map[x][y - 1].door_down = true;
            }
            generateRoomsBeside(x, y - 1, depth - 1);
        }
        if (map.map[x][y].door_down) {
            if(map.map[x][y + 1] == null) {
                map.map[x][y + 1] = new Room(depth > 0, true, false, false, false);
            } else {
                map.map[x][y + 1].door_up = true;
            }
            generateRoomsBeside(x, y + 1, depth - 1);
        }
        if (map.map[x][y].door_left) {
            if(map.map[x - 1][y] == null) {
                map.map[x - 1][y] = new Room(depth > 0, false, false, false, true);
            } else {
                map.map[x - 1][y].door_right = true;
            }
            generateRoomsBeside(x - 1, y, depth - 1);
        }
        if (map.map[x][y].door_right) {
            if(map.map[x + 1][y] == null) {
                map.map[x + 1][y] = new Room(depth > 0, false, false, true, false);
            } else {
                map.map[x + 1][y].door_left = true;
            }
            generateRoomsBeside(x + 1, y, depth - 1);
        }
    } else if(depth == 1) {
        if (map.map[x][y].door_up) {
            map.map[x][y - 1] = new Room(depth > 0);
            generateRoomsBeside(x, y - 1, depth - 1);
        }
        if (map.map[x][y].door_down) {
            map.map[x][y + 1] = new Room(depth > 0);
            generateRoomsBeside(x, y + 1, depth - 1);
        }
        if (map.map[x][y].door_left) {
            map.map[x - 1][y] = new Room(depth > 0);
            generateRoomsBeside(x - 1, y, depth - 1);
        }
        if (map.map[x][y].door_right) {
            map.map[x + 1][y] = new Room(depth > 0);
            generateRoomsBeside(x + 1, y, depth - 1);
        }
    }
}

void fixDoors() {
    for(int x = 0; x < map.map.length; x++) {
        for(int y = 0; y < map.map[x].length; y++) {
            if(map.map[x][y] != null) {
                if(map.map[x][y-1] != null && map.map[x][y-1].door_down) {
                    map.map[x][y].door_up = true;
                }
                if(map.map[x][y+1] != null && map.map[x][y+1].door_up) {
                    map.map[x][y].door_down = true;
                }
                if(map.map[x-1][y] != null && map.map[x-1][y].door_right) {
                    map.map[x][y].door_left = true;
                }
                if(map.map[x+1][y] != null && map.map[x+1][y].door_left) {
                    map.map[x][y].door_right = true;
                }
                
                if(map.map[x][y].door_down && map.map[x][y+1] == null) {
                    map.map[x][y].door_down = false;
                }
                if(map.map[x][y].door_up && map.map[x][y-1] == null) {
                    map.map[x][y].door_up = false;
                }
                if(map.map[x][y].door_left && map.map[x-1][y] == null) {
                    map.map[x][y].door_left = false;
                }
                if(map.map[x][y].door_right && map.map[x+1][y] == null) {
                    map.map[x][y].door_right = false;
                }
            }
        }
    }
}

void chooseTeleportRoom() {
    map.teleportRoom = null;
    map.teleportRoomX = 50;
    map.teleportRoomY = 50;
    while(map.teleportRoom == null) {
        map.teleportRoomX = floor(random(map.map.length));
        map.teleportRoomY = floor(random(map.map[map.teleportRoomY].length));
        map.teleportRoom = map.map[map.teleportRoomX][map.teleportRoomY];
    }
    map.teleportRoom.objects.clear();
    map.teleportRoom.objects.add(new Teleporter());
    for(int i = 1; i <= 4; i++) {
        map.teleportRoom.objects.add(new Pedestal(i));
    }
}

void generateObjects() {
    for(int x = 0; x < map.map.length; x++) {
        for(int y = 0; y < map.map[x].length; y++) {
            if(map.map[x][y] != null) {
                map.map[x][y].addObjects();
            }
        }
    }
}
