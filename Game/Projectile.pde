class Projectile{
  PImage[] disp;
  PImage[] chase; //might be null
  int velocity;
  int health; //negative means invincible
  int yCor, front, xCor, time, frames;
  boolean stun; //if projectile is able to be stopped
  boolean test = false; //not a real projectile if true
  
  Projectile(int x, int y){
    test = true;
    xCor = x;
    yCor = y;
    velocity = 3;
    frames = 1;
  }
  
  Projectile(PImage[] main, int vel, int hp, int x, int y, int size, boolean _stun){
    disp = main;
    velocity = vel;
    health = hp;
    xCor = x;
    yCor = y;
    front = size;
    stun=_stun;
    time= millis();
    frames = disp.length;
  }
  
  boolean die(int pX, int pY){
    if (yCor+6>pY&&yCor-6<pY){
      if (xCor+front>pX&&xCor-front<pX){
        disp = null;
        chase = null;
        return true;
      }
    }
    return false;
  }
  
  int xCor(){
    return xCor;
  }
  
  void display(){
    if(millis()-time>1000){
      time = millis();
    }
    for(int x = 1; x<=frames; x++){
      if(millis()-time<1000/frames*x){
        xCor+=velocity;
        System.out.println("hi");
        if (test){
          text("hi", xCor, yCor);
        }else{
          image(disp[x-1], xCor, yCor);
          if (chase!=null){
            image(chase[x-1], xCor, yCor);
          }
        }
      }
    }
  }
}