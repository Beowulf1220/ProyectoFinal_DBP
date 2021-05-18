// Meteorite Class

public abstract class GameObject{
  
  private int health;
  
  GameObject(int health){
    this. health = health;
  }
  
  public abstract float getX();
  public abstract float getY();
  public abstract int getSize();
  public abstract int getDamage();
  
  // Get methods
  public int getHealth(){
    return health;
  }
  
  // Set methods
  public void setHealth(int health){
    this.health = health;
  }
}

public class Meteorite extends GameObject{
  
  // There's a only meteorite sprite so, we can change the size and speed to show variety
  
  private float x,y; // Meteorite position
  private int frame;
  private float speed;
  private float rotationSpeed;
  private int size;
  private boolean alive;
  
  //Meteorite Builder
  public Meteorite(){
    super(10); // Father builder
    rotationSpeed = random(1,8);
    alive = false;
    frame = 0;
    size = 200;
    speed = 2.5;
    x = random((size/2),(width-(size/2)));
    y = -(size/2);
  }
  
  public Meteorite(int size, float speed){
    super(10); // Father builder
    rotationSpeed = random(1,8);
    alive = false;
    frame = 0;
    this.size = size;
    this.speed = speed;
    x = random((size/2),(width-(size/2)));
    y = -(size/2);
  }
  
  public void drawEnemy(){
    noSmooth();
    image(meteoriteGIF[frame],x,y,size,size);
    smooth(4);
    y += speed;
    if(frameCount%round(rotationSpeed) == 0) frame++;
    if(frame >= 20) frame = 0;
    if(y > height+(size/2)){
      alive = false;
      y = -(size/2);
    }
    if(getHealth() <= 0){
      alive = false;
      y = -(size/2);
    }
  }
  
  void revive(){
    setHealth(5);
    size = (int) random(32,256);
    rotationSpeed = random(1,8);
    alive = true;
    speed = random(1,10);
    x = random((size/2),(width-(size/2)));
    y = -(size/2);
  }
  
  // Get methods
  public boolean isAlive(){
    return alive;
  }
  
  @Override
  public int getSize(){
    return size;
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
  public int getDamage(){
    return 5;
  }
  
  // Sets methods
  public void setAlive(boolean alive){
    this.alive = alive;
  }
  
  public void setY(float y){
    this.y = y;
  }
}
