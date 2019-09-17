//This program features code adapted from these two sources:
//https://forum.processing.org/one/topic/shrinking-and-growing-shapes.html
//https://thecodingtrain.com/CodingChallenges/004-purplerain.html

int radius=700,  fill = 0;
float rand1 = random(0, 255), rand2 = random(0, 255), rand3 = random(0, 255), bkg1 = 0, bkg2 = 0, bkg3 = 0, mem1, mem2, mem3;
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
      strokeWeight(10);
      stroke(rand1, rand2, rand3);
      line(x, y, x, y+len);
    }
  }
}

Drop[] drops = new Drop[100];
 
void setup() {
  
  //Screen and shape setup
  fullScreen();
  smooth();
  rectMode(CENTER);
  
  //Instantiate drops
  for (int j = 0; j < drops.length; j++) {
    drops[j] = new Drop();
  }
}
 
void draw() {
  background(bkg1, bkg2, bkg3);
  
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
    
    //Storing background colors for use in fillTop()
    mem1 = bkg1;
    mem2 = bkg2;
    mem3 = bkg3;
    
    //Update background color to rectangle color
    bkg1 = rand1;
    bkg2 = rand2;
    bkg3 = rand3;
    
    //Reset rectangle
    fill = 0;
    
    //New fill color is selected
    rand1 = random(0, 255);
    rand2 = random(0, 255);
    rand3 = random(0, 255);
  } else {
    if (!fillingTop){
      fill++;
    }
  }
}

//Makes circle appear on ceiling that imitates a container being filled
void fillTop() {
  
  //Plays circle animation
  if (fillingTop) {
    fill(mem1, mem2, mem3);
    noStroke();
    ellipse(1615, 290, radius, radius);
    radius -= 3;
  }
  
  //Resets animation
  if (radius < 0) {
    fillingTop = false;
    radius = 700;
  }
}
