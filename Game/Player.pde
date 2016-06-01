abstract class Player{
  //Bandit, Jack, Henry, Davis
  PImage[] disp;
  int health;
  int strength;
  int mana;
  int x, y;
  boolean punch;
  
  void combo(String a){};
  void display(String player){}
  int xcor,ycor;
  void punch(){};
  void damage(Player other, int d){};
  void setx(int n){};
  void sety(int n){};
}