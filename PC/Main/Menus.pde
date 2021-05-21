////////////////////////////// Draw the login menu //////////////////////////////////////
void drawLoginMenu() {
  background(BLACK);
  starsBackground.draw();
  if (debugInfo) debugInfo();

  rectMode(CENTER);
  textAlign(CENTER);

  fill(WHITE);
  textFont(fontMenu);
  text("Type your nickname:", width/2, height/3);

  fill(GREEN);
  textFont(fontDefault);
  text("Player:"+playerName, width/2, 2*height/3);

  fill(WHITE);
  textFont(fontDefault);
  textSize(24);
  text("Press ENTER to continue", width/2, height-24);
}

/////////////////////////////// Join Phone ////////////////////////////////////////
// Here we conect our phone
void drawJoinPhone() {
  background(BLACK);
  starsBackground.draw();
  if (debugInfo) debugInfo();

  rectMode(CENTER);
  textAlign(CENTER);

  fill(WHITE);
  textFont(fontMenu);
  text("Type your phone's IP", width/2, height/5);

  fill(GREEN);
  textFont(fontDefault);
  text("IP:"+phoneAddress, width/2, height/2+50);

  fill(WHITE);
  textFont(fontDefault);
  textSize(24);
  text("Press ENTER to continue", width/2, height-24);

  if (phoneAddress.length() > 8) phoneConection();
  if (isPhoneConected) window = MAIN_MENU;
}

///////////////////////////////////// MainMenu ///////////////////////////////////
void drawMainMenu() {
  background(0);

  starsBackground.draw();
  if (debugInfo) debugInfo();

  rectMode(CENTER);
  textAlign(CENTER);

  // A nice image
  imageMode(CENTER);
  image(menuImg, width/2, height/2);

  textFont(fontDefault);
  textSize(24);
  fill(RED);
  text("Player: "+playerName, width/2, 32);

  textFont(fontMenu);
  fill(255);
  text("The space odyssey", width/2, height/4);

  textFont(fontButton);
  playButton.drawButton();
  exitButton.drawButton();
  settingsButton.drawButton();
}

//////////////// Select Menu Rol (host or join) //////////////////////////////////
void drawSelectRolMenu() {
  background(BLACK);
  starsBackground.draw();
  if (debugInfo) debugInfo();

  rectMode(CENTER);
  textAlign(CENTER);

  textFont(fontMenu);
  fill(WHITE);
  text("Select a game mode", width/2, height/4);

  textFont(fontButton);
  singleButton.drawButton();
  serverButton.drawButton();
  joinButton.drawButton();

  backButton.drawButton();
}

/////////////////////////////// Settings Menu ////////////////////////////////////////
void drawSettingsMenu() {
  background(BLACK);
  starsBackground.draw();
  if (debugInfo) debugInfo();

  textAlign(CENTER);

  textFont(fontMenu);
  fill(WHITE);
  text("Settings", width/2, height/6);

  rectMode(0);
  fill(WHITE, 100);
  rect(10, height/5, (width/2)-20, (3*height/5), 10);
  rect((width/2)+10, height/5, (width/2)-20, (3*height/5), 10);

  // Credits
  textFont(fontInfo);
  textSize(48);
  fill(YELLOW);
  text("Credits", (width/2)+10+(width/4)-10, height/5+48);
  textFont(fontDefault);
  textSize(30);
  fill(LIGHT_BLUE);
  text("Game developed by:", (width/2)+10+(width/4)-10, height/5+120);
  fill(YELLOW);
  text("Arnoldo Daniel", (width/2)+10+(width/4)-10, height/5+156);
  text("Edwin Alfredo", (width/2)+10+(width/4)-10, height/5+192);
  fill(LIGHT_BLUE);
  text("Game developed in:", (width/2)+10+(width/4)-10, height/5+250);
  fill(YELLOW);
  text("Processing", (width/2)+10+(width/4)-10, height/5+286);

  // Settings
  textFont(fontButton);
  textSize(26);
  text("Game audio: "+( soundEnable ? "ON" : "OFF" ), ((width/2)-10)/2, height/5+64);

  rectMode(CENTER);

  soundButton.drawButton(28);

  textSize(14);
  fill(LIGHT_BLUE);
  text("This option enable or disable\n the game audio music, but\n SFX's will be present.", ((width/2)-10)/2, 2*height/3-32);

  textSize(28);
  backButton.drawButton();
  changeButton.drawButton();
}

