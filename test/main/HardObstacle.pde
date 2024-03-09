public class HardObstacle extends Obstacle{
  int hardObsType;  
  public HardObstacle(float posX,float posY){
    super.pos = new PVector(posX,posY);
    super.type = 1 ;
    super.hardness = Integer.MAX_VALUE;
    super.radius = 45;
    hardObsType = (int)random(0,3);
  }
}
