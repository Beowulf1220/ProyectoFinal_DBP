PFont fontMenu,fontButton,fontInfo,fontDefault;

// Windows' Constants
public static final int LOGIN_MENU = 0;
public static final int MAIN_MENU = 1;

// A few constants
final color GREEN = color(0,255,0);
final color RED = color(255,0,0);
final color BLUE = color(0,0,255);
final color YELLOW = color(255,255,0);
final color WHITE = color(255);
final color BLACK = color(0);

int window;

// Buttons
Button playButton,exitButton;

// Background
StarsBackground starsBackground;

// Player
Player player;
String playerName;

void setup(){
  //Window
  size(800,600);
  window = LOGIN_MENU;
  starsBackground = new StarsBackground();
  
  //Text
  fontMenu = createFont("Resurces/Fonts/Roose Sally.otf",90);
  fontButton = createFont("Resurces/Fonts/Fipps-Regular.otf",32);
  fontInfo = createFont("Resurces/Fonts/PixelatedPusab.ttf",12);
  fontDefault = createFont("Resurces/Fonts/1942.ttf",48);
  
  //Buttons' Menu
  playButton = new Button("Play",width/2,height/2,200,100,GREEN);
  exitButton = new Button("Exit",width/2,height-150,200,100,GREEN);
  
  //Player
  playerName = "";
  
  // Frame rate
  frameRate(30);
}

//Draw
void draw(){
  frame.toFront(); //Focus, I guess...
  
  switch(window){
    case MAIN_MENU:
      drawMainMenu();
      break;
    case LOGIN_MENU:
      drawLoginMenu();
      break;
    default:
      text("Error: window not found!",width/2,height/2);
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

void mousePressed(){
  
  if(exitButton.isPressed() && window == MAIN_MENU){
    System.exit(0);
  }
}
