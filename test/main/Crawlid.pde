public class Crawlid extends Enemy{
    

    Crawlid (float posX,float posY){
        enemyPos = new PVector(posX,posY);
        type = 0 ;//Crawlid
        moveSpeed = 2.0;
        radius = 40;
        health = 6.5;
        attack = 1;
        curFrame = 0;
        curStatus = 0;
    }

    public void moveCrawlid(PVector player){
        super.enemyVel = PVector.sub(player,enemyPos).normalize().mult(moveSpeed);
        enemyPos = enemyPos.add(enemyVel);
    }
    


    public void updateStatus(){
        if(curFrame%8==0){
            curStatus = (curStatus+1) % 3;
            curFrame = 0;
        }
        curFrame++;
    }
}
