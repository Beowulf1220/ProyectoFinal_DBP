// Stage where every level must to run

void drawStage(int level){
  background(BLACK);
  starsBackground.draw();
  if(debugInfo) debugInfo();
  
  // Draw
  localPlayer.move(localX,localY);
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

/////////////////////////// Draw Enemies /////////////////////////////////////
void drawEnemies(){
  if(frameCount%250 == 0){
    for(int i = 0; i < MAX_METEORITES; i++){
      if(!meteorites[i].isAlive()) meteorites[i].revive();
    }
  }
  for(int i = 0; i < MAX_METEORITES; i++) if(meteorites[i].isAlive()) meteorites[i].drawEnemy();
}
