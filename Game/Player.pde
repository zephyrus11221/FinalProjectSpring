abstract class Player{
  protected int health;
  protected int speed;
  protected int strength;
  
  void action(String a) {
    if (a.equals("jump")) {
      jump();
    }  
    else if (a.equals("punch")) {
      punch();
    }
    else if (a.equals("move")) {
      move();
    }
    else {
      special();
    }
  }
  abstract void jump();
  abstract void punch();
  abstract void move();
  abstract void special();
  abstract void damage(Player other, int d);
}}