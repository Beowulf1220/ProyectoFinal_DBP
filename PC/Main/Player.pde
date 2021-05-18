// Player Class
public class Player extends GameObject{
  
  // Attributes
  private String name; // User name
  private int score;  // Current score
  private int highestScore;
  private int save; // Game progress
  private int playerNumber;
  
  // Positon
  private float x,y;
  
  // Player avatar
  private PImage avatar[];
  private int avatarFrame;
  
  // Health Points
  private int lifes;
  private int shield;
  
  //shots
  Laser lasers[];
  int shotDelay;
  
  // Builder
  public Player(String name,int highestScore, int save, int playerNumber){
    super(100);
    
    lifes = 3;
    shield = 0;
    shotDelay = 0;
    
    avatar = new PImage[2];
    lasers = new Laser[10];
    for(int i = 0; i < 10; i++) lasers[i] = new Laser();
    
    if(playerNumber == 1){
      avatar[0] = loadImage("Resources/Images/spaceShips/goldenHeart/frame1.gif");
      avatar[1] = loadImage("Resources/Images/spaceShips/goldenHeart/frame2.gif");
      x = 200;
    }else{
      avatar[0] = loadImage("Resources/Images/spaceShips/eagleRed/frame1.gif");
      avatar[1] = loadImage("Resources/Images/spaceShips/eagleRed/frame2.gif");
      x = 400;
    }
    
    avatarFrame = 0;
    this.name = name;
    this.highestScore = score;
    this.save = save;
    this.playerNumber = playerNumber;
    score = 0;
    y = height - 100;
  }
  
  // Set methods
  void setPosition(float x, float y){
    this.x = x;
    this.y = y;
  }
  
  void setScore(int score){
    this.score = score;
  }
  
  void setPlayerNumber(int playerNumber){
    this.playerNumber = playerNumber;
  }
  
  void setLifes(int lifes){
    this.lifes = lifes;
  }
  
  // Get methods
  public String getName(){
    return name;
  }
  
  public int getLifes(){
    return lifes;
  }
  
  public int getShield(){
    return shield;
  }
  
  public int getScore(){
    return score;
  }
  
  public int getPlayerNumber(){
    return playerNumber;
  }
  
  public int geHighestScore(){
    return highestScore;
  }
  
  @Override
  public float getX(){
    return x;
  }
  
  @Override
  public float getY(){
    return y;
  }
  
  @Override
  public int getSize(){
    return 64; // Spaceship size
  }
  
  @Override
  public int getDamage(){
    return 5;
  }
  
  // Intersting methods
  void drawPlayer(){
    if(getHealth() > 0){  // alive
      move(localX,localY);
      avatarFrame++;
      if(avatarFrame >= 2) avatarFrame = 0;
      if(laser && shotDelay > 10){
        shotDelay = 0;
        for(int i = 0; i < 10; i++){
          if(!lasers[i].inScreen()){
            lasers[i].restart(x,y);
            break;
          }
        }
      }else{
        if(shotDelay <= 10) shotDelay++;
      }
      for(int i = 0; i < 10; i++) if(lasers[i].inScreen()) lasers[i].draw(); // draw lasers
      image(avatar[avatarFrame], x, y);
    }
    else{ // dead
      image(explotionGIF[avatarFrame],x,y);
      avatarFrame++;
      if(lifes > 0 && avatarFrame == 8){
        revive();
        lifes--;
      }else{
        if(lifes <= 0) gameOver = true;
      }
    }
  }
  
  void revive(){
    avatarFrame = 0;
    setHealth(100);
  }
  
  // Move spaceShip
  void move(float x, float y){
    if(x > 0 && this.x < width) this.x += x;
    if(x < 0 && this.x > 0) this.x += x;
    if(y > 0 && this.y < height) this.y += y;
    if(y < 0 && this.y > 0) this.y += y;
    for(int i = 0; i < MAX_METEORITES; i++){
      checkCollision(this,meteorites[i]);
      for(int j = 0; j < 10; j++) if(lasers[j].getHealth() > 0 && meteorites[i].getHealth() > 0) checkCollision(meteorites[i],lasers[j]); // check laser and metoerites collition
    }
    if(getHealth() <= 0){
      explotionSound.play();
    }
  }
}

////////////////////////// Player interface ///////////////////////////////////////
void playerInerface(){
  textFont(fontInterface);
  textAlign(0);
  fill(GREEN,200);
  textSize(14);
  text("Player"+localPlayer.getPlayerNumber()+": "+localPlayer.getName()+
  "    Lifes:"+localPlayer.getLifes()+
  "    Health:"+localPlayer.getHealth()+
  "    Shield:"+localPlayer.getShield()+
  "    Score:"+localPlayer.getScore()+
  "    Time remaining to arrvie:"+(180-levelCounter),0,12);
  if(isCooperativeMode){
    // another one player ...
  }
}

//////////////////////////////// Laser shots //////////////////////////////////////////
public class Laser extends GameObject{
  
  private float x,y;
  private boolean inScreen;
  
  public Laser(){
    super(0);
    inScreen = false;
  }
  public void restart(float x, float y){
    this.x = x;
    this.y = y;
    inScreen = true;
    setHealth(1);
  }
  
  public void draw(){
    if(inScreen){
      fill(RED);
      rect(x,y,6,40);
      //ellipse(x,y,15,15);
      y -= 16;
      if(y < -25 || getHealth() <= 0){
        inScreen = false;
      }
    }
  }
  
  
  // Gets methods
  public int getSize(){
    return 15;
  }
  
  public float getX(){
    return x;
  }
  
  @Override
  public float getY(){
    return y;
  }
  
  public boolean inScreen(){
    return inScreen;
  }
  
  public int getDamage(){
    return 5;
  }
}

////////////////////////////////////////// Collitions ///////////////////////////////////////////////////////
private int checkCollision(GameObject a, GameObject b){
  
  int damage = 0;
  
  float x1 = a.getX();
  float y1 = a.getY();
  float x2 = b.getX();
  float y2 = b.getY();
  
  double objectARatio = (a.getSize()/2);
  double objectBRatio = (b.getSize()/2);
  
  objectARatio -= objectARatio*0.1; // Offset
  objectBRatio -= objectBRatio*0.1; // Offset
  
  double distancia = Math.sqrt((x2 - x1)*(x2 - x1) + (y2 - y1)*(y2 - y1));
  
  if(debugInfo){
    ellipse(x1,y1,a.getSize(),a.getSize()); // Object A hitBox
    ellipse(x2,y2,b.getSize(),b.getSize()); // Object B hitBox
  }
  
  if(distancia <= (objectARatio + objectBRatio)){
    hitSound1.play();
    a.setHealth(a.getHealth()-b.getDamage());
    b.setHealth(b.getHealth()-a.getDamage());
    //println("> ("+a.toString()+") crashed with ("+b.toString()+")");
  }
  return damage;
}
