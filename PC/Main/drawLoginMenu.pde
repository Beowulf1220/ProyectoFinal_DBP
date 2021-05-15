// Draw the login menu
void drawLoginMenu(){
  background(BLACK);
  starsBackground.draw();
  
  textAlign(CENTER);
  
  fill(WHITE);
  textFont(fontMenu);
  text("Type your nickname:",width/2,height/3);
  
  fill(GREEN);
  textFont(fontDefault);
  text("Player: "+playerName,width/2,2*height/3);
}

void keyPressed() {
  
  // Start with 'ENTER'
  if (key==ENTER) {
    window = MAIN_MENU;
  }
  // Delete the last one character in the string
  else if(key==BACKSPACE){
    if(playerName.length() > 0) playerName = playerName.substring(0, playerName.length()-1);
  }
  // Allow only letters, numbers and a few symbols (32-125 ASCII).
  else if(key >= 32 && key <= 125){
    if(playerName.length() < 16) playerName = playerName + key;
  }
}
