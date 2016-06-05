class Henry extends Player{
  Henry() {
    health = 100;
    strength = 10;
    mana = 100;
    xcor = 100;
    ycor = 550;
    right = true;
    idle = false;
    state = "walk";
    disp = new String[]{"bandit idle.png", "banditw1.png", "banditw2.png", "banditw3.png", "banditw4.png" };
  }
 // String[] arrow = new String[1];

  //Projectile punch(boolean p){
   // punch = p;
    //return Projectile a = new Projectile(arrow, null, 30, 1, xcor, ycor, 5, true);
  //}
  
  void combo(byte[] input){
    if (input[4]==8 && input[5]==8 && input[6]==8){
    }
  }
  
  void display(float x, float y, String player){
    PImage bandit;
    bandit = loadImage("bandit_s.jpg");
    image(bandit,x,y,100,150);
    
  };
}