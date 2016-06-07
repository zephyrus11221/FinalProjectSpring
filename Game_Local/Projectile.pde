class Projectile{
  String[] disp;
  String[] chase; //might be null
  int velocity;
  int health; //negative means invincible
  int yCor, front, xCor, time, frames;
  boolean stun; //if projectile is able to be stopped
  boolean test = false; //not a real projectile if true
  boolean display;
  int damage;
  
  Projectile(int x, int y){
    test = true;
    xCor = x;
    yCor = y;
    velocity = 30;
    frames = 5;
  }
  
  Projectile(String[] main, String[] ch, int vel, int hp, int x, int y, int size, boolean _stun, int d){
    disp = main;
    chase = ch;
    velocity = vel;
    health = hp;
    xCor = x;
    yCor = y;
    front = size;
    stun=_stun;
    time= millis();
    frames = disp.length;
  }
  
  boolean die(Player p){
    if (yCor+6>p.ycor&&yCor-6<p.ycor){
      if (xCor+front>p.xcor&&xCor-front<p.xcor){
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
    int nTime = millis();
    if(nTime-time>1000){
      time = millis();
    }
    display = true;
    for(int x = 0; x<=frames; x++){
      if(nTime-time<(1000/frames)*x && display){
        display = false;
        xCor+=velocity;
        if (test){
          //System.out.println(x);
          text(""+x, xCor, yCor);
        }else{
          if(velocity<0){
            PImage p = loadImage("l"+disp[x-1]);
            image(p, xCor, yCor);
            if (chase!=null){
              PImage c = loadImage("l"+chase[x-1]);
              image(c, xCor, yCor);
            }
          }
          else{
            PImage p = loadImage(disp[x-1]);
            image(p, xCor, yCor);
            if (chase!=null){
              PImage c = loadImage(chase[x-1]);
              image(c, xCor, yCor);
            }
          }
        }
      }
    }
  }
}