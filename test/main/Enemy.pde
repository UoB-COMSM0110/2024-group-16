public class Enemy{
  //Position
  PVector enemyPos;
  PVector enemyVel;
  
  //Character properties
  float moveSpeed;
  float attack;
  float health;
  float radius;
  int type;

  //Auxiliary variable 
  int curFrame = 0;
  int curStatus = 0;
  int lastShootTime;
  
  public void subMoveCrawlid(PVector obstacle){
        PVector temp = new PVector(obstacle.x+50,obstacle.y+50);
        enemyVel = PVector.sub(temp,enemyPos).normalize().mult(1.2*moveSpeed);
        enemyPos = enemyPos.sub(enemyVel);
  }
  
  
  public boolean checkKnightCollision(Knight player) {
    PVector fixedPos = new PVector(player.playerPos.x + 33, player.playerPos.y + 97);
    PVector fixedBlob = new PVector(this.enemyPos.x+radius,this.enemyPos.y+radius);
    float d = PVector.dist(fixedBlob, fixedPos);
    return d < radius + player.radius;
  }
  
  public boolean checkObstacleCollision(Obstacle obs) {
    PVector fixedPos = new PVector(obs.pos.x + 33, obs.pos.y + 97);
    PVector fixedBlob = new PVector(this.enemyPos.x+radius,this.enemyPos.y+radius);
    float d = PVector.dist(fixedBlob, fixedPos);
    return d < radius + obs.radius;
  }
  
  public void decHP(float damage){
     this.health = this.health - damage;
    }
    
  public float getHealth(){
    return this.health;
  }
  
}
