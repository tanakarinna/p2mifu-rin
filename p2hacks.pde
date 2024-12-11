import processing.video.*; // Processing Video ライブラリ

Capture cam; // カメラオブジェクト
String typedText = ""; // 入力された文字列を保存する変数
PImage img; // 画像オブジェクト
int selectedCamera = 0; // 選択されたカメラのインデックス

void setup() {
  size(1600, 1200); // ウィンドウサイズを指定
  PFont font = createFont("Meiryo", 30); // フォントの作成
  textFont(font);

  String[] cameras = Capture.list(); // 利用可能なカメラをリストアップ
  if (cameras.length == 0) {
    println("カメラが見つかりません！");
    exit();
  }

  println("利用可能なカメラ:");
  for (int i = 0; i < cameras.length; i++) {
    println(i + ": " + cameras[i]);
  }

  // 最初のカメラを初期化
  cam = new Capture(this, cameras[selectedCamera]);
  cam.start();

  // 画像の読み込み
 // size(100,100);
  img = loadImage("23723924.png"); // "23723924.png" をプロジェクトフォルダに置く
  if (img == null) {
    println("画像が見つかりません！");
  }
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

  // カメラ映像を画面に描画
  image(img,0,300,1600,300);
  image(cam, 0, 0, width, height);  // 入力された文字列を表示
  fill(255, 0, 0); // 文字色（赤）
  text(typedText, 20, height - 30); // 左下に文字を描画

  // 画像を描画
  if (img != null) {
    int imgSize = 180; // 画像サイズ
    image(img, width - imgSize - 20, height - imgSize - 20, imgSize, imgSize); // 右下に画像を表示
  }

  // UIの情報を描画
 // fill(255);
  //textSize(20);
  //text("現在のカメラ: " + selectedCamera, 20, 30);
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
