class LoadingThread implements Runnable{
   @Override
   public void run(){
     newManager = new Manager();
     delay(2000);
     hasDone = true;
   }
}
