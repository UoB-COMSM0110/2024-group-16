public class Boss{
    PVector pos;
    float HP;
    int radius;
    int attack;
    int actionCode;
    float moveSpeed;
    float dashSpeed;
    boolean isAlive;
    int timer;
    int shootTimer;
    
    
    PImage idle;
    PImage dash;
    PImage shoot;
    PImage dead;
    PImage BigBlobImg ;
    ArrayList<BigBlob> bb = new ArrayList<BigBlob>();
    
    Boss(){
      idle = loadImage("../images/Enemies/Boss/Soul_Master.png");
      dash = loadImage("../images/Enemies/Boss/Soul_Master_Dash.png");
      shoot = loadImage("../images/Enemies/Boss/Soul_Master_Shoot.png");
      dead = loadImage("../images/Enemies/Boss/Soul_Master_Dead.png");
      BigBlobImg = loadImage("../images/Enemies/Boss/Big_Blob/Big_Blob_00.png");
      
      pos = new PVector(100f,height/2);
      HP = 200;
      attack = 1;
      actionCode = 0;
      moveSpeed = 2.5f;
      dashSpeed = 5* moveSpeed;
      isAlive = true;
      timer = 0;
      shootTimer = 0;
      radius = 100;
    }
    
    void updateActionMode(){
      timer++;
      if(timer>180){
        timer=0;
        actionCode = (int)random(5);
      }
    }
    

    void bossAction(PVector player){
      switch (actionCode){
      case 0:
        image(idle,pos.x,pos.y);
        break;
      case 1:
        moveToPlayer(player);
        break;
      case 2:
        dashToPlayer();
        break;
      case 3:
        shootPlayer(player);
        break;
      case 4:
        shootPlayer(player);
        break;
      } 
    }
    
    void moveToPlayer(PVector player){
       PVector dir = PVector.sub(player, pos).normalize().mult(moveSpeed);
       pos.add(dir);
       image(idle,pos.x,pos.y);
    }
    
    
    void dashToPlayer(){
       PVector start = new PVector(0,height/2);
       PVector finish = new PVector(width,height/2);
       PVector dir = PVector.sub(finish,start).normalize().mult(dashSpeed);
       pos.add(dir);
       if(pos.x>width){
         pos.x = 110;
       }
       if(pos.y>height){
         pos.y = 110;
       }
       image(dash,pos.x,pos.y);
    }
    
    
    void shootPlayer(PVector player){
      shootTimer++;
      if(shootTimer%30==0){
       BigBlob tmp = new BigBlob(pos,PVector.sub(player,pos),6);
       bb.add(tmp);
       shootTimer=0;
      }
       image(shoot,pos.x,pos.y);
    }
    
    
    
    
    void moveBigBlob() {
      for (int i = bb.size()-1; i >= 0; i--) {
        BigBlob Bb = bb.get(i);
        Bb.move();
        if (Bb.pos.x <0 || Bb.pos.x > width ||
            Bb.pos.y <0 || Bb.pos.y > height) {
          bb.remove(i);
        }
      }
    }
    
    void drawBigBlob(){
      if(!bb.isEmpty()){
        for(BigBlob tmp: bb){
          image(BigBlobImg,tmp.pos.x,tmp.pos.y);
        }
      }
    }
    public void decHP(float damage){
     this.HP = this.HP - damage;
     System.out.println("boss HP = "+this.HP);
    }
    
    void drawDead(){
      image(dead,pos.x,pos.y);
    }
}
