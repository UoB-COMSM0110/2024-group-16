public class UI{
  
  PImage HUD_main;
  PImage HUD_HP;
  PImage HUD_emptyHP;
  PImage HUD_MP;
  PImage HUD_Bomb;
  
  public UI(){
    HUD_main=loadImage("../images/HUD/HUD_main.png");
    HUD_HP=loadImage("../images/HUD/HUD_health_HP.png");
    HUD_emptyHP=loadImage("../images/HUD/HUD_health_emptyHP.png");
    HUD_emptyHP.resize(33,41);
    HUD_MP=loadImage("../images/HUD/HUD_MP.png");
    HUD_MP.resize(36,45);
  }
  

}
