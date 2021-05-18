// Player Class
public class Player{
  
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
  private int health;
  private int shield;
  
  // Builder
  public Player(String name,int highestScore, int save, int playerNumber){
    
    lifes = 3;
    health = 100;
    shield = 0;
    
    avatar = new PImage[2];
    
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
  
  public int getHealth(){
    return health;
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
  
  public float getX(){
    return x;
  }
  
  public float getY(){
    return y;
  }
  
  // Intersting methods
  void drawPlayer(){
    if(health > 0){  // alive
      image(avatar[avatarFrame], x, y);
      avatarFrame++;
      if(avatarFrame >= 2) avatarFrame = 0;
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
    health = 100;
  }
  
  // Move spaceShip
  void move(float x, float y){
    if(x > 0 && this.x < width) this.x += x;
    if(x < 0 && this.x > 0) this.x += x;
    if(y > 0 && this.y < height) this.y += y;
    if(y < 0 && this.y > 0) this.y += y;
    int damage = checkCollision();
    health -= damage;
    if(health <= 0){
      health = 0;
      explotionSound.play();
    }
  }
  
  // Collision
  private int checkCollision(){
    int damage = 0;
    for(int i = 0; i < MAX_METEORITES; i++){ // Meteorites collision
      if(meteorites[i].isAlive()){
        double distancia = Math.sqrt( (x - meteorites[i].getX())*(x - meteorites[i].getX()) + (y - meteorites[i].getY())*(y - meteorites[i].getY()) ); // distance between player and meteorite "i"
        if(distancia <= 16+(meteorites[i].getSize()/2)){ // is the ship collisioning?
          damage = 50;
          meteorites[i].setAlive(false);
          hitSound1.play();
        }
      }
    }
    return damage;
  }
}

// Player interface
void playerInerface(){
  textFont(fontInterface);
  textAlign(0);
  fill(GREEN,200);
  textSize(14);
  text("Player"+localPlayer.getPlayerNumber()+": "+localPlayer.getName()+
  "    Lifes:"+localPlayer.getLifes()+
  "    Health:"+localPlayer.getHealth()+
  "    Shield:"+localPlayer.getShield()+
  "    Score:"+localPlayer.getScore(),0,12);
  if(isCooperativeMode){
    // another one player ...
  }
}
