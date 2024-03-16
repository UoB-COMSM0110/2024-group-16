
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
      newManager.optionPointer.setSoundStatus(0);
      newManager.optionPointer.setGameModeStatus(0);
      newManager.optionPointer.updatePos3();
      newManager.optionPointer.setStatus(2);
      newManager.optionPointer.updatePos();
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
  // in the options

    if(newManager.curScene != Scene.MAIN_MENU && keyCode == ESC){
       newManager.curScene = Scene.OPTIONS; 
    }
    if(newManager.curScene == Scene.OPTIONS){
          if(newManager.optionPointer.curOption == Option.OPTION_MENU){
            newManager.curScene = Scene.OPTIONS; 
            if(keyCode == UP){
              newManager.optionPointer.movePointers(1);
            }else if(keyCode == DOWN){
              newManager.optionPointer.movePointers(-1);
            }else if(keyCode == 32 || keyCode == ENTER){
            if(newManager.optionPointer.getStatus()==0){
              newManager.optionPointer.curOption = Option.SOUND_SETTING;
              newManager.optionPointer.setSoundStatus(0);
              newManager.optionPointer.updatePos3();
            }else if(newManager.optionPointer.getStatus()==1){
              newManager.optionPointer.curOption = Option.GAME_MODE;
              newManager.optionPointer.setGameModeStatus(0);
              newManager.optionPointer.updatePos3();
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
        }else if(newManager.optionPointer.curOption == Option.GAME_MODE){
          if(keyCode == UP){
          newManager.optionPointer.movePointers3(1);
          }else if(keyCode == DOWN){
            newManager.optionPointer.movePointers3(-1);
          }else if(keyCode == 32 || keyCode == ENTER){
            if(newManager.optionPointer.getGameModeStatus()==0){
              println("Normal option now:0");
            }else if(newManager.optionPointer.getGameModeStatus()==1){
              println("Random option now:1");
            }else if(newManager.optionPointer.getGameModeStatus()==2){
              newManager.optionPointer.setStatus(2);
              newManager.optionPointer.updatePos();
              newManager.curScene = Scene.OPTIONS;
              newManager.optionPointer.curOption = Option.OPTION_MENU;
            }
          }
      }else if(newManager.optionPointer.curOption == Option.SOUND_SETTING){
          if(keyCode == UP){
          newManager.optionPointer.movePointers3(1);
          }else if(keyCode == DOWN){
            newManager.optionPointer.movePointers3(-1);
          }else if(keyCode == 32 || keyCode == ENTER){
            if(newManager.optionPointer.getSoundStatus()==0){
              println("SE option now:0");
            }else if(newManager.optionPointer.getSoundStatus()==1){
              println("MUSIC option now:1");
            }else if(newManager.optionPointer.getSoundStatus()==2){
              newManager.optionPointer.setStatus(2);
              newManager.optionPointer.updatePos();
              newManager.curScene = Scene.OPTIONS;
              newManager.optionPointer.curOption = Option.OPTION_MENU;
            }
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
