public class Manager{
  
  PFont mainMenuFont;
  PImage menuBg;
  PImage gameBg;
  PImage optionBg;
  PImage title;
  int buttonInterval = 50;
  
  
  int curRoom;
  //by default, use the main menu
  Scene curScene=Scene.MAIN_MENU;
  Scene preScene=Scene.MAIN_MENU;
  //Option curOption=Option.OPTION_MENU;
  
  //Menu pointer
  MenuPointer menuPointer = new MenuPointer();
  OptionPointer optionPointer = new OptionPointer();

  //UI
  UI ui=new UI();
  
  //player
  Knight player = new Knight();
  
  //save and load some useful images
  MultiUseImages multi_use_images = new MultiUseImages();
  
  //save map info init-up-left-down-right
  Rooms[] rooms = new Rooms[5];
  
  
  
  public Manager(){
    
    mainMenuFont = createFont("../Fonts/TrajanPro-Bold.otf", 40); 
    
    menuBg=loadImage("../images/Menu/controller_prompt_bg.png");
    menuBg.resize(width,height);
    optionBg=loadImage("../images/Menu/menu_option_bg.png");
    optionBg.resize(width,height);
    title=loadImage("../images/Menu/vheart_title.png");  
    title.resize(1000,300);
    
    for(int i=0;i<5;i++){
      rooms[i]=new Rooms(i);
    }
    
    curRoom=0;
  }
  
  
  
  public void drawMap() {
    switch(curScene){
      case MAIN_MENU:
        drawMainMenu();
        break;
      case GAMING:
        drawGaming();
        break;
      case OPTIONS:
        drawOptions(); 
        break;
     case GAME_OVER:
         drawGameOver();
         break;
      }
  }
  
  public void drawMainMenu(){
    image(menuBg,0,0);
    image(title,150,50);
    
    image(menuPointer.img[0],menuPointer.getPosXLeft(),menuPointer.getPosYLeft());
    image(menuPointer.img[1],menuPointer.getPosXRight(),menuPointer.getPosYRight());
  
    drawButton(width / 2 - 50 , height / 2 + buttonInterval , "Start");
    drawButton(width / 2 - 50 , height / 2 + 3 * buttonInterval , "Options");
    drawButton(width / 2 - 50 , height / 2 + 5 * buttonInterval , "Exit");
  }
 
  public void drawGaming(){
    
    //change room
    changeRoom(player.getPosX(),player.getPosY());
    
    
    //roombg & door
    
    this.rooms[curRoom].drawRoom();
    
    //UI
    image(ui.HUD_main,20,20);
    for(int i=0;i<player.getmaxHP();i++){
      image(ui.HUD_emptyHP,120+40*i,70);
    }
    
    for(int i=0;i<player.getHP();i++){
      image(ui.HUD_HP,119+40*i,70);
    }
    
    //obstacle or items or drops
    drawObstacle(rooms[curRoom].obs);
        
    
    //player
    if(player.movePlayer()){
      player.drawWalk();
    }else{
      player.drawIdle();
    }
    
    
    //fireballs
    player.moveFireBalls();
    player.drawFireBalls(multi_use_images.fireBalls_up,
                         multi_use_images.fireBalls_down,
                         multi_use_images.fireBalls_left,
                         multi_use_images.fireBalls_right);
                         
     // collision of grass and fireball
     for(Obstacle temp:rooms[curRoom].obs){
       if(!player.fireBalls.isEmpty() && 
      player.fireBalls.get(player.fireBalls.size() - 1).checkObstacleCollision(temp)) {
      player.fireBalls.remove(player.fireBalls.size()-1);
     
     }
     
     // collision of grass and knight
       if(player.checkObstacleCollision(temp)) {
         if (player.moveUp) { 
          player.playerPos.y += player.moveSpeed;
        }
         if (player.moveDown) { 
         player.playerPos.y -= player.moveSpeed;
        }
         if (player.moveLeft) {
         player.playerPos.x += player.moveSpeed;
        }
         if (player.moveRight) {
         player.playerPos.x -= player.moveSpeed;
        }
       }
     
     }

  }
    
