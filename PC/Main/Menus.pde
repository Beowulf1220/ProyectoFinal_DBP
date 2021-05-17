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

/////////////////////////////// Join Phone ////////////////////////////////////////
// Here we conect our phone
void drawJoinPhone(){
  background(BLACK);
  starsBackground.draw();
  if(debugInfo) debugInfo();
  
  rectMode(CENTER);
  textAlign(CENTER);
  
  fill(WHITE);
  textFont(fontMenu);
  text("Type your phone's IP",width/2,height/5);
  
  fill(GREEN);
  textFont(fontDefault);
  text("IP:"+phoneAddress,width/2,height/2+50);
  
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
  
  for(int i = 0; i < 10; i++) levelButton[i].drawButton();
  backButton.drawButton();
}

/////////////////////////////// Waiting Room ////////////////////////////////////////
// Here we wait for another player
void drawWaitingRoom(){
  background(BLACK);
  starsBackground.draw();
  if(debugInfo) debugInfo();
  
  rectMode(CENTER);
  textAlign(CENTER);
  
  textFont(fontMenu);
  fill(WHITE);
  text("Waiting for a player",width/2,height/5);
  textFont(fontDefault);
  fill(YELLOW);
  text("Your IP: "+myIPAddress,width/2,height/2+40);
  
  backButton.drawButton();
}

/////////////////////////////// Join Room ////////////////////////////////////////
// Here we wait for another player
void drawJoinRoom(){
  background(BLACK);
  starsBackground.draw();
  if(debugInfo) debugInfo();
  
  rectMode(CENTER);
  textAlign(CENTER);
  
  fill(WHITE);
  textFont(fontMenu);
  text("Type the Host IP",width/2,height/5);
  
  fill(GREEN);
  textFont(fontDefault);
  text("Host:"+remoteAddress,width/2,height/2+50);
  
  fill(WHITE);
  textFont(fontDefault);
  textSize(24);
  text("Press ENTER to continue",width/2,height/3+40);
  
  backButton.drawButton();
}

//////////////////// Keyboard interface /////////////////////////////////////////
void keyPressed() {
  if(window == LOGIN_MENU || window == JOIN_ROOM || window == JOIN_PHONE){ // Starts with 'ENTER'
    if (key == ENTER) {
      if(playerName.length() > 0 && window == LOGIN_MENU){
        if(playerName.equals("GOD") && window == LOGIN_MENU){
          localPlayer = new Player(playerName,9999,10,1);
          cheats = true;
        }else{
          localPlayer = new Player(playerName,0,1,1);
        }
        window = JOIN_PHONE;
        clickSound.play();
      }
      else if(remoteAddress.length() > 0 && window == JOIN_ROOM){
        // ...
      }
      else if(phoneAddress.length() > 0 && window == JOIN_PHONE){
        
        OscMessage myMessage = new OscMessage("/conection");
        myMessage.add(myIPAddress);
        oscP5.send(myMessage, new NetAddress(phoneAddress, 12000));
        //println("Enviado");
        
        clickSound.play();
      }
    }
    // Delete the last one character in the string
    else if(key==BACKSPACE){
      if(playerName.length() > 0 && window == LOGIN_MENU) playerName = playerName.substring(0, playerName.length()-1);
      else if(remoteAddress.length() > 0 && window == JOIN_ROOM) remoteAddress = remoteAddress.substring(0, remoteAddress.length()-1);
      else if(phoneAddress.length() > 0 && window == JOIN_PHONE) phoneAddress = phoneAddress.substring(0, phoneAddress.length()-1);
    }
    // Allow only letters, numbers and a few symbols (32-125 ASCII).
    else if(key >= 32 && key <= 125){
      if(playerName.length() < 16 && window == LOGIN_MENU) playerName = playerName + key;
      else if(remoteAddress.length() < 16 && window == JOIN_ROOM) remoteAddress += key;
      else if(phoneAddress.length() < 16 && window == JOIN_PHONE) phoneAddress += key;
    }
    if(keyCode == SHIFT){
      debugInfo = !debugInfo;
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
  else if(backButton.isPressed() && (window == SELECT_ROL_MENU || window == SETTINGS_MENU || window == LEVEL_MENU || window == WAITING_ROOM || window == JOIN_ROOM)){
    window = MAIN_MENU;
    remoteAddress = "";
  }
  else if(changeButton.isPressed() && window == SETTINGS_MENU){
    window = LOGIN_MENU;
    playerName = "";
    localPlayer = null;
  }
  else if(serverButton.isPressed() && window == SELECT_ROL_MENU){
    window = LEVEL_MENU;
    isCooperativeMode = true;
  }
  else if(singleButton.isPressed() && window == SELECT_ROL_MENU){
    window = LEVEL_MENU;
    isCooperativeMode = false;
  }
  else if(window == LEVEL_MENU){
    // Check for every level button
    for(int i = 0; i < 10; i++){
      if(levelButton[i].isPressed() && localPlayer != null){
        if(isCooperativeMode) window = WAITING_ROOM;
        else window = STAGE;
        starsBackground.setStarsSpeed(6.5);
        stageLevel = (i+1);
        greetLevel = 0;
        break;
      }
    }
  }
  else if(joinButton.isPressed() && window == SELECT_ROL_MENU){
    window = JOIN_ROOM;
    isCooperativeMode = true;
  }
}

/////////////////////// Debug info ///////////////////////////////////
void debugInfo(){
  textFont(fontInfo);
  textAlign(0);
  fill(YELLOW);
  text("FPS: "+(int)frameRate,0,12);
  text("Mouse: "+mouseX+","+mouseY,0,24);
  text("PlayerControl: "+(isPhoneConected ? "ON" : "OFF"),0,36);
  text("Cheats: "+(cheats ? "ON" : "OFF"),0,48);
  text("local IP: "+myIPAddress,0,60);
  text("Phone's IP: "+phoneAddress,0,72);
}
