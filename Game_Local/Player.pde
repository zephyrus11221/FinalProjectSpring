abstract class Player{
  //Bandit, Jack, Henry, Davis
  String[] disp;
  int health;
  int strength;
  int mana;
  int x, y, time;
  boolean punch, right, idle;
  String state;
  
  void combo(String a){};
  void display(String player){}
  int xcor,ycor;
  void punch(Player other){};
  void damage(Player other, int d){};
  void setx(int n){};
  void sety(int n){};
}