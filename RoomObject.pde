public enum TexturePositionType {
    CENTER, ABSOLUTE;
}

//This class stores an object inside of the room. This class is not ment to be used, but instead inherited from.
public class RoomObject {
    float x, y;

    PImage texture;
    
    boolean locked = false;
    
    boolean collition = true;

    TexturePositionType posType;

    RoomObject() {
    }

    void OnClick() {
        println("This is a room object");
    }
    
    void onGenerate() {
        println("If your see this message, somthing has gone wrong...");
    }

    String getName() {
        return "Template Object";
    }
}

//This is a crate.
public class Crate extends RoomObject {

    Crate() {
        //Load the texture
        posType = TexturePositionType.CENTER;
        texture = img_crate;
        //Set it's position
        this.x = random(0, 150);
        this.y = random(0, 150);
        
        if(x > 13 && x < 17 && y > 13 && y < 17) { //This ensures there are no crates in the middle of the room (where the player spawns)
            this.x = random(0, 150);
            this.y = random(0, 150);
        }
        
        collition = true;
    }

    void OnClick() {
        //This code is run when a player interacts with the object.
        
        player.coins += int(random(10, 50));
        player.xp += 10;
        if(floor(random(1,3)) == 1) player.inv.giveItem(generateRandomItem());
        currentRoom.objects.remove(this);
    }
    
    //Returns the name of the object.
    String getName() {
        return "Crate";
    }
}

public class Shop extends RoomObject {

    Shop() {
        //Load the texture
        posType = TexturePositionType.CENTER;
        texture = img_shop;
        //Set it's position
        this.x = 240;
        this.y = 250;
        
        if(x > 13 && x < 17 && y > 13 && y < 17) { //This ensures there are no crates in the middle of the room (where the player spawns)
            this.x = random(0, 150);
            this.y = random(0, 150);
        }
        
        collition = true;
    }

    void OnClick() {
        //This code is run when a player interacts with the object.
        Text selection = new Text();
        selection.title = "Shop";
        selection.option1 = "Yes ($1000)";
        selection.option2 = "No, cancel";
        selection.option3 = "Yes ($1000)";
        selection.option4 = "No, cancel";
        selection.outputs = new String[] {"buy-ruin", "back-to-dungeon", "buy-ruin", "back-to-dungeon"};
        
        Text text = new Text();
        text.title = "Shop";
        text.text = "Would you like to buy (1) Ruin for $1000?";
        text.nextText = selection;
        
        sendText(text);
    }
    
    //Returns the name of the object.
    String getName() {
        return "Crate";
    }
}

public class Door extends RoomObject {

    Door() {
        //Load the texture
        posType = TexturePositionType.CENTER;
        texture = img_door;
        //Set it's position
        this.x = 150;
        this.y = 100;
        
        collition = true;
    }

    void OnClick() {
        //This code is run when a player interacts with the object.
        state = GameState.CREDITS;
    }
    
    //Returns the name of the object.
    String getName() {
        return "Crate";
    }
}

public class GooseObject extends RoomObject {

    GooseObject() {
        //Load the texture
        posType = TexturePositionType.CENTER;
        texture = img_goose_object;
        //Set it's position
        this.x = 150;
        this.y = 100;
        
        if(x > 13 && x < 17 && y > 13 && y < 17) { //This ensures there are no crates in the middle of the room (where the player spawns)
            this.x = random(0, 150);
            this.y = random(0, 150);
        }
        
        collition = true;
    }

    void OnClick() {
        //This code is run when a player interacts with the object.
        
        Text[] text = new Text[6];
        
        for(int i = 0; i < text.length; i++) {
            text[i] = new Text();
            text[i].title = "The Goose";
        }
        
        text[0].text = "So, you made it through my dungeon...";
        text[1].text = "I didn't think you would make it.";
        text[2].text = "But I'm not going to just let you walk out of here like nothing happened.";
        text[3].text = "That would defeat the entire purpose of this game!";
        text[4].text = "And yes, I do know that I'm 'Just inside a game.' I'm not that stupid.";
        text[5].text = "Anyways, prepare to die!";
        
        for(int i = 0; i < text.length; i++) {
            if(i < text.length - 1) {
                text[i].nextText = text[i+1];
            } else {
                text[i].onFinish = "battleGoose";
            }
        }
        
        sendText(text[0]);
    }
    
    //Returns the name of the object.
    String getName() {
        return "Crate";
    }
}

//This is the teleporter
public class Teleporter extends RoomObject {
    
    boolean activated = false;

    Teleporter() {
        //Load the texture
        posType = TexturePositionType.CENTER;
        texture = img_teleporter;
        //Set it's position
        this.x = 150;
        this.y = 150;
        
        //Disable collion detection
        collition = false;
    }

    void OnClick() {
        if(activated) {
            map.layer++;
            map.ruinCount = 0;
            if(map.layer == 2) {
                map.roomX = 50;
                map.roomY = 50;
                
                floorBackground = loadImage("floor_layer_2.png");
                
                map.map = new Room[100][100];
                
                timer = 0;
                state = GameState.LOADING;
            } else {
                map.roomX = 50;
                map.roomY = 50;
                
                floorBackground = loadImage("floor_layer_2.png");
                
                map.map = new Room[100][100];
                
                map.teleportRoomX = -1000;
                map.teleportRoomY = -1000;
                
                map.layer = 0;
                timer = 0;
                state = GameState.LOADING;
                
                player.x = 150;
                player.y = 250;
            }
        }
    }
    
    //Returns the name of the object.
    String getName() {
        return "Teleporter";
    }
}

int pedestalId = 0;

public class Pedestal extends RoomObject {
    
    boolean activated = false;

    int id = 0;

    Pedestal(int corner) {
        //Load the texture
        posType = TexturePositionType.CENTER;
        texture = img_pedestal;
        //Set it's position
        switch(corner) {
            case 1:
                this.x = 55;
                this.y = 55;
                break;
            case 2:
                this.x = 245;
                this.y = 55;
                break;
            case 3:
                this.x = 55;
                this.y = 245;
                break;
            case 4:
                this.x = 245;
                this.y = 245;
                break;
        }
        
        //Enable collion detection
        collition = true;
        
        id = corner;
    }

    void OnClick() {
        if(!activated) {
            println("coolio");
            Text selection = new Text();
            Text finished = new Text();
            Text text = new Text();
            
            text.title = getName();
            text.text = "Do you want to place an ancient ruin on the " + getName() + "?";
            text.nextText = selection;
            
            pedestalId = id;
            
            selection.title = getName();
            selection.option1 = "Yes";
            selection.option2 = "No";
            selection.option3 = "Yes";
            selection.option4 = "No";
            selection.outputs[0] = "try-place-ruin";
            selection.outputs[1] = "back-to-dungeon";
            selection.outputs[2] = "try-place-ruin";
            selection.outputs[3] = "back-to-dungeon";
            
            sendText(text);
            textVisible = true;
        }
    }
    
    //Returns the name of the object.
    String getName() {
        return "Pedestal";
    }
}
