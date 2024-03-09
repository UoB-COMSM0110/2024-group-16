public class Manager{
  
  PFont mainMenuFont;
  PImage menuBg;
  PImage gameBg;
  PImage title;
  int buttonInterval = 50;
  
  int curRoom;
  //by default, use the main menu
  Scene curScene=Scene.MAIN_MENU;
  
  //Menu pointer
  MenuPointer menuPointer = new MenuPointer();

  //UI
  UI ui=new UI();
  
  //player
  Knight player = new Knight();
  
  //save and load some useful images
  MultiUseImages multi_use_images = new MultiUseImages();
  
  //save map info init-up-left-down-right
  Rooms[] rooms = new Rooms[5];
  
  //grass
  Grass grass = new Grass();
  
  public Manager(){
    
    mainMenuFont = createFont("../Fonts/TrajanPro-Bold.otf", 40); 
    
    menuBg=loadImage("../images/Menu/controller_prompt_bg.png");
    menuBg.resize(width,height);
    
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
    for(int i=0;i<4;i++){
      image(multi_use_images.grass[i],115,110);
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
                         
    // check collision of gass and fireball                         
    if(!player.fireBalls.isEmpty() && 
    player.fireBalls.get(player.fireBalls.size() - 1).checkObstacleCollision(grass)) {
      player.fireBalls.remove(player.fireBalls.size()-1);
    }
                             

  }
    
  public void drawOptions(){
    background(255);
    textAlign(CENTER, CENTER);
    fill(0);
    textSize(24);
    text("OPTIONS", width/2, height/2);
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
      player.setPosY(vertiMargin+6*obstacleWidth-player.getHeight()-10);
    }else if(rooms[curRoom].doors[2]!=null                
                 && playerPosX >=rooms[curRoom].doorsCoordinates[0] 
                 && playerPosX <= rooms[curRoom].doorsCoordinates[0]+110 
                 && playerPosY >= vertiMargin+6*obstacleWidth-player.getHeight()){
      if(curRoom == 0){
        curRoom=3;
      }else if(curRoom == 1){
        curRoom=0;
      }
      player.setPosY(vertiMargin+obstacleWidth+10);
    }
    
    
    
    
  }
}
