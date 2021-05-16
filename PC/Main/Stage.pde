// Stage where every level must to run

void drawStage(int level){
  
  background(BLACK);
  starsBackground.draw();
  if(debugInfo) debugInfo();
  
  // Draw
  localPlayer.drawPlayer();
  
  drawEnemies();
  // ...
  playerInerface();
}

void drawEnemies(){
  println(frameCount);
  if(frameCount%250 == 0){
    for(int i = 0; i < MAX_METEORITES; i++){
      if(!meteorites[i].isAlive()) meteorites[i].revive();
    }
  }
  for(int i = 0; i < MAX_METEORITES; i++) if(meteorites[i].isAlive()) meteorites[i].drawEnemy();
}
