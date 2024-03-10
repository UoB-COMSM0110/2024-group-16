public class OptionPointer{
  float posX;
  float posY;
  int status;
  int horiOffset = 150;
  int smallHoriOffset = 20;
  int vertOffset = 15;
  int buttonInterval = 50;
  PImage img=new PImage();
  
  public OptionPointer(){
    status = 0 ;
    updatePos();
    img=loadImage("../images/Options/Cursor.png");
    img.resize(60,60);
  }
  public void movePointers(int e){
    if(e==-1){
      status=(status+1)%6;
    }else if(e==1){
      if(status==0){
        status=6;
      }
      status=(status-1);
    }
    updatePos();
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
        posX = 3 * width / 4 - 3 * buttonInterval  + horiOffset + 4 * smallHoriOffset;
        posY = 2 * height / 3 + 1 * buttonInterval - vertOffset / 3;
        break;
      case 2:
        posX = 3 * width / 4 - 3 * buttonInterval  + horiOffset + 4 * smallHoriOffset;
        posY = 2 * height / 3 + 2 * buttonInterval - vertOffset;
        break;
      case 3:
        posX = 3 * width / 4 - 3 * buttonInterval  + horiOffset + smallHoriOffset;
        posY = 2 * height / 3 + 3 * buttonInterval  - vertOffset;
        break;
      case 4:
        posX = 3 * width / 4 - 3 * buttonInterval  + horiOffset + smallHoriOffset;
        posY = 2 * height / 3 + 4 * buttonInterval  - vertOffset;
        break;
      case 5:
        posX = 3 * width / 4 - 3 * buttonInterval + 3 * smallHoriOffset;
        posY = 2 * height / 3 + 5 * buttonInterval - 3 *vertOffset;
        break;
    }
  }
}
