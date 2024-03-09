public class OptionPointer{
  float posX;
  float posY;
  int status;
  int horiOffset = 150;
  int smallHoriOffset = 30;
  int vertOffset = 20;
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
  
  public int getStatus(){return status;}
  //public void setStatus(int newStatus){status = newStatus;}
  
  private void updatePos(){
    switch (status){
      case 0: 
        posX = width / 2  + horiOffset +smallHoriOffset/2;
        posY = height/2 - 4*buttonInterval + vertOffset;
        break;
      case 1:
        posX = width / 2  + horiOffset + smallHoriOffset;
        posY = height/2 - 3*buttonInterval  + vertOffset;
        break;
      case 2:
        posX = width / 2  + horiOffset + smallHoriOffset;
        posY = height/2 - 2*buttonInterval  + vertOffset;
        break;
      case 3:
        posX = width / 2  + horiOffset - smallHoriOffset;
        posY = height/2 - buttonInterval  + vertOffset;
        break;
      case 4:
        posX = width / 2  + horiOffset - smallHoriOffset;
        posY = height/2  + vertOffset;
        status = 0;
        break;
      case 5:
        posX = width / 2 ;
        posY = height/2 + buttonInterval + vertOffset;
        break;
    }
  }
}
