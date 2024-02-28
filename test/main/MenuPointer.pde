public class MenuPointer {
  
  float posX_left;
  float posY_left;
  float posX_right;
  float posY_right;
  int wwidth;
  int wheight;
  int status;
  int smallOffset = 20;
  int buttonInterval = 50;
  PImage[] img=new PImage[2];
  public MenuPointer(int wwidth,int wheight){
    status = 0 ;
    this.wwidth=wwidth;
    this.wheight=wheight;
    updatePos();
    img[0]=loadImage("../images/Menu/Pointers/pointerLeft.png");
    img[1]=loadImage("../images/Menu/Pointers/pointerRight.png");
    img[0].resize(80,60);
    img[1].resize(80,60);
  }
  
  
  public void movePointers(int e){
    if(e==-1){
      status=(status+1)%3;
    }else if(e==1){
      if(status==0){
        status=3;
      }
      status=(status-1);
    }
    updatePos();
  }
  
  public float getPosXLeft(){return posX_left;}
  public float getPosYLeft(){return posY_left;}
  
  public float getPosXRight(){return posX_right;}
  public float getPosYRight(){return posY_right;}
  
  public int getStatus(){return status;}
  
  private void updatePos(){
    switch (status){
      case 0:
        posX_left = wwidth / 2 - 4*buttonInterval;
        posY_left = wheight / 2 + smallOffset;
        posX_right = wwidth / 2 + smallOffset;
        posY_right = wheight / 2 + smallOffset;
        break;
      case 1:
        posX_left = wwidth / 2 - 5*buttonInterval;
        posY_left = wheight / 2 + smallOffset + 2*buttonInterval;
        posX_right = wwidth / 2 + smallOffset + buttonInterval;
        posY_right = wheight / 2 + smallOffset + 2*buttonInterval;
        break;
      case 2:
        posX_left = wwidth / 2 - 4*buttonInterval;
        posY_left = wheight / 2 + smallOffset + 4*buttonInterval;
        posX_right = wwidth / 2 + smallOffset;
        posY_right = wheight / 2 + smallOffset + 4*buttonInterval;
        break;
    }      
  }
}
