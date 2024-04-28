class LoadingThread implements Runnable{
   @Override
   public void run(){
     newManager = new Manager();
     loadMusic();
     delay(5000);
     hasDone = true;
   }
}
