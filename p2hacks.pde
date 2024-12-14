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
String typedText = ""; 
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
 
}


void draw() {
  if (scene == 1 && !player.isPlaying()) {
    player.loop(); 
  } else if (scene != 1 && player.isPlaying()) {
    player.pause();  
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