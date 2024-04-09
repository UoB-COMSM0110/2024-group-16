public class Rooms{
    PImage roomBg;
    PImage[] doors= new PImage[4];
    PImage lockedDoor;
    Boss soulMaster=null;
    
    int[] doorsCoordinates = {650,0,width-115,340,650,height-110,0,340};
    
    //save obstacle
    ArrayList<Obstacle> obs = new ArrayList<>();
    ArrayList<Enemy> emy = new ArrayList<>();
    int[][] map = new int[12][6];
    boolean hasBomb;
    
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
          hasBomb = false;
          break;
        //item room
        case 1:
          roomBg=loadImage("../images/Map/basement.png");
          doors[0]=null;
          doors[1]=null;
          doors[2]=loadImage("../images/Map/itemroom_door_down.png");
          doors[3]=null;
          doors[2].resize(80,110);
          hasBomb = false;
          break;
        //common room
        case 2:
          roomBg=loadImage("../images/Map/basement.png");
          doors[0]=null;
          doors[1]=null;
          doors[2]=null;
          doors[3]=loadImage("../images/Map/commondoor_left.png");
          doors[3].resize(115,80);
          hasBomb = true;
          break;
        //other use: to be update
        case 3:
          roomBg=loadImage("../images/Map/basement.png");
          doors[0]=loadImage("../images/Map/commondoor_up.png");
          doors[1]=null;
          doors[2]=null;
          doors[3]=null;
          doors[0].resize(80,110);
          hasBomb = true;
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
          hasBomb = false;
          break;
      }
      roomBg.resize(width,height);
      
      //normal enemy room
      if(roometype==2 || roometype==3){
        //create obstacle & enemies
        int timesObs = (int)random(5,10);
        int timesEmy = (int)random(2,8);
        System.out.println("emy:"+timesEmy);
        while(timesObs>0){
          randomCreateObstacle(map);
          
          timesObs--;
        }
        while(timesEmy>0){
          randomCreateEnemies(map);
          timesEmy--;
        }

      }
    }
    
    public void randomCreateObstacle(int[][] map){
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
    }

    public void randomCreateEnemies(int[][] map){
      int x = (int)random(1,12);
      int y = (int)random(1,5);
      
      //have had allocated, get a new number
      while(map[x][y]==1){
        x = (int)random(1,12);
        y = (int)random(1,5);
      }

      switch((int)random(0,2)){
        case 0:
          Enemy crawlid = new Crawlid(obstacleWidth*x+horiMargin,obstacleWidth*y+vertiMargin);
          emy.add(crawlid);
          map[x][y]=1;
          break;
        case 1:
          Enemy mosquito = new Mosquito(obstacleWidth*x+horiMargin,obstacleWidth*y+vertiMargin);
          emy.add(mosquito);
          map[x][y]=1;
          break;
      }
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
