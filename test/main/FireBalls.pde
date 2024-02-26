public class FireBalls{
  
  //Position and velocity
  PVector pos;
  PVector vel;
  
  int direction;//1-UP,2-DOWN,3-LEFT,4-RIGHT
  int currentFrame = 0; 
  int currentstatus = 0;
  
  public FireBalls(float x, float y, float dirX, float dirY, float speed,int dir) {
    pos = new PVector(x, y);
    vel = new PVector(dirX, dirY).normalize().mult(speed);
    direction=dir;
  }
  
  public void move(){
    pos.add(vel);
  }
  
  public void resetCurStatus(){
    currentstatus=0;
  }
  
  public void incCurFrame(){
    currentFrame++;
  }
}
