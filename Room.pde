//This class storss information about all of the rooms in the dungeon.
public class Room {
    //Which doors does it have?
    boolean door_up = true;
    boolean door_down = true;
    boolean door_left = true;
    boolean door_right = true;
    
    //Objects and Entities in the room.
    public ArrayList<RoomObject> objects;
    
    public Room(boolean canHaveAdditionalDoors, boolean requiresUpDoor, boolean requiresDownDoor, boolean requiresLeftDoor, boolean requiresRightDoor) {
        //Randomly choose doors.
        if(canHaveAdditionalDoors) {
            door_up = floor(random(0, 4)) == 1;
            door_down = floor(random(0, 4)) == 1;
            door_left = floor(random(0, 4)) == 1;
            door_right = floor(random(0, 4)) == 1;
            
            while(!door_up && !door_down && !door_left && !door_right) {
                int door = int(random(1,5));
                switch(door) {
                    case 1:
                        if(!requiresUpDoor) door_up = true;
                        break;
                    case 2:
                        if(!requiresDownDoor) door_down = true;
                        break;
                    case 3:
                        if(!requiresLeftDoor) door_left = true;
                        break;
                    case 4:
                        if(!requiresRightDoor) door_right = true;
                        break;
                }
            }
        }
        
        //Set the doors that are required to be there
        if(requiresUpDoor) {
            door_up = true;
        }
        if(requiresDownDoor) {
            door_down = true;
        }
        if(requiresLeftDoor) {
            door_left = true;
        }
        if(requiresRightDoor) {
            door_right = true;
        }
    }
    
    public Room(boolean canHaveAdditionalDoors) {
        //Randomly choose doors.
        if(canHaveAdditionalDoors) {
            door_up = floor(random(0, 4)) == 1;
            door_down = floor(random(0, 4)) == 1;
            door_left = floor(random(0, 4)) == 1;
            door_right = floor(random(0, 4)) == 1;
            
            while(!door_up && !door_down && !door_left && !door_right) {
                int door = int(random(1,5));
                switch(door) {
                    case 1:
                        door_up = true;
                        break;
                    case 2:
                        door_down = true;
                        break;
                    case 3:
                        door_left = true;
                        break;
                    case 4:
                        door_right = true;
                        break;
                }
            }
        }
    }
    
    public void addObjects() {
        //Add random objects to the room.
        objects = new ArrayList<RoomObject>();
        int size = int(random(1,10));
        for(int i = 0; i < size; i++) {
            int type = int(random(1,2));
            
            //Add cases to this if statement to add diffrent objects
            switch(type) {
                case 1:
                    objects.add(new Crate());
                    println("Added crate to room!");
                    break;
            }
        }
    }
}
