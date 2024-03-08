public class Enemy{
  
  //Position
  PVector EnemyPos;
  
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
  PImage enemiesWalk=new PImage[5];
  
  //Auxiliary variable
  boolean moveUp, moveDown, moveLeft, moveRight; 
  int currentFrame = 0;
  int currentstatus = 0;
  int lastShootTime;
  
  public void Enemy(float x, float y, float h) {
    EnemyPos = new PVector(x, y);
    enemies = loadImage("../images/Enemies/Crawlid.png")
    health = h;
    radius = 20;
  }
  
  
  public void drawEnemy(){
    if(currentFrame%8==0){
      currentstatus = (currentstatus+1) % enemies.length;
    }
    image(enemies, EnemyPos.x , EnemyPos.y);
    currentFrame++;
  }
  
  // public void drawWalk(){
  //   if(currentstatus>=enemiesWalk.length){
  //     currentstatus=0;
  //   }
  //   if(currentFrame%8==0){
  //     currentstatus = (currentstatus+1) % enemiesWalk.length;
  //   }
  //   image(Walk[currentstatus], EnemyPos.x , EnemyPos.y);
  //   currentFrame++;
  // }
  
  
  
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

  public void takeDamage(float damage) {
  health -= damage;
  if (health <= 0) {
    // 敌人被击败
    parent.println("Enemy defeated!");
  }
}
}
