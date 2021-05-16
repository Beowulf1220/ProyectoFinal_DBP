// Stage where every level must to run
Meteorite x = new Meteorite();

void drawStage(int level){
  
  background(BLACK);
  starsBackground.draw();
  if(debugInfo) debugInfo();
  
  // Draw
  localPlayer.drawPlayer();
  x.drawEnemy();
  // ...
}
