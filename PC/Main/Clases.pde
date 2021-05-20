// A few constants
static final int MAX_AMMO = 10; // Max ammo that players can shooting in a raw
static final int MAX_MISSILE = 2;

final int MAX_METEORITES = 4;
final int MAX_ENEMIES = 6;

static final int LEVEL_TIME = 160; // 2 minutes and 40 seconds

// All objects must to be child from this class
public abstract class GameObject{
   
  private int health; // Object health
  protected float x,y; // Object position
  private int immuneTime;
  
  // Builder
  GameObject(int health){
    immuneTime = 0;
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
  
  public int getImmuneTime(){
    return immuneTime;
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
  
  public void setPosition(float x, float y){
    this.x = x;
    this.y = y;
  }
  
  public void setImmuneTime(int immuneTime){
    this.immuneTime = immuneTime;
  }
}

////////////////////////////////// Healing ////////////////////////////////////////////
public class Health extends GameObject{
  
  public Health(){
    super(0);
    this.x = -100;
    this.y = -100;
  }
  
  public int getDamage(){
    return -15;
  }
  
  public int getSize(){
    return 32;
  }
  
  public void draw(){
    if(!(checkCollision(this,localPlayer) > 0) && y < 900){
      image(hearthImage,x,y);
      y += 1;
    }else{
      y = 900;
    }
  }
  
  public void respawn(float x, float y){
    this.x = x;
    this.y = y;
    setHealth(1);
  }
}

/////////////////////////////// get Shield ////////////////////////////////
public class Shield extends GameObject{
  
  public Shield(){
    super(0);
    this.x = -100;
    this.y = -100;
  }
  
  public int getDamage(){
    return 0;
  }
  
  public int getSize(){
    return 32;
  }
  
  public void draw(){
    if(!(checkCollision(this,localPlayer) > 0) && y < 900){
      image(shieldImage,x,y);
      y += 1;
    }else{
      if(getHealth() > 0){
        if(localPlayer.getShield() < 100) localPlayer.setShield(localPlayer.getShield()+10);
        setHealth(0);
      }
      y = 900;
    }
  }
  
  public void respawn(float x, float y){
    setHealth(1);
    this.x = x;
    this.y = y;
  }
}

////////////////////////////////////////// Collitions ///////////////////////////////////////////////////////
private int checkCollision(GameObject a, GameObject b){
  
  int crashed = 0;
  
  if(!(a.getHealth() > 0 && b.getHealth() > 0)) return crashed;
  
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
    crashed = b.getHealth();
    if((a instanceof Health || b instanceof Health) ||(a instanceof Shield || b instanceof Shield)) clickSound.play();
    else hitSound1.play();
    if(!(a instanceof Shield) || (b instanceof Shield)){
      a.setHealth(a.getHealth()-b.getDamage());
      b.setHealth(b.getHealth()-a.getDamage());
      a.setImmuneTime(30);
      b.setImmuneTime(30);
    }
    println("> ("+a.toString()+") crashed with ("+b.toString()+")");
  }
  return crashed; // return the damage from object B to A
}
