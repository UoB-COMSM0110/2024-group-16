public class Grass extends Obstacle{
    
  public Grass(float posX,float posY){
    super.pos = new PVector(posX,posY);
    super.type = 0 ;
    super.hardness = 2;
    super.radius = 40;
  }
}
