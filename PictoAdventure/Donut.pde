class Donut extends Food{
  Donut(String name, int x, int y){ 
    super(name,x,y); 
    stand2 = loadImage("donut.png");
    stand2.resize(stand2.width/2,stand2.height/2);
  }
  void normal(){
    setXY(x,y);
    super.show();
  }
  void touched(){
    setXY(x,y - 500);
    super.show();
    score += 30;
  }
}
