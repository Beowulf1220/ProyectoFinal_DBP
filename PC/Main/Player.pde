// Player Class
public class Player{
  
  // Attributes
  private String name; // User name
  private int score;  // Current score
  private int highestScore;
  private int save; // Game progress
  
  // Positon
  float x,y;
  
  // Player avatar
  PImage avatar;
  
  // Builder
  public Player(String name,int highestScore, int save){
    
    avatar = loadImage("Resources/Images/spaceShips/eagleRed.png");
    
    this.name = name;
    this.highestScore = score;
    this.save = save;
    score = 0;
    x = 200;
    y = height - 100;
  }
  
  // Set methods
  void setPosition(float x, float y){
    this.x = x;
    this.y = y;
  }
  
  void setScore(int score){
    this.score = score;
  }
  
  // Get methods
  String getName(){
    return name;
  }
  
  int getScore(){
    return score;
  }
  
  // Intersting methods
  void drawPlayer(){
    image(avatar, x, y);
  }
}
