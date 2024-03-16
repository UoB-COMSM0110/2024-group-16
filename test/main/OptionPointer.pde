public class OptionPointer{
  float posX;
  float posY;
  int status; // need to using
  int state;
  int soundSetStatus;
  int gameModeStatus;
 
  int horiOffset = 150;
  int smallHoriOffset = 20;
  int vertOffset = 15;
  int buttonInterval = 60;
  PImage img=new PImage();
  PFont optionFont;
  Option curOption=Option.OPTION_MENU;
  //Manager drawB = new Manager();
  ArrayList<Snowflake> snowflakes = new ArrayList<Snowflake>();
  
  public OptionPointer(){
    status = 0 ;
    soundSetStatus=0;
    gameModeStatus=0;
    optionFont = createFont("../Fonts/TrajanPro-Bold.otf", 40);
    updatePos();
    updatePos3();
    img=loadImage("../images/Options/Cursor.png");
    img.resize(60,60);
    for (int i = 0; i < 50; i++) {
      snowflakes.add(new Snowflake());
    }
  }
  
  public void drawSnow(){
    for (Snowflake flake : snowflakes) {
      flake.update();
      flake.display();
    } 
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
    if(curOption == Option.SOUND_SETTING){
      state = soundSetStatus;
    }else if(curOption == Option.GAME_MODE){
      state = gameModeStatus;
    }
    if(e==-1){
      state=(state+1)%3;
    }else if(e==1){
      if(state==0){
        state=3;
      }
      state=(state-1);
    }
    if(curOption == Option.SOUND_SETTING){
      soundSetStatus = state;
    }else if(curOption == Option.GAME_MODE){
      gameModeStatus = state;
    }
    updatePos3();
  }
  
  
  public float getPosX(){return posX;}
  public float getPosY(){return posY;}
  public void setPosX(int newPosX){posX = newPosX;}
  public void setPosY(int newPosY){posY = newPosY;}
  
  
  
  public int getStatus(){return status;}
  public void setStatus(int newStatus){status = newStatus;}
  public int getSoundStatus(){return soundSetStatus;}
  public void setSoundStatus(int newStatus){soundSetStatus = newStatus;}
  public int getGameModeStatus(){return gameModeStatus;}
  public void setGameModeStatus(int newStatus){gameModeStatus = newStatus;}
  
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
    if(curOption == Option.SOUND_SETTING){
      state = soundSetStatus;
    }else if(curOption == Option.GAME_MODE){
      state = gameModeStatus;
    }
    switch (state){
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
    }
    if(curOption == Option.SOUND_SETTING){
      soundSetStatus = state;
    }else if(curOption == Option.GAME_MODE){
      gameModeStatus = state;
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
        break;
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
  
  public void optionSwitch(){
      if(newManager.optionPointer.curOption == Option.GAME_MODE){
          if(keyCode == UP){
          newManager.optionPointer.movePointers3(1);
          }else if(keyCode == DOWN){
            newManager.optionPointer.movePointers3(-1);
          }else if(keyCode == 32 || keyCode == ENTER){
            if(newManager.optionPointer.getGameModeStatus()==0){
              println("Normal option now:0");
              gameMode = 0;
            }else if(newManager.optionPointer.getGameModeStatus()==1){
              
              gameMode = (int)random(10);
              println("Random option now:1, gameMode now is: " + gameMode);
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
