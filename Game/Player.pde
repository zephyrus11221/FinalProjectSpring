abstract class Player{
  //Bandit, Jack, Henry, Davis
  int health;
  int strength;
  int mana;
  
  void combo(String a){};
  void punch(){};
  void damage(Player other, int d){};
  void display(float x, float y, String player){}
}