  public void drawOptions(){
    image(optionBg,0,0);
    image(optionPointer.img,optionPointer.getPosX(),optionPointer.getPosY());
    println(optionPointer.curOption);
    optionPointer.changeOption();
    // In the options using state Machine to change the bottons
  }
  
  public void drawGameOver(){
    background(255);
    textAlign(CENTER, CENTER);
    fill(0);
    textSize(24);
    text("Game Over", width/2, height/2);
  }
  
  
    
  public void drawButton(float x, float y, String label) {
    textAlign(CENTER, CENTER);
    fill(255);
    textFont(mainMenuFont); 
    text(label, x, y);
  } 
  
  public void changeRoom(float playerPosX,float playerPosY){
        
    //top door
    if(rooms[curRoom].doors[0]!=null                
                 && playerPosX >= rooms[curRoom].doorsCoordinates[0] 
                 && playerPosX <= rooms[curRoom].doorsCoordinates[0]+80 
                 && playerPosY <= horiMargin - player.getHeight()+obstacleWidth){
      //the door exists 
      if(curRoom == 0){
        curRoom=1;
      }else if(curRoom == 3){
        curRoom=0;
      }
      player.cleanFireballs();
      //update the pos of knight
      player.setPosY(vertiMargin+6*obstacleWidth-player.getHeight()-imageShift);
      
    //bottom door
    }else if(rooms[curRoom].doors[2]!=null                
                 && playerPosX >=rooms[curRoom].doorsCoordinates[0]-10 
                 && playerPosX <= rooms[curRoom].doorsCoordinates[0]+70 
                 && playerPosY >= vertiMargin+6*obstacleWidth-player.getHeight()){
      if(curRoom == 0){
        curRoom=3;
      }else if(curRoom == 1){
        curRoom=0;
      }
      player.cleanFireballs();
      //update the pos of knight
      player.setPosY(vertiMargin-imageShift);
      
     //right door
     }else if(rooms[curRoom].doors[1]!=null
                 && player.getPosX() >= horiMargin+12*obstacleWidth-player.getWidth()
                 && player.getPosY() >= rooms[curRoom].doorsCoordinates[3]-2*imageShift
                 && player.getPosY() <= rooms[curRoom].doorsCoordinates[3]+80-2*imageShift){
      if(curRoom == 0){
        curRoom=2;
      }else if(curRoom == 4){
        curRoom=0;
      }
      player.cleanFireballs();
      player.setPosX(horiMargin+imageShift);
      
     //left door
     }else if(rooms[curRoom].doors[3]!=null
                 && player.getPosX() <= horiMargin +imageShift
                 && player.getPosY() >= rooms[curRoom].doorsCoordinates[3]-2*imageShift
                 && player.getPosY() <= rooms[curRoom].doorsCoordinates[3]+80-2* imageShift){
      if(curRoom == 0){
        curRoom=4;
      }else if(curRoom == 2){
        curRoom=0;
      }
      player.cleanFireballs();
      player.setPosX(horiMargin+12*obstacleWidth-player.getWidth()-imageShift);
     }
     
  }
  
  
  public void drawObstacle(ArrayList<Obstacle> obs){
   for(Obstacle temp : obs){
     //this is grass
     if(temp.type == 0){
       Grass grass = (Grass)temp;
       image(multi_use_images.grass[grass.curStatus],temp.pos.x,temp.pos.y);
       if(grass.curFrame%35==0){
         grass.curStatus=(grass.curStatus+1)%4;
       }
       grass.curFrame++;       
     }else if(temp.type == 1){
       HardObstacle hard = (HardObstacle)temp;
       image(multi_use_images.hardObstacle[hard.hardObsType],temp.pos.x,temp.pos.y);
     }
    }
  }  
}
