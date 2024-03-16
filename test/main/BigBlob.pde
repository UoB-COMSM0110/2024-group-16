public class BigBlob{
  
  //Position and velocity
  PVector pos;
  PVector vel;
  float radius;
  int currentFrame = 0; 
  int currentStatus = 0;

  
  public BigBlob(PVector pos, PVector dir, float speed) {
    this.pos = new PVector(pos.x,pos.y);
    vel = dir.normalize().mult(speed);
    radius = 20;
  }
  public void move(){
    this.pos.add(this.vel);
  }
  
  public void resetCurStatus(){
    currentStatus=0;
  }
  
  public void incCurFrame(){
    currentFrame++;
  }

  public boolean checkKnightCollision(Knight player) {
    PVector fixedPos = new PVector(player.playerPos.x + 10, player.playerPos.y + 10);
    float d = PVector.dist(this.pos, fixedPos);
    return d < radius + player.radius;
  }
}
