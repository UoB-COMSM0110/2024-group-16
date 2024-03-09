public class Rooms{
    PImage roomBg;
    PImage[] doors= new PImage[4];
    PImage lockedDoor;
    
    
    int[] doorsCoordinates = {650,0,width-115,340,650,height-110,0,340};
    
    //save obstacle
    ArrayList<Obstacle> obs = new ArrayList<>();
    
    
    public Rooms (int roometype){
      
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
          doors[2].resize(60,110);
          break;
        //common room
        case 2:
          roomBg=loadImage("../images/Map/basement.png");
          doors[0]=null;
          doors[1]=null;
          doors[2]=null;
          doors[3]=loadImage("../images/Map/commondoor_left.png");
          doors[3].resize(115,60);
          break;
        //other use: to be update
        case 3:
          roomBg=loadImage("../images/Map/basement.png");
          doors[0]=loadImage("../images/Map/commondoor_up.png");
          doors[1]=null;
          doors[2]=null;
          doors[3]=null;
          doors[0].resize(60,110);
          break;
        //Boos room
        case 4:
          roomBg=loadImage("../images/Map/basement.png");
          doors[0]=null;
          doors[1]=loadImage("../images/Map/bossroom_door_right.png");
          doors[2]=null;
          doors[3]=null;
          doors[1].resize(115,60);
          break;
      }
      roomBg.resize(width,height);
      
      //normal enemy room
      if(roometype==2||roometype==3){
        //create obstacle & enemies
         
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
