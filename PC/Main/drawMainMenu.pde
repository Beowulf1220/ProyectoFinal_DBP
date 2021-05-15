//MainMenu
void drawMainMenu(){
  background(0);
  starsBackground.draw();
  debugInfo();
  rectMode(CENTER);
  textAlign(CENTER);
  
  textFont(fontMenu);
  fill(255);
  text("The space odyssey",width/2,height/3);
  
  textFont(fontButton);
  playButton.drawButton();
  exitButton.drawButton();
}
