public class Bomb{
  PVector pos;
  int size; 
  int timer;   
  boolean exploded;
  
  
  
  Bomb(float x, float y, int size) {
    pos = new PVector(x, y);
    this.size = size;
    timer = 0;
    exploded = false;
  }
  
  void update() {
    timer++;     
    if (timer >= 180) {
      exploded = true;
    }
  }
}  
