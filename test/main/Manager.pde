public class Manager{
  
  PFont mainMenuFont;
  PImage menuBg;
  PImage gameBg;
  PImage title;
  int buttonInterval = 50;
  //by default, use the main menu
  Scene curScene=Scene.MAIN_MENU;
  
  //Menu pointer
  MenuPointer menuPointer = new MenuPointer(wwidth,wheight);

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
    
    gameBg=loadImage("../images/Map/basement.png");
    gameBg.resize(width,height);
    
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
  
    drawButton(wwidth / 2 - 50 , wheight / 2 + buttonInterval , "Start");
    drawButton(wwidth / 2 - 50 , wheight / 2 + 3 * buttonInterval , "Options");
    drawButton(wwidth / 2 - 50 , wheight / 2 + 5 * buttonInterval , "Exit");
  }
 
  void drawGaming(){
    image(this.gameBg,0,0);
    
    if(player.movePlayer()){
      player.drawWalk();
    }else{
      player.drawIdle();
    }
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
