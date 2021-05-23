// A few constants
static final int MAX_AMMO = 6; // Max ammo that players can shooting in a raw
static final int MAX_MISSILE = 2;

final int MAX_METEORITES = 4;
final int MAX_ENEMIES = 5;
final int MAX_SMALL_SKULL = 5;
final int MAX_UFO_LASER = 2;

final int MAX_BRAIN_DEFENCE = 6;

static final int LEVEL_TIME = 60; // 1 minute

// All objects must to be child from this class
public abstract class GameObject {

  private int health; // Object health
  protected float x, y; // Object position
  private int immuneTime;

  // Builder
  GameObject(int health) {
    immuneTime = 0;
    this. health = health;
  }

  // Get methods
  public float getX() {
    return x;
  }
  public float getY() {
    return y;
  }

  public int getHealth() {
    return health;
  }

  public int getImmuneTime() {
    return immuneTime;
  }

  // Abstract methods
  public abstract int getSize();
  public abstract int getDamage();

  // Set methods
  public void setHealth(int health) {
    this.health = health;
  }

  public void setX(float x) {
    this.x = x;
  }

  public void setY(float y) {
    this.y = y;
  }

  public void setPosition(float x, float y) {
    this.x = x;
    this.y = y;
  }

  public void setImmuneTime(int immuneTime) {
    this.immuneTime = immuneTime;
  }
}

////////////////////////////////// Healing ////////////////////////////////////////////
public class Health extends GameObject {

  public Health() {
    super(0);
    this.x = -100;
    this.y = -100;
  }

  public int getDamage() {
    return -20;
  }

  public int getSize() {
    return 32;
  }

  public void draw() {
    if (!(checkCollision(this, localPlayer) > 0) && y < 900) {
      image(hearthImage, x, y);
      y += 1;
    } else {
      y = 900;
    }
  }

  public void respawn(float x, float y) {
    this.x = x;
    this.y = y;
    setHealth(1);
  }
}

/////////////////////////////// get Shield ////////////////////////////////
public class Shield extends GameObject {

  public Shield() {
    super(0);
    this.x = -100;
    this.y = -100;
  }

  public int getDamage() {
    return 0;
  }

  public int getSize() {
    return 32;
  }

  public void draw() {
    if (!(checkCollision(this, localPlayer) > 0) && y < 900) {
      image(shieldImage, x, y);
      y += 1;
    } else {
      if (getHealth() > 0) {
        if (localPlayer.getShield() < 100) localPlayer.setShield(localPlayer.getShield()+15);
        setHealth(0);
      }
      y = 900;
    }
  }

  public void respawn(float x, float y) {
    setHealth(1);
    this.x = x;
    this.y = y;
  }
}

////////////////////////////////////////// Collitions ///////////////////////////////////////////////////////
private int checkCollision(GameObject a, GameObject b) {

  int crashed = 0;

  if (a == null || b == null) return crashed;
  else if (!(a.getHealth() > 0 && b.getHealth() > 0)) return crashed;

  float x1 = a.getX();
  float y1 = a.getY();
  float x2 = b.getX();
  float y2 = b.getY();

  double objectARatio = (a.getSize()/2);
  double objectBRatio = (b.getSize()/2);

  objectARatio -= objectARatio*0.1; // Offset
  objectBRatio -= objectBRatio*0.1; // Offset

  double distancia = Math.sqrt((x2 - x1)*(x2 - x1) + (y2 - y1)*(y2 - y1));

  if (debugInfo) {
    ellipse(x1, y1, a.getSize(), a.getSize()); // Object A hitCircle
    ellipse(x2, y2, b.getSize(), b.getSize()); // Object B hitCircle
  }

  if (distancia <= (objectARatio + objectBRatio)) {
    crashed = b.getDamage();
    if ((a instanceof Health || b instanceof Health) ||(a instanceof Shield || b instanceof Shield)) clickSound.play();
    else {
      if (hitSound1.isPlaying()) hitSound1.stop();
      hitSound1.play();
    }
    if (!(a instanceof Shield) || (b instanceof Shield)) {
      a.setHealth(a.getHealth()-b.getDamage());
      b.setHealth(b.getHealth()-a.getDamage());
      a.setImmuneTime(30);
      b.setImmuneTime(30);
    }
    //println("> ("+a.toString()+") crashed with ("+b.toString()+")");
  }
  return crashed; // return the damage from object B to A
}

