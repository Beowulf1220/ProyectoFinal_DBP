// Stage where every level must to run

void drawStage(){
  if(!gameOver){
    if(!pause){
      background(BLACK);
      if(frameCount%30 == 0) levelCounter--; // Counter
      if(!stageSound.isPlaying() && soundEnable) stageSound.play();
      
      // Draw the background
      if(currentLevel <= 3){
        starsBackground.draw();
      }else{
        stageBackground.draw();
      }
      
      if(debugInfo) debugInfo();
      
      // Draw
      localPlayer.drawPlayer();
      
      drawEnemies();
      // ...
      
      // Support
      health.draw();
      shield.draw();
      
      playerInerface();
      
      // Level messages
      if(levelCounter > LEVEL_TIME-3) showMessage("Level "+currentLevel);
      else if(currentLevel%3==0 || currentLevel == 10)
      {
        if(levelCounter > -4 && levelCounter <= 0) showMessage("WARNING!!!\nBoss "+(currentLevel % 3 + 1)+" had came!!!",RED);
      }
      if(levelCounter == -5){
        gameOver = true;
      }
    }
    else{ // Show pause menu
      pauseMenu();
    }
  }
  else if(localPlayer.getLifes() > 0 || localPlayer.getHealth() > 0){
    window = NEXT_LEVEL;
    currentLevel++;
  }
  else{
    window = GAME_OVER_SCREEN;
    restartStage();
  }
}

/////////////////////////// initeialize the stage //////////////////////////
void initStage(){
  
  if(isCooperativeMode) window = WAITING_ROOM;
  else window = STAGE;
  gameOver = false;
  if(menuSound.isPlaying()) menuSound.pause();
  starsBackground.setStarsSpeed(6.5);
  levelCounter = LEVEL_TIME;
  if(stageSound == null){
    stageSound = new SoundFile(this,"Resources/Sounds/wow.wav",false);
    stageSound.amp(0.4);
  }
  
  if(health == null) health = new Health();
  if(shield == null) shield = new Shield();
  
  // Background
  if(currentLevel >= 4 && currentLevel <= 6){
    stageBackground = new CrazyBackground();
  }else if(currentLevel <= 9){
    stageBackground = new OceanBackground();
  }else{
    stageBackground = new MadnessBackground();
  }
  
  // Enemies
  meteorites = new Meteorite[MAX_METEORITES];
  enemies = new Enemy[MAX_ENEMIES];
  
  for(int i = 0; i < MAX_METEORITES; i++) meteorites[i] = new Meteorite((int)random(32,256),random(1,10));
  for(int i = 0; i < MAX_ENEMIES; i++) enemies[i] = new Medusa();
}

////////////////////// Level transition /////////////////////////////////
void nextLevel(){
  initStage();
}

/////////////////////////// Draw Enemies /////////////////////////////////////
void drawEnemies(){
  
  // Count
  if(frameCount%150 == 0){
    // Metoeorites respawn
    for(int i = 0; i < MAX_METEORITES; i++){
      if(!meteorites[i].isAlive() && levelCounter > 0) meteorites[i].revive();
    }
    // Enemies respawn
    for(int i = 0; i < MAX_ENEMIES; i++){
      if(enemies[i].getHealth() <= 0 && levelCounter > 0) enemies[i].respawn();
    }
  }
  // Meteorites draw
  for(int i = 0; i < MAX_METEORITES; i++){ // Draw only alive meteorites
      if(meteorites[i].isAlive()){
        meteorites[i].drawEnemy();
      }
   }
   // Enemies draw
    for(int i = 0; i < MAX_ENEMIES; i++){
      if(enemies[i].getHealth() > 0) enemies[i].draw();
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
