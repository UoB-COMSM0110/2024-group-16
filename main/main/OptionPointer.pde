public class OptionPointer{
  float posX;
  float posY;
  int status; // need to using
  int state;
  int soundSetStatus;
  int gameModeStatus;
  float volume=0.5;
 
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

  public void setSoundStatus(int newStatus){soundSetStatus = newStatus;}
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
        posX = 3 * width / 4 - 3 * buttonInterval + horiOffset + 2 * smallHoriOffset;
        posY = 2 * height / 3 - vertOffset;
        break;
      case 1:
        posX = 3 * width / 4 - 3 * buttonInterval  + horiOffset + 2 * smallHoriOffset;
        posY = 2 * height / 3 + 1 * buttonInterval - vertOffset / 3;
        break;
      case 2:
        posX = 3 * width / 4 - 3 * buttonInterval  + horiOffset + 3 * smallHoriOffset;
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
        if(soundSetStatus == 0){
            text("This fucntion is coming soon...", 400, 50);
        }else if(soundSetStatus == 1){ // Write the music relative items
            text("Increase volume: Left arrow key",400,100);
            text("Decrease volume: Right arrow key",415,150);
            text("Current Volume: ", 400, 50);
            drawVolumeBar(volume, 700, 35, 400, 30);
        }
      }else if(Mode == 2){
        drawButton(3*width / 4 - 3*buttonInterval , 2*height / 3 , "Normal Mode");
        drawButton(3*width / 4 - 3*buttonInterval , 2*height / 3 + buttonInterval, "Random Mode");
        drawButton(3*width / 4 - 3*buttonInterval , 2*height / 3 + 2*buttonInterval , "Back to Options");
          if(gameMode == 0){
            text("MODE: NORMAL",212,100);
            }
          if(gameMode == 1){
            text("MODE: HARD(RANDOM)",300,100);
          }
      }
      
  }
  public void optionSwitch(){
      if(curOption == Option.GAME_MODE){
          if(keyCode == UP){
             movePointers3(1);
          }else if(keyCode == DOWN){
            movePointers3(-1);
          }else if(keyCode == 32 || keyCode == ENTER){
            if(gameModeStatus==0){
              gameMode = 0;
            }else if(gameModeStatus==1){
              gameMode = 1;
            }else if(gameModeStatus==2){
              setStatus(2);
              updatePos();
              newManager.curScene = Scene.OPTIONS;
              curOption = Option.OPTION_MENU;
            }
          }
      }else if(curOption == Option.SOUND_SETTING){
          if(keyCode == UP){
          movePointers3(1);
          }else if(keyCode == DOWN){
            movePointers3(-1);
          }else if(keyCode == 32 || keyCode == ENTER){
            if(soundSetStatus==0){
            }else if(soundSetStatus==1){
              }
            }else if (keyCode == LEFT) {
                // Increase volume
                volume = constrain(volume - 0.1, 0, 1); // Prevent volume from going out of range
                soundFile.amp(volume); 
              } else if (keyCode == RIGHT) {
                // Decrease volume
                volume = constrain(volume + 0.1, 0, 1); // Prevent volume from going out of range
                soundFile.amp(volume);     
          }
          if(soundSetStatus==2 && keyCode == ENTER){
              setStatus(2);
              updatePos();
              newManager.curScene = Scene.OPTIONS;
              curOption = Option.OPTION_MENU;
            }
        }
  }
  
  void drawVolumeBar(float level, float x, float y, float w, float h) {
    // draw outside frame
    stroke(0);
    fill(180);
    rect(x, y, w, h);
    // fill the inside
    fill(255);
    float barWidth = map(level, 0, 1, 0, w); 
    rect(x, y, barWidth, h);
  }
}
