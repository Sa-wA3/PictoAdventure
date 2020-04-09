
PFont font;
NanoBoardAG[] nb;
Human[] h;
int[] arrayOfPortID = {1}; 
int timer = 0;
int displayID = 0;
int counterID = 0;
int phase = 0;
int counter = 0;
int score = 0;
import ddf.minim.*;
Minim minim;
AudioPlayer Aplayer;
AudioPlayer Bplayer;
AudioPlayer Cplayer;
AudioPlayer F1player,F2player,F3player,F4player,F5player,F6player,F7player,F8player,F9player;
Player player;
Cookie cookie,cookie2;
Candy candy,candy2,candy3;
Donut donut,donut2;
Chocolate choco;
Cake cake;

void setup(){
  size(660 ,480);
  nb = new NanoBoardAG[arrayOfPortID.length];
  h  = new Human[arrayOfPortID.length];
  for(int i = 0; i< arrayOfPortID.length; i++){
    nb[i] = new NanoBoardAG(this, arrayOfPortID[i], true);  // 2モータでNanoBoardAGクラスのインスタンスを生成
  }
  font = createFont("Meiryo", 20);
  minim = new Minim(this);
  Aplayer = minim.loadFile("playmusic.mp3");
  Bplayer = minim.loadFile("gameover.mp3");
  Cplayer = minim.loadFile("gameclear.mp3");
  F1player = minim.loadFile("getsound.mp3");
  F2player = minim.loadFile("getsound.mp3");
  F3player = minim.loadFile("getsound.mp3");
  F4player = minim.loadFile("getsound.mp3");
  F5player = minim.loadFile("getsound.mp3");
  F6player = minim.loadFile("getsound.mp3");
  F7player = minim.loadFile("getsound.mp3");
  F8player = minim.loadFile("getsound.mp3");
  F9player = minim.loadFile("getsound.mp3");
  player = new Player("Picto");
  cookie = new Cookie("Cookie",470,245);
  cookie2 = new Cookie("Cookie2",580,300);
  candy = new Candy("Candy",460,150);
  candy2 = new Candy("Candy2",220,245);
  candy3 = new Candy("Candy3",560,60);
  donut = new Donut("Donut",30,50);
  donut2 = new Donut("Donut2",320,340);
  choco = new Chocolate("Chocolate",350,150);
  cake = new Cake("Cake",300,430);
}

void draw(){
   if (phase == 0){
     title();
  }else if (phase == 1){
     play(); 
  }else if (phase == 2){
     Aplayer.close();
     Bplayer.play();
     gameover();
  }else if (phase == 3){
     Aplayer.close();
     Cplayer.play();
     stage1clear();
  }
}
void title(){
  background(255);
  fill(0);
  textSize(80);
  text("Picto Adventure",25,150);
  textSize(40);
  text("←→:Slider ↑↓:Button",120,300);
  textSize(20);
  text("Music:maoudamashii",440,470);
  textSize(60);
  counter++;
  if( (counter%60) <35){
    text("Press 'Enter'",160,400);
  }
  if(keyPressed && key == ENTER){ 
    textSize(11);
    phase = 1; // play()へ
  }    
}

