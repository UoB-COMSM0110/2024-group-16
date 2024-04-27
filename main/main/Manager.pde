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
  PImage gameEndBg;
  PImage title;
  PImage gameoverBg;
  int buttonInterval = 50;
  int buttonIntervalOption = 60;
  int bossCollideFlag = 0;

  int curRoom;
  
  boolean isRandom;
  //by default, use the main menu
  Scene curScene=Scene.MAIN_MENU;
  Scene preScene=Scene.MAIN_MENU;
  //Option curOption=Option.OPTION_MENU;
  
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
    gameEndBg=loadImage("../images/Menu/game_end_bg.png");
    gameEndBg.resize(width,height);
    title=loadImage("../images/Menu/vheart_title.png");  
    title.resize(1000,300);
    gameoverBg =loadImage("../images/GameOver/GameOverBg.jpg");
    gameoverBg.resize(width,height);

    for(int i=0;i<5;i++){
      rooms[i]=new Rooms(i);
    }
  
    curRoom=0;
    isRandom = true;
  }
  
  
  
  public void drawMap() {
    if(isRandom && gameMode == 1){
      player.setValue();
      isRandom =false;
    }
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
     case GAME_TBC:
         drawGameTbc();
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
    //get pills
    if(curRoom == 1){
      getPills();
    }
    
    //UI
    image(ui.HUD_main,20,20);
    image(ui.HUD_Bomb,20,160);
    image(ui.HUD_Pill,20,220);
    for(int i=0;i<player.getmaxHP();i++){
      image(ui.HUD_emptyHP,120+40*i,70);
    }  
    for(int i=0;i<player.getHP();i++){
      image(ui.HUD_HP,119+40*i,70);
    }
    drawText(Integer.toString(player.numOfBomb),90,200);
    drawText(Integer.toString(player.numOfPill),90,250);
    
    //obstacle or items or drops
    drawObstacle(rooms[curRoom].obs);
    
    Iterator<Bomb> iterator = bombs.iterator();
    while (iterator.hasNext()) {
    Bomb bomb = iterator.next();
    bomb.update();
    drawBombs(bomb);
      if (bomb.exploded) {
        bombDamage(bomb);
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
    for(int i=0;i<rooms[curRoom].obs.size();i++){
      Obstacle temp = rooms[curRoom].obs.get(i);
      if(!player.fireBalls.isEmpty() && 
      player.fireBalls.get(player.fireBalls.size() - 1).checkObstacleCollision(temp)) {
        player.fireBalls.remove(player.fireBalls.size()-1);
        temp.hardness--;

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
    
    // collision of Enemy and Knight
    for(Enemy enemy:rooms[curRoom].emy) {
      for(Obstacle obs:rooms[curRoom].obs){
        if(enemy.type == 0 && enemy.checkObstacleCollision(obs)){
          enemy.subMoveCrawlid(obs.pos);
        }
      
      }
      if(!player.fireBalls.isEmpty() && 
        player.fireBalls.get(player.fireBalls.size() - 1).checkEnemyCollision(enemy)) {
        enemy.decHP(player.getAttack());
        player.fireBalls.remove(player.fireBalls.size()-1);
     
    }
    if(enemy.checkKnightCollision(player)|| player.InvincibleFrame != 0) {
      if(player.InvincibleFrame == 0){
            player.HP--;
            player.InvincibleFrame = 200;       
          } else {
              player.InvincibleFrame--;    
          }
          if(player.playerPos.x - enemy.enemyPos.x > 0 && player.InvincibleFrame > 190 && player.playerPos.x < horiMargin + obstacleWidth*12 - player.knightWidth)
            player.playerPos.x+=5;
          if(player.playerPos.x - enemy.enemyPos.x < 0 && player.InvincibleFrame > 190 && player.playerPos.x > horiMargin)
            player.playerPos.x-=5;
          if(player.playerPos.y - enemy.enemyPos.y < 0 && player.InvincibleFrame > 190 && player.playerPos.y > vertiMargin + obstacleWidth - player.knightHeight)
            player.playerPos.y-=5;
          if(player.playerPos.y - enemy.enemyPos.y > 0 && player.InvincibleFrame > 190 && player.playerPos.y < vertiMargin + obstacleWidth*6 - player.knightHeight)
            player.playerPos.y+=5;
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
        // collision of Boss and knight
        if(player.checkBossCollision(rooms[4].soulMaster) || player.InvincibleFrame != 0) {
          if(player.InvincibleFrame == 0){
            player.HP--;
            player.InvincibleFrame = 200;       
          } else {
              player.InvincibleFrame--;
          }
          if(player.playerPos.x - rooms[4].soulMaster.pos.x > 0 && player.InvincibleFrame > 190 && player.playerPos.x < horiMargin + obstacleWidth*12 - player.knightWidth)
            player.playerPos.x+=10;
          if(player.playerPos.x - rooms[4].soulMaster.pos.x < 0 && player.InvincibleFrame > 190 && player.playerPos.x > horiMargin)
            player.playerPos.x-=10;
          if(player.playerPos.y - rooms[4].soulMaster.pos.y < 0 && player.InvincibleFrame > 190 && player.playerPos.y > vertiMargin + obstacleWidth - player.knightHeight)
            player.playerPos.y-=10;
          if(player.playerPos.y - rooms[4].soulMaster.pos.y > 0 && player.InvincibleFrame > 190 && player.playerPos.y < vertiMargin + obstacleWidth*6 - player.knightHeight)
            player.playerPos.y+=10;
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
      drawEmemies(player);
    }
    
    // Boss is defeated
    if(curRoom == 4 && rooms[4].soulMaster.isAlive == false){
      curScene = Scene.GAME_TBC;
    }
  }
    
  public void drawOptions(){
    image(optionBg,0,0);
    image(optionPointer.img,optionPointer.getPosX(),optionPointer.getPosY());
    optionPointer.drawSnow();
    optionPointer.changeOption();
  }
  
  public void drawGameOver(){
    image(gameoverBg,0,0);
    drawCharacter(chineseCharacter.charAt(0), width/2, height/2);
  }
  
  public void drawGameTbc(){
   image(gameEndBg,0,0);
   drawTbc("TO BE CONTINUED...",700,400);
  }
  
    
  public void drawButton(float x, float y, String label) {
    textAlign(CENTER, CENTER);
    fill(255);
    textFont(mainMenuFont); 
    text(label, x, y);
  } 
  
  void drawText(String str,int x,int y){
    textFont(mainMenuFont); 
    fill(255); 
    textSize(32);
    textAlign(CENTER, CENTER); 
    text(str, x, y); 
  }
  void drawTbc(String str,int x,int y){
    textFont(mainMenuFont); 
    fill(255); 
    textSize(72);
    textAlign(CENTER, CENTER); 
    text(str, x, y); 
  }
  
  
  public void changeRoom(float playerPosX,float playerPosY){
    if(curRoom != 0 && curRoom !=1 && curRoom != 4 && rooms[curRoom].emy.size()>0){
      return;
    }    
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
   for(int i=0;i<obs.size();i++) {
     if(obs.get(i).getHardness() == 0) {
       obs.remove(i);
     }
   }
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
    if(player.numOfBomb <= 0){
      return;
    }else{
      bombs.add( new Bomb(player.getPosX()-20,player.getPosY()+50,50));  
      player.numOfBomb--;
    }
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
  
  void bombDamage(Bomb bomb){
    for(Obstacle tmp:rooms[curRoom].obs){
      float distance = bomb.pos.dist(tmp.pos);
      if(distance<300){
        tmp.hardness = tmp.hardness-2;
      }
    }
    for(Enemy tmp:rooms[curRoom].emy){
      float distance = bomb.pos.dist(tmp.enemyPos);
      if(distance<300){
        tmp.decHP(bomb.bombDmg);
      }
    }
    if(curRoom==4){
      PVector tmp = new PVector(rooms[4].soulMaster.pos.x+180,rooms[4].soulMaster.pos.y+180);
      if(tmp.dist(bomb.pos)<=300)
        rooms[4].soulMaster.decHP(bomb.bombDmg);
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
  
  void drawEmemies(Knight player){
    if(rooms[curRoom].hasBomb && rooms[curRoom].emy.size()<=0){
      player.numOfBomb++;
      rooms[curRoom].hasBomb = false;
    }
    
    for(int i=0;i<rooms[curRoom].emy.size();i++){
      if(rooms[curRoom].emy.get(i).getHealth() <= 0) {
        rooms[curRoom].emy.remove(i);
      }
    
    }
    for(Enemy curEmy: rooms[curRoom].emy){
       if(curEmy.type==0){
         //Crawlid
         Crawlid crawlid = (Crawlid)curEmy;
         crawlid.updateStatus();
         crawlid.moveCrawlid(player.playerPos);
         image(multi_use_images.crawlid[crawlid.curStatus],crawlid.enemyPos.x,crawlid.enemyPos.y);
       }else if(curEmy.type ==1){
         //Mosquito
         Mosquito mosquito = (Mosquito)curEmy;
         mosquito.updateStatus();
         mosquito.moveMosquito(player.playerPos);
         image(multi_use_images.mosquito[mosquito.curStatus],mosquito.enemyPos.x,mosquito.enemyPos.y);
       }
    }
  }
  
  void getPills(){
     for(int i=0;i<rooms[curRoom].pills.size();i++){
       //get pills
       if(rooms[curRoom].pills.get(i).itemsPos.dist(player.playerPos)<80){
         player.numOfPill++;
         rooms[curRoom].pills.remove(i);
       }
     }
  }
  
  void eatPill(){
    player.numOfPill--;
    startTime = frameCount;
    pillCode = (int)random(0,8);
    switch(pillCode){
      case 0:{
        player.attack++;
        break;
      }
      case 1:{
        player.attack--;
        break;
      }
      case 2:{
        player.HP++;
      }
      case 3:{
        player.HP--;
        break;
      }
      case 4:{
        player.moveSpeed = player.moveSpeed+2;
        break;
      }
      case 5:{
        player.moveSpeed = player.moveSpeed-2;
        break;
      }
      case 6:{
        player.shootSpeed = player.shootSpeed+1;
        break;
      }
      case 7:{
        player.shootSpeed = player.shootSpeed-1;
        break;
      }
    }
  }
  
  void showEffect(String str){
    
    textAlign(CENTER, CENTER);
    textSize(50);
    if (frameCount - startTime <= 60) {
      text(str, width/2, height/2);
    }
  }
}