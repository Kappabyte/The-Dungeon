PImage delete;

public class Inventory {
    public Helmet head;
    public Chestplate body;
    public Leggings legs;
    public Boots boots;

    public Weapon mainWeapon, secondaryWeapon;

    public Item arrows;

    public Item holding;

    public Item[] storage = new Item[32];

    Inventory() {
        arrows = new Arrow();
        arrows.amount = 8;
    
        //Set initial items
        mainWeapon = new Sword();
        mainWeapon.name = "Starter Sword";
        mainWeapon.maxAttack = 15;
        mainWeapon.rarity = Rarity.COMMON;
        mainWeapon.updateDesc();
        secondaryWeapon = new Bow();
        secondaryWeapon.name = "Starter Bow";
        secondaryWeapon.maxAttack = 15;
        secondaryWeapon.rarity = Rarity.COMMON;
        secondaryWeapon.updateDesc();
        
        //Load the delete texture.
        delete = loadImage("delete.png");
    }
    
    //Gives an item to the player.
    public boolean giveItem(Item item) {
        if (item.name == "Arrow") {
            arrows.amount += item.amount;
            return true;
        }
        for (int i = 0; i < storage.length; i++) {
            if (storage[i] == null) {
                storage[i] = item;
                return true;
            }
        }
        return false;
    }
    
    //Removes an item from the player.
    public boolean removeItem(String name, int amount) {
        if (name == "Arrow") {
            arrows.amount -= amount;
            return true;
        }
        for (int i = 0; i < storage.length; i++) {
            if (storage[i] != null && storage[i].name == name) {
                storage[i].amount--;
                if(storage[i].amount <= 0) {
                    storage[i] = null;
                }
                return true;
            }
        }
        return false;
    }
    
    //Draws the inventory
    public void renderInventory() {
        fill(0);
        stroke(255);
        strokeWeight(2);

        //Slots
        rect(20, 20, 45, 45);  //Helmet
        rect(20, 85, 45, 45);  //Chestplate
        rect(200, 20, 45, 45); //Legs
        rect(200, 85, 45, 45); //Feet

        if (head != null) {
            //Change the outline color of the item based on it's rarity
            setStrokeColorToRarity(head);
            rect(20, 20, 45, 45);
            image(head.texture, 22.5, 22.5, 40, 40);
            stroke(255);
        }
        if (body != null) {
            //Change the outline color of the item based on it's rarity
            setStrokeColorToRarity(body);
            rect(20, 85, 45, 45);
            image(body.texture, 22.5, 87.5, 40, 40);
            stroke(255);
        }
        if (legs != null) {
            //Change the outline color of the item based on it's rarity
            setStrokeColorToRarity(legs);
            rect(200, 20, 45, 45);
            image(legs.texture, 202.5, 22.5, 40, 40);
            stroke(255);
        }
        if (boots != null) {
            //Change the outline color of the item based on it's rarity
            setStrokeColorToRarity(boots);
            rect(200, 85, 45, 45);
            image(boots.texture, 202.5, 87.5, 40, 40);
            stroke(255);
        }

        rect(650, 58, 35, 35); //Quiver
        rect(400, 20, 45, 45); //Main Weapon
        rect(400, 85, 45, 45); //Secondary Weapon

        if (mainWeapon != null) {
            setStrokeColorToRarity(mainWeapon);
            rect(400, 20, 45, 45);
            image(mainWeapon.texture, 402.5, 22.5, 40, 40);
            stroke(255);
        }
        if (secondaryWeapon != null) {
            setStrokeColorToRarity(secondaryWeapon);
            rect(400, 85, 45, 45);
            image(secondaryWeapon.texture, 402.5, 87.5, 40, 40);
            stroke(255);
        }

        image(arrows.texture, 652.5, 60.5, 30, 30);

        line(0, 150, width, 150);

        textFont(mainFont);
        fill(255);

        //Slot labels
        text("Helmet", 75, 50);
        text("Chest", 75, 115);
        text("Legs", 255, 50);
        text("Boots", 255, 115);

        text("Main Weapon", 455, 50);
        text("Secondary Weapon", 455, 115);

        textSize(14);

        //Draw the slots for armor/weapons & the quiver
        if (head != null && head.amount > 1) {
            text(head.amount, 22.5, 62.5);
        }
        if (body != null && body.amount > 1) {
            text(body.amount, 22.5, 127.5);
        }
        if (legs != null && legs.amount > 1) {
            text(legs.amount, 202.5, 62.5);
        }
        if (boots != null && boots.amount > 1) {
            text(boots.amount, 202.5, 127.5);
        }
        if (mainWeapon != null && mainWeapon.amount > 1) {
            text(mainWeapon.amount, 402.5, 62.5);
        }
        if (secondaryWeapon != null && secondaryWeapon.amount > 1) {
            text(secondaryWeapon.amount, 402.5, 127.5);
        }
        if(arrows.amount > 1) {
            text(arrows.amount, 652.5, 90.5);
        }

        //Main inventory slots
        for (int x = 0; x < 8; x++) {
            for (int y = 0; y < 4; y++) {
                fill(0);
                push();
                if (storage[x + 8 * y] != null) {
                    //Change the outline color of the item based on it's rarity
                    setStrokeColorToRarity(storage[x + 8 * y]);
                }
                rect(x * 75 + 20 * (x + 1), 150 + y * 40 + 20 * (y + 1), 45, 45);
                if (storage[x + 8 * y] != null) {
                    image(storage[x + 8 * y].texture, x * 75 + 20 * (x + 1) + 2.5, 150 + y * 40 + 20 * (y + 1) + 2.5, 40, 40);
                    fill(255);
                    if(storage[x + 8 * y].amount > 1) {
                        text(storage[x + 8 * y].amount, x * 75 + 20 * (x + 1) + 2.5, 150 + y * 40 + 20 * (y + 1) + 40);
                    }
                }
                pop();
            }
        }
        
        rect(width - 50, height - 50, 45, 45);
        image(delete, width - 50 + 5, height - 50 + 5, 40, 40);

        //Item currently moving
        if (holding != null) {
            image(holding.texture, mouseX - 20, mouseY - 20, 40, 40);
        }
    }

