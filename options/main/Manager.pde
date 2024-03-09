public class Manager{
  
  PFont mainMenuFont;
  PImage menuBg;
  PImage gameBg;
  PImage optionBg;
  PImage title;
  int buttonInterval = 50;
  int smallOffset = 20;
  
  
  int curRoom;
  //by default, use the main menu
  Scene curScene=Scene.MAIN_MENU;
  Scene preScene=Scene.MAIN_MENU;
  
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
    println("In the drawmMainMenu");
    image(menuBg,0,0);
    image(title,150,50);
    
    image(menuPointer.img[0],menuPointer.getPosXLeft(),menuPointer.getPosYLeft());
    image(menuPointer.img[1],menuPointer.getPosXRight(),menuPointer.getPosYRight());
  
    drawButton(width / 2 - 50 , height / 2 + buttonInterval , "Start");
    drawButton(width / 2 - 50 , height / 2 + 3 * buttonInterval , "Options");
    drawButton(width / 2 - 50 , height / 2 + 5 * buttonInterval , "Exit");
  }
 
  public void drawGaming(){
    println("In the drawGaming");
    
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
    for(int i=0;i<4;i++){
      image(multi_use_images.grass[i],115+i*obstacleWidth,110+i*obstacleWidth);
    }
        
    
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

  }
    
  public void drawOptions(){
    println("In the drawOptions");
    image(optionBg,0,0);
    image(optionPointer.img,optionPointer.getPosX(),optionPointer.getPosY());
    
    drawButton(width / 2 - 50 , height / 4 + smallOffset , "Sound Settings");
    drawButton(width / 2 - 50 , height / 4 + 1*buttonInterval + smallOffset, "KeyBoard Settings");
    drawButton(width / 2 - 50 , height / 4 + 2*buttonInterval + smallOffset, "Languages Settings");
    drawButton(width / 2 - 50 , height / 4 + 3*buttonInterval + smallOffset, "Back to Game");
    drawButton(width / 2 - 50 , height / 4 + 4*buttonInterval + smallOffset, "Back to Menu");
    drawButton(width / 2 - 50 , height / 4 + 5*buttonInterval + smallOffset, "Exit");
    
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
                 && playerPosX <= rooms[curRoom].doorsCoordinates[0]+110 
                 && playerPosY <= horiMargin){
      //the door exists 
      if(curRoom == 0){
        curRoom=1;
      }else if(curRoom == 3){
        curRoom=0;
      }
      //update the pos of knight
      player.setPosY(vertiMargin+6*obstacleWidth-player.getHeight()-imageShift);
      
    //bottom door
    }else if(rooms[curRoom].doors[2]!=null                
                 && playerPosX >=rooms[curRoom].doorsCoordinates[0] 
                 && playerPosX <= rooms[curRoom].doorsCoordinates[0]+110 
                 && playerPosY >= vertiMargin+6*obstacleWidth-player.getHeight()){
      if(curRoom == 0){
        curRoom=3;
      }else if(curRoom == 1){
        curRoom=0;
      }
      //update the pos of knight
      player.setPosY(vertiMargin+obstacleWidth+imageShift);
      
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
      player.setPosX(horiMargin+12*obstacleWidth-player.getWidth()-imageShift);
     
     
     }
      
  }
}
