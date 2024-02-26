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
  for(int i=0;i<newManager.multi_use_images.fireBalls.length;i++){
    newManager.multi_use_images.fireBalls[i]=
      loadImage("../images/Knight/Fireballs/fireball_"+i+".png");
    newManager.multi_use_images.fireBalls[i].resize(80,50);
  }
  
  
  //Gaming
  newManager.gameBg=loadImage("../images/Map/basement.png");
  for(int i=0;i<newmap.player.Idle.length;i++){
    newManager.player.Idle[i]=loadImage("../images/Knight/Idle/Idle_"+i+".PNG");
  }
  for(int i=0;i<newmap.player.Walk.length;i++){
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
    }
    if (key == 'd') {
      newManager.player.moveRight = true;
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
}