////////////////////////////////////////// Collitions ///////////////////////////////////////////////////////
private int checkCollision(GameObject a, GameObject b, Player player) {

  int crashed = 0;

  if (a == null || b == null) return crashed;
  else if (!(a.getHealth() > 0 && b.getHealth() > 0)) return crashed;

  float x1 = a.getX();
  float y1 = a.getY();
  float x2 = b.getX();
  float y2 = b.getY();

  double objectARatio = (a.getSize()/2);
  double objectBRatio = (b.getSize()/2);

  objectARatio -= objectARatio*0.1; // Offset
  objectBRatio -= objectBRatio*0.1; // Offset

  double distancia = Math.sqrt((x2 - x1)*(x2 - x1) + (y2 - y1)*(y2 - y1));

  if (debugInfo) {
    ellipse(x1, y1, a.getSize(), a.getSize()); // Object A hitCircle
    ellipse(x2, y2, b.getSize(), b.getSize()); // Object B hitCircle
  }

  if (distancia <= (objectARatio + objectBRatio)) {
    crashed = b.getDamage();
    player.setScore(player.getScore()+10);
    if (b instanceof Health || b instanceof Shield) clickSound.play();
    else {
      if (hitSound1.isPlaying()) hitSound1.stop();
      hitSound1.play();
    }
    if (!(b instanceof Shield)) {
      a.setHealth(a.getHealth()-b.getDamage());
      b.setHealth(b.getHealth()-a.getDamage());
      a.setImmuneTime(30);
      b.setImmuneTime(30);
    }
    //println("> ("+a.toString()+") crashed with ("+b.toString()+")");
  }
  return crashed; // return the damage from object B to A
}

////////////////////// little alien waiting for someone  /////////////////////////////
public class ufoWait extends GameObject {

  private int frame;
  PImage ufoWaitGIF[];

  public ufoWait(float x, float y) {
    super(0);
    frame = 0;
    this.x = x;
    this.y = y;

    ufoWaitGIF = new PImage[29];
    for (int i = 0; i < 29; i++) {
      ufoWaitGIF[i] = loadImage("Resources/Images/ufoWait/frame-"+(i+1)+".gif");
    }
  }

  public int getDamage() {
    return 0;
  }

  public int getSize() {
    return 32;
  }

  public void draw() {
    image(ufoWaitGIF[frame], x, y);
    if (frameCount%4==0) frame++;
    if (frame == 29) frame = 0;
  }

  public void respawn(float x, float y) {
    this.x = x;
    this.y = y;
    setHealth(0);
  }
}

//////////////////// Ardunio conection ////////////////////////////////
class SerialConnection
{
  Serial serialPort;
  PApplet app;
  int baud;
  int numberOfPorts;
  boolean deviceDetected = false;
  boolean isReady = false;
  String[] portList;
  String detectedPort;
     
  SerialConnection(PApplet _app, int _baud)
  {
    app = _app;
    baud = _baud;
    getSerialPorts();
  }

  void getSerialPorts()
  {
    //printArray(serialPort.list());
   // println("Connect device");
    numberOfPorts = serialPort.list().length;
    portList = new String[numberOfPorts];
    for(int i = 0; i < numberOfPorts; i++)
    {
      portList[i] = serialPort.list()[i];
    }
  }

  void startSerialCommunication()
  {
      if((serialPort.list().length > numberOfPorts) && !deviceDetected)
      {
          deviceDetected = true;
          boolean str_match = false;
          if(numberOfPorts == 0)
          {
              detectedPort = serialPort.list()[0];
          }
          else
          {
              for(int i = 0; i < serialPort.list().length; i++)
              {
                  for(int j = 0; j < numberOfPorts; j++)
                  {
                      if(serialPort.list()[i].equals(portList[j]))
                      {
                          break;
                      }
                      if(j == (numberOfPorts - 1))
                      {
                          str_match = true;
                          detectedPort = serialPort.list()[i];
                      }
                  }
              }
          }
          //println("Device detected");
          establishCommunication();
      }
      terminateCommunication();
  }

  void establishCommunication()
  {
    delay(100);
    serialPort = new Serial(app, detectedPort, baud);
    isReady = true;
    //println("Serial communication established at: " + detectedPort);
  }
  void terminateCommunication()
  {
    if(keyPressed) if(key == 'œ')
    {
      try
      {
        serialPort.clear();
        serialPort.stop();
        //println("Serial communication terminated");
        exit();
      }
      catch(Exception e)
      {
        exit();
      }
    }
  }
}
