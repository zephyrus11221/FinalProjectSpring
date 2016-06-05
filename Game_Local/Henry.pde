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
    disp = new String[]{"henry idle.png", "henryw1.png", "henryw2.png", "henryw3.png", "henryw4.png", "Henry arrow", "henry arrow 1"
    , "henry arrow 2", "henry arrow 3", "henry arrow 4", "henry arrow 5", "henry arrow 6"};
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
  
  void display(String player){
    if (health > 0) {
      PImage henry;
      if(idle){
        henry = loadImage(disp[0]);
      image(henry,xcor,ycor,120,135);
      }
      else if(state == "walk"){
        boolean display;
        int nTime = millis();
        if(nTime-time>440){
          time = millis();
        }
        display = true;
        for(int x = 0; x<4; x++){
          if(nTime-time<(110)*x && display){
            display = false;
            henry = loadImage(disp[x]);
            //System.out.println(disp[x]);
            image(henry,xcor,ycor,120,135);
          
          }
        }
      }
    }
  }
}