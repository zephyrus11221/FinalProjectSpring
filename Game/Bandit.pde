class Bandit extends Player{
  Bandit() {
    health = 100;
    strength = 15;
    mana = 10;
    xcor = 100;
    ycor = 150;
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
  void display(String player){
    PImage bandit;
    bandit = loadImage("bandit_s.jpg");
    image(bandit,xcor,ycor,100,150);
    
  }
  void setx(int n){
    xcor += n;
  }  
  void sety(int n){
    ycor += n;
  }
}