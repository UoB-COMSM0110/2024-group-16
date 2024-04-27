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
    radius = 40;
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
    PVector fixedPos = new PVector(player.playerPos.x + 33, player.playerPos.y + 97);
    PVector fixedBlob = new PVector(this.pos.x+40,this.pos.y+40);
    float d = PVector.dist(fixedBlob, fixedPos);
    return d < radius + player.radius;
  }
}
