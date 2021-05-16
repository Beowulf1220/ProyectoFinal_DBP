// Player Class
public class Player{
  
  // Attributes
  private String name; // User name
  private int score;  // Current score
  private int highestScore;
  private int save; // Game progress
  private int playerNumber;
  
  // Positon
  private float x,y;
  
  // Player avatar
  private PImage avatar[];
  private int avatarFrame;
  
  // Health Points
  private int health = 100;
  private int shield = 0;
  
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
    this.playerNumber = playerNumber;
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
  
  int getHealth(){
    return health;
  }
  
  int getShield(){
    return shield;
  }
  
  int getScore(){
    return score;
  }
  
  int getPlayerNumber(){
    return playerNumber;
  }
  
  // Intersting methods
  void drawPlayer(){
    image(avatar[avatarFrame], x, y);
    avatarFrame++;
    if(avatarFrame >= 2) avatarFrame = 0;
  }
}

// Player interface
void playerInerface(){
  textFont(fontInterface);
  textAlign(0);
  fill(GREEN,200);
  textSize(14);
  text("Player"+localPlayer.getPlayerNumber()+": "+localPlayer.getName()+
  "    Health:"+localPlayer.getHealth()+
  "    Shield:"+localPlayer.getShield()+
  "    Score:"+localPlayer.getScore(),0,12);
  if(isCooperativeMode){
    // another one player ...
  }
}
