Text titleText;

Text instructionsText1;
Text instructionsText2;
Text instructionsText3;

Text creditsText;

public void createTitleTexts() {
    //Create the main menu dialoge using the TextSystem
    titleText = new Text();
    titleText.title = "";
    titleText.option1 = "Play";
    titleText.option2 = "Instructions";
    titleText.option3 = "Credits";
    titleText.option4 = "Quit";
    titleText.outputs = new String[] {"play", "instructions", "credits", "quit"};
    
    //Create the instructions (pt 3) dialoge using the TextSystem
    instructionsText3 = new Text();
    instructionsText3.title = "Instructions";
    instructionsText3.text = "You can press 'e' to interact with objects in the dungeon, WASD to move, and 'i' to open your inventory. Click with your mouse to interact with the inventory. In text boxes (like this one), press 'ENTER' to continue, or use the arrow keys to select an option. Use the middle mouse button to move the map.";
    instructionsText3.nextText = titleText;
    
    //Create the instructions (pt 2) dialoge using the TextSystem
    instructionsText2 = new Text();
    instructionsText2.title = "Instructions";
    instructionsText2.text = "Be careful though! There are dangerous monsters throughout the dungeon. Find loot, level up your character, and kill the final boss!\n Dont forget to equip armor in your inventory!";
    instructionsText2.nextText = instructionsText3;
    
    //Create the instructions (pt 1) dialoge using the TextSystem
    instructionsText1 = new Text();
    instructionsText1.title = "Instructions";
    instructionsText1.text = "Welcome to the dungeon! Once you're in the dungeon, control your character by using WASD. You can open your inventory by pressing 'i'. Find the crystals on each floor in crates, use them to activate the teleporter, and make your way out of the dungeon!";
    instructionsText1.nextText = instructionsText2;
    
    //Create the credits dialoge using the TextSystem
    creditsText = new Text();
    creditsText.title = "Credits";
    creditsText.text = "Made 100% from scratch by Avery Keuben.\nSome images are from google images.\nTo see spicifics, see 'credits.txt' in the source code.";
    creditsText.nextText = titleText;
    
    //Use the main menu dialoge
    sendText(titleText);
}

public void drawTitle() {
    push();
    
    //Draw title and coins
    textFont(mainFont, 36);
    text("The Dungeon", width / 2 - textWidth("The Dungeon") / 2, 100);
    textSize(18);
    
    image(coins, width / 2 - coins.width / 2, 200);
    
    pop();
}
