class Food{
  private String name; 
  int x;
  int y;
  PImage stand2;

  Food(String name, int x, int y) {
    this.name = name;
    this.x = x;
    this.y = y;
  }
  
  void setXY(int x, int y){
     this.x = x;
     this.y = y;
  }

  int getX(){
    return x;
  }

  int getY() {
     return y;
  } 
  
  int getHeight(){
    
     return stand2.height;
  }
  
  int getWidth(){
     return stand2.width;
  }
  
  void show(){
      image(stand2, x,y,stand2.width/3,stand2.height/3);
  }
  
  String getName() {
    return this.name;
  }

  void setName(String name) {
    this.name = name;
  }
}
