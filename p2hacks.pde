import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

import processing.video.*; 
Minim minim;
AudioPlayer player;
Capture cam; 
String typedText = ""; // 入力された文字列を保存する変数
PImage asobikata; 
PImage news;
PImage top;
int selectedCamera = 0; 
float startTime;
boolean isRectangleVisible = false;
float lastTime = 0; 

void setup() {
  size(1600, 1200); 
  frameRate(30); 
  PFont font = createFont("Meiryo", 30); 
  textFont(font);

  String[] cameras = Capture.list(); // 利用可能なカメラをリストアップ
  
  minim = new Minim(this);
  player = minim.loadFile("kisyakaiken.mp3");
  player.loop();

  println("利用可能なカメラ:");
  for (int i = 0; i < cameras.length; i++) {
    println(i + ": " + cameras[i]);
  }
 
  // 最初のカメラを初期化
  cam = new Capture(this, cameras[selectedCamera]);
  cam.start();

  
  news = loadImage("news.png");
 
}


void draw() {
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
  background(0); // 背景を黒でクリア

  if (cam.available()) {
    cam.read(); // 新しいフレームを読み込む
  }

 
  image(cam, 0, 0, width, height);  // 入力された文字列を表示
  fill(255, 0, 0); // 文字色（赤）
  text(typedText, 20, height - 30); // 左下に文字を描画
   if (millis() - lastTime > 6000) { // 6秒ごと
    lastTime = millis(); // 現在の時間を記録
    isRectangleVisible = true; // 長方形を表示
    startTime = millis(); // 長方形が表示され始めた時間
  }

  if (isRectangleVisible) {
    // 長方形を透明度を持たせて描画
    fill(255, 255, 255, 100); // 白色で透明度100
    rect(0,0, 1600, 1200); // ランダムな位置に200x100の長方形を描画
    
    // 0.3秒後に長方形を非表示
    if (millis() - startTime > 50) {
      isRectangleVisible = false;
    }
  }
  image(news,0,0,1600,1200);
  

  
}

void keyPressed() {
  if (key == BACKSPACE && typedText.length() > 0) {
    // バックスペースが押された場合、最後の文字を削除
    typedText = typedText.substring(0, typedText.length() - 1);
  } else if (key == ENTER || key == RETURN) {
    // Enterキーが押された場合、入力内容をクリア
    typedText = "";
  } else if (key == 'n') {
    // 'n'キーで次のカメラに切り替え
    switchCamera();
  } else if (key != CODED) {
    // 他のキーが押された場合、文字を追加
    typedText += key;
  }
  //  if (millis() - lastTime > 6000) { // 6秒ごと
  //   lastTime = millis(); // 現在の時間を記録
  //   isRectangleVisible = true; // 長方形を表示
  //   startTime = millis(); // 長方形が表示され始めた時間
  // }

  // if (isRectangleVisible) {
  //   // 長方形を透明度を持たせて描画
  //   fill(255, 255, 255); // 白色で透明度100
  //   rect(0,0, 1600, 1200); // ランダムな位置に200x100の長方形を描画
    
  //   // 0.3秒後に長方形を非表示
  //   if (millis() - startTime > 300) {
  //     isRectangleVisible = false;
  //   }
}

// カメラを切り替える関数
void switchCamera() {
  String[] cameras = Capture.list(); // 利用可能なカメラをリストアップ
  if (cameras.length > 0) {
    cam.stop(); // 現在のカメラを停止
    selectedCamera = (selectedCamera + 1) % cameras.length; // 次のカメラに切り替え
    cam = new Capture(this, cameras[selectedCamera]); // 新しいカメラを初期化
    cam.start(); // 新しいカメラを開始
    println("切り替え後のカメラ: " + cameras[selectedCamera]);
  } else {
    println("カメラが見つかりません！");
  }
}
