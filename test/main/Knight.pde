public class Knight{
  
  //Position
  PVector playerPos;
  
  //Character properties
  float moveSpeed;
  float attack;
  float bulletSpeed;
  float shootSpeed;// 1 sec x bullets
  
  //FireBalls
  ArrayList<FireBalls> fireBalls = new ArrayList<FireBalls>();
  
  //Animation
  PImage[] Idle=new PImage[9];
  PImage[] Walk=new PImage[5];
  
  //Auxiliary variable
  boolean moveUp, moveDown, moveLeft, moveRight; 
  int currentFrame = 0; 
  int currentstatus = 0;
  int lastShootTime;
  
  public Knight(){
     playerPos = new PVector(700, 400);
     moveSpeed = 7.0;
     bulletSpeed = 10.0;
     shootSpeed = 2.0;
     lastShootTime = millis();
  }
  
  
  public void drawIdle(){
    if(currentFrame%8==0){
      currentstatus = (currentstatus+1) % Idle.length;
    }
    image(Idle[currentstatus], playerPos.x , playerPos.y);
    currentFrame++;
  }
  
  public void drawWalk(){
    if(currentstatus>=Walk.length){
      currentstatus=0;
    }
    if(currentFrame%8==0){
      currentstatus = (currentstatus+1) % Walk.length;
    }
    image(Walk[currentstatus], playerPos.x , playerPos.y);
    currentFrame++;
  }
  
  
  public boolean movePlayer(){
    boolean isMove = false;
    if (moveUp) {
      playerPos.y -= moveSpeed;
      isMove = true;
    }
    if (moveDown) {
      playerPos.y += moveSpeed;
      isMove = true;
    }
    if (moveLeft) {
      playerPos.x -= moveSpeed;
      isMove = true;
    }
    if (moveRight) {
      playerPos.x += moveSpeed;
      isMove = true;
    }
    return isMove;
  }
  
  void moveFireBalls() {
    for (int i = fireBalls.size()-1; i >= 0; i--) {
      FireBalls fb = fireBalls.get(i);
      fb.move();
      if (fb.pos.x < 70 || fb.pos.x > width-70 || fb.pos.y < 70 || fb.pos.y > height-70) {
        fireBalls.remove(i);
      }
    }
  }
  
  void drawFireBalls(PImage curFireBall) {
    
    for (FireBalls fb : fireBalls) {
     image(curFireBall, fb.pos.x, fb.pos.y); 
    }
  }
  
  void shootFireBalls(int curKeyCode) {
    float dirX = 0;
    float dirY = 0;
    if (curKeyCode == UP) {
      dirY = -1;
    }
    if (curKeyCode == DOWN) {
      dirY = 1;
    }
    if (curKeyCode == LEFT) {
      dirX = -1;
    }
    if (curKeyCode == RIGHT) {
      dirX = 1;
    }
    
    //keep shootSpeed
    if(millis()-lastShootTime > 1000.0/shootSpeed){
      FireBalls fb = new FireBalls(playerPos.x, playerPos.y+50, dirX, dirY, bulletSpeed);
      fireBalls.add(fb);
      lastShootTime=millis();
    }
  }
}
