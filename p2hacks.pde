import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;
String typedText = "";  // 入力されたテキストを保持する変数
int textBoxX = 120;     // テキストボックスのX座標
int textBoxY = 340;     // テキストボックスのY座標
int textBoxWidth = 1309; // テキストボックスの幅
int textBoxHeight = 96; // テキストボックスの高さ
int maxLength = 20;
int scene = 0;
import processing.video.*; 
Minim minim;
AudioPlayer player;
Capture cam; 
//String typedText = ""; 
PImage asobikata; 
PImage news;
PImage top;
PImage sinbun;
PImage hiduke;
PImage komento;
PImage syuryo;
PImage puropo;
PImage saisei;
PImage arai;
PImage mono;
PImage pu;
PImage rin;
PImage currentImage1;
PImage currentImage2;
PImage currentImage3;
int selectedCamera = 0; 
float startTime1,startTime2;
boolean isRectangleVisible1 = false,isRectangleVisible2 = false;
float lastTime1 = 0,lastTime2 = 0;
int startTime = 0; 
int elapsedTime = 0;

void setup() {
  textSize(90);
  textAlign(LEFT, TOP);
  // 日本語フォントの設定
  //PFont font = createFont("Meiryo", 32);
  //textFont(font);
  size(1600, 1200); 
  frameRate(30); 
  startTime = millis(); 
  PFont font = createFont("Meiryo", 90); 
  textFont(font);
  currentImage1 = puropo;
  currentImage2 = arai;
  currentImage3 = pu;

  String[] cameras = Capture.list(); 
  
  minim = new Minim(this);
  player = minim.loadFile("kisyakaiken.mp3");
  println("利用可能なカメラ:");
  for (int i = 0; i < cameras.length; i++) {
    println(i + ": " + cameras[i]);
  }
 
  
  cam = new Capture(this, cameras[selectedCamera]);
  cam.start();

  
  news = loadImage("news.png");
  top = loadImage("top.png");
  asobikata = loadImage("asobikata.png");
  sinbun = loadImage("sinbun.png");
  hiduke = loadImage("hiduke.png");
  komento = loadImage("komento.png");
  syuryo = loadImage("syuryo.png");
  puropo = loadImage("puropo.png");
  saisei = loadImage("saisei.png");
  arai = loadImage("arai.png");
  mono = loadImage("mono.png");
  pu = loadImage("pu.png");
  rin = loadImage("rin.png");

}


void draw() {
  // fill(255);
  // stroke(0);
  // rect(textBoxX, textBoxY, textBoxWidth, textBoxHeight);
  
  // // 入力されたテキストを描画
  // fill(0);
  // text(typedText, textBoxX + 10, textBoxY + 10);
 
  if (scene == 1 && !player.isPlaying()) {
    player.loop(); 
  } else if (scene != 1 && player.isPlaying()) {
    player.pause();  
  }
  
  if(scene == 0){
    top();
  }else if(scene == 1){
    camera();
    elapsedTime = (millis() - startTime)/1000;
  }else if(scene == 2){
    asobikata();
  }else if(scene == 3){
    memory();
  }else if(scene == 4){
    movie1();
  }else if(scene == 5){
    movie2();
  }else if(scene == 6){
    movie3();
  }
 


}
// void keyTyped() {
//   // キー入力が日本語でも処理できるように
//   if (key == BACKSPACE && typedText.length() > 0) {
//     // バックスペースが押されたとき
//     typedText = typedText.substring(0, typedText.length() - 1);
//   } else {
//     // 日本語を含む文字の入力を受け入れる
//     typedText += key;
//   }
// }
 void mousePressed() {
  // クリック位置でシーンを切り替える
  if ((mouseX >= 881 && mouseX <= 881 + 186 && mouseY >= 60 && mouseY <= 60 + 104) &&(scene == 0 || scene == 2 || scene == 3)) {
    scene = 0; // rect(881, 60, 186, 104)をクリックするとscene = 0
  } else if ((mouseX >= 1075 && mouseX <= 1075 + 290 && mouseY >= 62 && mouseY <= 62 + 102)&&(scene == 0 || scene == 2 || scene == 3)) {
    scene = 3; // rect(1075, 62, 290, 102)をクリックするとscene = 3
  } else if ((mouseX >= 1416 && mouseX <= 1416 + 108 && mouseY >= 53 && mouseY <= 53 + 108)&&(scene == 0 || scene == 2 || scene == 3)) {
    scene = 2; // rect(1416, 53, 108, 108)をクリックするとscene = 2
  } else if ((mouseX >= 421 && mouseX <= 421 + 761 && mouseY >= 784 && mouseY <= 784 + 457)&&(scene==0)) {
    scene = 1; // rect(421, 784, 761, 457)をクリックするとscene = 1
    startTime = millis();
  } else if ((mouseX >= 1232 && mouseX <= 1232 + 294 && mouseY >= 48 && mouseY <= 48 + 134)&&(scene==1)){
    scene = 3;
  } else if ((mouseX >= 111 && mouseX <= 111 + 368 && mouseY >= 405 && mouseY <= 405 + 289)&&(scene==3)){
    currentImage1 = puropo;
    scene = 4;//動画を再生する画面に移る！！！！
  }else if ((mouseX >= 615 && mouseX <= 615 + 368 && mouseY >= 405 && mouseY <= 405 + 289)&&(scene==3)){
    currentImage2 = arai;
    scene = 5;//動画を再生する画面に移る！！！！
  }else if ((mouseX >= 1119 && mouseX <= 1119 + 368 && mouseY >= 405 && mouseY <= 405 + 289)&&(scene==3)){
    currentImage3 = pu;
    scene = 6;//動画を再生する画面に移る！！！！
  }
   else if ((mouseX >= 1274 && mouseX <= 1274 + 294 && mouseY >= 1051 && mouseY <= 1051 + 134)&&(scene==4||scene == 5||scene == 6)){
    scene = 3;//メモリーにもどる！！！！
  } else if((mouseX >= 701 && mouseX <= 701 + 197 && mouseY >= 528 && mouseY <= 528 + 197)&&(scene==4)){
    if (currentImage1==saisei) {
      currentImage1 = puropo;  // img1 -> img2 に切り替え
    } else {
      currentImage1 = saisei;  // img2 -> img1 に切り替え
    }//再生と停止を切り替える
  }
    else if((mouseX >= 701 && mouseX <= 701 + 197 && mouseY >= 528 && mouseY <= 528 + 197)&&(scene==5)){
    if (currentImage2==arai) {
      currentImage2 = mono;  // img1 -> img2 に切り替え
    } else {
      currentImage2 = arai;  // img2 -> img1 に切り替え
    }
  }//再生と停止を切り替える
    else if((mouseX >= 701 && mouseX <= 701 + 197 && mouseY >= 528 && mouseY <= 528 + 197)&&(scene==6)){
    if (currentImage3==pu) {
      currentImage3 = rin;  // img1 -> img2 に切り替え
    } else {
      currentImage3 = pu;  // img2 -> img1 に切り替え
    }//再生と停止を切り替える
  }
}