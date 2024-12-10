// // PImage img;
// // import processing.video.*; // ライブラリのインポート
// // Capture cam; // カメラオブジェクト
// // void setup(){
// //     PFont font = createFont("Meiryo",30);
// //     textFont(font);
// //     size(1600,1200);
// //     String[] cameras = Capture.list(); // 利用可能なカメラをリストアップ
// //     while (cameras.length == 0) {
// //       cameras = Capture.list(); 
// //     }
// //   if (cameras.length == 0) {
// //     println("カメラが見つかりません！");
// //     exit();
// //   }

// //   // カメラの初期化
// //   cam = new Capture(this, cameras[0]); // 最初のカメラを使用
// //   cam.start(); // カメラを開始
// // }

// // void draw(){
// // if (cam.available() == tr
// Capture cam; // カメラオブジェクト
// String typedText = ""; // 入力された文字列を保存する変数
// PImage img; // 画像オブジェクト
// String[] cameras = Capture.list();
// cam = new Capture(this, cameras[0]);
// cam.start();
// img = loadImage("23723924.png");

// void setup() {
//   size(1600, 1200); // ウィンドウサイズを指定
//   PFont font = createFont("Meiryo", 30); // フォントの作成
//   textFont(font);

//   String[] cameras = Capture.list(); // 利用可能なカメラをリストアップ
//   if (cameras.length == 0) {
//     println("カメラが見つかりません！");
//     exit();
//   }

//   // カメラの初期化
//   cam = new Capture(this, cameras[0]); // 最初のカメラを使用
//   cam.start(); // カメラを開始

//   // 画像の読み込み
//   img = loadImage("23723924.png"); // "example.png" をプロジェクトフォルダに置く
// }

// void draw() {
//   if (cam.available() == true) {
//     cam.read(); // 新しいフレームを読み込む
//   }
//   image(cam, 0, 0, width, height); // カメラ映像を画面に描画

//   // 入力された文字列を表示
//   fill(255, 0, 0); // 文字色（赤）
//   text(typedText, 20, height - 30); // 左下に文字を描画

//   // 画像を描画
//   if (img != null) {
//     image(img, width - 200, height - 200, 180, 180); // 右下に画像を表示
//   }
// }

// void keyPressed() {
//   if (key == BACKSPACE && typedText.length() > 0) {
//     // バックスペースが押された場合、最後の文字を削除
//     typedText = typedText.substring(0, typedText.length() - 1);
//   } else if (key == ENTER || key == RETURN) {
//     // Enterキーが押された場合、入力内容をクリア
//     typedText = "";
//   } else if (key != CODED) {
//     // 他のキーが押された場合、文字を追加
//     typedText += key;
//   }
// }





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
  img = loadImage("23723924.png"); // "23723924.png" をプロジェクトフォルダに置く
  if (img == null) {
    println("画像が見つかりません！");
  }
}

void draw() {
  background(0); // 背景を黒でクリア

  if (cam.available()) {
    cam.read(); // 新しいフレームを読み込む
  }

  // カメラ映像を画面に描画
  image(cam, 0, 0, width, height);

  // 入力された文字列を表示
  fill(255, 0, 0); // 文字色（赤）
  text(typedText, 20, height - 30); // 左下に文字を描画

  // 画像を描画
  if (img != null) {
    int imgSize = 180; // 画像サイズ
    image(img, width - imgSize - 20, height - imgSize - 20, imgSize, imgSize); // 右下に画像を表示
  }

  // UIの情報を描画
  fill(255);
  textSize(20);
  text("現在のカメラ: " + selectedCamera, 20, 30);
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
