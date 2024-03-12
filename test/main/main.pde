
Manager newManager;

int obstacleWidth = 98;
int vertiMargin = 110;
int horiMargin = 115;
int imageShift = 20;
boolean hasDone = false;
int gameMode = 0;

//control the loading images
PImage[] loadingImage=new PImage[8];
int curFrame = 1;
int curStatus = 0;

void setup() {
  size(1400, 800);
  for(int i=0;i<loadingImage.length;i++){
    loadingImage[i]=loadImage("../images/Loading/loading_icon_0"+i+".png");
  }
  Thread loadingThread = new Thread(new LoadingThread());
  loadingThread.start();
}


void draw() {
  if(!hasDone){
     background(0);
     image(loadingImage[curStatus],width/2-loadingImage[curStatus].width/2,height/2-loadingImage[curStatus].height/2);
     if(curFrame%5==0){
        curStatus=(curStatus+1)%8;
     }
     curFrame++;
  }else{
    newManager.drawMap();
  }
}


void keyPressed(){
  if(hasDone){
   // Forbbiden the ESC key to quit the whole processing
     if(key==27){
      key=0;
    }
    println(newManager.curScene);
    //in the main menu
    if( newManager.curScene == Scene.MAIN_MENU ){//in the main menu
      // reset the cursor postion and status
      newManager.optionPointer.setStatus(0);
      newManager.optionPointer.updatePos();
      newManager.modePointer.setStatus(0);
      newManager.modePointer.updatePos();
      newManager.preScene = Scene.MAIN_MENU;
      if(keyCode == ESC){
        exit();
      }
      if(keyCode == UP){
        newManager.menuPointer.movePointers(1);
      }else if(keyCode == DOWN){
        newManager.menuPointer.movePointers(-1);
      }else if(keyCode == 32 || keyCode == ENTER){
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
  // in the game mode
  if(newManager.curScene == Scene.GAME_MODE){
       newManager.curScene = Scene.GAME_MODE;
       if(keyCode == UP){
        newManager.modePointer.movePointers(1);
      }else if(keyCode == DOWN){
        newManager.modePointer.movePointers(-1);
      }else if(keyCode == 32 || keyCode == ENTER){
        //turn to other scene or changing the game mode
        if(newManager.modePointer.getStatus()==0){
          gameMode = 0;
          println("In normal mode: " + gameMode);
        }else if(newManager.modePointer.getStatus()==1){
          // set the random difficult game levels
          gameMode = (int)random(10);
          println(gameMode);
        }else if(newManager.modePointer.getStatus()==2){
            /*println("In 2 status");
            //newManager.curScene=Scene.OPTIONS;
            if(newManager.preScene == Scene.GAME_MODE) {     
            newManager.curScene=Scene.OPTIONS;
          }*/
        }
      }
    }
  // in the options

    if(newManager.curScene != Scene.MAIN_MENU && keyCode == ESC){
       newManager.curScene = Scene.OPTIONS; 
    }
    if(newManager.curScene == Scene.OPTIONS){
      newManager.curScene = Scene.OPTIONS; 
      if(keyCode == UP){
        newManager.optionPointer.movePointers(1);
      }else if(keyCode == DOWN){
        newManager.optionPointer.movePointers(-1);
      }else if(keyCode == 32 || keyCode == ENTER){
        //turn to other scene
        if(newManager.optionPointer.getStatus()==0){
          // add music setting
        }else if(newManager.optionPointer.getStatus()==1){
          // add different game level setting
          if(keyCode == 32 || keyCode == ENTER){
            newManager.optionPointer.setStatus(0);
            newManager.curScene = Scene.GAME_MODE;
            
          }
        }else if(newManager.optionPointer.getStatus()==2){ 
          if(newManager.preScene == Scene.GAMING) {     
            newManager.curScene=Scene.GAMING; 
          }
        }else if(newManager.optionPointer.getStatus()==3){
          if(newManager.preScene == Scene.MAIN_MENU) {     
            newManager.curScene=Scene.MAIN_MENU;
          }else if(newManager.preScene == Scene.GAMING) {     
            newManager.curScene=Scene.MAIN_MENU;
          }
        }else if(newManager.optionPointer.getStatus()==4){
          exit();
        }
      }
    }
  }
}

void keyReleased() {
  if(hasDone){
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
}