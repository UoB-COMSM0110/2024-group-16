import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

import java.util.Iterator;

Minim minim;
AudioPlayer audioPlayer;

Manager newManager;

PFont loadingFont ;
int obstacleWidth = 98;
int vertiMargin = 110;
int horiMargin = 115;
int imageShift = 20;
boolean hasDone = false;
int gameMode = 0;

//control the loading images
PImage[] loadingImage=new PImage[8];
String[] pillTips ={"ATTACK UP!","ATTACK DOWN!","HEALTH UP!","HEALTH DOWN!","SPEED UP!","SPEED DOWN!","SHOOTSPEED UP","SHOOTSPEED DOWN"};
int startTime = 0;
int pillCode = -1;
int curFrame = 1;
int curStatus = 0;

void setup() {
  size(1400, 800);
  for(int i=0;i<loadingImage.length;i++){
    loadingImage[i]=loadImage("../images/Loading/loading_icon_0"+i+".png");
  }
  
  //initial the music library
  minim = new Minim(this);
  loadMusic();
  loadingFont = createFont("../Fonts/Perpetua.ttf", 40); 
  Thread loadingThread = new Thread(new LoadingThread());
  loadingThread.start();
}


void draw() {
  if(!hasDone){
     background(0);
     image(loadingImage[curStatus],width/2-loadingImage[curStatus].width/2,height/2-loadingImage[curStatus].height/2);
     textFont(loadingFont); 
     fill(255); 
     textSize(25);
     textAlign(LEFT, CENTER); 

     text("Tips:  Use the up, down, left and right keys to shoot, WASD to move!", width/4, 500);
     text("Tips:  Use E to release powerful bombs!", width/4, 540);
     text("Tips:  Before heading to the boss room on the left,", width/4, 580);
     textAlign(CENTER, CENTER); 
     text("you can clear the normal monster rooms on the right and below to get some bombs!", width/2+90, 620); 
     textSize(30);
     text("The game's resources come from Hollow Knight and The Binding of Isaac, paying homage to both of these games!", width/2, 200);
     if(curFrame%5==0){
        curStatus=(curStatus+1)%8;
     }
     curFrame++;
  }else{
    newManager.drawMap();
    if(pillCode>0 && pillCode<pillTips.length)
      newManager.showEffect(pillTips[pillCode]);
  }
}


void keyPressed(){
  if(hasDone){
   // Forbbiden the ESC using  quit to exit the processing
     if(key==27){
      key=0;
    }
    //in the main menu
    if( newManager.curScene == Scene.MAIN_MENU ){//in the main menu
      // reset the cursor postion and status
      newManager.optionPointer.setStatus(0);
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
      if(key == 'e'){
        if(newManager.player.numOfBomb > 0 )
          newManager.createBomb();     
      }
      if (keyCode == 32 && newManager.player.numOfPill > 0) {
        newManager.eatPill();     
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
          if(newManager.preScene == Scene.GAMING) {     
            newManager.curScene=Scene.GAMING;;
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





void loadMusic() {
  if (audioPlayer != null) {
    audioPlayer.close();
  }
  audioPlayer = minim.loadFile("../bgm/soundtrack.wav"); 
  if (audioPlayer != null) {
    audioPlayer.loop();
  }
}


void stop() {
  if (audioPlayer != null) {
    audioPlayer.close();
  }
  minim.stop();
  super.stop();
}

/*MAIN_MENU,
  GAMING,
  OPTIONS,
  GAME_OVER
  */
