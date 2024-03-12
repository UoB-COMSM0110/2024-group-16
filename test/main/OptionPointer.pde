public class OptionPointer{
  float posX;
  float posY;
  int status;
  int horiOffset = 150;
  int smallHoriOffset = 20;
  int vertOffset = 15;
  int buttonInterval = 60;
  PImage img=new PImage();
  PFont optionFont;
  Option curOption=Option.OPTION_MENU;
  //Manager drawB = new Manager();
  
  public OptionPointer(){
    status = 0 ;
    optionFont = createFont("../Fonts/TrajanPro-Bold.otf", 40);
    //drawButtons();
    updatePos();
    updatePos3();
    img=loadImage("../images/Options/Cursor.png");
    img.resize(60,60);
  }
  public void movePointers(int e){
    if(e==-1){
      status=(status+1)%5;
    }else if(e==1){
      if(status==0){
        status=5;
      }
      status=(status-1);
    }
    updatePos();
  }
  public void movePointers3(int e){
    if(e==-1){
      status=(status+1)%3;
    }else if(e==1){
      if(status==0){
        status=3;
      }
      status=(status-1);
    }
    updatePos3();
  }
  
  
  public float getPosX(){return posX;}
  public float getPosY(){return posY;}
  public void setPosX(int newPosX){posX = newPosX;}
  public void setPosY(int newPosY){posY = newPosY;}
  
  
  
  public int getStatus(){return status;}
  public void setStatus(int newStatus){status = newStatus;}
  
  private void updatePos(){
    switch (status){
      case 0: 
        posX = 3 * width / 4 - 3 * buttonInterval + horiOffset + 3 * smallHoriOffset;
        posY = 2 * height / 3 - vertOffset;
        break;
      case 1:
        posX = 3 * width / 4 - 3 * buttonInterval  + horiOffset + smallHoriOffset;
        posY = 2 * height / 3 + 1 * buttonInterval - vertOffset / 3;
        break;
      case 2:
        posX = 3 * width / 4 - 3 * buttonInterval  + horiOffset + 2 * smallHoriOffset;
        posY = 2 * height / 3 + 2 * buttonInterval  - vertOffset;
        break;
      case 3:
        posX = 3 * width / 4 - 3 * buttonInterval  + horiOffset + 2 * smallHoriOffset;
        posY = 2 * height / 3 + 3 * buttonInterval  - vertOffset;
        break;
      case 4:
        posX = 3 * width / 4 - 3 * buttonInterval + 4 * smallHoriOffset;
        posY = 2 * height / 3 + 4 * buttonInterval - 2 * vertOffset;
        break;
    }
  }
  
  private void updatePos3(){
    switch (status){
      case 0: 
        posX = 3 * width / 4 - 3 * buttonInterval + horiOffset + 3 * smallHoriOffset;
        posY = 2 * height / 3 + 2 * vertOffset;
        break;
      case 1:
        posX = 3 * width / 4 - 3 * buttonInterval + horiOffset + 3 * smallHoriOffset;
        posY = 2 * height / 3 + 1 * buttonInterval + 5 * vertOffset / 3;
        break;
      case 2:
        posX = 3 * width / 4 - 3 * buttonInterval + horiOffset + 4 * smallHoriOffset;
        posY = 2 * height / 3 + 2 * buttonInterval  + 2 * vertOffset;
        break;
    }
  }
  public void drawButton(float x, float y, String label) {
    textAlign(CENTER, CENTER);
    fill(255);
    textFont(optionFont); 
    text(label, x, y);
  }
  public void changeOption(){
    switch(curOption){
      case OPTION_MENU:
        drawButtons(0);
      case SOUND_SETTING:
        drawButtons(1);
        break;
      case GAME_MODE:
        drawButtons(2);
        break;
      }
  }
  public void drawButtons(int Mode){
      if(Mode == 0){
        drawButton(3*width / 4 - 3*buttonInterval , 2*height / 3 , "Sound Settings");
        drawButton(3*width / 4 - 3*buttonInterval , 2*height / 3 + buttonInterval, "Game Mode");
        drawButton(3*width / 4 - 3*buttonInterval , 2*height / 3 + 2*buttonInterval, "Back to Game");
        drawButton(3*width / 4 - 3*buttonInterval , 2*height / 3 + 3*buttonInterval, "Back to Menu");
        drawButton(3*width / 4 - 3*buttonInterval , 2*height / 3  + 4*buttonInterval, "Exit");
      }else if(Mode == 1){
        drawButton(3*width / 4 - 3*buttonInterval , 2*height / 3 , "SE");
        drawButton(3*width / 4 - 3*buttonInterval , 2*height / 3 + buttonInterval, "MUSIC");
        drawButton(3*width / 4 - 3*buttonInterval , 2*height / 3+ 2*buttonInterval , "Back to Options");
        
      }else if(Mode == 2){
        drawButton(3*width / 4 - 3*buttonInterval , 2*height / 3 , "Normal Mode");
        drawButton(3*width / 4 - 3*buttonInterval , 2*height / 3 + buttonInterval, "Random Mode");
        drawButton(3*width / 4 - 3*buttonInterval , 2*height / 3 + 2*buttonInterval , "Back to Options");
      }
  }
}
