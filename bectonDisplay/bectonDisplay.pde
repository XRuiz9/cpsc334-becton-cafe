class Drop {
  float x; // x postion of drop
  float y; // y position of drop
  float z; // z position of drop , determines whether the drop is far or near
  float len; // length of the drop
  float yspeed; // speed of the drop
  
  //near means closer to the screen , ie the higher the z value ,closer the drop is to the screen.
  Drop() {
    x  = random(width); // random x position ie width because anywhere along the width of screen
    y  = 636; // random y position, negative values because drop first begins off screen to give a realistic effect
    z  = random(0, 20); // z value is to give a perspective view , farther and nearer drops effect
    len = map(z, 0, 20, 10, 20); // if z is near then  drop is longer
    yspeed  = map(z, 0, 20, 1, 20); // if z is near drop is faster
  }

  void fall() { // function  to determine the speed and shape of the drop 
    y = y + yspeed; // increment y position to give the effect of falling 
    float grav = map(z, 0, 20, 0, 0.2); // if z is near then gravity on drop is more
    yspeed = yspeed + grav; // speed increases as gravity acts on the drop

    if (y > height) { // repositions the drop after it has 'disappeared' from screen
      y = 636;
      yspeed = map(z, 0, 20, 4, 10);
    }
  }

  void show() { // function to render the drop onto the screen
    float thick = map(z, 0, 20, 1, 3); //if z is near , drop is more thicker 
    strokeWeight(10); // weight of the drop
    stroke(200, 50, 100);
    line(x, y, x, y+len); // draws the line with two points 
  }
}

class Drip {
  float x;
  float y;
  float fadeRate;
  
  Drip() {
    x = random(1200, 1950);
    y = random(0, 550);
    fadeRate = 4;
  }
  
  void fade() {
    state = -state;
    
    if (state > 0) {
      alpha -= this.fadeRate; 
    }

    
    if (alpha <= 0) {
      alpha = 255;
      radius = 0;
      x = random(1200, 1950);
      y = random(0, 550);
      fadeRate = 4;
    }
  }
  
  void show() {
    fill(0);
    stroke(200, 50, 100, alpha);
    strokeWeight(10);
    ellipse(x, y, radius, radius);
    radius++;
  }
}

//Drop[] drops = new Drop[500]; // array of drop objects

//void setup() {
//  fullScreen(); // size of the window
//  for (int i = 0; i < drops.length; i++) { // we create the drops 
//    drops[i] = new Drop();
//  }
//}

//void draw() {
//  background(0); // background color in RGB color cordinates
//  for (int i = 0; i < drops.length; i++) {
//    drops[i].fall(); // sets the shape and speed of drop
//    drops[i].show(); // render drop
//  }
//}
int radius=0, alpha = 255, delta = 1, state = 1;


Drop[] drops = new Drop[100];
Drip[] drips = new Drip[20];

boolean circleIsShrinking = false;
 
void setup() {
  fullScreen();
  smooth();
  for (int i = 0; i < drips.length; i++) { // we create the drops 
    drips[i] = new Drip();
  }
  for (int j = 0; j < drops.length; j++) {
    drops[j] = new Drop();
  }
}
 
void draw() {
  background(0);
  
  //if (alpha == 0 || alpha == 255) { delta = +delta; }
  //alpha -= delta;

  for (int i = 0; i < drips.length; i++) {
    drips[i].fade(); // sets the shape and speed of drop
    drips[i].show(); // render drop
  }
  
  for (int j = 0; j < drops.length; j++) {
    drops[j].fall();
    drops[j].show();
  }
  //if (circleIsShrinking) radius--;
  //else radius++;
}
