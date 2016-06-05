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
  
  void combo(){}
  
  void display(float x, float y, String player){
    PImage bandit;
    bandit = loadImage("bandit_s.jpg");
    image(bandit,x,y,100,150);
    
  };
}