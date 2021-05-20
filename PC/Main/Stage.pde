// Stage where every level must to run

void drawStage(int level){
  if(!gameOver){
    if(!pause){
      background(BLACK);
      if(frameCount%30 == 0) levelCounter--; // Counter
      
      // Draw the background
      if(level <= 3){
        starsBackground.draw();
      }else{
        stageBackground.draw();
      }
      
      if(debugInfo) debugInfo();
      
      // Draw
      localPlayer.drawPlayer();
      
      drawEnemies();
      // ...
      playerInerface();
      
      // Level messages
      if(levelCounter > LEVEL_TIME-3) showMessage("Level "+level);
      else if(level%3==0 || level == 10)
      {
        if(levelCounter > -4 && levelCounter <= 0) showMessage("WARNING!!!\nBoss "+(level % 3 + 1)+" had came!!!",RED);
      }
    }
    else{ // Show pause menu
      pauseMenu();
    }
  }else{
    window = GAME_OVER_SCREEN;
    restartStage();
  }
}

/////////////////////////// initeialize the stage //////////////////////////
void initStage(int level){
  menuSound.pause();
  if(isCooperativeMode) window = WAITING_ROOM;
  else window = STAGE;
  starsBackground.setStarsSpeed(6.5);
  stageLevel = (level);
  levelCounter = LEVEL_TIME;
  stageSound = new SoundFile(this,"Resources/Sounds/wow.wav",false);
  stageSound.amp(0.4);
  stageSound.loop();
  stageSound.play();
  
  // Background
  if(level >= 4 && level <= 6){
    // ...
  }else if(level <= 9){
    // ...
  }else{
    stageBackground = new MadnessBackground();
  }
}


/////////////////////////// Draw Enemies /////////////////////////////////////
void drawEnemies(){
  
  // Meteorites
  if(frameCount%150 == 0){
    for(int i = 0; i < MAX_METEORITES; i++){
      if(!meteorites[i].isAlive() && levelCounter > 0) meteorites[i].revive();
    }
  }
  for(int i = 0; i < MAX_METEORITES; i++){ // Draw only alive meteorites
      if(meteorites[i].isAlive()){
        meteorites[i].drawEnemy();
      }
   }
}

///////////////////////// Restart /////////////////////////////////////
void restartStage(){
  localPlayer.revive();
  localPlayer.setLifes(3);
  
  for(int i = 0; i < MAX_METEORITES; i++) meteorites[i].setY(-meteorites[i].getSize());
}

///////////// For impertants messages ///////////////////////////////////
void showMessage(String message){
  textFont(fontSpecial);
  textAlign(CENTER);
  fill(WHITE,100);
  text(message,width/2,height/2);
}

void showMessage(String message, color col){
  textFont(fontSpecial);
  textAlign(CENTER);
  fill(col,250);
  text(message,width/2,height/2);
}
