public class Mosquito extends Enemy{
    

    Mosquito (float posX,float posY){
        enemyPos = new PVector(posX,posY);
        type = 1 ;//Mosquito
        moveSpeed = 2.0;
        radius = 40;
        health = 6.5;
        attack = 1;
        curFrame = 0;
        curStatus = 0;
    }

    public void moveMosquito(PVector player){
        super.enemyVel = PVector.sub(player,enemyPos).normalize().mult(moveSpeed);
        enemyPos = enemyPos.add(enemyVel);
    }

    public void updateStatus(){
        if(curFrame%8==0){
            curStatus = (curStatus+1) % 4;
            curFrame = 0;
        }
        curFrame++;
    }
}
