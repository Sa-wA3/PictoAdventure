class Candy extends Food{
  Candy(String name, int x, int y){ 
    super(name,x,y); 
    stand2 = loadImage("candy.png");
  }
  void normal(){
    setXY(x,y);
    super.show();
  }
  void touched(){
    setXY(x,y - 500);
    super.show();
    score += 10;
  }
}
