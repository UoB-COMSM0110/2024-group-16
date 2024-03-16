public class Rooms{
    PImage roomBg;
    PImage[] doors= new PImage[4];
    PImage lockedDoor;
    Boss soulMaster=null;
    
    int[] doorsCoordinates = {650,0,width-115,340,650,height-110,0,340};
    
    //save obstacle
    ArrayList<Obstacle> obs = new ArrayList<>();
    int[][] map = new int[12][6];
    
    public Rooms (int roometype){
      
      map[5][1]=1;
      map[6][1]=1;
      map[1][2]=1;
      map[1][3]=1;
      switch(roometype){
        //initial room
        case 0:
          roomBg=loadImage("../images/Map/initialbasement.png");
          //four doors
          doors[0]=loadImage("../images/Map/itemroom_door_up.png");
          doors[1]=loadImage("../images/Map/commondoor_right.png");
          doors[2]=loadImage("../images/Map/commondoor_down.png");
          doors[3]=loadImage("../images/Map/bossroom_door_left.png");
          doors[0].resize(80,110);
          doors[1].resize(115,80);
          doors[2].resize(80,110);
          doors[3].resize(115,80);
          break;
        //item room
        case 1:
          roomBg=loadImage("../images/Map/basement.png");
          doors[0]=null;
          doors[1]=null;
          doors[2]=loadImage("../images/Map/itemroom_door_down.png");
          doors[3]=null;
          doors[2].resize(80,110);
          break;
        //common room
        case 2:
          roomBg=loadImage("../images/Map/basement.png");
          doors[0]=null;
          doors[1]=null;
          doors[2]=null;
          doors[3]=loadImage("../images/Map/commondoor_left.png");
          doors[3].resize(115,80);
          break;
        //other use: to be update
        case 3:
          roomBg=loadImage("../images/Map/basement.png");
          doors[0]=loadImage("../images/Map/commondoor_up.png");
          doors[1]=null;
          doors[2]=null;
          doors[3]=null;
          doors[0].resize(80,110);
          break;
        //Boos room
        case 4:
          soulMaster = new Boss();
          roomBg=loadImage("../images/Map/basement.png");
          doors[0]=null;
          doors[1]=loadImage("../images/Map/bossroom_door_right.png");
          doors[2]=null;
          doors[3]=null;
          doors[1].resize(115,80);
          break;
      }
      roomBg.resize(width,height);
      
      //normal enemy room
      if(roometype==2 || roometype==3){
        //create obstacle & enemies
        int times = (int)random(1,30);
        while(times>0){
          obs=randomCreateObstacle(obs,map);
          times--;
        }
        
      }
    }
    
   public ArrayList<Obstacle> randomCreateObstacle(ArrayList<Obstacle> obs,int[][] map){
      int x = (int)random(1,11);
      int y = (int)random(1,5);
      
      
      //have had obstacle,get a new number
      while(map[x][y]==1){
        x = (int)random(1,11);
        y = (int)random(1,5);
      }
      
      
      switch((int)random(0,2)){
        case 0:
          Obstacle grass = new Grass(obstacleWidth*x+horiMargin,obstacleWidth*y+vertiMargin);
          obs.add(grass);
          map[x][y]=1;
          break;
        case 1:
          Obstacle hardObs = new HardObstacle(obstacleWidth*x+horiMargin,obstacleWidth*y+vertiMargin);
          obs.add(hardObs);
          map[x][y]=1;
          break;
      }
    
      return obs;
    }
    
    
    public void drawRoom(){
      image(this.roomBg,0,0);
      for(int i=0;i<4;i++){
        if(this.doors[i]!=null){
          image(this.doors[i],this.doorsCoordinates[2*i],this.doorsCoordinates[2*i+1]);
        }
      }
    }
   
}
