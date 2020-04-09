import processing.serial.*;

class NanoBoardAG {

  Serial myPort;

  int  index = 0;
  byte  sendData = 0x00;

  // センサー用変数
  double valSlider;
  double valLight;
  double valSound;
  double valButton;
  double valResistanceA;
  double valResistanceB;
  double valResistanceC;
  double valResistanceD;

  // モーター用変数
  byte motorDirection = 0;
  byte isMotorOn = 0;
  byte motorPower = 0;
  
  // 2モーター用変数
  byte motorDirectionA = 0;
  byte isMotorOnA = 0;
  byte motorPowerA = 0;
  byte motorDirectionB = 0;
  byte isMotorOnB = 0;
  byte motorPowerB = 0;

  // 2モーターかのフラグ
  boolean is2motor = false;

  int timer = 0;

  int maxNumReadings = 18;
  int[] data = new int[maxNumReadings];
  int   val;

  NanoBoardAG(PApplet p, int num, boolean is2motor){
    // ポート番号の指定通常は 0 0でだめなら1,2,と順次増やして行く
    String port = Serial.list()[0];
    printArray(Serial.list());
    myPort = new Serial(p, port, 38400);
    this.is2motor = is2motor;
  }

  NanoBoardAG(PApplet p, int num){
    this(p, num, false);    
  }

  

  // スライダーの値の取得　0-100
  double getValSlider(){
    return valSlider;
  }

  // 光センサーの値の取得　0-100
  double getValLight(){
    return valLight;
  }

  // 音センサーの値の取得　0-100
  double getValSound(){
    return valSound;
  }

  // ボタンが押されているか? 0 押されていない, 100 押されている
  double getValButton(){
    return valButton;
  }
  
  //  抵抗Aの値　繋がっていると0
  double getValResistanceA(){
    return valResistanceA;
  }

  //  抵抗Bの値　繋がっていると0  
  double getValResistanceB(){
    return valResistanceB;
  }
  
  //  抵抗Cの値　繋がっていると0
  double getValResistanceC(){
    return valResistanceC;
  }

  //  抵抗Dの値　繋がっていると0  
  double getValResistanceD(){
    return valResistanceD;
  }

  // モーターパワーのセット 0〜100, 100が最速
  void setMotorPower(double power){
    motorPower = (byte)(power * 1.28);     
  }

  // モーターの回転方向を反転
  void reverseMotorDirection(){
    motorDirection = (byte)((motorDirection + 1)  & 0x1);
  }

  // モーターAパワーのセット 0〜100, 100が最速
  void setMotorPowerA(double power){
    motorPowerA = (byte)(power * 1.28);     
  }
  
  // モーターAの回転方向を反転
  void reverseMotorDirectionA(){
    motorDirectionA = (byte)((motorDirectionA + 1)  & 0x1);
  }

  // モーターBパワーのセット 0〜100, 100が最速
  void setMotorPowerB(double power){
    motorPowerB = (byte)(power * 1.28);     
  }
  
  // モーターBの回転方向を反転
  void reverseMotorDirectionB(){
    motorDirectionB = (byte)((motorDirectionA + 1)  & 0x1);
  }

  // NanoBoardAGにモータの制御情報を送出
  void sendData(){
    if (is2motor){
      myPort.write(motorDirectionA << 7 | (motorPowerA >> 4 ) << 4 | motorDirectionB << 3 | motorPowerB >> 4 );
    } else {
      myPort.write(motorDirection << 7 | motorPower);
    }
  }

  // 終了時にモーターを止める
  void dispose(){    
    myPort.write(0);
  }

  // NanoBoardAGから各種センサデータを受け取ったら呼ばれるメソッド
  void serialEvent(Serial p){

    if (p != myPort) return;
    val = myPort.read();  
    data[index] = val;

    if (val >= 0xF8) index = 0;
    if (index == maxNumReadings - 1){
      // These values are decided by Scratch Board Technical Information
      valResistanceD = ((data[2] & 0x07) * 128 + data[3])*100/1023.0; 
      valResistanceC = ((data[4] & 0x07) * 128 + data[5])*100/1023.0; 
      valResistanceB = ((data[6] & 0x07) * 128 + data[7])*100/1023.0; 
      valButton = 100 - ((data[8] & 0x07) * 128 + data[9])*100/1023.0; 
      valResistanceA = ((data[10] & 0x07) * 128 + data[11])*100/1023.0; 
      valLight = 100- ((data[12] & 0x07) * 128 + data[13])*100/1023.0;
      valSound = ((data[14] & 0x07) * 128 + data[15])*100/1023.0;
      valSlider = ((data[16] & 0x07) * 128 + data[17])*100/1023.0; 
    }
    index = (++index) % maxNumReadings;  
  }

}