    public void click() {
        //This holds what you will be holding after everything else
        Item newHold = holding;

        //The following if statements check if you click inside a box, and if so, replace what you are currently holding with wahts in the box
        if (mouseX > 20 && mouseX < 65 && mouseY > 20 && mouseY < 65) {
            try {
                newHold = head;
                head = (Helmet) holding;
            } 
            catch (Exception e) {
                newHold = holding;
            }
        } else if (mouseX > 20 && mouseX < 65 && mouseY > 85 && mouseY < 130) {
            try {
                newHold = body;
                body = (Chestplate) holding;
            } 
            catch (Exception e) {
                newHold = holding;
            }
        } else if (mouseX > 200 && mouseX < 245 && mouseY > 20 && mouseY < 65) {
            try {
                newHold = legs;
                legs = (Leggings) holding;
            } 
            catch (Exception e) {
                newHold = holding;
            }
        } else if (mouseX > 200 && mouseX < 245 && mouseY > 85 && mouseY < 130) {
            try {
                newHold = boots;
                boots = (Boots) holding;
            } 
            catch (Exception e) {
                newHold = holding;
            }
        } else if (mouseX > 400 && mouseX < 445 && mouseY > 20 && mouseY < 65) {
            try {
                newHold = mainWeapon;
                mainWeapon = (Weapon) holding;
            } 
            catch (Exception e) {
                newHold = holding;
            }
        } else if (mouseX > 400 && mouseX < 445 && mouseY > 85 && mouseY < 130) {
            try {
                newHold = secondaryWeapon;
                secondaryWeapon = (Weapon) holding;
            } 
            catch (Exception e) {
                newHold = holding;
            }
        }
        //This also checks if you click in a main storage box
        for (int x = 0; x < 8; x++) {
            for (int y = 0; y < 4; y++) {
                fill(0);
                rect(x * 75 + 20 * (x + 1), 150 + y * 40 + 20 * (y + 1), 45, 45);
                if (mouseX > x * 75 + 20 * (x + 1) && mouseX < x * 75 + 20 * (x + 1) + 45 && mouseY > 150 + y * 40 + 20 * (y + 1) && mouseY < 150 + y * 40 + 20 * (y + 1) + 45) {
                    newHold = storage[x + 8 * y];
                    storage[x + 8 * y] = holding;
                }
            }
        }
        
        //Delete item box. This basically just clears whatever you are holding
        if(mouseX > width - 50 && mouseX < width - 5 && mouseY > height - 50 && mouseY < height - 5) {
            holding = null;
            newHold = null;
        }
        
        //Deletes fist object
        if(newHold != null && newHold.name == "Fist") {
            newHold = null;
        }

        //Set what your currently holding
        holding = newHold;
    }

