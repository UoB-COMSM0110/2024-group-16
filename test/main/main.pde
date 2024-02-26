PFont customFont; 
PImage menuBg;
PImage title;
int pointPos=0;
int wwidth=1400;
int wheight=800;
int buttonInterval = 50;
int smallOffset = 20;

Map newmap = new Map();

void setup() {
  size(1400, 800);
  //load images and Fonts
  
  //Main menu
  customFont = createFont("../Fonts/TrajanPro-Bold.otf", 40); 
  menuBg=loadImage("../images/Menu/controller_prompt_bg.png");
  title=loadImage("../images/Menu/vheart_title.png");  
  newmap.menuPointer.img[0]=loadImage("../images/Menu/Pointers/pointerLeft.png");
  newmap.menuPointer.img[1]=loadImage("../images/Menu/Pointers/pointerRight.png");
  newmap.menuPointer.img[0].resize(80,60);
  newmap.menuPointer.img[1].resize(80,60);
  menuBg.resize(wwidth,wheight);
  title.resize(1000,300);
  
  //Some frequently used image resources, including obstacles, enemies, drops, bullets, etc.
  for(int i=0;i<newmap.multi_use_images.fireBalls.length;i++){
    newmap.multi_use_images.fireBalls[i]=
      loadImage("../images/Knight/Fireballs/fireball_"+i+".png");
    newmap.multi_use_images.fireBalls[i].resize(80,50);
  }
  
  
  //Gaming
  newmap.gameBg=loadImage("../images/Map/basement.png");
  for(int i=0;i<newmap.player.Idle.length;i++){
    newmap.player.Idle[i]=loadImage("../images/Knight/Idle/Idle_"+i+".PNG");
  }
  for(int i=0;i<newmap.player.Walk.length;i++){
    newmap.player.Walk[i]=loadImage("../images/Knight/Walk/Walk_"+i+".PNG");
  }
  newmap.gameBg.resize(wwidth,wheight);
  //Game_over
  
  
}

void draw() {
  newmap.drawMap();
}

void keyPressed(){
  //in the main menu
  if( newmap.curScene == Scene.MAIN_MENU ){//in the main menu
    if(keyCode == UP){
      newmap.menuPointer.movePointers(1);
    }else if(keyCode == DOWN){
      newmap.menuPointer.movePointers(-1);
    }else if(keyCode == 32){
      //turn to other scene
      if(newmap.menuPointer.getStatus()==0){
        newmap.curScene=Scene.GAMING;
      }else if(newmap.menuPointer.getStatus()==1){
        newmap.curScene=Scene.OPTIONS;
      }else if(newmap.menuPointer.getStatus()==2){
        exit();
      }
    }
  }
  
  //in the game
  if(newmap.curScene==Scene.GAMING){
    if (key == 'w') {
      newmap.player.moveUp = true;
    }
    if (key == 's') {
      newmap.player.moveDown = true;
    }
    if (key == 'a') {
      newmap.player.moveLeft = true;
    }
    if (key == 'd') {
      newmap.player.moveRight = true;
    }
    if (keyCode == UP || keyCode == DOWN || keyCode == LEFT || keyCode == RIGHT) {
      newmap.player.shootFireBalls(keyCode);
    } 
    
  }
  //other keyboard activities
  
}

void keyReleased() {
  if (key == 'w') {
    newmap.player.moveUp = false;
  }
  if (key == 's') {
    newmap.player.moveDown = false;
  }
  if (key == 'a') {
    newmap.player.moveLeft = false;
  }
  if (key == 'd') {
    newmap.player.moveRight = false;
  }
}
