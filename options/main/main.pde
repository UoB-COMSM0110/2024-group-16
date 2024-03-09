Manager newManager;

int obstacleWidth = 98;
int vertiMargin = 110;
int horiMargin = 115;
int imageShift = 20;

void setup() {
  size(1400, 800);
  newManager = new Manager();
}

void draw() {
  newManager.drawMap();
}

void keyPressed(){
   // Forbbiden the ESC using  quit to exit the processing
   if(key==27){
    key=0;
  }
  //in the main menu
  if( newManager.curScene == Scene.MAIN_MENU ){//in the main menu
    // reset the cursor postion and status
    newManager.optionPointer.setStatus(0);
    image(newManager.optionPointer.img,newManager.optionPointer.getPosX(),newManager.optionPointer.getPosY());
    newManager.preScene = Scene.MAIN_MENU;
    if(keyCode == ESC){
      exit();
    }
    if(keyCode == UP){
      newManager.menuPointer.movePointers(1);
    }else if(keyCode == DOWN){
      newManager.menuPointer.movePointers(-1);
    }else if(keyCode == 32){
      //turn to other scene
      if(newManager.menuPointer.getStatus()==0){
        newManager.curScene=Scene.GAMING;
      }else if(newManager.menuPointer.getStatus()==1){
        newManager.curScene=Scene.OPTIONS;
      }else if(newManager.menuPointer.getStatus()==2){
        exit();
      }
    }
  }
  
  //in the game
  if(newManager.curScene==Scene.GAMING){
    newManager.preScene = Scene.GAMING;
    if (key == 'w') {
      newManager.player.moveUp = true;
    }
    if (key == 's') {
      newManager.player.moveDown = true;
    }
    if (key == 'a') {
      newManager.player.moveLeft = true;
      newManager.player.turnToLeft();
    }
    if (key == 'd') {
      newManager.player.moveRight = true;
      newManager.player.turnToRight();
    }
    if (keyCode == UP || keyCode == DOWN || keyCode == LEFT || keyCode == RIGHT) {
      newManager.player.shootFireBalls(keyCode);
    } 
  }
  //other keyboard activities
  // in the options
  if(newManager.curScene != Scene.MAIN_MENU && keyCode == ESC ){
     newManager.curScene = Scene.OPTIONS; 
  }
  if(newManager.curScene == Scene.OPTIONS){
    if(keyCode == UP){
      newManager.optionPointer.movePointers(1);
    }else if(keyCode == DOWN){
      newManager.optionPointer.movePointers(-1);
    }else if(keyCode == 32){
      //turn to other scene
      if(newManager.optionPointer.getStatus()==0){
        // add music setting
      }else if(newManager.optionPointer.getStatus()==1){
        // add keyboard setting
      }else if(newManager.optionPointer.getStatus()==2){
        // add language setting
      }else if(newManager.optionPointer.getStatus()==3){ 
        if(newManager.preScene == Scene.GAMING) {     
          newManager.curScene=Scene.GAMING; 
        }
      }else if(newManager.optionPointer.getStatus()==4){
        if(newManager.preScene == Scene.MAIN_MENU) {     
          //newManager.curScene=Scene.GAMING; 
          newManager.curScene=Scene.MAIN_MENU;
        }else if(newManager.preScene == Scene.GAMING) {     
          //newManager.curScene=Scene.GAMING; 
          newManager.curScene=Scene.MAIN_MENU;
        }
      }else if(newManager.optionPointer.getStatus()==5){
        exit();
      }
    }
  }
}

void keyReleased() {
  if (key == 'w') {
    newManager.player.moveUp = false;
  }
  if (key == 's') {
    newManager.player.moveDown = false;
  }
  if (key == 'a') {
    newManager.player.moveLeft = false;
  }
  if (key == 'd') {
    newManager.player.moveRight = false;
  }
  if(keyCode == UP){
    newManager.player.shootUp = false;
  }
  if(keyCode == DOWN){
    newManager.player.shootDown = false;
  }
  if(keyCode == LEFT){
    newManager.player.shootLeft = false;
  }
  if(keyCode == RIGHT){
    newManager.player.shootRight = false;
  }
}
