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
    setHealth(200); // health
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
