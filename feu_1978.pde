
/*
 ***************************
 RECODE PROJECT MARCH / 2013
 ***************************
 Bernard Demiaux
 Feu d'artifice 1978
 Programmed on an Applesoft
 Language : Basic 
 
 >>> http://www.demiaux.com/bd/video/feu_2.wmv 
 >>> http://apple2.info/wiki/index.php?title=Applesoft_BASIC
 
 Project Information 
 >>> http://recodeproject.com/
 >>> www.freeartbureau.org
 ***************************
 
 */

/////////////////////////// GLOBALS ////////////////////////////

int GOSUBGRAPHIC;
float S;
color COL;
color[] MYC = {
  #41379B, #e46501, #000000, #f1a6bf, #ffffff
};
float XPOS, YPOS;
float H = 0;
float V = 0;
int SINES;
int RAND_TRANS;
int RAND_HV;
int TIMER;
int RANDTIME;
int FC;

/////////////////////////// SETUP ////////////////////////////

void setup() {
  size(400, 400);
  background(#40337f);
  smooth();
  rectMode(CENTER);
  RAND_HV = 0;
  FC = 0;
  GOSUBGRAPHIC = 0;
  call();
}

/////////////////////////// DRAW ////////////////////////////
void draw() {
  
  // DIRECTION & STEP
  if (RAND_HV == 0) {
    if (S<20) {
      H+=0.5;
    }
    else {
      H+=1.5;
    }
  }
  else {
    if (S<20) {
      V+=0.5;
    }
    else {
      V+=1.5;
    }
  }
 
  // DRAW A SUBGRAPHIC
  if (GOSUBGRAPHIC == 0) {
    trait(XPOS, YPOS, S, COL, RAND_TRANS);
  }
  else if (GOSUBGRAPHIC == 1) {  
    arcs(XPOS, YPOS, S, COL, RAND_TRANS);
  }

  else if (GOSUBGRAPHIC == 2) {  
    eclair(XPOS, YPOS, S, COL, RAND_TRANS);
  }

  else if (GOSUBGRAPHIC == 3) {  
    trait2(XPOS, YPOS, S, COL, RAND_TRANS);
  }

  else if (GOSUBGRAPHIC == 4) {  
    pix(XPOS, YPOS, S, COL, RAND_TRANS);
  }

  else if (GOSUBGRAPHIC == 5) {  
    pix2(XPOS, YPOS, S, COL, RAND_TRANS);
  }

  else if (GOSUBGRAPHIC == 6) {  
    pix(XPOS, YPOS, S, COL, RAND_TRANS);
  }

  else if (GOSUBGRAPHIC == 7) {  
    arcs(XPOS, YPOS, S, COL, RAND_TRANS);
  }

  // CHOOSE ANOTHER SUBGRAPHIC AFTER 250 FRAMES
  if ((TIMER > 250) || (mousePressed == true)) {
    println("FEU !");
    call();
  }
  TIMER++;

  // AFTER 30000 FRAMES NEW COMPOSITION
  FC++;
  if (FC > 30000) {
    saveFrame("img_###.png");
    background(#40337f);
    FC = 0;
    call();
  }
}

/////////////////////////// FUNCTIONS ////////////////////////////

///////////// INITIALISE

void call() {
  //TIMER
  TIMER = 0;
  // RANDTIME = (int)random(73, 173);

  //UP or RIGHT ?
  RAND_HV = (int)random(3);
  V=0;
  H=0;

  SINES = (int)random(2, 8);

  //PICK A GRAPHIC
  GOSUBGRAPHIC = (int)random(8);

  //COLOUR
  RAND_TRANS = (int)random(225, 255);
  COL = pickColour();

  //POSITION
  float prob = (int)random(6);
  if (prob<2) {
    XPOS = random(150);
    YPOS = random(150);
  }
  else if (prob == 3) {
    XPOS = random(150, width);
    YPOS = random(0, height);
  }

  else if (prob == 4) {
    XPOS = random(0, width);
    YPOS = random(150, height);
  }    
  else {
    XPOS = random(-50, width);
    YPOS = random(-50, height);
  }

//SIZE OF GRAPHICS
S = random(5, 50);
}
///////////// END OF CALL FUNCTION


///////////// GRAPHICS

//LINES
void trait(float x, float y, float S, color COL, int transp) {
  stroke(COL, transp);
  strokeWeight(0.4);
  if (RAND_HV == 0) {
    line(x+S+H, y-S+V, x+S+H, y+S+V);
  }
  else {
    line(x-S+H, y-S+V, x+S+H, y-S+V);
  }
}

//MORE LINES
void trait2(float x, float y, float S, color COL, int transp) {
  if (RAND_HV == 0) {
    line(x+S+H, y+S+V, x-S+H, y+S+V);
  }
  else {
    line(x+S+H, y-S+V, x-S+H, y+S+V);
  }
}

//ARCS
void arcs(float x, float y, float S, color COL, int transp) {
  noFill();
  stroke(COL, transp);
  strokeWeight(0.3);
  if (RAND_HV == 0) {
    arc(x+S+H, y+S+V, S*2, S*2, 0, radians(270));
  }
  else {
    arc(x+S+H, y+S+V, S*2, S*2, HALF_PI, radians(270));
  }
}

//LIGHTENING
void eclair(float x, float y, float S, color COL, int transp) {
  beginShape();
  noFill();
  stroke(COL, transp);
  strokeWeight(0.3);
  vertex(x+V, y+H);
  vertex(x+S/2+V, y+S/2+H);
  vertex(x+V, y+(S*1.3)+H);
  vertex(x+S+V, y+(S*1.3)+H+S);
  endShape();
}

//PIXELS
void pix(float x, float y, float S, color COL, int transp) {
  float mov = sin(frameCount%360*(S*0.15)) * S/SINES;
  fill(COL, transp);
  noStroke();
  rect(x+V+mov*2, y+H+mov*2, 1, 1);
}

//PIXELS
void pix2(float x, float y, float S, color COL, int transp) {
  float mov2 = sin(frameCount%360*(S*0.33)) * S/SINES;
  fill(COL, transp);
  noStroke();
  rect(x+V+mov2, y+H+mov2, 1, 1);
}

//PICK A RANDOM COLOUR
color pickColour() {
  color pc = MYC[int(random(MYC.length))];
  return pc;
}

//SAVE AN IMAGE
void keyPressed() {
  if (key == 's') 
    saveFrame("img_###.png");
}

