class Bandit extends Player{
  int punchTime;
  Bandit(int xcor, int ycor, boolean face) {
    health = 100;
    strength = 10;
    mana = 10;
    this.xcor = xcor;
    this.ycor = ycor;
    right = face;
    block = 3;
    punchTime = 0;
    idle = false;
    state = "walk";
    disp = new String[]{"bandit idle.png", "banditw1.png", "banditw2.png", "banditw3.png", "banditw4.png", "banditj.png", "banditb.png"
    , "banditp1.png", "banditp2.png", "banditp3.png", "banditp4.png"};
  }
  void punch(Player other){
    int timeNow = millis();
    println("okay");
    if (timeNow - punchTime > 100) {
      System.out.println("punch");
      this.damage(other, ((int) (strength * Math.random())));
      punchTime = timeNow;
    }
    else {
      state = "idle";
    }
  }
  void special(){
    strength += 10;
    damage(this,strength);
    strength -= 10;
  }
  void combo(Player other){}
  
  void damage(Player other, int d) {
    other.health -= d;
  }
  void display(String player){
    if (health > 0) {
      PImage bandit;
      if(state.equals("idle")){
        if(right){
          bandit = loadImage(disp[0]);
          image(bandit,xcor,ycor,120,135);
        }else{          
          bandit = loadImage("l"+disp[0]);
          image(bandit,xcor,ycor,120,135);
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
              bandit = loadImage(disp[x]);
              image(bandit,xcor,ycor,120,135);
            }else{          
              bandit = loadImage("l"+disp[x]);
              image(bandit,xcor,ycor,120,135);
            }
          }
        }
      }
      else if(state == "jumping"){
        if(right){
          bandit = loadImage(disp[5]);
          image(bandit,xcor,ycor,120,135);
        }else{          
          bandit = loadImage("l"+disp[5]);
          image(bandit,xcor,ycor,120,135);
        } 
      }
      else if(state == "punch"){
        boolean display;
        int nTime = millis();
        if(nTime-time>450){
          time = millis();
        }
        display = true;
        for(int x = 0; x<4; x++){
          if(nTime-time<(150)*x && display){
            display = false;
            if(right){
              bandit = loadImage(disp[x+7]);
              image(bandit,xcor,ycor,120,135);
            }else{          
              bandit = loadImage("l"+disp[x+7]);
              image(bandit,xcor,ycor,120,135);
            }
          }
        }
      }
      else if(state == "block"){
        if(right){
          bandit = loadImage(disp[6]);
          image(bandit,xcor,ycor,110,123);
        }else{          
          bandit = loadImage("l"+disp[6]);
          image(bandit,xcor,ycor,110,123);
        } 
      }
    }
  }
    void setx(int n){ 
    xcor += n;
  }  
  void sety(int n){
    ycor += n;

  }
}