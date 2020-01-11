//This function calculates the height of a text block (Used for tooltips)
int textHeight(String string, int targetWidth) {
    String[] words;
    String temp = "";
    int numLines = 0;

    words = split(string, " ");

    for (int i=0; i < words.length; i++) {
        if (textWidth(temp + words[i]) < targetWidth) {
            temp += words[i] + " ";
        } else {
            temp = words[i] + " ";
            numLines++;
        }
    }

    numLines++;
    return(round(numLines * (textDescent() + textAscent())));
}

//Sets the stroke color to the color representing the item's rarity
void setStrokeColorToRarity(Item item) {
    switch(item.rarity) {
        case COMMON:
            stroke(128, 128, 128); //Gray
            break;
        case RARE:
            stroke(0, 128, 255); //Blue
            break;
        case EPIC:
            stroke(140, 3, 133); //Purple
            break;
        case LEGENDARY:
            stroke(204, 192, 22); //Gold
            break;
        case DEVELOPER:
            stroke(0, 255, 0); //Green
            break;
        default:
            stroke(128, 128, 128); //Gray
    }
}
