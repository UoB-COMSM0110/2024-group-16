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
  
  
  //Auxiliary variable
  boolean moveUp, moveDown, moveLeft, moveRight; 
  int currentFrame = 0;
  int currentStatus = 0;
  int lastShootTime;
  
  public Enemy() {
    enemyPos = new PVector(900, 600);
    health = 10;
    radius = 20;
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
  
  //public boolean checkFireballCollision(FireBalls fireball) {
  //  PVector fixedPos = new PVector(enemy.enemyPos.x + 10, enemy.enemyPos.y + 10);
  //  float d = PVector.dist(this.pos, fixedPos);
  //  return d < radius + enemy.radius;
  //}

//  public void takeDamage(float damage) {
//  health -= damage;
//  if (health <= 0) {
//    parent.println("Enemy defeated!");
//  }
//}
}
