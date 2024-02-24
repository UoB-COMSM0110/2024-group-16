public class Knight{
  PVector playerPos;
  float moveSpeed;
  PImage[] Idle=new PImage[9];
  PImage[] Walk=new PImage[5];
  boolean moveUp, moveDown, moveLeft, moveRight; 
  int currentFrame = 0; 
  int currentstatus = 0;
  
  public Knight(){
     playerPos = new PVector(700, 400);
     moveSpeed = 4.0;
  }
  
  
  public void drawIdle(){
    if(currentFrame%10==0){
      currentstatus = (currentstatus+1) % Idle.length;
    }
    image(Idle[currentstatus], playerPos.x , playerPos.y);
    currentFrame++;
  }
  
  
  public void movePlayer(){
    if (moveUp) {
      playerPos.y -= moveSpeed;
    }
    if (moveDown) {
      playerPos.y += moveSpeed;
    }
    if (moveLeft) {
      playerPos.x -= moveSpeed;
    }
    if (moveRight) {
      playerPos.x += moveSpeed;
    }
  }
}
