// Background

public abstract class Background{
  public abstract void draw();
}

// Backraund for levels 1-3 and the menu
public class StarsBackground extends Background{
  
  // Stars matrix
  private float stars[][];
  private color starColor[];
  private int stars_number;
  private float starsSpeed;
  
  // Builders
  public StarsBackground(int stars_number, float stars_speed){
    this.stars_number = stars_number;
    this.starsSpeed = stars_speed;
    
    stars = new float[2][stars_number];
    starColor = new color[stars_number];
    giveColor();
    
    for(int i = 0; i < stars_number; i++){
      stars[0][i] = random(width);  // X value of Star i
      stars[1][i] = random(height);  // Y value of Star i
    }
  }
  
  public StarsBackground(int stars_number){
    this.stars_number = stars_number;
    starsSpeed = 1;
    
    stars = new float[2][stars_number];
    starColor = new color[stars_number];
    giveColor();
    
    for(int i = 0; i < stars_number; i++){
      stars[0][i] = random(width);  // X value of Star i
      stars[1][i] = random(height);  // Y value of Star i
    }
  }
  
  public StarsBackground(){
    stars_number = 100;
    starsSpeed = 1;
    
    stars = new float[2][stars_number];
    starColor = new color[stars_number];
    giveColor();
    
    //for(int i = 0; i < 2; i++) stars[i] = new float[stars_number];
    for(int i = 0; i < stars_number; i++){
      stars[0][i] = random(width);
      stars[1][i] = random(height);
    }
  }
  
  // Stars color
  private void giveColor(){
    for(int i = 0; i < stars_number; i++){
      starColor[i] = getAColor();
    }
  }
  
  private color getAColor(){
    float rand;
    color col;
    rand = random(0,1);
    if(rand <= 0.1) col = RED;
    else if(rand <= 0.25) col = BLUE;
    else if(rand <= 0.5) col = YELLOW;
    else col = WHITE;
    return col;
  }
  
  @Override
  public void draw(){
    for(int i = 0; i < stars_number; i++){
      fill(starColor[i]);
      ellipse(stars[0][i],stars[1][i],3,3);
    }
    
    for(int i = 0; i < stars_number; i++){
      stars[1][i] += starsSpeed; // Y value of the star
      if(stars[1][i] > height){
        stars[1][i] = -1; // return the star to the top
        // change the star
        stars[0][i] = random(width);
        starColor[i] = getAColor();
      }
    }
  }
  
  public void setStarsSpeed(float speed){
    starsSpeed = speed;
  }
}

// Background for levels 4-6
public class CrazyBackground extends Background{
  
  private PImage frames[];
  private int frame;
  
  // Builder
  public CrazyBackground(){
    frame = 0;
    frames = new PImage[10];
    for(int i = 0; i < 10; i ++) frames[i] = loadImage("Resources/Images/enviroment/level_4/frame-"+(i+1)+".gif");
  }
  
  @Override
  void draw(){
    image(frames[frame],width/2,height/2,width,height);
    if(frameCount%3==0) frame++;
    if(frame >= 10) frame = 0;
  }
}

// Background for levels 7-9
public class OceanBackground extends Background{
  
  private PImage frames[];
  private int frame;
  
  // Builder
  public OceanBackground(){
    frame = 0;
    frames = new PImage[10];
    for(int i = 0; i < 10; i ++) frames[i] = loadImage("Resources/Images/enviroment/level_7/frame-"+(i+1)+".gif");
  }
  
  @Override
  void draw(){
    image(frames[frame],width/2,height/2,width,height);
    if(frameCount%3==0) frame++;
    if(frame >= 10) frame = 0;
  }
}

// Background for level 10 (last level)
public class MadnessBackground extends Background{
  
  private PImage frames[];
  private int frame;
  
  // Builder
  public MadnessBackground(){
    frame = 0;
    frames = new PImage[8];
    for(int i = 0; i < 8; i ++) frames[i] = loadImage("Resources/Images/enviroment/level_10/frame-"+(i+1)+".gif");
  }
  
  @Override
  void draw(){
    image(frames[frame],width/2,height/2,width,height);
    if(frameCount%3==0) frame++;
    if(frame >= 8) frame = 0;
  }
}
