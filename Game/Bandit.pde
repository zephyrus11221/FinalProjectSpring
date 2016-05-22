class Bandit extends Player{
  Bandit() {
    health = 100;
    strength = 15;
    mana = 10;
  }
  void punch(){
    damage(this,strength);
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
  void display(float x, float y, String player){
    PImage bandit;
    bandit = loadImage("bandit_s.jpg");
    image(bandit,x,y,100,150);
    
  };
}