    public void hoverTooltip() {
        //What item should we be displaying things for?
        Item tooltipTarget = null;

        //These if statements check what box you are hovering over.
        if (mouseX > 20 && mouseX < 65 && mouseY > 20 && mouseY < 65) {
            tooltipTarget = head;
        } else if (mouseX > 20 && mouseX < 65 && mouseY > 85 && mouseY < 130) {
            tooltipTarget = body;
        } else if (mouseX > 200 && mouseX < 245 && mouseY > 20 && mouseY < 65) {
            tooltipTarget = legs;
        } else if (mouseX > 200 && mouseX < 245 && mouseY > 85 && mouseY < 130) {
            tooltipTarget = boots;
        } else if (mouseX > 400 && mouseX < 445 && mouseY > 20 && mouseY < 65) {
            tooltipTarget = mainWeapon;
        } else if (mouseX > 400 && mouseX < 445 && mouseY > 85 && mouseY < 130) {
            tooltipTarget = secondaryWeapon;
        }
        //This also checks what box you are hovering over
        for (int x = 0; x < 8; x++) {
            for (int y = 0; y < 4; y++) {
                if (mouseX > x * 75 + 20 * (x + 1) && mouseX < x * 75 + 20 * (x + 1) + 45 && mouseY > 150 + y * 40 + 20 * (y + 1) && mouseY < 150 + y * 40 + 20 * (y + 1) + 45) {
                    tooltipTarget = storage[x + 8 * y];
                }
            }
        }

        //If your holding somthing, than that should be the tooltip.
        if (holding != null) {
            tooltipTarget = holding;
        }
        if (tooltipTarget != null) {
            //Change the outline based on the item's rarity
            setStrokeColorToRarity(tooltipTarget);
            //Math to calculate the size and position of the background rectangle.
            int ttHeight = textHeight(tooltipTarget.name, 200) + 15;
            for (int i = 0; i < tooltipTarget.desc.length; i++) {
                ttHeight += textHeight(tooltipTarget.desc[i].text, 240) * 1.3;
            }
            int x = mouseX + 10;
            if (x > width - 256) {
                x = width - 256;
            }

            //Background rectangle
            rect(x, mouseY, 250, ttHeight);

            //Each line of text (including title)
            ttHeight = textHeight(tooltipTarget.name, 240) + 20;
            fill(255);
            text(tooltipTarget.name, x + 5, mouseY + 16);
            for (int i = 0; i < tooltipTarget.desc.length; i++) {
                fill(tooltipTarget.desc[i].c);
                text(tooltipTarget.desc[i].text, x + 5, mouseY + ttHeight - 15, 240, height);

                ttHeight += textHeight(tooltipTarget.desc[i].text, 240) * 1.3;
            }
        }
    }
}

//Stores the rarity of the item
public enum Rarity {
    COMMON, RARE, EPIC, LEGENDARY, DEVELOPER /* This one is for me =) */;
}

//A line of text in the description of the item.
public class TextLine {
    String text;

    color c;

    TextLine(String text, color c) {
        this.text = text;
        this.c = c;
    }
    TextLine(String text) {
        this.text = text;
        this.c = #777777;
    }
}

// ITEM TEMPLATES
public class Item {
    public String name = "generic item";
    public TextLine[] desc = new TextLine[] {new TextLine("a programmer forgot to give you a real item...")};
    public int amount = 1;

    public int value = 50;

    public Rarity rarity = Rarity.COMMON;

    public PImage texture;

    void updateDesc() {
    }
}

public class Weapon extends Item {

    public int maxAttack = 0;