/////////////////////////////// Select Level Menu ////////////////////////////////////////
void drawLevelMenu() {
  background(BLACK);
  starsBackground.draw();
  if (debugInfo) debugInfo();

  rectMode(CENTER);
  textAlign(CENTER);

  textFont(fontMenu);
  fill(WHITE);
  text("Select a Level", width/2, height/6);

  for (int i = 0; i < 10; i++) levelButton[i].drawButton();
  backButton.drawButton();
}

/////////////////////////////// Waiting Room ////////////////////////////////////////
// Here we wait for another player
void drawWaitingRoom() {
  background(BLACK);
  starsBackground.draw();
  if (debugInfo) debugInfo();

  rectMode(CENTER);
  textAlign(CENTER);

  textFont(fontMenu);
  fill(WHITE);
  text("Waiting for a player", width/2, height/5);
  textFont(fontDefault);
  fill(YELLOW);
  text("Your IP: "+myIPAddress, width/2, height/2+40);

  ufoWaiting.draw();

  backButton.drawButton();

  if (isCoopConected) initStage();
}

/////////////////////////////// Join Room ////////////////////////////////////////
// Here we wait for another player
void drawJoinRoom() {
  background(BLACK);
  starsBackground.draw();
  if (debugInfo) debugInfo();

  rectMode(CENTER);
  textAlign(CENTER);

  fill(WHITE);
  textFont(fontMenu);
  text("Type the Host IP", width/2, height/5);

  fill(GREEN);
  textFont(fontDefault);
  text("Host:"+remoteAddress, width/2, height/2+50);

  fill(WHITE);
  textFont(fontDefault);
  textSize(24);
  text("Press ENTER to continue", width/2, height/3+40);

  backButton.drawButton();
}

///////////////////////// End game /////////////////////////
void drawEnd() {
  background(BLACK);
  starsBackground.draw();
  if (debugInfo) debugInfo();

  rectMode(CENTER);
  textAlign(CENTER);

  fill(WHITE);
  textFont(fontMenu);
  text("Contratulations!!!", width/2, height/2);

  ufoWaiting.draw();

  backButton.drawButton();
}

