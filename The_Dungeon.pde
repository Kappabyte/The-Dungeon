//Stores the GameState
enum GameState {
    TITLE, DUNGEON, BATTLE, INVENTORY, LOADING, CREDITS
}
GameState state = GameState.TITLE;

void setup() {
    noStroke();
    background(255);
    size(750, 750);

    initalizeImages();

    //Initalize fonts
    mainFont = createFont("Yu Gothic Bold", 18);
    titleFont = createFont("Impact", 18);
    textSize(30);
    fill(0);

    //Create Player
    player = new Player();

    textSize(16);
    createTitleTexts();
}

//Countdown for timer (gives it an oppertunity to show).
int timer = 0;
int creditsHeight = 750;

void draw() {
    background(0);
    fill(255);

    //Update the player.
    player.update();

    //Draw things based on the current state
    if (state == GameState.DUNGEON) {
        drawMap();
        drawMapUI();
        drawCurrentRoom();
        drawRoomObjects();
        drawUI();
    } else if (state == GameState.BATTLE) {
        drawBattle();
        drawBattleUI();
    } else if (state == GameState.INVENTORY) {
        player.inv.renderInventory();
        player.inv.hoverTooltip();
    } else if (state == GameState.TITLE) {
        drawTitle();
    } else if (state == GameState.LOADING) {
        textSize(50);
        text("LOADING...", 100, 100);
        timer++;
        if (timer == 15) generate();
    } else if (state == GameState.CREDITS) {
        push();
        creditsHeight -= 3;
        tint(255, 128);
        image(credits_background, -300, 0, 1418, 750);
        textVisible = false;
        tint(255, 0);
        textAlign(CENTER);
        fill(255);
        text("Computer Science 10: Final Project Credits\n\n-- [ ART ] --\n\nAll art is being used under fair use laws, under EDUCATION.\n\nSkeleton Art\nwww.opengameart.org\n\nZombie Art\nwww.pinterest.ie (John Nguyen)\n\nDemon (Daemon) Art\nwww.FAVPNG.com\n\nGoose Art\nHouse House\n\nCPU Art\ncomputerscience.gcse.guru\n\nCircuit Pun Art\nwww.pinterest.ca/pin/468022586247613253/\n\nPlayer Art\nwww.pixelartmaker.com\n\nArmor Art\nMojang AB\n\nBow Art\npixelartmaker.com\n\nDiamond pixel art (Ruin)\ngiphy.com\n\nCredits Background Image\nhttps://twitter.com/talecrafter\n\n\n-- [ Code ] --\n\nAll code is made by Avery Keuben\n\n-- [ EXTRAS ] --\n\nThank you Mr. Wiebe for teaching me computer science this year. Even through I knew most of the stuff already, thank you for teaching me about CPU's, Transistors, and Logic Gates. I enjoyed your class this year, and am looking forwards to being in CS20-AP next year!\nGo Team 4733!\n", 0, creditsHeight, width, 999999999);
        pop();
        if (creditsHeight < -1500) {
            text("Press <Enter> to exit", width / 2 - 100, height / 2);
            if(keyCode == ENTER || keyCode == RETURN) {
                exit();
            }
        }
    }

    //Always draw text
    drawText();
}

//Called to generate a new dungeon.
void generate() {
    startGeneration(10 * map.layer);
    map.roomX = 50;
    map.roomY = 50;

    if (map.layer == 0) {
        map.map[50][50].objects.clear();
        map.map[50][50].objects.add(new GooseObject());
        map.layer = 3;
    }
}

float px;
float py;
void mousePressed() {
    //Stores the previous position of the mouse (last frame).
    if (state == GameState.DUNGEON) {
        px = mouseX;
        py = mouseY;
    }

    //This is what allows you to move items in the inventory.
    if (mouseButton == LEFT) {
        if (state == GameState.INVENTORY) {
            player.inv.click();
        }
    }
}

void keyPressed() {
    //Key presses
    if (keyCode == ESC) {
        key = 'i';
    }

    //Selecting options for the TextSystem
    if (textVisible) {
        moveSelection();
        selectionSubmit();
    }

    //able to close the inventory
    if (state == GameState.INVENTORY) {
        if (key == 'i' || key == 'I') {
            state = GameState.DUNGEON;
            return;
        }
    }

    //Registar inputs for the player (movement, inventory, etc)
    if (state == GameState.DUNGEON && !textVisible) {
        player.playerInputs();
    }
}

//For moving the map
void mouseDragged() {
    if (mouseButton == CENTER) {
        float nx = mouseX - px;
        float ny = mouseY - py;

        map.offsetX += nx;
        map.offsetY += ny;

        mousePressed();
    }
}

//For zooming the map.
void mouseWheel(MouseEvent event) {
    float e = event.getCount();
    map.scale += e / -10;
}
