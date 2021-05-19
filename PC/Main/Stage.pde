// Stage where every level must to run

void drawStage(int level){
  if(!gameOver){
    if(!pause){
      background(BLACK);
      
      if(frameCount%30 == 0) levelCounter--;
      
      if(level == 1 || level == 2){
        starsBackground.draw();
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

/////////////////////////// Draw Enemies /////////////////////////////////////
void drawEnemies(){
  if(frameCount%150 == 0){
    for(int i = 0; i < MAX_METEORITES; i++){
      if(!meteorites[i].isAlive()) meteorites[i].revive();
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
  fill(col,150);
  text(message,width/2,height/2);
}
