// Meteorite Class
public class Meteorite{
  
  private float x,y; // Meteorite position
  private int frame;
  private float speed;
  private int size;
  
  //Meteorite Builder
  public Meteorite(){
    frame = 0;
    size = 200;
    speed = 2.5;
    randomSeed(0);
    x = (float) Math.random()*width;/////////////// ...
    if(x > width-(size/2)) x = width-(size/2);
    if(x < (size/2)) x = (size/2);
    println(x);
    y = -(size/2);
  }
  
  void drawEnemy(){
    image(meteoriteGIF[frame],x,y);
    y += speed;
    if(frameCount%2 == 0) frame++;
    if(frame >= 20) frame = 0;
  }
}
