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
    radius = 10;
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

  public boolean checkCollision(Enemy enemy) {
    float d = PVector.dist(this.pos, enemy.enemyPos);
    return d < radius + enemy.radius;
  }
}