//////////////////// Keyboard interface /////////////////////////////////////////
void keyPressed() {
  if (window == LOGIN_MENU || window == JOIN_ROOM || window == JOIN_PHONE) { // Starts with 'ENTER'
    if (key == ENTER) {
      if (playerName.length() > 0 && window == LOGIN_MENU) {
        if (playerName.equals("GOD") && window == LOGIN_MENU) {
          localPlayer = new Player(playerName, 0, 9999, 10, 1);
          cheats = true;
        } else {

          // LOGIN
          String data = null;
          if(fireBase != null) data = fireBase.getValue("Game/Profiles");
          else return;
          if(data == null) return;
          
          boolean isHere = false;
          String saveS = "";
          String highestScoreS = "";
          String name = "";
          
          boolean nameB = false;
          boolean highestScoreB = false;
          boolean saveB = false;
          
          for(int i = 1; i < data.length()-1; i++){ // Here we clean the data, example: {Car={score=0, save=1}, Edw={score=0, save=1}, Ed={score=0, save=1}}
            if(!nameB){ // Get name
              if(data.charAt(i) != ' ') name+= data.charAt(i);
              if(data.charAt(i+1) == '='){
                nameB = true;
                i++;
              }
            }
            if(!highestScoreB && nameB){
              if(Character.isDigit(data.charAt(i))) highestScoreS += data.charAt(i); // Get Score
              if(data.charAt(i+1) == ','){
                highestScoreB = true;
                i++;
              }
            }
            if(!saveB && nameB && highestScoreB){
              if(Character.isDigit(data.charAt(i))) saveS += data.charAt(i); // Get Score
              if(data.charAt(i+1) == '}'){
                saveB = true;
                i+=2;
              }
            }
            if(nameB && highestScoreB && saveB){
              //println("Name:"+name+"\nscore:"+highestScoreS+"\nsave:"+saveS);
              if(playerName.equals(name)){
                isHere = true;
                break;
              }else{
                saveS = "";
                highestScoreS = "";
                name = "";
                
                nameB = false;
                highestScoreB = false;
                saveB = false;
              }
            }
          }
          
          // If the profile is here
          if (isHere) {
            //println("Here");
            int save = Integer.parseInt(saveS);
            int highestScore = Integer.parseInt(highestScoreS);
            localPlayer = new Player(playerName, 0, highestScore, save, 1);
            window = JOIN_PHONE;
          }else{
            int res = JOptionPane.showConfirmDialog(null,"The profile \""+playerName+"\" doesn't esist, do you want to create it?","Warning",JOptionPane.YES_NO_OPTION);
            if(res == JOptionPane.YES_OPTION){
              fireBase.setValue("Game/Profiles/"+playerName+"/save","1"); // save
              fireBase.setValue("Game/Profiles/"+playerName+"/score","0"); // highestScore
              JOptionPane.showMessageDialog(null, "Profile created!");
            }
          }
        }
        clickSound.play();
      } else if (remoteAddress.length() > 0 && window == JOIN_ROOM) {
        // ...
      } else if (phoneAddress.length() > 0 && window == JOIN_PHONE) { // This wouldn't must to use, if phoneConection works.
        phoneConection();
        clickSound.play();
      }
    }
    // Delete the last one character in the string
    else if (key==BACKSPACE) {
      if (playerName.length() > 0 && window == LOGIN_MENU) playerName = playerName.substring(0, playerName.length()-1);
      else if (remoteAddress.length() > 0 && window == JOIN_ROOM) remoteAddress = remoteAddress.substring(0, remoteAddress.length()-1);
      else if (phoneAddress.length() > 0 && window == JOIN_PHONE) phoneAddress = phoneAddress.substring(0, phoneAddress.length()-1);
    }
    // Allow only letters, numbers and a few symbols (32-125 ASCII).
    else if (key >= 32 && key <= 125) {
      if (playerName.length() < 16 && window == LOGIN_MENU) playerName = playerName + key;
      else if (remoteAddress.length() < 16 && window == JOIN_ROOM) remoteAddress += key;
      else if (phoneAddress.length() < 16 && window == JOIN_PHONE) phoneAddress += key;
    }
    if (keyCode == SHIFT) {
      debugInfo = !debugInfo;
    }
  } else if (keyCode == SHIFT) {
    debugInfo = !debugInfo;
  } else if (key == 'p') {
    pause = !pause;
  }
}

////////////////////////////// Phone conection ////////////////////////////////////////////
void phoneConection() {
  //println("Enviado");
  OscMessage myMessage = new OscMessage("/conection");
  myMessage.add(myIPAddress);
  oscP5.send(myMessage, new NetAddress(phoneAddress, 12000));
}

//////////////////////////// Pause Menu /////////////////////////////////////////////////
void pauseMenu() {
  background(BLACK);
  starsBackground.draw();
  if (debugInfo) debugInfo();

  rectMode(CENTER);
  textAlign(CENTER);

  textFont(fontSpecial);
  fill(WHITE, 200);
  textSize(64);
  text("Pause", width/2, height/2);

  textFont(fontButton);
  backButton.drawButton();
}

