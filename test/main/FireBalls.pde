public class FireBalls{
  
  //Position and velocity
  PVector pos;
  PVector vel;
  
  public FireBalls(float x, float y, float dirX, float dirY, float speed) {
    pos = new PVector(x, y);
    vel = new PVector(dirX, dirY).normalize().mult(speed);
  }
  
  public void move(){
    pos.add(vel);
  }
}
