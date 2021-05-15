public class Player{
  
  private String name; // User name
  private int score;  // Current score
  private int highestScore;
  private int save; // Game progress
  
  //builder
  public Player(String name,int highestScore, int save){
    this.name = name;
    this.highestScore = score;
    this.save = save;
    score = 0;
  }
}
