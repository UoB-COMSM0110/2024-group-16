public class OptionPointer{
  float posX;
  float posY;
  int status;
  int smallOffset = 20;
  int buttonInterval = 50;
  PImage[] img=new PImage[1];
  
  public OptionPointer(){
    status = 0 ;
    updatePos();
    img[0]=loadImage("../images/Options/Cursor.png");
    img[0].resize(60,40);
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
  
  public float getPosX(){return posX;}
  public float getPosY(){return posY;}
  
  public int getStatus(){return status;}
  
  private void updatePos(){
    switch (status){
      case 0:
        posX = width / 2 + smallOffset;
        posY = height / 2 + smallOffset;
        break;
    }
  }
}
