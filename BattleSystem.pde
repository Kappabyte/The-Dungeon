//The entity you are attacking
public Entity currentTarget;

//Call this to start a battle
public void InitiateBattle(Entity entity) {

    currentTarget = entity;

    state = GameState.BATTLE;
}

//Draw the battle (You, target, pads)
public void drawBattle() {
    fill(255);
    ellipse(100, 200, 150, 50);
    ellipse(width - 300, 400, 150, 50);
    
    image(currentTarget.texture, 61, 72);
    image(player.battleTexture, width - 400, 300);
}

//Draw the battleUI and text
void drawBattleUI() {
    //Set the text to be the correct text for the battle
    if (currentText.title != "Battle") {
        //Create text for the battle
        Text battleText = new Text();
        battleText.title = "Battle";
        
        //Give players a 'Fist' item if a weapon slot is empty.
        if(player.inv.mainWeapon == null) {
            player.inv.mainWeapon = new Weapon();
            player.inv.mainWeapon.name = "Fist";
            player.inv.mainWeapon.maxAttack = 1;
            player.inv.mainWeapon.texture = loadImage("Entities/player.png");
            player.inv.mainWeapon.updateDesc();
        }
        if(player.inv.secondaryWeapon == null) {
            player.inv.secondaryWeapon = new Weapon();
            player.inv.secondaryWeapon.name = "Fist";
            player.inv.secondaryWeapon.maxAttack = 1;
            player.inv.secondaryWeapon.texture = loadImage("Entities/player.png");
            player.inv.secondaryWeapon.updateDesc();
        }
        
        //Set the battle options
        battleText.option1 = "Attack (" + player.inv.mainWeapon.name + ")";
        battleText.option2 = "Attack (" + player.inv.secondaryWeapon.name + ")";
        battleText.option3 = "Run";
        battleText.option4 = "Heal";
        battleText.outputs = new String[] {"attack_sword", "attack_bow", "run", "heal"};
        
        //Display the arrow count for bows.
        if(player.inv.mainWeapon.name == "Bow" || player.inv.mainWeapon.name == "Starter Bow") {
            battleText.option1 += " [" + player.inv.arrows.amount + "]";
            if(player.inv.arrows.amount < 1) {
                //Can shoot a bow without arrows!
                battleText.outputs[0] = "player-turn";
            }
        }
        if(player.inv.secondaryWeapon.name == "Bow" || player.inv.secondaryWeapon.name == "Starter Bow") {
            battleText.option2 += " [" + player.inv.arrows.amount + "]"; 
            if(player.inv.arrows.amount < 1) {
                //Can shoot a bow without arrows!
                battleText.outputs[1] = "player-turn";
            }
        }
        
        //Send the battle text.
        sendText(battleText);
    }

    //Enemy UI
    fill(0);
    stroke(255);
    rect(200, 50, 200, 100);
    fill(255);
    noStroke();
    text(currentTarget.getName(), 215, 75);
    //Health
    fill(128, 0, 0);
    rect(215, 100, 170, 15);
    fill(255, 0, 0);
    rect(215, 100, currentTarget.health / float(currentTarget.maxHealth) * 170, 15);

    //Player UI
    fill(0);
    stroke(255);
    rect(width - 205, 225, 200, 100);
    fill(255);
    noStroke();
    text("Player", width - 190, 250);
    //Health
    fill(128, 0, 0);
    rect( width - 190, 275, 170, 15);
    fill(255, 0, 0);
    rect( width - 190, 275, player.health / float(player.maxHealth) * 170, 15);
}

//Attacks with your primary (main) weapon.
void attackSword() {
    //Removes arrwos for bows
    if(player.inv.mainWeapon.name == "Bow" || player.inv.mainWeapon.name == "Starter Bow") {
        player.inv.arrows.amount--;
    }
    
    //Calculate the damage of the weapon.
    int damage = int(random(player.inv.mainWeapon.maxAttack / 2, player.inv.mainWeapon.maxAttack));
    
    //Update text to tell you the amount of damage.
    Text battleText2 = new Text();
    battleText2.title = "Battle";
    
    //Take damage, and check if the battle is over.
    if (currentTarget.TakeDamage(damage)) {
        //is dead
        battleText2.onFinish = "win-battle";
    } else {
        //is alive
        battleText2.onFinish = "enemy-turn";
    }
    
    battleText2.text = "You attack with your sword, dealing " + damage + " damage!";
    
    //Send the text
    sendText(battleText2);
}

