/** 
 *     sideways
 *     slit scan from a perspective
 */

import processing.video.*;

Movie mov;

String filename, extension;

int movFrameRate = 30;   // movie frame rate
int scanBorderOffset = 0;
int scanWidth = 42;   // make it even
int widthFactor = 6;  // make it ~half than the previous (+-)
int drawPos = 0;
int frame = 0;
int movLength;

// Interface variables
PFont font;
float margin = 25;
float sc, sc2; // scales

// Left & Right sides
PGraphics izq, der;             // the two canvases
PImage izqSample, derSample, i, d;    // the two slices

PImage currentFrame, maskImage, bitmapMask; 

//
float correction = scanWidth * .666;

void setup() {

  int width = 400;

  filename = "video-name";
  extension = ".mp4";

  mov = new Movie(this, filename+extension);

  // read and pause the video
  mov.play();
  mov.jump(0);
  mov.pause();

  movLength = getLength();

  izq = createGraphics(int(movLength * widthFactor), mov.height);
  der = createGraphics(int(movLength * widthFactor), mov.height);

  createMask();

  sc = (width - 2*margin) / mov.width;  // scale of the frame
  sc2 = (width - 2*margin) / izq.width; // scale of the miniature stripes

  size(width, round(3*margin + mov.height*sc + izq.height*sc2*2));

  font = createFont("Monaco", 10);
  textFont(font, 10);
  noStroke();
  fill(255);
}

void createMask() {

  // the proportional gray
  maskImage = createImage(scanWidth, mov.height, ALPHA); 
  float a = 128 + (128.0 / float(scanWidth));  // calculate proportional transparency relative to scanWidth
  maskImage.loadPixels();
  for (int i = 0; i < maskImage.pixels.length; i++) {
    maskImage.pixels[i] = color(a);
  }
  maskImage.updatePixels();

  // the gradient masl
  bitmapMask = loadImage("mask.png");

  // the mixing surface
  PGraphics maskCanvas = createGraphics(scanWidth, mov.height);
  maskCanvas.beginDraw();
  maskCanvas.image(bitmapMask, 0, 0, scanWidth, mov.height);
  // maskCanvas.blend(maskImage, 0, 0, scanWidth, mov.height, 0, 0, scanWidth, mov.height, MULTIPLY);
  maskCanvas.endDraw();
  maskImage = maskCanvas.get();
}

void draw() {
  background(0);
  setFrame(frame);

  // get current frame as an image
  currentFrame = mov.get();

  // draw interface
  text(filename +" - "+ frame +" / "+movLength, margin, margin);
  image(currentFrame, margin, 2*margin, mov.width*sc, mov.height*sc);

  i = izq.get();
  d = der.get();

  // tiny stripes
  image(i, margin, mov.height * sc + 2*margin, izq.width * sc2, izq.height * sc2);
  image(d, margin, mov.height * sc + 2*margin + izq.height * sc2, der.width * sc2, der.height * sc2);


  // ----------------------------------------- render left image
  izq.beginDraw();
  izqSample = mov.get(scanBorderOffset, 0, scanWidth, mov.height);
  prepareSlice(izqSample);
  izq.image(izqSample, drawPos, 0, scanWidth, mov.height);
  izq.endDraw();

  // ----------------------------------------- render right image
  der.beginDraw();
  derSample = mov.get(mov.width - scanWidth - scanBorderOffset, 0, scanWidth, mov.height);
  prepareSlice(derSample);
  der.image(derSample, der.width - drawPos - scanWidth, 0, scanWidth, mov.height);
  der.endDraw();

  if (frame >= getLength()) {
    end();
  }
  frame++;
  drawPos += widthFactor;
}


void keyPressed() {
  if (key == ' ') {
    end();
  }
}


void prepareSlice(PImage slice) {
  slice.mask(maskImage);
}

void end() {
  mov.stop();
  String timeStamp = ""+year()+month()+day()+hour()+minute()+second();
  izq.save(filename+"/"+ timeStamp +"_izq.png");
  der.save(filename+"/"+ timeStamp +"_der.png");
  println(" * * * * * finished * * * * *");
  exit();
}

