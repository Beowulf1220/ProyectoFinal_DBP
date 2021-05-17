////////////////////////////// Draw the login menu //////////////////////////////////////
void drawLoginMenu(){
  background(BLACK);
  starsBackground.draw();
  if(debugInfo) debugInfo();
  
  rectMode(CENTER);
  textAlign(CENTER);
  
  fill(WHITE);
  textFont(fontMenu);
  text("Type your nickname:",width/2,height/3);
  
  fill(GREEN);
  textFont(fontDefault);
  text("Player:"+playerName,width/2,2*height/3);
  
  fill(WHITE);
  textFont(fontDefault);
  textSize(24);
  text("Press ENTER to continue",width/2,height-24);
}

///////////////////////////////////// MainMenu ///////////////////////////////////
void drawMainMenu(){
  background(0);
  
  starsBackground.draw();
  if(debugInfo) debugInfo();
  
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
  if(debugInfo) debugInfo();
  
  rectMode(CENTER);
  textAlign(CENTER);
  
  textFont(fontMenu);
  fill(WHITE);
  text("Select a game mode",width/2,height/4);
  
  textFont(fontButton);
  singleButton.drawButton();
  serverButton.drawButton();
  joinButton.drawButton();
  
  backButton.drawButton();
}

/////////////////////////////// Settings Menu ////////////////////////////////////////
void drawSettingsMenu(){
  background(BLACK);
  starsBackground.draw();
  if(debugInfo) debugInfo();
  
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

/////////////////////////////// Select Level Menu ////////////////////////////////////////
void drawLevelMenu(){
  background(BLACK);
  starsBackground.draw();
  if(debugInfo) debugInfo();
  
  rectMode(CENTER);
  textAlign(CENTER);
  
  textFont(fontMenu);
  fill(WHITE);
  text("Select a Level",width/2,height/6);
  
  textFont(fontButton);
  for(int i = 0; i < 10; i++) levelButton[i].drawButton();
  backButton.drawButton();
}

//////////////////// Keyboard interface /////////////////////////////////////////
void keyPressed() {
  if(window == LOGIN_MENU){
    // Start with 'ENTER'
    if (key==ENTER && playerName.length() > 0) {
      if(playerName.equals("GOD")){
        localPlayer = new Player("GOD",9999,10,1);
        cheats = true;
      }
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
    if(keyCode == SHIFT){
      debugInfo = !debugInfo;
      println(debugInfo);
    }
  }else{
    if(keyCode == SHIFT){
      debugInfo = !debugInfo;
    }
  }  
}

/////////////////////////// Mouse pressed ( Buttons ) //////////////////////////////////////////////
void mousePressed(){
  clickSound.play();
  if(exitButton.isPressed() && window == MAIN_MENU){
    System.exit(0);
  }
  else if(playButton.isPressed() && window == MAIN_MENU){
    window = SELECT_ROL_MENU;
  }
  else if(settingsButton.isPressed() && window == MAIN_MENU){
    window = SETTINGS_MENU;
  }
  else if(backButton.isPressed() && (window == SELECT_ROL_MENU || window == SETTINGS_MENU || window == LEVEL_MENU)){
    window = MAIN_MENU;
  }
  else if(changeButton.isPressed() && window == SETTINGS_MENU){
    window = LOGIN_MENU;
    playerName = "";
    localPlayer = null;
  }
  else if((serverButton.isPressed() || singleButton.isPressed()) && window == SELECT_ROL_MENU){
    window = LEVEL_MENU;
  }
  else if(window == LEVEL_MENU){
    // Check for every level button
    for(int i = 0; i < 10; i++){
      if(levelButton[i].isPressed() && localPlayer != null){
        window = STAGE;
        stageLevel = (i+1);
        starsBackground.setStarsSpeed(3.5);
        greetLevel = 0;
        break;
      }
    }
  }
}

/////////////////////// Debug info ///////////////////////////////////
void debugInfo(){
  textFont(fontInfo);
  textAlign(0);
  fill(YELLOW);
  text("FPS: "+(int)frameRate,0,12);
  text("Mouse: "+mouseX+","+mouseY,0,24);
  text("PlayerControl: OFF",0,36);
  text("Cheats: "+(cheats ? "ON" : "OFF"),0,48);
}
