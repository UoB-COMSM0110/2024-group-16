public class Knight{
  
  //Position
  PVector playerPos;
  
  int maxHP;
  int HP;
  int MP;
  
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
  int knightHeight = 127;
  int knightWidth = 65;
  boolean moveUp, moveDown, moveLeft, moveRight;
  boolean shootUp, shootDown, shootLeft, shootRight;
  boolean isFaceToLeft;
  int currentFrame = 0; 
  int currentStatus = 0;
  int lastShootTime;
  
  
  public Knight(){
     playerPos = new PVector(700, 400);
     maxHP=6;
     HP=3;
     MP=2;
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
     radius = 40;
  }
  
  public void turnToLeft(){
    isFaceToLeft=true;
  }
  public void turnToRight(){
    isFaceToLeft=false;
  }
  
  public void drawIdle(){
    if(currentFrame%8==0){
      currentStatus = (currentStatus+1) % Idle.length;
    }
    if(!isFaceToLeft){
      pushMatrix();
      scale(-1, 1);
      image(Idle[currentStatus], -playerPos.x-Idle[currentStatus].width , playerPos.y);
      popMatrix();
    }else{
      image(Idle[currentStatus], playerPos.x , playerPos.y);
    }
    currentFrame++;
  }
  
  public void drawWalk(){
    if(currentStatus>=Walk.length){
      currentStatus=0;
    }
    if(currentFrame%8==0){
      currentStatus = (currentStatus+1) % Walk.length;
    }
    if(!isFaceToLeft){
      pushMatrix();
      scale(-1, 1);
      image(Walk[currentStatus], -playerPos.x-Walk[currentStatus].width , playerPos.y);
      popMatrix();
    }else{
      image(Walk[currentStatus], playerPos.x , playerPos.y);
    }
    currentFrame++;
  }
  
  
  public boolean movePlayer(){
    boolean isMove = false;
    if (moveUp) { //110+98-127
      if(playerPos.y >= vertiMargin + obstacleWidth - knightHeight){
        playerPos.y -= moveSpeed;
      }
      isMove = true;
    }
    if (moveDown) { //110+98*6-127
      if(playerPos.y <= vertiMargin + obstacleWidth*6 - knightHeight){
        playerPos.y += moveSpeed;
      }
      isMove = true;
    }
    if (moveLeft) {//115
      if(playerPos.x >= horiMargin){
        playerPos.x -= moveSpeed;
      }
      isMove = true;
    }
    if (moveRight) {//115+98*12-65=1226
      if(playerPos.x <= horiMargin + obstacleWidth*12 - knightWidth){
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
      if (fb.pos.x < 70 || fb.pos.x > width-100 ||
          fb.pos.y < 70 || fb.pos.y > height-100) {
        fireBalls.remove(i);
      }
    }
  }
  
  void drawFireBalls(PImage[] FireBallsUP,PImage[] FireBallsDOWN,
                     PImage[] FireBallsLEFT,PImage[] FireBallsRIGHT) {
    
    for (FireBalls fb : fireBalls) {
      if(fb.currentStatus > FireBallsUP.length){
        fb.resetCurStatus();
      }
      if(fb.currentFrame%5==0){
        fb.currentStatus = (currentStatus+1) % FireBallsUP.length;
      }
      switch(fb.direction){
        case 1:
          image(FireBallsUP[fb.currentStatus], fb.pos.x ,fb.pos.y );
          break;
        case 2:
          image(FireBallsDOWN[fb.currentStatus], fb.pos.x ,fb.pos.y );
          break;
        case 3:
          image(FireBallsLEFT[fb.currentStatus], fb.pos.x ,fb.pos.y );
          break;
        case 4:
          image(FireBallsRIGHT[fb.currentStatus], fb.pos.x ,fb.pos.y );
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
  
  public void cleanFireballs(){
    fireBalls.clear();    
  }
  
  // set & get func
  public int getmaxHP(){return maxHP;}
  public int getHP(){return HP;}
  public int getMP(){return MP;}
  public float getPosX(){return playerPos.x;}
  public float getPosY(){return playerPos.y;}
  public int getHeight(){return knightHeight;}
  public int getWidth(){return knightWidth;}
  
  
  public void setmaxHP(int maxHP){this.maxHP=maxHP;}
  public void setHP(int HP){this.HP=HP;}
  public void setMP(int MP){this.MP=MP;}
  public void setPosX(float posX){ playerPos.x=posX;}
  public void setPosY(float posY){ playerPos.y=posY;}
  
}
