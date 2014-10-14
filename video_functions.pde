void movieEvent(Movie m) {
  m.read();
}

int getFrame() {    
  return ceil(mov.time() * 30) - 1;
}

void setFrame(int n) {
  mov.play();
    
  // The duration of a single frame:
  float frameDuration = 1.0 / movFrameRate;
    
  // We move to the middle of the frame by adding 0.5:
  float where = (n + 0.5) * frameDuration; 
    
  // Taking into account border effects:
  float diff = mov.duration() - where;
  if (diff < 0) {
    where += diff - 0.25 * frameDuration;
  }
    
  mov.jump(where);
  mov.pause();  
}  

int getLength() {
  return int(mov.duration() * movFrameRate);
}  

