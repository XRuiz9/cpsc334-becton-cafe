//This program features code adapted from these two sources:
//https://forum.processing.org/one/topic/shrinking-and-growing-shapes.html
//https://thecodingtrain.com/CodingChallenges/004-purplerain.html

int radius = 0,  fill = 0;
float rand1 = random(0, 255), rand2 = random(0, 255), rand3 = random(0, 255), bkg1 = 0, bkg2 = 0, bkg3 = 0;
boolean fillingTop = false;

class Drop {
  //x, y and z positions of drop
  float x;
  float y;
  float z;
  
  //length and speed of drop
  float len;
  float yspeed;

  Drop() {
    //Instantiate drops with coordinates relative to all Becton screens
    x  = random(width);
    y  = 636;
    z  = random(0, 20);
    len = map(z, 0, 20, 10, 20);
    yspeed  = map(z, 0, 20, 1, 20);
  }

  void fall() {
    //Increment y position to imitate gravity and perspective
    y = y + yspeed;
    float grav = map(z, 0, 20, 0, 0.2);
    yspeed = yspeed + grav;

    //Reposition drops after it has disappeared from view
    if (y > height) {
      y = 636;
      yspeed = map(z, 0, 20, 4, 10);
    }
  }

  void show() {
    //Shows drops when top is not filling
    if (!fillingTop) {
      float thick = map(z, 0, 20, 1, 3);
      strokeWeight(5);
      stroke(rand1, rand2, rand3);
      line(x, y, x, y+len);
    }
  }
}

class Drip {
  //x and y positions of drip
  float x;
  float y;
  
  //fade rate and size of drip
  float alpha;
  float dripRadius;
  
  Drip() {
    //Instantiates drips on ceiling only
    x = random(1200, 1950);
    y = random(0, 550);
    alpha = random(0, 255);
    dripRadius = 0;
  }
  
  void fade() {
    //Makes drips disappear over time
    alpha -= 3;
    
    //Resets drips once they disappear
    if (alpha <= 0) {
      alpha = random(0, 255);
      dripRadius = 0;
      x = random(1200, 1950);
      y = random(0, 550);
    }
  }
  
  void show() {
    fill(rand1, rand2, rand3, alpha);
    noStroke();
    ellipse(x, y, dripRadius, dripRadius);
    dripRadius += 3;
  }
}

Drip[] drips = new Drip[30];
Drop[] drops = new Drop[100];
 
void setup() {
  
  //Screen and shape setup
  fullScreen();
  smooth();
  rectMode(CENTER);
  
  //Instantiate drips
  for (int i = 0; i < drips.length; i++) {
    drips[i] = new Drip();
  }
  
  //Instantiate drops
  for (int j = 0; j < drops.length; j++) {
    drops[j] = new Drop();
  }
}
 
void draw() {
  background(bkg1, bkg2, bkg3);
  
  for (int i = 0; i < drips.length; i++) {
    drips[i].show();
    drips[i].fade();
  }
  
  for (int j = 0; j < drops.length; j++) {
    drops[j].fall();
    drops[j].show();
  }
  
  fillTop();
  
  //Rectangle that fills screen as drops fall
  fill(rand1, rand2, rand3);
  noStroke();
  rect(width/2, height, width, fill);
  
  if (fill == 900) {
    //Ceiling sequence begins
    fillingTop = true;
  } else {
    if (!fillingTop){
      fill++;
    }
  }
}

void fillTop() {
  
  //Plays circle animation
  if (fillingTop) {
    fill(rand1, rand2, rand3);
    noStroke();
    ellipse(1615, 290, radius, radius);
    radius += 3;
  }
  
  if (radius > 950) {
    //Update background color to rectangle color
    bkg1 = rand1;
    bkg2 = rand2;
    bkg3 = rand3;
  }
  
  //Resets animation
  if (radius > 1050) {
    
    //New fill color is selected
    rand1 = random(0, 255);
    rand2 = random(0, 255);
    rand3 = random(0, 255);
    
    //Reset rectangle and top
    radius = 0;
    fill = 0;
    
    fillingTop = false;
  }
}
