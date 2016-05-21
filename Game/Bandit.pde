class Bandit extends Player{
  Bandit() {
    health = 100;
    speed = 10;
    strength = 15;
  }
  
  void jump() {
  }
  void punch(){
    damage(this,strength);
  }
  void move(){
  }
  void special(){
    strength += 10;
    damage(this,strength);
    strength -= 10;
  }
  void damage(Player other, int d) {
    other.health -= d;
  }
}