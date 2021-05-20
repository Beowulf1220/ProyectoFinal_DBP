// A few constants
static final int MAX_AMMO = 10; // Max ammo that players can shooting in a raw
static final int MAX_MISSILE = 2;

final int MAX_METEORITES = 4;

static final int LEVEL_TIME = 160; // 2 minutes and 40 seconds

// All objects must to be child from this class
public abstract class GameObject{
  
  private int health; // Object health
  protected float x,y; // Object position
  
  // Builder
  GameObject(int health){
    this. health = health;
  }
  
  // Get methods
  public float getX(){
    return x;
  }
  public float getY(){
    return y;
  }
  
  public int getHealth(){
    return health;
  }
  
  // Abstract methods
  public abstract int getSize();
  public abstract int getDamage();
  
  // Set methods
  public void setHealth(int health){
    this.health = health;
  }
  
  public void setX(float x){
    this.x = x;
  }
  
  public void setY(float y){
    this.y = y;
  }
  
  void setPosition(float x, float y){
    this.x = x;
    this.y = y;
  }
}

////////////////////////////////////////// Collitions ///////////////////////////////////////////////////////
private boolean checkCollision(GameObject a, GameObject b){
  
  boolean crashed = false;
  
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
    ellipse(x1,y1,a.getSize(),a.getSize()); // Object A hitCircle
    ellipse(x2,y2,b.getSize(),b.getSize()); // Object B hitCircle
  }
  
  if(distancia <= (objectARatio + objectBRatio)){
    crashed = true;
    hitSound1.play();
    a.setHealth(a.getHealth()-b.getDamage());
    b.setHealth(b.getHealth()-a.getDamage());
    //println("> ("+a.toString()+") crashed with ("+b.toString()+")");
  }
  return crashed;
}
