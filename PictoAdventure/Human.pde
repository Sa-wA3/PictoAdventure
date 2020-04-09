class Human{
  private String name; 
  int x;
  int y;
  PImage stand;

  Human(String name, int x, int y) {
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
    
     return stand.height;
  }
  
  int getWidth(){
     return stand.width;
  }
  
  void update(){
      image(stand, (int)(x - stand.width/2), (int)(y - stand.height/2 ), stand.width, stand.height);
  }
  
  String getName() {
    return this.name;
  }

  void setName(String name) {
    this.name = name;
  }
}