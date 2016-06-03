class Henry extends Player{
  Henry() {
    health = 100;
    strength = 10;
    mana = 100;
  }

  void punch(boolean p){
    punch = p;
  }

  void special(){
    strength += 10;
    damage(this,strength);
    strength -= 10;
  }
  
  String combo(){
    return "";
  }
  
  void display(float x, float y, String player){
    if(punch){}
    else if(state.equals("idle")){
      PImage bandit;
      bandit = loadImage("bandit_s.jpg");
      image(bandit,x,y,100,150);
    }
    else if(state.equals("walk")){}
    else if(state.equals("run")){}
  }
}