    Weapon() {
        rarity = Rarity.DEVELOPER;

        name = "Generic Weapon";
        desc = new TextLine[] {new TextLine("A generic weapon."), new TextLine("Max Damage: " + maxAttack, #e3c714)};
    }

    void updateDesc() {
        desc = new TextLine[] {new TextLine("A generic weapon."), new TextLine("Max Damage: " + maxAttack, #e3c714)};
    }
}

public class Armor extends Item {

    public float protectionModifier;

    Armor() {
        texture = img_chestplate;

        name = "Generic Armor";
        desc = new TextLine[] {new TextLine("Strong metal plating that reduces incomming damage."), new TextLine("Protection: " + protectionModifier, #e3c714)};
    }

    void updateDesc() {
        desc = new TextLine[] {new TextLine("Strong metal plating that reduces incomming damage."), new TextLine("Protection: " + protectionModifier, #e3c714)};
    }
}

/* --------------------------- ACTUAL ITEMS -------------------------- */
//This code *should* be pretty self explanatory. Just in case though, I will comment the first one


public class Arrow extends Item {
    Arrow() {
        //Load the image texture
        texture = img_arrow;
        
        //Set the item name
        name = "Arrow";
        
        //Set the item description.
        desc = new TextLine[] {new TextLine("A pointy stick you can shoot with a bow at enemies.", #777777)};
    }
}

public class Artifact extends Item {
    //A stat for the item.
    int value = 100;

    Artifact() {
        texture = img_ruin;

        name = "Ruin";
        desc = new TextLine[] {new TextLine("A shiny object found in a dungeon", #777777), new TextLine("Value: " + value, #e3c714)};
    }
    
    //Updates the description. Call after the descrtiption or state has changed.
    void updateDesc() {
        desc = new TextLine[] {new TextLine("A shiny object found in a dungeon", #777777), new TextLine("Value: " + value, #e3c714)};
    }
}

public class Helmet extends Armor {

    Helmet() {
        texture = img_helmet;

        name = "Helmet";
        desc = new TextLine[] {new TextLine("A headpeice that protects your skull from damage."), new TextLine("Protection: " + protectionModifier, #e3c714)};
    }
    
    void updateDesc() {
        desc = new TextLine[] {new TextLine("A headpeice that protects your skull from damage."), new TextLine("Protection: " + protectionModifier, #e3c714)};
    }
}

public class Chestplate extends Armor {

    Chestplate() {
        texture = img_chestplate;

        name = "Chestplate";
        desc = new TextLine[] {new TextLine("A piece of armor that covers your chest that protects you from damage."), new TextLine("Protection: " + protectionModifier, #e3c714)};
    }
    
    void updateDesc() {
        desc = new TextLine[] {new TextLine("A piece of armor that covers your chest that protects you from damage."), new TextLine("Protection: " + protectionModifier, #e3c714)};
    }
}

public class Leggings extends Armor {

    Leggings() {
        texture = img_leggings;

        name = "Leggings";
        desc = new TextLine[] {new TextLine("A piece of armor that covers your legs that protects you from damage."), new TextLine("Protection: " + protectionModifier, #e3c714)};
    }
    
    void updateDesc() {
        desc = new TextLine[] {new TextLine("A piece of armor that covers your legs that protects you from damage."), new TextLine("Protection: " + protectionModifier, #e3c714)};
    }
}

public class Boots extends Armor {

    Boots() {
        texture = img_boots;

        name = "Boots";
        desc = new TextLine[] {new TextLine("Reduces damage delt to the player. Protects your feet."), new TextLine("Protection: " + protectionModifier, #e3c714)};
    }
    
    void updateDesc() {
        desc = new TextLine[] {new TextLine("Reduces damage delt to the player. Protects your feet."), new TextLine("Protection: " + protectionModifier, #e3c714)};
    }
}

public class Sword extends Weapon {

    Sword() {
        texture = img_sword;

        name = "Sword";
        desc = new TextLine[] {new TextLine("A large blade that can deal lots of damage."), new TextLine("Max Damage: " + maxAttack, #e3c714)};
    }
    
    void updateDesc() {
        desc = new TextLine[] {new TextLine("A large blade that can deal lots of damage."), new TextLine("Max Damage: " + maxAttack, #e3c714)};
    }
}

public class Bow extends Weapon {

    Bow() {
        texture = img_bow;

        name = "Bow";
        desc = new TextLine[] {new TextLine("A ranged weapon used to attack enemies."), new TextLine("Max Damage: " + maxAttack, #e3c714)};
    }
    
    void updateDesc() {
        desc = new TextLine[] {new TextLine("A ranged weapon used to attack enemies."), new TextLine("Max Damage: " + maxAttack, #e3c714)};
    }
}
