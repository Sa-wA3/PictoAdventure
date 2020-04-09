class Player extends Human {
  Player(String name) {
    super(name,40,height);
    stand = loadImage("you.png");
    stand.resize(stand.width/5,stand.height/5);
  }
  void moverightnormal(){
    setXY(x + 1,y);
    super.update();
  }
  void moverightfast(){
    setXY(x + 2,y);
    super.update();
  }
  void moveleftnormal(){
    setXY(x - 1,y);
    super.update();
  }
  void moveleftfast(){
    setXY(x - 2,y);
    super.update();
  }
  void moveupnormal(){
    setXY(x ,y + 2); 
  }
  void movedownnormal(){
    setXY(x ,y - 2);
  }
}
