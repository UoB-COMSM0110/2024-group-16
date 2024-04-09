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
  
  
  public boolean checkKnightCollision(Knight player) {
    PVector fixedPos = new PVector(player.playerPos.x + 33, player.playerPos.y + 97);
    PVector fixedBlob = new PVector(this.enemyPos.x+radius,this.enemyPos.y+radius);
    float d = PVector.dist(fixedBlob, fixedPos);
    return d < radius + player.radius;
  }
  
  public void decHP(float damage){
     this.health = this.health - damage;
    }
    
  public float getHealth(){
    return this.health;
  }
  
}
