// Player Class
public class Player extends GameObject{
  
  // Attributes
  private String name; // User name
  private int score;  // Current score
  private int highestScore;
  private int save; // Game progress
  private int playerNumber;
  
  // Player avatar
  private PImage avatar[];
  private int avatarFrame; // For change the frame every "x" time
  
  // Health Points
  private int lifes;
  private int shield;
  
  //shots
  Laser lasers[];
  Missile missiles[];
  int shotDelay;
  
  // Builder
  public Player(String name,int highestScore, int save, int playerNumber){
    super(100);
    
    lifes = 3;
    shield = 0;
    shotDelay = 0;
    
    avatar = new PImage[2];
    lasers = new Laser[MAX_AMMO];
    missiles = new Missile[MAX_MISSILE];
    for(int i = 0; i < MAX_AMMO; i++) lasers[i] = new Laser();
    for(int i = 0; i < MAX_MISSILE; i++) missiles[i] = new Missile();
    
    if(playerNumber == 1) // PLayer 1 sprite
    {
      avatar[0] = loadImage("Resources/Images/spaceShips/goldenHeart/frame1.gif");
      avatar[1] = loadImage("Resources/Images/spaceShips/goldenHeart/frame2.gif");
      setX(width/3);
    }
    else // PLayer 2 sprite
    {
      avatar[0] = loadImage("Resources/Images/spaceShips/eagleRed/frame1.gif");
      avatar[1] = loadImage("Resources/Images/spaceShips/eagleRed/frame2.gif");
      setX(2*width/3);
    }
    
    avatarFrame = 0;
    this.name = name;
    this.highestScore = score;
    this.save = save;
    this.playerNumber = playerNumber;
    score = 0;
    setY(height - 100);
  }
  
  // Set methods
  void setScore(int score){
    this.score = score;
  }
  
  void setPlayerNumber(int playerNumber){
    this.playerNumber = playerNumber;
  }
  
  void setLifes(int lifes){
    this.lifes = lifes;
  }
  
  public void setShield(int shield){
    this.shield = shield;
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
  public int getSize(){
    return 54; // Spaceship size
  }
  
  @Override
  public int getDamage(){
    return 5;
  }
  
  // Intersting methods
  void drawPlayer(){
    if(getHealth() > 0){  // alive
      if(getHealth() > 100) setHealth(100);
      if(getShield() > 100) setShield(100);
      move(localX,localY);
      avatarFrame++;
      if(avatarFrame >= 2) avatarFrame = 0;
      if(laser && shotDelay > 10){
        shootLaser();
      }else if(missile && shotDelay > 10){
        shootMissile();
      }else{
        if(shotDelay <= 10) shotDelay++;
      }
      for(int i = 0; i < MAX_AMMO; i++){
        if(lasers[i].getHealth() > 0){
          lasers[i].draw(); // draw lasers
        }
      }
      for(int i = 0; i < MAX_MISSILE; i++) if(missiles[i].getHealth() > 0) missiles[i].draw(); // draw missiles
      if(this.getImmuneTime() > 0){
        if(frameCount%3==0) tint(RED,150);
        else tint(WHITE,150);
        image(avatar[avatarFrame], x, y);
      }
      image(avatar[avatarFrame], x, y);
      noTint();
      fill(LIGHT_BLUE,50);
      if(shield > 0){
        ellipse(x,y,64,64);
      }
      if(this.getImmuneTime() >= 1) this.setImmuneTime(getImmuneTime()-1);
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
  
  // Shoot laser
  void shootLaser(){
    shotDelay = 0;
    for(int i = 0; i < MAX_AMMO; i++){
      if(lasers[i].getHealth() <= 0){
        lasers[i].restart(x,y);
        laserSound.play();
        break;
      }
    }
  }
  
  void shootMissile(){
    shotDelay = 0;
    for(int i = 0; i < MAX_MISSILE; i++){
      if(missiles[i].getHealth() <= 0){
        missiles[i].restart(x,y);
        break;
      }
    }
  }
  
  // Respawn our player with 100 HP
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
    for(int i = 0; i < MAX_METEORITES; i++){ // Check collitions player-meteorites
      if(this.getImmuneTime() <= 0){
        if(shield > 0){
          int damage = checkCollision(this,meteorites[i]);
          this.setHealth(this.getHealth()+damage);
          shield -= damage;
          if(shield < 0)shield = 0;
        }
        else checkCollision(this,meteorites[i]);
      }
    }
    for(int i = 0; i < MAX_ENEMIES; i++){ // Check collitions player-enemies
      if(this.getImmuneTime() <= 0){
        if(shield > 0){
          int damage = checkCollision(this,enemies[i]);
          this.setHealth(this.getHealth()+damage*2);
          shield -= damage;
          if(shield < 0)shield = 0;
        }
        else checkCollision(this,enemies[i]);
      }
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
  "    Score:"+localPlayer.getScore(),0,12);
  textAlign(RIGHT);
  if(levelCounter >= 0) text("Time remaining to arrvie:"+levelCounter,width,12);
  if(isCooperativeMode){
    // another one player ...
  }
}

//////////////////////////////// Laser shots //////////////////////////////////////////
public class Laser extends GameObject{
  
  // Builder
  public Laser(){
    super(0);
  }
  
  // Revive lasers
  public void restart(float x, float y){
    this.x = x;
    this.y = y;
    setHealth(1);
  }
  
  //Draw the laser
  public void draw(){
    if(this.getHealth() > 0){
      fill(RED);
      rect(x,y,6,40);
      //ellipse(x,y,15,15);
      y -= 16;
      if(y < -5){
        setHealth(0);
      }
      for(int i = 0; i < MAX_METEORITES; i++) checkCollision(this,meteorites[i]);
      for(int i = 0; i < MAX_ENEMIES; i++) checkCollision(this,enemies[i]);
    }
  }
  
  // Gets methods
  public int getSize(){
    return 16;
  }
  
  public int getDamage(){
    return 5;
  }
}

//////////////////////////////// Missile shoots //////////////////////////////////////////
public class Missile extends GameObject{
  
  //Builder
  public Missile(){
    super(0);
  }
  
  // Revive missiles
  public void restart(float x, float y){
    this.x = x;
    this.y = y;
    setHealth(1);
  }
  
  public void draw(){
    if(this.getHealth() > 0 || y < -24){
      fill(RED);
      image(mineImage,x,y,36,36);
      x += 24*sin(y);
      y -= 6;
      if(y < -5){
        setHealth(0);
      }
      // Check for missile collisions
      for(int i = 0; i < MAX_METEORITES; i++) checkCollision(this,meteorites[i]);
      for(int i = 0; i < MAX_ENEMIES; i++) checkCollision(this,enemies[i]);
    }
  }
  
  // Gets methods
  public int getSize(){
    return 24;
  }
  
  public int getDamage(){
    return 25;
  }
}
