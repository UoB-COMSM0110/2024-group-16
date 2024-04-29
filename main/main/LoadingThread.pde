class LoadingThread implements Runnable{
   @Override
   public void run(){
     newManager = new Manager();
     loadMusic();
     delay(4000);
     hasDone = true;
   }
}
