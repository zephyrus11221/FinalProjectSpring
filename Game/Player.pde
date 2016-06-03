abstract class Player{
  //Bandit, Henry, Davis
  PImage[] disp;
  int health;
  int strength;
  int mana;
  int x, y;
  String state = "idle";
  boolean punch, right;
  
  void combo(String a){};
  void display(String player){}
  int xcor,ycor;
  void punch(){};
  void damage(Player other, int d){};
  void setx(int n){};
  void sety(int n){};
}