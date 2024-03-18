public class Manager{
  
  PFont gameoverFont; 
  int gameoverFontSize = 20; 
  String chineseCharacter = "死"; 
  int targetSize = 500;
  int sizeIncrement = 2;
  
  PFont mainMenuFont;
  PImage menuBg;
  PImage gameBg;
  PImage optionBg;
  PImage title;
  PImage gameoverBg;
  int buttonInterval = 50;
  int buttonIntervalOption = 60;
  
  int bossCollideFlag = 0;
  int curRoom;
  //by default, use the main menu
  Scene curScene=Scene.MAIN_MENU;
  Scene preScene=Scene.MAIN_MENU;
  
  //Menu pointer
  MenuPointer menuPointer = new MenuPointer();
  OptionPointer optionPointer = new OptionPointer();

  //UI
  UI ui=new UI();
  
  //player
  Knight player = new Knight();
  
  //save and load some useful images
  MultiUseImages multi_use_images = new MultiUseImages();
  
  //save map info init-up-left-down-right
  Rooms[] rooms = new Rooms[5];
  
  //Bomb
  ArrayList<Bomb> bombs = new ArrayList<Bomb>();
  
  public Manager(){
    
    mainMenuFont = createFont("../Fonts/TrajanPro-Bold.otf", 40); 
    gameoverFont = createFont("../Fonts/si.ttf", 40);
    menuBg=loadImage("../images/Menu/controller_prompt_bg.png");
    menuBg.resize(width,height);
    optionBg=loadImage("../images/Menu/menu_option_bg.png");
    optionBg.resize(width,height);
    title=loadImage("../images/Menu/vheart_title.png");  
    title.resize(1000,300);
    gameoverBg =loadImage("../images/GameOver/GameOverBg.jpg");
    gameoverBg.resize(width,height);

    for(int i=0;i<5;i++){
      rooms[i]=new Rooms(i);
    }
  
    curRoom=0;
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
  
  public void drawMainMenu(){
    image(menuBg,0,0);
    image(title,150,50);
    
    image(menuPointer.img[0],menuPointer.getPosXLeft(),menuPointer.getPosYLeft());
    image(menuPointer.img[1],menuPointer.getPosXRight(),menuPointer.getPosYRight());
  
    drawButton(width / 2 - 50 , height / 2 + buttonInterval , "Start");
    drawButton(width / 2 - 50 , height / 2 + 3 * buttonInterval , "Options");
    drawButton(width / 2 - 50 , height / 2 + 5 * buttonInterval , "Exit");
  }
 
  public void drawGaming(){
    //check player HP
    if(player.HP <= 0){
      curScene = Scene.GAME_OVER;
    }
    
    //change room
    changeRoom(player.getPosX(),player.getPosY());
    
    
    //roombg & door
    this.rooms[curRoom].drawRoom();
    
    //UI
    image(ui.HUD_main,20,20);
    for(int i=0;i<player.getmaxHP();i++){
      image(ui.HUD_emptyHP,120+40*i,70);
    }  
    for(int i=0;i<player.getHP();i++){
      image(ui.HUD_HP,119+40*i,70);
    }
    
    
    //obstacle or items or drops
    drawObstacle(rooms[curRoom].obs);
    
    Iterator<Bomb> iterator = bombs.iterator();
    while (iterator.hasNext()) {
    Bomb bomb = iterator.next();
    bomb.update();
    drawBombs(bomb);
      if (bomb.exploded) {
        iterator.remove();
      }
    }

    
    
    //player
    if(player.movePlayer()){
      player.drawWalk();
    }else{
      player.drawIdle();
    }
    
    
    //fireballs
    player.moveFireBalls();
    player.drawFireBalls(multi_use_images.fireBalls_up,
                         multi_use_images.fireBalls_down,
                         multi_use_images.fireBalls_left,
                         multi_use_images.fireBalls_right);
                         
     // collision of grass and fireball
    for(Obstacle temp:rooms[curRoom].obs){
      if(!player.fireBalls.isEmpty() && 
      player.fireBalls.get(player.fireBalls.size() - 1).checkObstacleCollision(temp)) {
        player.fireBalls.remove(player.fireBalls.size()-1);
     
    }
     
     // collision of grass and knight
      if(player.checkObstacleCollision(temp)) {
        if (player.moveUp) { 
          player.playerPos.y += player.moveSpeed;
        }
        if (player.moveDown) { 
         player.playerPos.y -= player.moveSpeed;
        }
        if (player.moveLeft) {
         player.playerPos.x += player.moveSpeed;
        }
        if (player.moveRight) {
         player.playerPos.x -= player.moveSpeed;
        }
      }
    }
    if(curRoom == 4 && rooms[4].soulMaster.isAlive){
        // collision of bigblob and knight
        if(!rooms[4].soulMaster.bb.isEmpty()) {
          for(int i=0;i<rooms[4].soulMaster.bb.size();i++) {
            if(rooms[4].soulMaster.bb.get(i).checkKnightCollision(player)) {
              rooms[4].soulMaster.bb.remove(i);
              player.HP--;
            }
          }
        }
       
        // collision of Boss and knight
        if(player.checkBossCollision(rooms[4].soulMaster) || bossCollideFlag != 0) {
          if(bossCollideFlag == 0){
            player.HP--;
            bossCollideFlag = 30;       
          }
          if (player.moveUp) {
            player.playerPos.y += 2*player.moveSpeed;
          }
          if (player.moveDown) { 
            player.playerPos.y -= 2*player.moveSpeed;
          }
          if (player.moveLeft) {
            player.playerPos.x += 2*player.moveSpeed;
          }
          if (player.moveRight) {
            player.playerPos.x -= 2*player.moveSpeed;
          }
          bossCollideFlag--;
      }
       
       
     // collision of fireballs and boss
      if(!player.fireBalls.isEmpty() && 
        player.fireBalls.get(player.fireBalls.size() - 1).checkBossCollision(rooms[4].soulMaster)) {
          player.fireBalls.remove(player.fireBalls.size()-1);
          rooms[4].soulMaster.decHP(player.getAttack());
      }
    }
    
    // Boss & Enemies
    if(curRoom == 4){
      drawBoss(player.playerPos);
    }else if(curRoom == 2 || curRoom ==3){
      drawEmemies(player.playerPos);
    }

  }
    
  public void drawOptions(){
    image(optionBg,0,0);
    image(optionPointer.img,optionPointer.getPosX(),optionPointer.getPosY());
    optionPointer.drawSnow();
    drawButton(3*width / 4 - 3*buttonInterval , 2*height / 3 , "Sound Settings");
    drawButton(3*width / 4 - 3*buttonInterval , 2*height / 3 + buttonIntervalOption, "Game Mode");
    drawButton(3*width / 4 - 3*buttonInterval , 2*height / 3 + 2*buttonIntervalOption, "Back to Game");
    drawButton(3*width / 4 - 3*buttonInterval , 2*height / 3 + 3*buttonIntervalOption, "Back to Menu");
    drawButton(3*width / 4 - 3*buttonInterval , 2*height / 3  + 4*buttonIntervalOption, "Exit");
    
  }
  
  public void drawGameOver(){
    image(gameoverBg,0,0);
    drawCharacter(chineseCharacter.charAt(0), width/2, height/2);
  }
    
  public void drawButton(float x, float y, String label) {
    textAlign(CENTER, CENTER);
    fill(255);
    textFont(mainMenuFont); 
    text(label, x, y);
  } 
  
  public void changeRoom(float playerPosX,float playerPosY){
        
    //top door
    if(rooms[curRoom].doors[0]!=null                
                 && playerPosX >= rooms[curRoom].doorsCoordinates[0] 
                 && playerPosX <= rooms[curRoom].doorsCoordinates[0]+80 
                 && playerPosY <= horiMargin - player.getHeight()+obstacleWidth){
      //the door exists 
      if(curRoom == 0){
        curRoom=1;
      }else if(curRoom == 3){
        curRoom=0;
      }
      player.cleanFireballs();
      //update the pos of knight
      player.setPosY(vertiMargin+6*obstacleWidth-player.getHeight()-imageShift);
      
    //bottom door
    }else if(rooms[curRoom].doors[2]!=null                
                 && playerPosX >=rooms[curRoom].doorsCoordinates[0]-10 
                 && playerPosX <= rooms[curRoom].doorsCoordinates[0]+70 
                 && playerPosY >= vertiMargin+6*obstacleWidth-player.getHeight()){
      if(curRoom == 0){
        curRoom=3;
      }else if(curRoom == 1){
        curRoom=0;
      }
      player.cleanFireballs();
      //update the pos of knight
      player.setPosY(vertiMargin-imageShift);
      
     //right door
     }else if(rooms[curRoom].doors[1]!=null
                 && player.getPosX() >= horiMargin+12*obstacleWidth-player.getWidth()
                 && player.getPosY() >= rooms[curRoom].doorsCoordinates[3]-2*imageShift
                 && player.getPosY() <= rooms[curRoom].doorsCoordinates[3]+80-2*imageShift){
      if(curRoom == 0){
        curRoom=2;
        player.cleanFireballs();
        player.setPosX(horiMargin+imageShift);
      }else if(curRoom == 4 && !rooms[curRoom].soulMaster.isAlive){
        curRoom=0;
        player.cleanFireballs();
        player.setPosX(horiMargin+imageShift);
      }
      
     //left door
     }else if(rooms[curRoom].doors[3]!=null
                 && player.getPosX() <= horiMargin +imageShift
                 && player.getPosY() >= rooms[curRoom].doorsCoordinates[3]-2*imageShift
                 && player.getPosY() <= rooms[curRoom].doorsCoordinates[3]+80-2* imageShift){
      if(curRoom == 0){
        curRoom=4;
      }else if(curRoom == 2){
        curRoom=0;
      }
      player.cleanFireballs();
      player.setPosX(horiMargin+12*obstacleWidth-player.getWidth()-imageShift);
     }
     
  }
  
  
  public void drawObstacle(ArrayList<Obstacle> obs){
   for(Obstacle temp : obs){
     //this is grass
     if(temp.type == 0){
       Grass grass = (Grass)temp;
       image(multi_use_images.grass[grass.curStatus],temp.pos.x,temp.pos.y);
       if(grass.curFrame%35==0){
         grass.curStatus=(grass.curStatus+1)%4;
       }
       grass.curFrame++;       
     }else if(temp.type == 1){
       HardObstacle hard = (HardObstacle)temp;
       image(multi_use_images.hardObstacle[hard.hardObsType],temp.pos.x,temp.pos.y);
     }
    }
  }
  
  //Bomb
  void createBomb(){
    bombs.add( new Bomb(player.getPosX()-20,player.getPosY()+50,50));  
    player.numOfBomb--;
  }

  void drawBombs(Bomb bomb) {
    if (!bomb.exploded) { 
      if (frameCount % 30 < 15) {
        image(multi_use_images.bomb,bomb.pos.x,bomb.pos.y);
      } 
    } else {
      image(multi_use_images.bombing,bomb.pos.x,bomb.pos.y);
    }
  }
  
  void drawBoss(PVector player){
     if(rooms[4].soulMaster.HP < 0){
       rooms[4].soulMaster.isAlive = false;
     }
    
     if(rooms[4].soulMaster.isAlive){
       rooms[curRoom].soulMaster.updateActionMode();
       rooms[curRoom].soulMaster.bossAction(player);
       rooms[4].soulMaster.moveBigBlob();
       rooms[4].soulMaster.drawBigBlob();
     }else{
        rooms[4].soulMaster.drawDead();
     }
  }
  
  void drawCharacter(char character, float x, float y) {
    fill(155, 0, 0); 
    textAlign(CENTER, CENTER);
    textSize(gameoverFontSize);
    text(character, x, y);
    
    if (gameoverFontSize < targetSize) {
      gameoverFontSize += sizeIncrement;
      gameoverFont = createFont("../Fonts/si.ttf", gameoverFontSize); 
      textFont(gameoverFont);
    }
  }
  
  void drawEmemies(PVector player){
    
    for(Enemy curEmy: rooms[curRoom].emy){
       if(curEmy.type==0){
         Crawlid crawlid = (Crawlid)curEmy;
         crawlid.updateStatus();
         crawlid.moveCrawlid(player);
         image(multi_use_images.crawlid[crawlid.curStatus],crawlid.enemyPos.x,crawlid.enemyPos.y);
      }
    }
  }
}
