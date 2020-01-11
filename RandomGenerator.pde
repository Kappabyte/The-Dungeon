//Generates a random entity. Used for random encounters throughout the dungeon
Entity generateRandomEntity() {
    int type = int(random(1, 10));
    if(map.layer == 1 && type > 4) {
        type = int(random(1, 5));
    }
    
    switch(type) {
        case 1:
            return new Bug();
        case 2:
            return new Slime();
        case 3:
            return new Skeleton();
        case 4:
            return new Zombie();
        case 5:
            return new Binary();
        case 6:
            return new Packet();
        case 7:
            return new CPU();
        case 8:
            return new Circuit();
        case 9:
            return new Daemon();
        default:
            return new Bug();
    }
}

//Generates random items. Used mostly by crates.
Item generateRandomItem() {
    //Type of the item to generate
    int type = int(random(1, 9));
    
    //How good is the item?
    int itemStat = int(random(0,100));
    
    //Set the rarity of the item based on it's stat.
    Rarity itemRarity;
    if(itemStat > 98) {
        itemRarity = Rarity.LEGENDARY;
    } else if(itemStat > 90) {
        itemRarity = Rarity.EPIC;
    } else if(itemStat > 75) {
        itemRarity = Rarity.RARE;
    } else {
        itemRarity = Rarity.COMMON;
    }
    
    //This actually creates the items that are returned. This code should be pretty self explanatory.
    switch(type) {
        case 1:
            Helmet helmet = new Helmet();
            
            helmet.protectionModifier = itemStat;
            
            helmet.rarity = itemRarity;
            
            helmet.updateDesc();
            
            return helmet;
        case 2:
            Chestplate chest = new Chestplate();
            
            chest.protectionModifier = itemStat;
            
            chest.rarity = itemRarity;
            
            chest.updateDesc();
            
            return chest;
        case 3:
            Leggings legs = new Leggings();
            
            legs.protectionModifier = itemStat;
            
            legs.rarity = itemRarity;
            
            legs.updateDesc();
            
            return legs;
        case 4:
            Boots boots = new Boots();
            
            boots.protectionModifier = itemStat;
            
            boots.rarity = itemRarity;
            
            boots.updateDesc();
            
            return boots;
        case 5:
        default:
            Artifact artifact = new Artifact();
            
            artifact.value = itemStat * 25;
            
            artifact.rarity = itemRarity;
            
            artifact.updateDesc();
            
            return artifact;
        case 6:
            Arrow arrows = new Arrow();
            
            arrows.amount = int(random(5,16));
            
            arrows.updateDesc();
            
            return arrows;
        case 7:
            Sword sword = new Sword();
            
            sword.maxAttack = itemStat / 2;
            
            sword.rarity = itemRarity;
            
            sword.updateDesc();
            return sword;
        case 8:
            Bow bow = new Bow();
            
            bow.maxAttack = itemStat / 2;
            
            bow.rarity = itemRarity;
            
            bow.updateDesc();
            return bow;
    }
}