void play(){
  background(255);
  strokeWeight(3);
  line(0,0,0,480);
  line(0,480,660,480);
  line(660,480,660,0);
  line(660,0,0,0);
  
  line(0,320,200,320);
  line(200,320,200,400);
  line(200,400,430,400);
  
  line(430,400,430,320);
  line(430,120,430,210);
  line(320,210,320,320);
  line(320,210,110,210);
  
  line(550,480,550,120);
  line(550,120,110,120);
  
  fill(0);
  //text("NanoBoradAG No.: " + displayID, 10, 10);
  //text("Slider: " + nb[displayID].getValSlider(), 10, 20);
  //text("Light: " + nb[displayID].getValLight(), 10, 30);
  //text("Sound: " + nb[displayID].getValSound(), 10, 40);
  //text("Button: " + nb[displayID].getValButton(), 10, 50);
  //text("A: " + nb[displayID].getValResistanceA(), 10, 60);
  //text("B: " + nb[displayID].getValResistanceB(), 10, 70);
  //text("C: " + nb[displayID].getValResistanceC(), 10, 80);
  //text("D: " + nb[displayID].getValResistanceD(), 10, 90);
  //text("X: " + donut.getWidth(),10,100);
  //text("Y: " + donut.getHeight(),10,110);
  textSize(50);
  text( "Score: " + score,200,75);
  textSize(35);
  text("Start",60,420);
  text("Goal",570,450);
  textSize(11);
  Aplayer.play();
  
  cookie.show();
  cookie2.show();
  candy.show();
  candy2.show();
  candy3.show();
  donut.show();
  if(score > 40){
    choco.show();
  }
  if(score > 50){
    donut2.show();
  }
  if(score > 149){
    cake.show();
  }
  timer++;
  if (timer % 60 == 0) displayID = (displayID + 1) % arrayOfPortID.length;  
  for(int i = 0; i< arrayOfPortID.length; i++){
    nb[i].sendData();
  }
  
  
  if(nb[displayID].getValSlider() >= 75){
    player.moverightfast();
  }else if(nb[displayID].getValSlider() > 50){
    player.moverightnormal();
  }else if(nb[displayID].getValSlider() <= 25){
    player.moveleftfast(); 
  }else if(nb[displayID].getValSlider() <= 50){
    player.moveleftnormal();
  }
  //ここまで左右の移動
  
  if(nb[displayID].getValButton() > 90){
    player.moveupnormal();
  }else if(nb[displayID].getValButton() < 10 ){
    player.movedownnormal();
  }
  //ここまで上下の移動
  
  if((player.getX() > cookie.getX() - 75) && (player.getX() < cookie.getX() + 75) && (player.getY() > cookie.getY() - 74) && (player.getY() < cookie.getY() + 74)){
    F1player.play();
    cookie.touched();
  }
  if((player.getX() > candy.getX() - 100) && (player.getX() < candy.getX() + 100) && (player.getY() > candy.getY() - 41) && (player.getY() < candy.getY() + 41)){
    F2player.play();
    candy.touched(); 
  }
  if((player.getX() > donut.getX() - 125) && (player.getX() < donut.getX() + 125) && (player.getY() > donut.getY() - 104) && (player.getY() < donut.getY() + 30)){
    F3player.play();
    donut.touched();
  }
  if((score > 40) && (player.getX() > choco.getX() - 40) && (player.getX()< choco.getX() + 40) && (player.getY() > choco.getY() - 60) && (player.getY() < choco.getY() + 60)){
    F4player.play();
    choco.touched();
  }
  if((player.getX() > candy2.getX() - 20) && (player.getX() < candy2.getX() + 100) && (player.getY() > candy2.getY() - 41) && (player.getY() < candy2.getY() + 41)){
    F5player.play();
    candy2.touched(); 
  }
  if((score > 40) && (player.getX() > donut2.getX() - 60) && (player.getX() < donut2.getX() + 60) && (player.getY() > donut2.getY() - 40) && (player.getY() < donut2.getY() + 40)){
    F6player.play();
    donut2.touched();
  }
  if((player.getX() > candy3.getX() - 20) && (player.getX() < candy3.getX() + 100) && (player.getY() > candy3.getY() - 41) && (player.getY() < candy3.getY() + 41)){
    F7player.play();
    candy3.touched(); 
  }
  if((player.getX() > cookie2.getX() - 30) && (player.getX() < cookie2.getX() + 75) && (player.getY() > cookie2.getY() - 74) && (player.getY() < cookie2.getY() + 74)){
    F8player.play();
    cookie2.touched();
  }
  if((score > 149) && (player.getX() > cake.getX() -70) && (player.getX() < cake.getX() + 70) && (player.getY() > cake.getY() - 40) && (player.getY() < cake.getY() + 40)){
    F9player.play();
    cake.touched();
  }
  
  
  
  //以下、ゲームオーバーへの遷移
  if((player.getX() - 26) < 1){
    phase = 2; 
  }
  //leftside
  
  if((player.getX() + 26) > width + 2){
    phase = 2;
  }
  //rightside
  
  if((player.getY() - 14) < 1){
    phase = 2;
  }
  //downside
  if((player.getX() > 200) && (player.getY() > 460)){
    phase = 2;
  }
  
  if((player.getX() > 0) && (player.getX() < 200) && (player.getY() > 300) && (player.getY() < 340)){
    phase = 2;
  }
  if((player.getX() > 180) && (player.getX() < 220) && (player.getY() > 320) && (player.getY() < 400)){
    phase = 2;
  }
  if((player.getX() > 200) && (player.getX() < 430) && (player.getY() > 380) && (player.getY() < 420)){
    phase = 2;
  }
  if((player.getX() > 410) && (player.getX() - 15 < 450) && (player.getY() > 320) && (player.getY() < 400)){
    phase = 2;
  }
  if((player.getX() > 410) && (player.getX() - 15 < 450) && (player.getY() > 120) && (player.getY() < 210)){
    phase = 2;
  }
  if((player.getX() + 10 > 530) && (player.getX() < 570) && (player.getY() > 120) && (player.getY() < 480)){
    phase = 2;
  }
  if((player.getX() > 110) && (player.getX() < 550) && (player.getY() > 100) && (player.getY() < 140)){
    phase = 2;
  }
  if((player.getX() + 15 > 300) && (player.getX() - 15 < 340) && (player.getY() > 210) && (player.getY() < 320)){
    phase = 2;
  }
  if((player.getX() > 110) && (player.getX() < 320) && (player.getY() > 190) && (player.getY() < 230)){
    phase = 2;
  }
   
  if((player.getX() > 550) && ((player.getY() + 14) > 450)){
    phase = 3;
  }
}
void gameover(){
  background(0);
  fill(255);
  textSize(80);
  text("Game Over", 110,150);
  textSize(60);
  text("Let's try again!!",110,300);
  counter++;
  if( (counter%60) <35){
  text("Quit→ 'Enter'",150,450);
  }
  if(keyPressed && key == ENTER){ 
    textSize(11);
    exit();
  }
}
void stage1clear(){
  background(255);
  fill(0);
  textSize(80);
  text("Game Clear!", 100,150);
  textSize(50);
  text("Your Score:" + score,160,230);
  textSize(60);
  text("Thank you for playng!",15,360);
  counter++;
  if( (counter%60) <35){
    text("Quit→ 'Enter'",150,450);
  }
  if(keyPressed && key == ENTER){ 
    textSize(11);
    exit();
  }
}
void dispose() {
 for(int i = 0; i< arrayOfPortID.length; i++){
    nb[i].dispose();
  }
}


void serialEvent(Serial p){
  for(int i = 0; i< arrayOfPortID.length; i++){
    nb[i].serialEvent(p);
  }
}
