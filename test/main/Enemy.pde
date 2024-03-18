public class Enemy{
  //Position
  PVector enemyPos;
  PVector enemyVel;
  
  //Character properties
  float moveSpeed;
  float attack;
  float health;
  float radius;
  int type;

  //Auxiliary variable 
  int curFrame = 0;
  int curStatus = 0;
  int lastShootTime;
  
}
