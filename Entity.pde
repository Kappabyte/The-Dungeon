//Entities are the things that can you can battle, and is also the player.
public class Entity {
    //Stores health info about the entity
    public int health = 50;
    public int maxHealth = 100;
    
    //Attack information about the entity
    int primaryAttackMaxDamage = 20;
    int secondaryAttackMaxDamage = 20;
    String primaryAttackName = "P-Attack";
    String secondaryAttackName = "S-Attack";
    
    //Stores the entities Texture
    PImage texture;
    
    //Removes health from the player. Returns wether the entity is dead.
    boolean TakeDamage(int damage) {
        println("taking " + damage + "damage");
        if(health - damage <= 0) {
            health = 0;
            return true;
        } else {
            health -= damage;
            return false;
        }
        
    }
    
    //Gets the name of the entity.
    String getName() {
        return "Generic Entity";
    }
}

/*        BELOW THIS LINE ARE ACTUAL ENTITIES IN THE GAME        */
//The code should be pretty self explanatory, but just in case, I will comment the first one.

public class Bug extends Entity {
    Bug() {
        //Loads the Entities texture.
        texture = img_bug;
        
        //Sets the health info for the entity.
        maxHealth = 15 * map.layer;
        health = maxHealth;
        
        //Sets attack information
        primaryAttackMaxDamage = 15 * map.layer;
        secondaryAttackMaxDamage = 10 * map.layer;
        primaryAttackName = "Fly";
        secondaryAttackName = "Buzz";
    }
    
    //Returns the name of the entity
    String getName() {
        return "Bug";
    }
}

public class Goose extends Entity {
    
    Goose() {
        texture = img_goose;
        
        primaryAttackMaxDamage = 100;
        secondaryAttackMaxDamage = 50;
        primaryAttackName = "Honk";
        secondaryAttackName = "Flap";
        
        health = 500;
        maxHealth = 500;
    }
    
    String getName() {
        return "The Goose";
    }
}

public class Daemon extends Entity {
    Daemon() {
        texture = img_daemon;
        
        maxHealth = 150 * map.layer;
        health = maxHealth;
        
        primaryAttackMaxDamage = 20 * map.layer;
        secondaryAttackMaxDamage = 15 * map.layer;
        primaryAttackName = "Gradle";
        secondaryAttackName = "Subsequent builds are faster";
    }
    
    String getName() {
        return "Daemon";
    }
}

public class Skeleton extends Entity {
    
    Skeleton() {
        texture = img_skeleton;
        
        maxHealth = 75 * map.layer;
        health = maxHealth;
        
        primaryAttackMaxDamage = 20 * map.layer;
        secondaryAttackMaxDamage = 15 * map.layer;
        primaryAttackName = "Bones";
        secondaryAttackName = "Gut";
    }
    
    String getName() {
        return "Skeleton";
    }
}

public class Zombie extends Entity {
    
    Zombie() {
        texture = img_zombie;
        
        maxHealth = 75 * map.layer;
        health = maxHealth;
        
        primaryAttackMaxDamage = 20 * map.layer;
        secondaryAttackMaxDamage = 15 * map.layer;
        primaryAttackName = "Brain Eater";
        secondaryAttackName = "Melee";
    }
    
    String getName() {
        return "Zombie";
    }
}

public class Slime extends Entity {
    
    Slime() {
        texture = img_slime;
        
        maxHealth = 50 * map.layer;
        health = maxHealth;
        
        primaryAttackMaxDamage = 20 * map.layer;
        secondaryAttackMaxDamage = 15 * map.layer;
        primaryAttackName = "Slime";
        secondaryAttackName = "Bounce";
    }
    
    String getName() {
        return "Slime";
    }
}

public class Packet extends Entity {
    
    Packet() {
        texture = img_packet;
        
        maxHealth = 75 * map.layer;
        health = maxHealth;
        
        primaryAttackMaxDamage = 20 * map.layer;
        secondaryAttackMaxDamage = 15 * map.layer;
        primaryAttackName = "Send";
        secondaryAttackName = "Recieve";
    }
    
    String getName() {
        return "Packet";
    }
}

public class CPU extends Entity {
    
    CPU() {
        texture = img_cpu;
        
        maxHealth = 125 * map.layer;
        health = maxHealth;
        
        primaryAttackMaxDamage = 20 * map.layer;
        secondaryAttackMaxDamage = 15 * map.layer;
        primaryAttackName = "Fetch";
        secondaryAttackName = "Execute";
    }
    
    String getName() {
        return "CPU";
    }
}

public class Circuit extends Entity {
    
    Circuit() {
        texture = img_circuit;
        
        maxHealth = 75 * map.layer;
        health = maxHealth;
        
        primaryAttackMaxDamage = 20 * map.layer;
        secondaryAttackMaxDamage = 15 * map.layer;
        primaryAttackName = "And";
        secondaryAttackName = "Or";
    }
    
    String getName() {
        return "Circuit";
    }
}

public class Binary extends Entity {
    
    Binary() {
        if(int(random(1,3)) == 1) {
            texture = img_binary_0;
        } else {
            texture = img_binary_1;
        }
        
        maxHealth = 100 * map.layer;
        health = maxHealth;
        
        primaryAttackMaxDamage = 20 * map.layer;
        secondaryAttackMaxDamage = 15 * map.layer;
        primaryAttackName = "byte";
        secondaryAttackName = "bit";
    }
    
    String getName() {
        return "Binary Digit";
    }
}
