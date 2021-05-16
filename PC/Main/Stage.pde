// Stage where every level must to run

void drawStage(int level){
  background(BLACK);
  starsBackground.draw();
  if(debugInfo) debugInfo();
  
  localPlayer.drawPlayer();
  // ...
}
