// Button Class for all our buttons

public class Button{
  
  //Attributes
  private String text;
  private float positionX,positionY;
  private float sizeX,sizeY;
  
  private color col;
  
  //Builder default color
  public Button(String text,float positionX, float positionY, float sizeX, float sizeY){
    this.text = text;
    this.positionX = positionX;
    this.positionY = positionY;
    this.sizeX = sizeX;
    this.sizeY = sizeY;
    col = GREEN;
  }
  
  //Builder custom color
  public Button(String text,float positionX, float positionY, float sizeX, float sizeY,color col){
    this.text = text;
    this.positionX = positionX;
    this.positionY = positionY;
    this.sizeX = sizeX;
    this.sizeY = sizeY;
    this.col = col;
  }
  
  // Draw the button
  void drawButton(){
    // This draw a button with a border
    fill(col);
    rect(positionX,positionY,sizeX,sizeY,5);
    fill(0);
    rect(positionX,positionY,sizeX-4,sizeY-4,5);
    
    // Button's text
    fill(col);
    textFont(fontButton);
    text(text,positionX,positionY+16);
  }
  
  void drawButton(int textSize){
    // This draw a button with a border
    fill(col);
    rect(positionX,positionY,sizeX,sizeY,5);
    fill(0);
    rect(positionX,positionY,sizeX-4,sizeY-4,5);
    
    // Button's text
    fill(col);
    textFont(fontButton);
    textSize(textSize);
    text(text,positionX,positionY+16);
  }
  
  // Set methods
  void setText(String text){
    this.text = text;
  }
  
  void setColor(color col){
    this.col = col;
  }
  
  //Get methods
  color getColor(){
    return col;
  }
  
  //check if the button is pressed
  boolean isPressed(){
    boolean isPressed = false;
    if((mouseX >= positionX-(sizeX/2) && mouseX <= positionX+(sizeX/2)) && (mouseY >= positionY-(sizeY/2) && mouseY <= positionY+(sizeY/2))){
      isPressed = true;
    }
    return isPressed;
  }
  
  void pressed(){
    col = WHITE;
  }
}
