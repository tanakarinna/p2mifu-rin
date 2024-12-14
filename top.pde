void top(){
    image(top,0,0,1600,1200);
    
  fill(0);
  text(typedText, textBoxX + 10, textBoxY + 10);
}
void keyTyped() {
  if (key == BACKSPACE && typedText.length() > 0) {
    typedText = typedText.substring(0, typedText.length() - 1);
  } else if(typedText.length()  < maxLength){
      typedText += key;
  }
}