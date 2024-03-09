public class Obstacle{
  int type;

  int hardness;//1-can be destroyed by 2 bullets, 2- cannot be destroy
  float radius;
  PVector obstaclePos; 
  
  public Obstacle() {
    this.obstaclePos = new PVector(115,110);
    this.radius = 40;
  }

}
