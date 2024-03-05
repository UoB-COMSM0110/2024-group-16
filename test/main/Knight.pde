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
  boolean shootUp, shootDown, shootLeft, shootRight;
  boolean isFaceToLeft;
  int currentFrame = 0; 
  int currentstatus = 0;
  int lastShootTime;
  
  public Knight(){
     playerPos = new PVector(700, 400);
     moveSpeed = 7.0;
     bulletSpeed = 10.0;
     shootSpeed = 2.0;
     lastShootTime = millis();
     isFaceToLeft = true;
     
     for(int i=0;i<Idle.length;i++){
        Idle[i]=loadImage("../images/Knight/Idle/Idle_"+i+".PNG");
     }
     for(int i=0;i<Walk.length;i++){
       Walk[i]=loadImage("../images/Knight/Walk/Walk_"+i+".PNG");
     }
  }
  
  public void turnToLeft(){
    isFaceToLeft=true;
  }
  public void turnToRight(){
    isFaceToLeft=false;
  }
  
  public void drawIdle(){
    if(currentFrame%8==0){
      currentstatus = (currentstatus+1) % Idle.length;
    }
    if(!isFaceToLeft){
      pushMatrix();
      scale(-1, 1);
      image(Idle[currentstatus], -playerPos.x-Idle[currentstatus].width , playerPos.y);
      popMatrix();
    }else{
      image(Idle[currentstatus], playerPos.x , playerPos.y);
    }
    currentFrame++;
  }
  
  public void drawWalk(){
    if(currentstatus>=Walk.length){
      currentstatus=0;
    }
    if(currentFrame%8==0){
      currentstatus = (currentstatus+1) % Walk.length;
    }
    if(!isFaceToLeft){
      pushMatrix();
      scale(-1, 1);
      image(Walk[currentstatus], -playerPos.x-Walk[currentstatus].width , playerPos.y);
      popMatrix();
    }else{
      image(Walk[currentstatus], playerPos.x , playerPos.y);
    }
    currentFrame++;
  }
  
  
  public boolean movePlayer(){
    boolean isMove = false;
    if (moveUp) {
      if(playerPos.y >= 110){
        playerPos.y -= moveSpeed;
      }
      isMove = true;
    }
    if (moveDown) {
      if(playerPos.y <= 570){
        playerPos.y += moveSpeed;
      }
      isMove = true;
    }
    if (moveLeft) {
      if(playerPos.x >= 115){
        playerPos.x -= moveSpeed;
      }
      isMove = true;
    }
    if (moveRight) {
      if(playerPos.x <= 1220){
        playerPos.x += moveSpeed;
      }
      isMove = true;
    }
    return isMove;
  }
  
  void moveFireBalls() {
    for (int i = fireBalls.size()-1; i >= 0; i--) {
      FireBalls fb = fireBalls.get(i);
      fb.move();
      if (fb.pos.x < 70 || fb.pos.x > width-70 || 
          fb.pos.y < 70 || fb.pos.y > height-70) {
        fireBalls.remove(i);
      }
    }
  }
  
  void drawFireBalls(PImage[] FireBallsUP,PImage[] FireBallsDOWN,
                     PImage[] FireBallsLEFT,PImage[] FireBallsRIGHT) {
    
    for (FireBalls fb : fireBalls) {
      if(fb.currentstatus > FireBallsUP.length){
        fb.resetCurStatus();
      }
      if(fb.currentFrame%5==0){
        fb.currentstatus = (currentstatus+1) % FireBallsUP.length;
      }
      switch(fb.direction){
        case 1:
          image(FireBallsUP[fb.currentstatus], fb.pos.x ,fb.pos.y );
          break;
        case 2:
          image(FireBallsDOWN[fb.currentstatus], fb.pos.x ,fb.pos.y );
          break;
        case 3:
          image(FireBallsLEFT[fb.currentstatus], fb.pos.x ,fb.pos.y );
          break;
        case 4:
          image(FireBallsRIGHT[fb.currentstatus], fb.pos.x ,fb.pos.y );
          break;      
      }
      
      fb.incCurFrame();
    }
  }
  
  void shootFireBalls(int curKeyCode) {
    float dirX = 0;
    float dirY = 0;
    if (curKeyCode == UP) {
      dirY = -1;
      shootUp=true;
    }
    if (curKeyCode == DOWN) {
      dirY = 1;
      shootDown=true;
    }
    if (curKeyCode == LEFT) {
      dirX = -1;
      shootLeft=true;
    }
    if (curKeyCode == RIGHT) {
      dirX = 1;
      shootRight=true;
    }
    
    //You can't shoot right when facing left, and vice versa.
    if(!((shootRight && isFaceToLeft)|| (shootLeft && !isFaceToLeft) )){
      //keep shootSpeed
      if(millis()-lastShootTime > 1000.0/shootSpeed){
        if(shootUp){
        FireBalls fb = new FireBalls
            (playerPos.x, playerPos.y+50, dirX, dirY, bulletSpeed,1);
            fireBalls.add(fb);
        }else if(shootDown){
        FireBalls fb = new FireBalls
            (playerPos.x, playerPos.y+50, dirX, dirY, bulletSpeed,2);
            fireBalls.add(fb);
        }else if(shootLeft){
        FireBalls fb = new FireBalls
            (playerPos.x, playerPos.y+50, dirX, dirY, bulletSpeed,3);
            fireBalls.add(fb);
        }else if(shootRight){
        FireBalls fb = new FireBalls
            (playerPos.x, playerPos.y+50, dirX, dirY, bulletSpeed,4);
            fireBalls.add(fb);
        }
        lastShootTime=millis();
      }
    }
  }
  
  
  
  
}
