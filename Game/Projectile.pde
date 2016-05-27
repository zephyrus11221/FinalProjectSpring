class Projectile{
  PImage[] disp;
  PImage[] chase; //might be null
  int velocity;
  int health; //negative means invincible
  int yCor, front, xCor;
  boolean stun; //if projectile is able to be stopped
  
  Projectile(PImage[] main, int vel, int hp, int x, int y, int size, boolean _stun){
    disp = main;
    velocity = vel;
    health = hp;
    xCor = x;
    yCor = y;
    front = size;
    stun=_stun;
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
  
}