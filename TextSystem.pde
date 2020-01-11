boolean textVisible = false;

PFont mainFont, titleFont;

Text currentText;

void sendText(Text text) {
    currentText = text;
    textVisible = true;
}

void drawText() {
    if (textVisible && currentText.title != null) {
        //Set style settings for the text box
        push();
        stroke(255);
        strokeWeight(3);
        fill(0);
        rect(0, height / 2 + height / 4, width - 2, height / 4 - 2);
        rect(25, height / 2 + height / 4 - 15, 200, 30);
        fill(255);
        textFont(titleFont);
        text(currentText.title, 30, height / 2 + height / 4 + 8);
        textFont(mainFont);
        if (currentText.text == null) {
            //If it is an options box, render the options
            text("> ", 15, height / 2 + height / 4 + 70 + (currentText.selection - 1) * 25);
            text(currentText.option1, 30, height / 2 + height / 4 + 70);
            text(currentText.option2, 30, height / 2 + height / 4 + 95);
            text(currentText.option3, 30, height / 2 + height / 4 + 120);
            text(currentText.option4, 30, height / 2 + height / 4 + 145);
        } else {
            //If it is a text box, render the text
            text(currentText.text, 30, height / 2 + height / 4 + 30, width - 60, height - 20);
        }
        text("<ENTER>", width - textWidth("<ENTER>") - 10, height - 10);
        pop();
    }
}

void moveSelection() {
    //This function changes your selection by using the arrow keys. (For option text)
    if(currentText == null) return;
    if (keyCode == UP) {
        currentText.selection--;
    } else if (keyCode == DOWN) {
        currentText.selection++;
    }
    if (currentText.selection == 0) {
        currentText.selection = 4;
    } else if (currentText.selection == 5) {
        currentText.selection = 1;
    }
}

void selectionSubmit() {
    //This functions runs the desired code based on the currently selected option.
    if(currentText == null) return;
    if (keyCode == ENTER || keyCode == RETURN) {
        println(currentText.nextText);
        if (currentText.text == null) {
            println("A");
            decodeSelectionOutput(currentText.outputs[currentText.selection - 1]);
        } else if (currentText.nextText != null) {
            println("B");
            sendText(currentText.nextText);
        } else if(currentText.onFinish != null) {
            decodeSelectionOutput(currentText.onFinish);
        } else {
            textVisible = false;
        }
    }
}

public void decodeSelectionOutput(String selectionOutput) {
    //This is where you define what code you want to run based of a key, which is stored for each Text Dialoge, or for each option
    switch(selectionOutput) {
        case "attack_sword":
            attackSword();
            break;
        case "attack_bow":
            attackBow();
            break;
        case "run":
            run();
            break;
        case "heal":
            heal();
            break;
        case "enemy-turn":
            enemyTurn();
            break;
        case "player-turn":
            currentText.title = "Battle ";
            break;
        case "win-battle":
            winBattle();
            break;
        case "lose-battle":
            loseBattle();
            break;
        case "back-to-dungeon":
            backToDungeon();
            textVisible = false;
            break;
        case "battleGoose":
            InitiateBattle(new Goose());
            currentRoom.objects.clear();
            currentRoom.objects.add(new Door());
            textVisible = false;
            break;
        case "play": 
            timer = 0;
            state = GameState.LOADING;
            
            textVisible = false;
            break;
        case "instructions":
            sendText(instructionsText1);
            break;
        case "credits":
            sendText(creditsText);
            break;
        case "quit":
            exit();
            break;
        case "buy-ruin":
            if(player.coins >= 1000) {
                if(player.inv.giveItem(new Artifact())) {
                    player.coins -= 1000;
                    Text text = new Text();
                    text.title = "Shop";
                    text.text = "Bought 1 Ruin for $1000";
                    sendText(text);
                } else {
                    Text text = new Text();
                    text.title = "Shop";
                    text.text = "Not enough inventory space!";
                    sendText(text);
                }
            } else {
                Text text = new Text();
                text.title = "Shop";
                text.text = "Not enough money!";
                sendText(text);
            }
            break;
        case "try-place-ruin":
            if(player.inv.removeItem("Ruin", 1)) {
                ((Pedestal)map.teleportRoom.objects.get(pedestalId)).activated = true;
                ((Pedestal)map.teleportRoom.objects.get(pedestalId)).texture = img_pedestal_on;
                map.ruinCount++;
                if(map.ruinCount == 4) {
                    Teleporter teleporter = (Teleporter) map.teleportRoom.objects.get(0);
                    teleporter.activated = true;
                    teleporter.texture = img_teleporter_on;
                    map.teleportRoom.objects.set(0, teleporter);
                }
                textVisible = false;
            } else {
                Text noRuin = new Text();
                noRuin.title = "Error";
                noRuin.text = "You dont have a ruin!";
                sendText(noRuin);
            }
    }
}

//This is the class for Text. Create an instance of this to create a new text box. send it with sendText(text);
public class Text {
    public String title;
    public String text = null;
    
    public String onFinish = null;

    public Text nextText = null;

    public String option1, option2, option3, option4;
    public String[] outputs = new String[4];

    public int selection = 1;
}
