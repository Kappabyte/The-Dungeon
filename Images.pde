//This file just stores references to images in the game
//General images
PImage floorBackground;
PImage wallV, wallH;
PImage coins, xp, hp, lvl;

PImage img_sword, img_bow, img_helmet, img_chestplate, img_leggings, img_boots, img_arrow, img_ruin; 

PImage img_goose_object, img_crate, img_shop, img_teleporter, img_teleporter_on, img_pedestal, img_pedestal_on, img_door;

PImage img_bug, img_binary_0, img_binary_1, img_circuit, img_cpu, img_daemon, img_goose, img_packet, img_player, img_skeleton, img_slime, img_zombie;

PImage credits_background;

void initalizeImages() {
    //Initalize UI and Dungeon Images
    floorBackground = loadImage("floor_layer_1.png");
    wallV = loadImage("wall_vertical.png");
    wallH = loadImage("wall_horizontal.png");
    coins = loadImage("coins.png");
    xp = loadImage("experience.png");
    hp = loadImage("health.png");
    lvl = loadImage("level.png");
    
    //Initalize Entity Textures
    img_binary_0 = loadImage("Entities/binary-0.png");
    img_binary_1 = loadImage("Entities/binary-1.png");
    img_circuit = loadImage("Entities/circuit.png");
    img_cpu = loadImage("Entities/cpu.png");
    img_daemon = loadImage("Entities/daemon.png");
    img_goose = loadImage("Entities/goose-final-boss.png");
    img_packet = loadImage("Entities/packet.png");
    img_player = loadImage("Entities/player.png");
    img_skeleton = loadImage("Entities/skeleton.png");
    img_slime = loadImage("Entities/slime.png");
    img_zombie = loadImage("Entities/zombie.png");
    img_bug = loadImage("bug.png");
    
    //Initalize Item images
    img_sword = loadImage("Items/sword.png");
    img_bow = loadImage("Items/bow.png");
    img_helmet = loadImage("Items/helmet.png");
    img_chestplate = loadImage("Items/chestplate.png");
    img_leggings = loadImage("Items/leggings.png");
    img_boots = loadImage("Items/boots.png");
    img_arrow = loadImage("Items/arrow.png");
    img_ruin = loadImage("Items/ruin.png");
    
    //Initalize Object images
    img_goose_object = loadImage("goose.png");
    img_crate = loadImage("crate.png");
    img_shop = loadImage("shop.png");
    img_teleporter = loadImage("teleporter_off.png");
    img_teleporter_on = loadImage("teleporter_on.png");
    img_pedestal = loadImage("pedestal.png");
    img_pedestal_on = loadImage("pedestal_on.png");
    img_door = loadImage("door.png");
    
    //Credits background
    credits_background = loadImage("background_end.png");
}
