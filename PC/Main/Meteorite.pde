// Meteorite Class

public class Meteorite{
  
  // There's a only meteorite sprite so, we can change the size and speed to show variety
  
  private float x,y; // Meteorite position
  private int frame;
  private float speed;
  private float rotationSpeed;
  private int size;
  private boolean alive;
  
  //Meteorite Builder
  public Meteorite(){
    rotationSpeed = random(1,8);
    alive = false;
    frame = 0;
    size = 200;
    speed = 2.5;
    x = random((size/2),(width-(size/2)));
    y = -(size/2);
  }
  
  public Meteorite(int size, float speed){
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
    if(y > height+(size/2)) alive = false;
  }
  
  void revive(){
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
  
  public int getSize(){
    return size;
  }
  
  public float getX(){
    return x;
  }
  
  public float getY(){
    return y;
  }
  
  // Sets methods
  public void setAlive(boolean alive){
    this.alive = alive;
  }
  
  public void setY(float y){
    this.y = y;
  }
}
