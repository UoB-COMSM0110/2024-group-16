class LoadingThread implements Runnable{
   @Override
   public void run(){
     newManager = new Manager();
     loadMusic();
     hasDone = true;
   }
}
