void camera(){
 background(0); 
 if (cam.available()) {
    cam.read(); 
  }

 
  image(cam, 0, 0, width, height);  
  fill(255, 0, 0); 
  text(typedText, 20, height - 30); 
   if (millis() - lastTime1 > 5000) { // 5秒ごと
    lastTime1 = millis(); // 現在の時間を記録
    isRectangleVisible1 = true; // 長方形を表示
    startTime1 = millis(); //
  }

  if (isRectangleVisible1) {
    // 長方形を透明度を持たせて描画
    fill(255, 255, 255, 100); // 白色で透明度100
    rect(0,0, 1600, 1200); // ランダムな位置に200x100の長方形を描画
    
    // 0.3秒後に長方形を非表示
    if (millis() - startTime1 > 30) {
      isRectangleVisible1 = false;
    }
  }
   if (millis() - lastTime2 > 7000) { // 7秒ごと
    lastTime2 = millis(); // 現在の時間を記録
    isRectangleVisible2 = true; // 長方形を表示
    startTime2 = millis(); // 長方形が表示され始めた時間
  }
  
  if (isRectangleVisible2) {
    // 長方形を透明度を持たせて描画
    fill(255, 255, 255, 70); // 
    rect(0,0, 1600, 1200); 
    
  
    if (millis() - startTime2 > 30) {
      isRectangleVisible2 = false;
    }
  }
  image(news,0,0,1600,1200);
  image(syuryo,0,0,1600,1200);
  

  
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