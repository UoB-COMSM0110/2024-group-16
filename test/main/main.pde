PFont customFont; 
PImage menuBg;
PImage title;
int pointPos=0;
int wwidth=1400;
int wheight=800;
int buttonInterval = 50;
int smallOffset = 20;

Manager newManager = new Manager();

void setup() {
  size(1400, 800);
  //load images and Fonts
  
  //Main menu
  customFont = createFont("../Fonts/TrajanPro-Bold.otf", 40); 
  menuBg=loadImage("../images/Menu/controller_prompt_bg.png");
  title=loadImage("../images/Menu/vheart_title.png");  
  newManager.menuPointer.img[0]=loadImage("../images/Menu/Pointers/pointerLeft.png");
  newManager.menuPointer.img[1]=loadImage("../images/Menu/Pointers/pointerRight.png");
  newManager.menuPointer.img[0].resize(80,60);
  newManager.menuPointer.img[1].resize(80,60);
  menuBg.resize(wwidth,wheight);
  title.resize(1000,300);
  
  //Some frequently used image resources, including obstacles, enemies, drops, bullets, etc.
  for(int i=0;i<newManager.multi_use_images.fireBalls_up.length;i++){
    newManager.multi_use_images.fireBalls_up[i]=
      loadImage("../images/Knight/Fireballs/fireball_up_"+i+".png");
    newManager.multi_use_images.fireBalls_up[i].resize(50,80);
    newManager.multi_use_images.fireBalls_down[i]=
      loadImage("../images/Knight/Fireballs/fireball_down_"+i+".png");
    newManager.multi_use_images.fireBalls_down[i].resize(50,80);
    newManager.multi_use_images.fireBalls_left[i]=
      loadImage("../images/Knight/Fireballs/fireball_left_"+i+".png");
    newManager.multi_use_images.fireBalls_left[i].resize(80,50);
    newManager.multi_use_images.fireBalls_right[i]=
      loadImage("../images/Knight/Fireballs/fireball_right_"+i+".png");
    newManager.multi_use_images.fireBalls_right[i].resize(80,50);
  }
  
  
  //Gaming
  newManager.gameBg=loadImage("../images/Map/basement.png");
  for(int i=0;i<newManager.player.Idle.length;i++){
    newManager.player.Idle[i]=loadImage("../images/Knight/Idle/Idle_"+i+".PNG");
  }
  for(int i=0;i<newManager.player.Walk.length;i++){
    newManager.player.Walk[i]=loadImage("../images/Knight/Walk/Walk_"+i+".PNG");
  }
  newManager.gameBg.resize(wwidth,wheight);
  //Game_over
  
  
}

void draw() {
  newManager.drawMap();
}

void keyPressed(){
  //in the main menu
  if( newManager.curScene == Scene.MAIN_MENU ){//in the main menu
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
