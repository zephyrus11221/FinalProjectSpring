class Bandit extends Player{
  Bandit() {
    health = 100;
    strength = 15;
    mana = 10;
    xcor = 100;
    ycor = 550;
    right = true;
    idle = false;
    state = "walk";
    disp = new String[]{"bandit idle.png", "banditw1.png", "banditw2.png", "banditw3.png", "banditw4.png" };
  }
  void punch(Player other){
    this.damage(other, ((int) (strength * Math.random())));
  }
  void special(){
    strength += 10;
    damage(this,strength);
    strength -= 10;
  }
  void combo(){}
  
  void damage(Player other, int d) {
    other.health -= d;
  }
  void display(String player){
    if (health > 0) {
      PImage bandit;
      if(idle){
        bandit = loadImage("bandit idle.png");
      image(bandit,xcor,ycor,120,135);
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
            bandit = loadImage(disp[x]);
            //System.out.println(disp[x]);
            image(bandit,xcor,ycor,120,135);
            
          }
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