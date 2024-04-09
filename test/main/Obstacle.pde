public class Obstacle{
  int type;
  float radius;
  int hardness;//one bullet -> - one hardness
  
  PVector pos;  //position
  
  public int getHardness(){
    return this.hardness;
  }
}
