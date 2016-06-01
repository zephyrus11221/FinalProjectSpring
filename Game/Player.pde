abstract class Player{
  //Bandit, Jack, Henry, Davis
  PImage[] disp;
  int health;
  int strength;
  int mana;
<<<<<<< HEAD
  int x, y;
  boolean punch;
  
  void combo(String a){};
  void display(float x, float y, String player){}
=======
  int xcor,ycor;
  void combo(String a){};
  void punch(){};
  void damage(Player other, int d){};
  void display(String player){}
  void setx(int n){};
  void sety(int n){};
>>>>>>> 8f51bd0c1f9649242fabbfe54758990169fd1424
}