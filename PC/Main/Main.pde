// Main

/*
  Project: Space Odissey

  Requires to run it:
  > Sound library.
  > oscP5 library.
  
  Task remaining:
  > add more enemies
  > add the bosses
  > add a few power up's
  > add firebase conection
  > add ardunio conection
  > add android conection
*/

import processing.sound.*;
import oscP5.*;
import netP5.*;

PFont fontMenu,fontButton,fontInfo,fontDefault,fontSpecial,fontInterface;

// Windows' Constants
public static final int LOGIN_MENU = 0;
public static final int MAIN_MENU = 1;
public static final int SETTINGS_MENU = 2;
public static final int SELECT_ROL_MENU = 3;
public static final int LEVEL_MENU = 4;
public static final int STAGE = 5;
public static final int WAITING_ROOM = 6;
public static final int JOIN_ROOM = 7;
public static final int JOIN_PHONE = 8;

// A few constants
final color GREEN = color(0,255,0);
final color RED = color(255,0,0);
final color BLUE = color(0,0,255);
final color LIGHT_BLUE = color(81,209,246);
final color YELLOW = color(255,255,0);
final color WHITE = color(255);
final color BLACK = color(0);

int window;

// Level variable
int stageLevel;

// Debug Information
boolean debugInfo;
boolean cheats;

// Main Menu Buttons
Button playButton,exitButton,settingsButton;
// Select Rol Menu Buttons
Button serverButton,joinButton,singleButton;

// Back Button
Button backButton;

// Change Profile Button
Button changeButton;

// Levels' Buttons
Button levelButton[];
int greetLevel;

// Background stars
StarsBackground starsBackground;

// Local Player
Player localPlayer;
String playerName;

// Another player
Player otherPlayer;

// Meteorites
final int MAX_METEORITES = 4;
Meteorite meteorites[];

// Are we in cooperative mode game?
boolean isCooperativeMode;

//Images menu
PImage menuImg;

//Images game
PImage meteoriteGIF[];

// Sounds
SoundFile clickSound;

// Conection PC and Android
OscP5 oscP5;
String myIPAddress; // Your address
String remoteAddress; // Your mate's address
String phoneAddress; // phone address (control)
NetAddress remoteLocation;

void setup(){
  // Window
  surface.setTitle("Space Odissey - Powered by Godzilla");
  size(800,600);
  window = LOGIN_MENU;
  starsBackground = new StarsBackground();
  
  // Conection
  myIPAddress = NetInfo.lan();
  remoteAddress = "";
  phoneAddress = "";
  
  // Others
  debugInfo = false;
  cheats = false;
  isCooperativeMode = false;
  
  // Sounds
  clickSound = new SoundFile(this,"Resources/Sounds/click.wav",false);
  
  //Text fonts
  fontMenu = createFont("Resources/Fonts/Roose Sally.otf",90);
  fontButton = createFont("Resources/Fonts/Fipps-Regular.otf",32);
  fontInfo = createFont("Resources/Fonts/PixelatedPusab.ttf",12);
  fontDefault = createFont("Resources/Fonts/1942.ttf",48);
  fontSpecial = createFont("Resources/Fonts/BadlyStamped.ttf",48);
  fontInterface = createFont("Resources/Fonts/bauserif.ttf",48);
  
  //Buttons' Menu
  playButton = new Button("Play",120,height-70,200,100,GREEN);
  exitButton = new Button("Exit",width-120,height-70,200,100,GREEN);
  settingsButton = new Button("Settings",width/2,height-70,280,100,GREEN);
  
  singleButton = new Button("Single player",width/2,height/2-30,410,100,LIGHT_BLUE);
  serverButton = new Button("Host",width/2+105,height/2+90,200,100,LIGHT_BLUE);
  joinButton = new Button("Join",width/2-105,height/2+90,200,100,LIGHT_BLUE);
  
  backButton = new Button("Back to menu",width-200,height-60,380,100);
  changeButton = new Button("Change user",200,height-60,380,100);
  
  // Levels' Buttons
  levelButton = new Button[10];
  float x=175,y=250;
  for(int i = 0; i < 10; i++){
    levelButton[i] = new Button(""+(i+1),x,y,100,100,YELLOW);
    x += 110;
    if(i==4){
      x = 175; // Row
      y += 110; // Colum
    }
  }
  
  //Player
  playerName = "";
  
  // Frame rate
  frameRate(30);
  
  // Enemies
  meteorites = new Meteorite[MAX_METEORITES];
  for(int i = 0; i < MAX_METEORITES; i++) meteorites[i] = new Meteorite((int)random(32,256),random(1,10));
  
  //Image menu
  float rando = random(0,1);
  if(rando >= 0.5) menuImg = loadImage("Resources/Images/rusiaMenu.png");
  else menuImg = loadImage("Resources/Images/ovniMenu.png");
  menuImg.resize(320, 240);
  
  // Meteorite Images
  meteoriteGIF = new PImage[20];
  for(int i = 0; i < 20; i++) meteoriteGIF[i] = loadImage("Resources/Images/meteorite/frame-"+(i+1)+".gif");
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
     case LEVEL_MENU:
       drawLevelMenu();
       break;
     case STAGE:
       drawStage(stageLevel);
       break;
     case WAITING_ROOM:
       drawWaitingRoom();
       break;
     case JOIN_ROOM:
       drawJoinRoom();
       break;
     case JOIN_PHONE:
       drawJoinPhone();
       break;
     default:
       text("Error: window not found!",width/2,height/2);
       break;
  }
}

void oscEvent(OscMessage theOscMessage) {
  /*if (theOscMessage.checkTypetag("fff"))                  // 6
  {
     =  theOscMessage.get(0).floatValue();  // 7
    accelerometerY =  theOscMessage.get(1).floatValue();
    accelerometerZ =  theOscMessage.get(2).floatValue();
  }
  */
}
