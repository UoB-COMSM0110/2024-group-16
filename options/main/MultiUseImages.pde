public class MultiUseImages{
  
  PImage[] fireBalls_left = new PImage[7];
  PImage[] fireBalls_up = new PImage[7];
  PImage[] fireBalls_down = new PImage[7];
  PImage[] fireBalls_right = new PImage[7];
  PImage[] grass = new PImage[4];


  PImage[] crawlid = new PImage[13];
  PImage[] primal_aspid = new PImage[13];
  PImage[] zombie_fly = new PImage[7];
  PImage[] hardObstacle = new PImage[3];
  PImage[] small_coin = new PImage[5];
  PImage[] silver_coin = new PImage[4];
  PImage[] gold_coin = new PImage[5];
  PImage[] bling_coin = new PImage[4];

  
  
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
  }


    
    for(int i=0;i<hardObstacle.length;i++){
      hardObstacle[i]=loadImage("../images/Obstacle/HardObstacle/hardObstacle_0"+i+".png");
      hardObstacle[i].resize(obstacleWidth,obstacleWidth);
    }

    for(int i=0;i<grass.length;i++){
      grass[i]=loadImage("../images/Obstacle/Grass/grass_"+convertNumber(i)+".png");
      grass[i].resize(obstacleWidth,obstacleWidth);
    }
    
    for(int i=0;i<crawlid.length;i++){
      crawlid[i]=loadImage("../images/Enemies/Crawlid_"+convertNumber(i)+".png");
    }
    
    for(int i=0;i<primal_aspid.length;i++){
      primal_aspid[i]=loadImage("../images/Enemies/Primal_Aspid_"+convertNumber(i)+".png");
    }
    
    for(int i=0;i<zombie_fly.length;i++){
      primal_aspid[i]=loadImage("../images/Enemies/Zombie_Fly_"+convertNumber(i)+".png");
    }
    
    for(int i=0;i<small_coin.length;i++){
      small_coin[i]=loadImage("../images/HUD/Small_Coin_"+convertNumber(i)+".png");
    }
    for(int i=0;i<silver_coin.length;i++){
      silver_coin[i]=loadImage("../images/HUD/Silver_Coin_"+convertNumber(i)+".png");
    }
    for(int i=0;i<gold_coin.length;i++){
      gold_coin[i]=loadImage("../images/HUD/Gold_Coin_"+convertNumber(i)+".png");
    }
    for(int i=0;i<bling_coin.length;i++){
      bling_coin[i]=loadImage("../images/HUD/Bling_Coin_"+convertNumber(i)+".png");
    }
 
  }
  
  public String convertNumber(int i){
    String prefix= i<10 ?"0" :"";
    return prefix+String.valueOf(i);
  }

}
