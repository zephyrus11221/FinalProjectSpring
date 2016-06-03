class Bandit extends Player{
  Bandit() {
    health = 100;
    strength = 15;
    mana = 10;
    xcor = 100;
    ycor = 550;
    right = true;
  }
  void punch(boolean p){
    punch = p;
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
    if(punch){}
    else if(state.equals("idle")){
      PImage bandit;
      bandit = loadImage("bandit_s.jpg");
      image(bandit,x,y,100,150);
    }
    else if(state.equals("walk")){}
    else if(state.equals("run")){}
  }
  void setx(int n){
    xcor += n;
  }  
  void sety(int n){
    ycor += n;
  }
}