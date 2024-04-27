public class FireBalls{
  
  //Position and velocity
  PVector pos;
  PVector vel;
  float radius;
  int direction;//1-UP,2-DOWN,3-LEFT,4-RIGHT
  int currentFrame = 0; 
  int currentStatus = 0;
  
  public FireBalls(float x, float y, float dirX, float dirY, float speed,int dir) {
    pos = new PVector(x, y);
    vel = new PVector(dirX, dirY).normalize().mult(speed);
    direction=dir;
    radius = 20;
  }
  
  public void move(){
    pos.add(vel);
  }
  
  public void resetCurStatus(){
    currentStatus=0;
  }
  
  public void incCurFrame(){
    currentFrame++;
  }

  public boolean checkEnemyCollision(Enemy enemy) {
    PVector fixedPos = new PVector(enemy.enemyPos.x + enemy.radius, enemy.enemyPos.y + enemy.radius);
    PVector fixedBullet ;
    if(direction %2 == 0){
      fixedBullet =  new PVector(this.pos.x + 40, this.pos.y + 25);
    }else{
      fixedBullet =  new PVector(this.pos.x + 25, this.pos.y + 40);
    }
    float d = PVector.dist(fixedBullet, fixedPos);
    return d < radius + enemy.radius;
  }
  
  public boolean checkBossCollision(Boss boss){
    PVector fixedBullet ;
    if(direction %2 == 0){
      fixedBullet =  new PVector(this.pos.x + 40, this.pos.y + 25);
    }else{
      fixedBullet =  new PVector(this.pos.x + 25, this.pos.y + 40);
    }
    PVector fixedBossPos = new PVector(boss.pos.x+180,boss.pos.y+180);
    float d = PVector.dist(fixedBullet, fixedBossPos);
    return d < radius + boss.radius;
  }
  
  public boolean checkObstacleCollision(Obstacle obstacle) {
    PVector fixedPos = new PVector(obstacle.pos.x + 50, obstacle.pos.y + 50);
    PVector fixedBullet ;
    if(direction %2 == 0){
      fixedBullet =  new PVector(this.pos.x + 40, this.pos.y + 25);
    }else{
      fixedBullet =  new PVector(this.pos.x + 25, this.pos.y + 40);
    }
    
    float d = PVector.dist(fixedBullet, fixedPos);
    return d < radius + obstacle.radius;
  }

}
