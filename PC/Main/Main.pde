PFont fontMenu,fontButton,fontInfo;

// Windows' Constants
public static final int MAIN_MENU = 0;

// A few constants
final color GREEN = color(0,255,0);
final color RED = color(255,0,0);
final color BLUE = color(0,0,255);
final color YELLOW = color(255,255,0);
final color WHITE = color(255,255,255);

int window;

//Buttons
Button playButton,exitButton;

//Background
StarsBackground starsBackground;

void setup(){
  //Window
  size(800,600);
  window = MAIN_MENU;
  starsBackground = new StarsBackground();
  
  //Text
  fontMenu = createFont("Resurces/Fonts/Roose Sally.otf",90);
  fontButton = createFont("Resurces/Fonts/Fipps-Regular.otf",32);
  fontInfo = createFont("Resurces/Fonts/PixelatedPusab.ttf",12);
  
  //Buttons' Menu
  playButton = new Button("Play",width/2,height/2,200,100,GREEN);
  exitButton = new Button("Exit",width/2,height-150,200,100,GREEN);
  
  // Frame rate
  frameRate(30);
}

//Draw
void draw(){
  switch(window){
    case MAIN_MENU:
      drawMainMenu();
      break;
  }
}

// Debug info
void debugInfo(){
  textFont(fontInfo);
  textAlign(0);
  fill(YELLOW);
  text("FPS: "+(int)frameRate,0,12);
  text("Mouse: "+mouseX+","+mouseY,0,30);
  text("PlayerControl: OFF",0,48);
}

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

void mousePressed(){
  if(exitButton.isPressed()){
    System.exit(0);
  }
}
