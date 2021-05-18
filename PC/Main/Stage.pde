// Stage where every level must to run

void drawStage(int level){
  if(!gameOver){
    if(!pause){
      background(BLACK);
      
      if(frameCount%30 == 0 && levelCounter < 180) levelCounter++;
      
      if(level == 1){
        starsBackground.draw();
      }
      
      if(debugInfo) debugInfo();
      
      // Draw
      localPlayer.drawPlayer();
      
      drawEnemies();
      // ...
      playerInerface();
      
      if(greetLevel < 100){
        textFont(fontSpecial);
        textAlign(CENTER);
        fill(WHITE,100);
        text("Level "+level,width/2,height/2);
        greetLevel++;
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
