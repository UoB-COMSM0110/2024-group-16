public class Snowflake {
  PVector pos; 
  PVector vel; 
  
  Snowflake() {
    pos = new PVector(random(width), random(height)); 
    vel = new PVector(random(0, 1), random(0, 1)); 
  }
  

  void update() {
    pos.add(vel); 
    if (pos.y > height || pos.x > width) {
      pos.x = random(width);
      pos.y = random(height);
    }
  }
  
  void display() {
    fill(255); 
    noStroke();
    ellipse(pos.x, pos.y, 8, 8); 
  }
}