////////////////////////// Game over Screen //////////////////////////////////////////////////////
void drawGameOverScreen() {
  background(BLACK);
  starsBackground.draw();
  if (debugInfo) debugInfo();

  rectMode(CENTER);
  textAlign(CENTER);

  textFont(fontSpecial);
  fill(WHITE, 220);
  textSize(72);
  text("Game Over", width/2, height/2);

  textFont(fontButton);
  backButton.drawButton();
}

/////////////////////////// Mouse pressed ( Buttons ) //////////////////////////////////////////////
void mousePressed() {
  clickSound.play();
  if (exitButton.isPressed() && window == MAIN_MENU) {
    System.exit(0);
  } else if (playButton.isPressed() && window == MAIN_MENU) {
    window = SELECT_ROL_MENU;
  } else if (settingsButton.isPressed() && window == MAIN_MENU) {
    window = SETTINGS_MENU;
  } else if (soundButton.isPressed() && window == SETTINGS_MENU) {
    soundEnable = !soundEnable;
    soundButton.setText(soundEnable ? "Disable audio" : "Enable audio");
    if (!soundEnable) {
      menuSound.pause();
    } else {
      if (!menuSound.isPlaying()) menuSound.play();
    }
  } else if (backButton.isPressed() && (window == SELECT_ROL_MENU || window == SETTINGS_MENU || window == LEVEL_MENU || window == WAITING_ROOM || window == JOIN_ROOM || pause || window == GAME_OVER_SCREEN || window ==END)) {
    window = MAIN_MENU;
    saveData();
    remoteAddress = "";
    gameOver = false;
    if (stageSound != null) stageSound.stop();
    if (soundEnable && !menuSound.isPlaying()) menuSound.play();
    localPlayer.setScore(0);
    localPlayer.setLifes(3);
    localPlayer.setHealth(100);
    localPlayer.setShield(0);
  } else if (changeButton.isPressed() && window == SETTINGS_MENU) {
    window = LOGIN_MENU;
    playerName = "";
    localPlayer = null;
  } else if (serverButton.isPressed() && window == SELECT_ROL_MENU) {
    window = LEVEL_MENU;
    isCooperativeMode = true;
  } else if (singleButton.isPressed() && window == SELECT_ROL_MENU) {
    window = LEVEL_MENU;
    isCooperativeMode = false;
  } else if (window == LEVEL_MENU) {
    // Check for every level button
    for (int i = 0; i < 10; i++) {
      if (levelButton[i].isPressed() && localPlayer != null) {
        currentLevel = i+1;
        if (isCooperativeMode) window = WAITING_ROOM;
        else initStage();
        break;
      }
    }
  } else if (joinButton.isPressed() && window == SELECT_ROL_MENU) {
    window = JOIN_ROOM;
    isCooperativeMode = true;
  }
}

/////////////////////////// Mouse released ( Buttons ) //////////////////////////////////////////////
void mouseReleased() {
}

/////////////////////// Debug info ///////////////////////////////////
void debugInfo() {
  textFont(fontInfo);
  textAlign(0);
  fill(YELLOW);
  text("FPS: "+(int)frameRate, 0, 12);
  text("Mouse: "+mouseX+","+mouseY, 0, 24);
  text("PlayerControl: "+(isPhoneConected ? "ON" : "OFF"), 0, 36);
  text("Cheats: "+(cheats ? "ON" : "OFF"), 0, 48);
  text("Local IP: "+myIPAddress, 0, 60);
  text("Phone's IP: "+phoneAddress, 0, 72);
  text("Coop IP: "+remoteAddress, 0, 84);
  text("Sound: "+(soundEnable ? "ON" : "OFF"), 0, 96);
  text("Window: "+window, 0, 108);
  text("missile: "+missile, 0, 120);
  text("laser: "+laser, 0, 132);
  text("level counter: "+levelCounter, 0, 144);
}
