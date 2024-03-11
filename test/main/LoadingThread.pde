class LoadingThread implements Runnable{
   @Override
   public void run(){
     newManager = new Manager();
     delay(1000);
     hasDone = true;
   }
}
