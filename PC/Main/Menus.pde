////////////////////////////// Draw the login menu //////////////////////////////////////
void drawLoginMenu(){
  background(BLACK);
  starsBackground.draw();
  
  textAlign(CENTER);
  
  fill(WHITE);
  textFont(fontMenu);
  text("Type your nickname:",width/2,height/3);
  
  fill(GREEN);
  textFont(fontDefault);
  text("Player:"+playerName,width/2,2*height/3);
}

///////////////////////////////////// MainMenu ///////////////////////////////////
void drawMainMenu(){
  background(0);
  
  starsBackground.draw();
  debugInfo();
  
  rectMode(CENTER);
  textAlign(CENTER);
  
  // A nice image
  imageMode(CENTER);
  image(menuImg, width/2, height/2);
  
  textFont(fontDefault);
  textSize(24);
  fill(RED);
  text("Player: "+playerName,width/2,32);
  
  textFont(fontMenu);
  fill(255);
  text("The space odyssey",width/2,height/4);
  
  textFont(fontButton);
  playButton.drawButton();
  exitButton.drawButton();
  settingsButton.drawButton();
}

//////////////// Select Menu Rol (host or join) //////////////////////////////////
void drawSelectRolMenu(){
  background(BLACK);
  starsBackground.draw();
  debugInfo();
  
  rectMode(CENTER);
  textAlign(CENTER);
  
  textFont(fontMenu);
  fill(WHITE);
  text("Select a Rol",width/2,height/4);
  
  textFont(fontButton);
  serverButton.drawButton();
  joinButton.drawButton();
  
  backButton.drawButton();
}

/////////////////////////////// Settings Menu ////////////////////////////////////////
void drawSettingsMenu(){
  background(BLACK);
  starsBackground.draw();
  debugInfo();
  
  rectMode(CENTER);
  textAlign(CENTER);
  
  textFont(fontMenu);
  fill(WHITE);
  text("Settings",width/2,height/6);
  
  textFont(fontButton);
  
  textSize(28);;
  backButton.drawButton();
  changeButton.drawButton();
}

//////////////////// Keyboard interface /////////////////////////////////////////
void keyPressed() {
  if(window == LOGIN_MENU){
    // Start with 'ENTER'
    if (key==ENTER && playerName.length() > 0) {
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
}
