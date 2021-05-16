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
  PImage avatar[];
  int avatarFrame;
  
  // Builder
  public Player(String name,int highestScore, int save, int playerNumber){
    
    avatar = new PImage[2];
    
    if(playerNumber == 1){
      avatar[0] = loadImage("Resources/Images/spaceShips/goldenHeart/frame1.gif");
      avatar[1] = loadImage("Resources/Images/spaceShips/goldenHeart/frame2.gif");
      x = 200;
    }else{
      avatar[0] = loadImage("Resources/Images/spaceShips/eagleRed/frame1.gif");
      avatar[1] = loadImage("Resources/Images/spaceShips/eagleRed/frame2.gif");
      x = 400;
    }
    
    avatarFrame = 0;
    this.name = name;
    this.highestScore = score;
    this.save = save;
    score = 0;
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
    image(avatar[avatarFrame], x, y);
    avatarFrame++;
    if(avatarFrame >= 2) avatarFrame = 0;
  }
}