void attackBow() {
    //Removes arrwos for bows
    if(player.inv.secondaryWeapon.name == "Bow" || player.inv.secondaryWeapon.name == "Starter Bow") {
        player.inv.arrows.amount--;
    }
    
    //Calculate the damage of the weapon.
    int damage = int(random(player.inv.secondaryWeapon.maxAttack / 2, player.inv.secondaryWeapon.maxAttack));
    
    //Update text to tell you the amount of damage.
    Text battleText2 = new Text();
    battleText2.title = "Battle";
    
    //Take damage, and check if the battle is over.
    if (currentTarget.TakeDamage(damage)) {
        //is dead
        battleText2.onFinish = "win-battle";
    } else {
        //is alive
        battleText2.onFinish = "enemy-turn";
    }
    
    battleText2.text = "You attack with your bow, dealing " + damage + " damage!";
    
    //Send the text
    sendText(battleText2);
}
void run() {
    //Chance of escaping
    boolean escape = int(random(1, 3)) == 1;
    
    //Show the correct text based on if you escape. Return to the dungeon if you do.
    if (escape && currentTarget.getName() != "The Goose") {
        Text battleText2 = new Text();
        battleText2.title = "Battle";
        battleText2.onFinish = "back-to-dungeon";
        battleText2.text = "You manage escape the battle";
        sendText(battleText2);
    } else {
        Text battleText2 = new Text();
        battleText2.title = "Battle";
        battleText2.onFinish = "enemy-turn";
        battleText2.text = "You fail to escape the battle!";
        sendText(battleText2);
    }
}

void heal() {
    //How much should be healed?
    int health = int(random(1, (player.maxHealth - player.health) / 10));
    
    //Update the text to show how much you healed.
    Text battleText2 = new Text();
    battleText2.title = "Battle";
    battleText2.onFinish = "enemy-turn";
    battleText2.text = "You heal " + health + " health!";
    sendText(battleText2);
    
    //Give back the health
    player.TakeDamage(-1 * health);
}


void enemyTurn() {
    //Deside what the enemy is going to do.
    int action = int(random(1, 15));
    if (action >= 0 && action <= 6) {
        //Attack (main)
        
        //Calculate damage
        int damage = int(random(currentTarget.primaryAttackMaxDamage / 2, currentTarget.primaryAttackMaxDamage));
        damage *= 1 - player.getProtectionModifier();
        
        //Update the text
        currentText.text = currentTarget.getName() + " dealt " + damage + " damage using " + currentTarget.primaryAttackName;
        
        //Take damage
        player.TakeDamage(damage);
    } else if (action > 6 && action <= 12) {
        //Attack (secondary)
        
        //Calculate Damage
        int damage = int(random(currentTarget.secondaryAttackMaxDamage / 2, currentTarget.secondaryAttackMaxDamage));
        damage *= 1 - player.getProtectionModifier();
        
        //Update the text
        currentText.text = currentTarget.getName() + " dealt " + damage + " damage using " + currentTarget.secondaryAttackName;
        
        //Take damage
        player.TakeDamage(damage);
    } else if (action == 13) {
        //Heal
        
        //How much should be healed?
        int health = int(random(1, (currentTarget.maxHealth - currentTarget.health) / 10));
        
        //Update the text
        currentText.text = currentTarget.getName() + " healed " + health + " health!";
        
        //Give back health
        currentTarget.TakeDamage(-health);
    } else if (action == 14) {
        //Run Away
        
        //Target always fails to run away =)
        currentText.text = currentTarget.getName() + " tried to run away, but failed!";
    }
    
    //Go back to the players turn after this text
    currentText.onFinish = "player-turn";
    
    //If the player is dead, lose the battle
    if(player.health <= 0) {
        currentText.onFinish = "lose-battle";
    }
}

void winBattle() {
    //Update text for winning
    currentText.text = "You won the battle!";
    currentText.onFinish = "back-to-dungeon";
    
    //Give XP and Coins reward
    player.xp += 15 * map.layer;
    player.coins += int(random(1,150));
}
void loseBattle() {
    //Update the text
    currentText.text = "You lost the battle!";
    currentText.onFinish = "play";
    
    //Update the player health
    player.health = player.maxHealth;
    
    //Go to the previous layer
    map.layer -= 1;
    
    //Make sure the player isnt on layer 0
    if(map.layer == 0) {
        map.layer = 1;
    }
    
    //Fix the background for floor 1
    if(map.layer ==1) {
        floorBackground = loadImage("floor_layer_1.png");
    }
    
    //Reset the map.
    map.map = new Room[100][100];
}
