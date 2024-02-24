PFont customFont; 
PImage menuBg;
PImage title;
int pointPos=0;
int wwidth=1400;
int wheight=800;
int buttonInterval = 50;
int smallOffset = 20;

MenuPointer menuPointer = new MenuPointer(wwidth,wheight);
Map newmap = new Map();
Knight player = new Knight();

//by default, use the main menu
Scene curScene=Scene.MAIN_MENU;

void setup() {
  size(1400, 800);
  //load images and Fonts
  
  //Main menu
  customFont = createFont("../Fonts/TrajanPro-Bold.otf", 40); 
  menuBg=loadImage("../images/Menu/controller_prompt_bg.png");
  title=loadImage("../images/Menu/vheart_title.png");  
  menuPointer.img[0]=loadImage("../images/Menu/Pointers/pointerLeft.png");
  menuPointer.img[1]=loadImage("../images/Menu/Pointers/pointerRight.png");
  menuPointer.img[0].resize(80,60);
  menuPointer.img[1].resize(80,60);
  menuBg.resize(wwidth,wheight);
  title.resize(1000,300);
  
  //Gaming
  newmap.gameBg=loadImage("../images/Map/basement.png");
  for(int i=0;i<player.Idle.length;i++){
    player.Idle[i]=loadImage("../images/Knight/Idle/Idle_"+i+".PNG");
  }
  for(int i=0;i<player.Walk.length;i++){
    player.Walk[i]=loadImage("../images/Knight/Walk/Walk_"+i+".PNG");
  }
  newmap.gameBg.resize(wwidth,wheight);
  //Game_over
  
  
}

void draw() {
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
  image(newmap.gameBg,0,0);
  
  player.movePlayer();
  player.drawIdle();
  
  
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

void keyPressed(){
  //in the main menu
  if( curScene == Scene.MAIN_MENU ){//in the main menu
    if(keyCode == UP){
      menuPointer.movePointers(1);
    }else if(keyCode == DOWN){
      menuPointer.movePointers(-1);
    }else if(keyCode == 32){
      //turn to other scene
      if(menuPointer.getStatus()==0){
        curScene=Scene.GAMING;
      }else if(menuPointer.getStatus()==1){
        curScene=Scene.OPTIONS;
      }else if(menuPointer.getStatus()==2){
        exit();
      }
    }
  }
  
  //in the game
  if(curScene==Scene.GAMING){
    if (key == 'w') {
      player.moveUp = true;
    }
    if (key == 's') {
      player.moveDown = true;
    }
    if (key == 'a') {
      player.moveLeft = true;
    }
    if (key == 'd') {
      player.moveRight = true;
    }
  }
  //other keyboard activities
}

void keyReleased() {
  if (key == 'w') {
    player.moveUp = false;
  }
  if (key == 's') {
    player.moveDown = false;
  }
  if (key == 'a') {
    player.moveLeft = false;
  }
  if (key == 'd') {
    player.moveRight = false;
  }
}
