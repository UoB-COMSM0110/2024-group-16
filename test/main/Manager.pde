public class Manager{
  PImage gameBg;
  
  
    
  //by default, use the main menu
  Scene curScene=Scene.MAIN_MENU;
    
  MenuPointer menuPointer = new MenuPointer(wwidth,wheight);
  Knight player = new Knight();
  MultiUseImages multi_use_images = new MultiUseImages();
   
   
  void drawMap() {
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
    player.drawFireBalls(multi_use_images.fireBalls[0]);
    
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
    textFont(customFont); 
    text(label, x, y);
  } 
}
