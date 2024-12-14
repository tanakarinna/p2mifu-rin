import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;
int scene = 0;
import processing.video.*; 
Minim minim;
AudioPlayer player;
Capture cam; 
String typedText = ""; // 入力された文字列を保存する変数
PImage asobikata; 
PImage news;
PImage top;
PImage sinbun;
PImage hiduke;
PImage komento;
int selectedCamera = 0; 
float startTime1,startTime2;
boolean isRectangleVisible1 = false,isRectangleVisible2 = false;
float lastTime1 = 0,lastTime2 = 0;


void setup() {
  size(1600, 1200); 
  frameRate(30); 
  PFont font = createFont("Meiryo", 30); 
  textFont(font);

  String[] cameras = Capture.list(); // 利用可能なカメラをリストアップ
  
  minim = new Minim(this);
  player = minim.loadFile("kisyakaiken.mp3");
  println("利用可能なカメラ:");
  for (int i = 0; i < cameras.length; i++) {
    println(i + ": " + cameras[i]);
  }
 
  // 最初のカメラを初期化
  cam = new Capture(this, cameras[selectedCamera]);
  cam.start();

  
  news = loadImage("news.png");
  top = loadImage("top.png");
  asobikata = loadImage("asobikata.png");
  sinbun = loadImage("sinbun.png");
  hiduke = loadImage("hiduke.png");
  komento = loadImage("komento.png");
 
}


void draw() {
  if (scene == 1 && !player.isPlaying()) {
    player.loop();  // scene1 では音楽を再生
  } else if (scene != 1 && player.isPlaying()) {
    player.pause();  // scene1 以外では音楽を停止
  }
  
  if(scene == 0){
    top();
  }else if(scene == 1){
    camera();
  }else if(scene == 2){
    asobikata();
  }else if(scene == 3){
    memory();
  }else if(scene == 4){
    movie();
  }
  //background(0); // 背景を黒でクリア

//   if (cam.available()) {
//     cam.read(); // 新しいフレームを読み込む
//   }

 
//   image(cam, 0, 0, width, height);  // 入力された文字列を表示
//   fill(255, 0, 0); // 文字色（赤）
//   text(typedText, 20, height - 30); // 左下に文字を描画
//    if (millis() - lastTime1 > 5000) { // 5秒ごと
//     lastTime1 = millis(); // 現在の時間を記録
//     isRectangleVisible1 = true; // 長方形を表示
//     startTime1 = millis(); // 長方形が表示され始めた時間
//   }

//   if (isRectangleVisible1) {
//     // 長方形を透明度を持たせて描画
//     fill(255, 255, 255, 100); // 白色で透明度100
//     rect(0,0, 1600, 1200); // ランダムな位置に200x100の長方形を描画
    
//     // 0.3秒後に長方形を非表示
//     if (millis() - startTime1 > 30) {
//       isRectangleVisible1 = false;
//     }
//   }
//    if (millis() - lastTime2 > 7000) { // 7秒ごと
//     lastTime2 = millis(); // 現在の時間を記録
//     isRectangleVisible2 = true; // 長方形を表示
//     startTime2 = millis(); // 長方形が表示され始めた時間
//   }
  
//   if (isRectangleVisible2) {
//     // 長方形を透明度を持たせて描画
//     fill(255, 255, 255, 70); // 白色で透明度150
//     rect(0,0, 1600, 1200); // ランダムな位置に200x100の長方形を描画
    
//     // 0.05秒後に長方形を非表示
//     if (millis() - startTime2 > 30) {
//       isRectangleVisible2 = false;
//     }
//   }
//   image(news,0,0,1600,1200);
  

  
// }

// void keyPressed() {
//   if (key == BACKSPACE && typedText.length() > 0) {
//     // バックスペースが押された場合、最後の文字を削除
//     typedText = typedText.substring(0, typedText.length() - 1);
//   } else if (key == ENTER || key == RETURN) {
//     // Enterキーが押された場合、入力内容をクリア
//     typedText = "";
//   } else if (key == 'n') {
//     // 'n'キーで次のカメラに切り替え
//     switchCamera();
//   } else if (key != CODED) {
//     // 他のキーが押された場合、文字を追加
//     typedText += key;
//   }
//   //  if (millis() - lastTime > 6000) { // 6秒ごと
//   //   lastTime = millis(); // 現在の時間を記録
//   //   isRectangleVisible = true; // 長方形を表示
//   //   startTime = millis(); // 長方形が表示され始めた時間
//   // }

//   // if (isRectangleVisible) {
//   //   // 長方形を透明度を持たせて描画
//   //   fill(255, 255, 255); // 白色で透明度100
//   //   rect(0,0, 1600, 1200); // ランダムな位置に200x100の長方形を描画
    
//   //   // 0.3秒後に長方形を非表示
//   //   if (millis() - startTime > 300) {
//   //     isRectangleVisible = false;
//   //   }
// }

// // カメラを切り替える関数
// void switchCamera() {
//   String[] cameras = Capture.list(); // 利用可能なカメラをリストアップ
//   if (cameras.length > 0) {
//     cam.stop(); // 現在のカメラを停止
//     selectedCamera = (selectedCamera + 1) % cameras.length; // 次のカメラに切り替え
//     cam = new Capture(this, cameras[selectedCamera]); // 新しいカメラを初期化
//     cam.start(); // 新しいカメラを開始
//     println("切り替え後のカメラ: " + cameras[selectedCamera]);
//   } else {
//     println("カメラが見つかりません！");
//   }
}
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
  }
}