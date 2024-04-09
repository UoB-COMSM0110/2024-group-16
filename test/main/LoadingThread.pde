class LoadingThread implements Runnable{
   @Override
   public void run(){
     newManager = new Manager();
     delay(5000);
     hasDone = true;
   }
}
