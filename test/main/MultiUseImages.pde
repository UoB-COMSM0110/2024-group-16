public class MultiUseImages{
  
  PImage[] fireBalls_left = new PImage[7];
  PImage[] fireBalls_up = new PImage[7];
  PImage[] fireBalls_down = new PImage[7];
  PImage[] fireBalls_right = new PImage[7];
  PImage[] grass = new PImage[4];
  PImage[] hardObstacle = new PImage[3];
  
  
  public MultiUseImages(){
    for(int i=0;i<fireBalls_up.length;i++){
      fireBalls_up[i]=loadImage("../images/Knight/Fireballs/fireball_up_"+i+".png");
      fireBalls_up[i].resize(50,80);
      
      fireBalls_down[i]=loadImage("../images/Knight/Fireballs/fireball_down_"+i+".png");
      fireBalls_down[i].resize(50,80);
      
      fireBalls_left[i]=loadImage("../images/Knight/Fireballs/fireball_left_"+i+".png");
      fireBalls_left[i].resize(80,50);
      
      fireBalls_right[i]=loadImage("../images/Knight/Fireballs/fireball_right_"+i+".png");
      fireBalls_right[i].resize(80,50);
    }
    
    for(int i=0;i<grass.length;i++){
      grass[i]=loadImage("../images/Obstacle/Grass/grass_0"+i+".png");
      grass[i].resize(obstacleWidth,obstacleWidth);
    }
    
    for(int i=0;i<hardObstacle.length;i++){
      hardObstacle[i]=loadImage("../images/Obstacle/HardObstacle/hardObstacle_0"+i+".png");
      hardObstacle[i].resize(obstacleWidth,obstacleWidth);
    }

  }

}
