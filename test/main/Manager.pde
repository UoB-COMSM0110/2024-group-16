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
  
  //save map info
  Rooms[] rooms = new Rooms[5];
  
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
  
  void drawMainMenu(){
    image(menuBg,0,0);
    image(title,150,50);
    
    image(menuPointer.img[0],menuPointer.getPosXLeft(),menuPointer.getPosYLeft());
    image(menuPointer.img[1],menuPointer.getPosXRight(),menuPointer.getPosYRight());
  
    drawButton(width / 2 - 50 , height / 2 + buttonInterval , "Start");
    drawButton(width / 2 - 50 , height / 2 + 3 * buttonInterval , "Options");
    drawButton(width / 2 - 50 , height / 2 + 5 * buttonInterval , "Exit");
  }
 
  void drawGaming(){
    
    //roombg
    image(this.rooms[curRoom].roomBg,0,0);
    for(int i=0;i<4;i++){
      if(rooms[curRoom].doors[i]!=null){
        image(rooms[curRoom].doors[i],rooms[curRoom].doorsCoordinates[2*i],
                                      rooms[curRoom].doorsCoordinates[2*i+1]);
      }
    }
    
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
    
  void drawOptions(){
    background(255);
    textAlign(CENTER, CENTER);
    fill(0);
    textSize(24);
    text("OPTIONS", width/2, height/2);
  }
  
  void drawGameOver(){
    background(255);
    textAlign(CENTER, CENTER);
    fill(0);
    textSize(24);
    text("Game Over", width/2, height/2);
  }
    
  void drawButton(float x, float y, String label) {
    textAlign(CENTER, CENTER);
    fill(255);
    textFont(mainMenuFont); 
    text(label, x, y);
  } 
}
