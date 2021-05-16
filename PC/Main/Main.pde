PFont fontMenu,fontButton,fontInfo,fontDefault,fontSpecial;

// Windows' Constants
public static final int LOGIN_MENU = 0;
public static final int MAIN_MENU = 1;
public static final int SETTINGS_MENU = 2;
public static final int SELECT_ROL_MENU = 3;

// A few constants
final color GREEN = color(0,255,0);
final color RED = color(255,0,0);
final color BLUE = color(0,0,255);
final color LIGHT_BLUE = color(81,209,246);
final color YELLOW = color(255,255,0);
final color WHITE = color(255);
final color BLACK = color(0);

int window;

// Main Menu Buttons
Button playButton,exitButton,settingsButton;
// Select Rol Menu Buttons
Button serverButton,joinButton;

// Back Button
Button backButton;

// Change Profile Button
Button changeButton;

// Background stars
StarsBackground starsBackground;

// Player
Player player;
String playerName;

//Images
PImage menuImg;

void setup(){
  //Window
  size(800,600);
  window = LOGIN_MENU;
  starsBackground = new StarsBackground();
  
  //Text fonts
  fontMenu = createFont("Resources/Fonts/Roose Sally.otf",90);
  fontButton = createFont("Resources/Fonts/Fipps-Regular.otf",32);
  fontInfo = createFont("Resources/Fonts/PixelatedPusab.ttf",12);
  fontDefault = createFont("Resources/Fonts/1942.ttf",48);
  fontSpecial = createFont("Resources/Fonts/BadlyStamped.ttf",48);
  
  //Buttons' Menu
  playButton = new Button("Play",120,height-70,200,100,GREEN);
  exitButton = new Button("Exit",width-120,height-70,200,100,GREEN);
  settingsButton = new Button("Settings",width/2,height-70,280,100,GREEN);
  
  serverButton = new Button("Server",width/2,height/2-60,200,100,LIGHT_BLUE);
  joinButton = new Button("Join",width/2,height/2+60,200,100,LIGHT_BLUE);
  
  backButton = new Button("Back to menu",width-210,height-60,380,100);
  changeButton = new Button("Change profile",210,height-60,380,100);
  
  //Player
  playerName = "";
  
  // Frame rate
  frameRate(30);
  
  //Image menu
  float rando = random(0,1);
  if(rando >= 0.5) menuImg = loadImage("Resources/Images/rusiaMenu.png");
  else menuImg = loadImage("Resources/Images/ovniMenu.png");
  menuImg.resize(320, 240);
}

//Draw
void draw(){
  
  switch(window){
    case MAIN_MENU:
      drawMainMenu();
      break;
    case LOGIN_MENU:
      drawLoginMenu();
      break;
    case SELECT_ROL_MENU:
      drawSelectRolMenu();
      break;
     case SETTINGS_MENU:
       drawSettingsMenu();
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
  else if(playButton.isPressed() && window == MAIN_MENU){
    window = SELECT_ROL_MENU;
  }
  else if(settingsButton.isPressed() && window == MAIN_MENU){
    window = SETTINGS_MENU;
  }
  else if(backButton.isPressed() && (window == SELECT_ROL_MENU || window == SETTINGS_MENU)){
    window = MAIN_MENU;
  }
}
