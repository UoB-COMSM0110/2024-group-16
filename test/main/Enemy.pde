public class Enemy{
  
  //Position
  PVector enemyPos;
  
  //Character properties
  float moveSpeed;
  float attack;
  float bulletSpeed;
  float shootSpeed;// 1 sec x bullets
  float health;
  float radius;
  
  //FireBalls
  ArrayList<FireBalls> fireBalls = new ArrayList<FireBalls>();
  
  //Animation
  PImage enemies;
  //PImage enemiesWalk=new PImage[5];
  
  //Auxiliary variable
  boolean moveUp, moveDown, moveLeft, moveRight; 
  int currentFrame = 0;
  int currentStatus = 0;
  int lastShootTime;
  
  public Enemy() {
    enemyPos = new PVector(900, 600);
    enemies = loadImage("../images/Enemies/Crawlid_0.png");
    health = 10;
    radius = 20;
  }
  
  
  public void drawEnemy(){
    //if(currentFrame%8==0){
    //  currentstatus = currentFrame;
    //}
    image(enemies, enemyPos.x , enemyPos.y);
    currentFrame++;
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

}
