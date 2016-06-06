class Henry extends Player{
  Henry(int xcor,int ycor,boolean face) {
    health = 100;
    strength = 7;
    mana = 100;
    this.xcor = xcor;
    this.ycor = ycor;
    right = face;
    block = 3;
    idle = false;
    state = "walk";
    disp = new String[]{"henry idle.png", "henryw1.png", "henryw2.png", "henryw3.png", "henryw4.png", "Henry arrow.png", "henry arrow 1.png"
    , "henry arrow 2.png", "henry arrow 3.png", "henry arrow 4.png", "henry arrow 5.png", "henry arrow 6.png"};
  }
 // String[] arrow = new String[1];

  //Projectile punch(boolean p){
   // punch = p;
    //return Projectile a = new Projectile(arrow, null, 30, 1, xcor, ycor, 5, true);
  //}
  void punch(Player other){
    this.damage(other, ((int) (strength * Math.random())));
  }
  void special(){
    strength += 10;
    damage(this,strength);
    strength -= 10;
  }
  void damage(Player other, int d) {
    other.health -= d;
  }
  Projectile combo(byte[] input){
    if(input[5]==8 && input[6]==8 && input[0]==8 && mana > 30){      
      println("working");
      mana-=30;
      return new Projectile(new String[]{disp[6],disp[7],disp[8],disp[9],disp[10],disp[11]}, new String[0], -35, -1, xcor, ycor, 20, false);
    }
    else if(input[5]==8 && input[6]==8 && input[3]==8 && mana > 30){
      mana-=30;
      return new Projectile(new String[]{disp[6],disp[7],disp[8],disp[9],disp[10],disp[11]}, new String[0], 35, -1, xcor, ycor, 20, false);
    }
    
    return null;
  }
    void setx(int n){
    xcor += n;
  }  
  void sety(int n){
    ycor += n;
  }
  void display(String player){
    if (health > 0) {
      PImage henry;
      if(idle){
        if(right){
          henry = loadImage(disp[0]);
          image(henry,xcor,ycor,120,135);
        }else{          
          henry = loadImage("l"+disp[0]);
          image(henry,xcor,ycor,120,135);
        } 
      }
      else if(state == "walk"){
        boolean display;
        int nTime = millis();
        if(nTime-time>330){
        time = millis(); 
      }
      display = true;
      for(int x = 0; x<4; x++){
        if(nTime-time<(110)*x && display){
          display = false;        
          if(right){
            henry = loadImage(disp[x]);
            image(henry,xcor,ycor,120,135);
          }else{          
            henry = loadImage("l"+disp[x]);
            image(henry,xcor,ycor,120,135);
          }
        }
      }
    }
  }
}
}