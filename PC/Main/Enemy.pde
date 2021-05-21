// Enemy Class
public abstract class Enemy extends GameObject{
  
  protected int frame;
  
  // Builder
  public Enemy(){
    super(0);
    frame = 0;
  }
  
  public abstract int getSize();
  public abstract int getDamage();
  public abstract void respawn();
  public abstract void draw();
}

/////////////////// Medusa /////////////////////////////
public class Medusa extends Enemy{
  
  boolean right,down;
  float speedX,speedY;
  
  // Builder
  public Medusa(){
    speedX = random(1,6);
    speedY = random(1,6);
    setHealth(0);
    right = false;
    down = false;
  }
  
  void draw(){
    if(this.getHealth() > 0){
      move();
      if(this.getImmuneTime() > 0){
        if(frameCount%3==0) tint(RED,150);
        else tint(WHITE,150);
        image(meduGIF[frame],x,y,54,54);
      }
      textFont(fontDefault);
      if(debugInfo) text(String.valueOf(this.getHealth()),x,y);
      image(meduGIF[frame],x,y,54,54);
      noTint();
      
      frame++;
      if(frame > 6) frame = 0;
      if(this.getImmuneTime() >= 1) this.setImmuneTime(getImmuneTime()-1);
    }
  }
  
  // Move
  void move(){
    
    if(this.x >= width || this.x <= 0) right = !right;
    if(this.y >= height || this.y < 0) down = !down;
    if(y < 0) down = true;
    
    if(right) x += speedX;
    else this.x -= speedX;
    if(down) this.y += speedY;
    else this.y -= speedY;
  }
  
  // Methods
  public int getSize(){
    return 54;
  }
  public int getDamage(){
    return 15;
  }
  
  public void respawn(){
    setHealth(25);
    setPosition(random(54,width-54),-random(-54,-300));
  }
}


//////////////////////// Moon (bigBoss) ////////////////////////////
public class bigMoon extends Enemy{
  
  boolean right,down;
  float speedX,speedY;
  
  // Builder
  public bigMoon(){
    speedX = 10;
    speedY = 10;
    setHealth(300); // health
    right = false;
    down = false;
    x = 100;
    y = -256;
  }
  
  void draw(){
    if(this.getHealth() > 0){
      move();
      if(this.getImmuneTime() > 0){
        if(frameCount%3==0) tint(RED,150);
        else tint(WHITE,150);
        image(moonImage,x,y,300,300);
      }
      textFont(fontDefault);
      if(debugInfo) text(String.valueOf(this.getHealth()),x,y);
      image(moonImage,x,y,300,300);
      noTint();
      if(this.getImmuneTime() >= 1) this.setImmuneTime(getImmuneTime()-1);
    }
  }
  
  // Move
  void move(){
    
    if(this.x >= width || this.x <= 0) right = !right;
    if(this.y >= height || this.y < 0) down = !down;
    if(y < 0) down = true;
    
    if(right) x += speedX;
    else this.x -= speedX;
    if(down) this.y += speedY;
    else this.y -= speedY;
  }
  
  // Methods
  public int getSize(){
    return 300;
  }
  public int getDamage(){
    return 25;
  }
  
  public void respawn(){ // Don't use
    setHealth(200);
    setPosition(random(54,width-54),-random(-54,-300));
  }
}

//////////////////////// bigSkull (bigBoss) ////////////////////////////
public class bigSkull extends Enemy{
  
  boolean right;
  
  smallSkull ammo[]; // Enemy AMMO
  
  // Builder
  public bigSkull(){
    ammo = new smallSkull[MAX_SMALL_SKULL];
    for(int i = 0; i < MAX_SMALL_SKULL; i++) ammo[i] = new smallSkull();
    setHealth(500); // health
    right = false;
    x = width/2;
    y = -300;
    frame = 0;
  }
  
  void draw(){
    if(this.getHealth() > 0){
      move();
      if(this.getImmuneTime() > 0){
        if(frameCount%3==0) tint(RED,150);
        else tint(WHITE,150);
        image(bigSkullGIF[frame],x,y,300,300);
      }else{
        tint(250-(this.getHealth()/2),(this.getHealth())-250,0);
      }
      textFont(fontDefault);
      if(debugInfo) text(String.valueOf(this.getHealth()),x,y);
      image(bigSkullGIF[frame],x,y,300,300);
      noTint();
      if(this.getImmuneTime() >= 1) this.setImmuneTime(getImmuneTime()-1);
      frame++;
      if(frame == 8) frame = 0;
    }
  }
  
  // Move
  void move(){
    
    if(this.x >= width || this.x <= 0) right = !right;
    if(y < 120) this.y += 10;
    
    if(right) x += 15-(getHealth()/100);
    else this.x -= 15-(getHealth()/100);
    
    if(frameCount%15==0){
      for(int i = 0; i < MAX_SMALL_SKULL; i++){
        if(ammo[i].getHealth() <= 0){
          ammo[i].respawn(this.x,this.y-10);
          break;
        }
      }
    }
    for(int i = 0; i < MAX_SMALL_SKULL; i++) ammo[i].draw();
  }
  
  // Methods
  public int getSize(){
    return 300;
  }
  public int getDamage(){
    return 25;
  }
  
  public void respawn(){ // Don't use
    setHealth(200);
    setPosition(random(54,width-54),-random(-54,-300));
  }
}

////////////////////////////// small Skull //////////////////////
public class smallSkull extends Enemy{
  
  float speedY;
  
  // Builder
  public smallSkull(){
    speedY = random(3,10);
    setHealth(0); // health
    frame = 0;
  }
  
  void draw(){
    if(this.getHealth() > 0){
      move();
      textFont(fontDefault);
      if(debugInfo) text(String.valueOf(this.getHealth()),x,y-14);
      tint(WHITE,150);
      image(smallSkullGIF[frame],this.x,this.y,64,64);
      noTint();
      if(frameCount%10 == 0) frame++;
      if(frame == 8) frame = 0;
    }
  }
  
  // Move
  void move(){
    if(this.y < 850){
      y += speedY;
    }else{
      this.setHealth(0);
    }
    if(localPlayer.getImmuneTime() <= 0) checkCollision(localPlayer,this);
  }
  
  // Methods
  public int getSize(){
    return 64;
  }
  public int getDamage(){
    return 7;
  }
  
  public void respawn(){
    setHealth(15);
    setPosition(0,0);
  }
  
  public void respawn(float x, float y){
    setHealth(15);
    setPosition(x,y);
  }
}
