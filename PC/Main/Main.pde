
PFont fontMenu,fontButton,fontInfo;

// A few constants
private final color GREEN = color(0,255,0);
private final color RED = color(255,0,0);
private final color BLUE = color(0,0,255);

//Buttons
Button playButton,exitButton;

void setup(){
  //Window
  size(800,600);
  
  //Text
  fontMenu = createFont("Resurces/Fonts/Roose Sally.otf",90);
  fontButton = createFont("Resurces/Fonts/Fipps-Regular.otf",32);
  fontInfo = createFont("Resurces/Fonts/PixelatedPusab.ttf",12);
  textAlign(CENTER);
  
  //Buttons' Menu
  rectMode(CENTER);
  playButton = new Button("Play",width/2,height/2,200,100,GREEN);
  exitButton = new Button("Exit",width/2,height-150,200,100,GREEN);
  
  // Frame rate
  frameRate(30);
}

//Draw
void draw(){
  drawMainMenu();
}

//MainMenu
void drawMainMenu(){
  background(0);
  
  textFont(fontInfo);
  fill(GREEN);
  text("FPS: "+(int)frameRate,32,12);
  text("Mouse: "+mouseX+","+mouseY,56,32);
  
  textFont(fontMenu);
  fill(GREEN);
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
