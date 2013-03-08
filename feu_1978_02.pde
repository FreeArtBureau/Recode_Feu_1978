
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

Pix[] FEU = new Pix[10];
color[] MYC = {
  #41379B, #e46501, #000000, #FCE8EF, #ffffff
};
int TIMER;
int RANDTIME;
int FC;
/////////////////////////// SETUP ////////////////////////////

void setup() {
  size(400, 400);
  background(#40337f);
  smooth();
  rectMode(CENTER);
  FC = 0;
  call();
}

/////////////////////////// DRAW ////////////////////////////
void draw() {
  fill(#40337f,0.5);
  rect(0,0,width*2,height*2);
  for (int i=0; i<FEU.length; i++) {
    FEU[i].render();
  }

  if ((TIMER > 500) || (mousePressed == true)) {
    println("FEU !");
    call();
  }
  TIMER++;
  FC++;
  
  //AFTER 10000 FRAMES NEW COMPOSITION
  if(FC > 10000){
   //saveFrame("img_###.png");
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
  //RANDTIME = (int)random(200, 400);

  //Init Class
  for (int i=0; i<FEU.length; i++) {
    float xPos = random(-10,width);
    float yPos = random(200, height+200);
    FEU[i] = new Pix(xPos, yPos);
  }
}

/////////////////////////// CLASS ////////////////////////////

class Pix {
  float x, y;
  float pixSize;
  color col;
  int op;
  int randHV;
  float v, h;
  int signs;
  float s;
  float angle;

  Pix(float x, float y) {
    this.x = x; 
    this.y = y; 
    col = pickColour(); 
    randHV = (int)random(3);
    v=0;
    h=0;
    s = random(2, 60); 
    op = (int)random(73, 255);
    pixSize = random(1, 2); 
    signs = (int)random(1, 5);
  }

  void render() {

    int GOSUBGRAPHIC = (int)random(3);
    if (GOSUBGRAPHIC == 0) {

      //DRAW SUBGRAPHIC
      noStroke();
      fill(col);
      rect(x+h, y+v, pixSize, pixSize);
    }
    else if (GOSUBGRAPHIC == 1) {
      noFill();
      stroke(col, op);
      strokeWeight(0.3);
      ellipse(x+h, y+v, pixSize+3, pixSize+3);
    }
    else {
      noStroke();
      fill(col, op);
      ellipse(x+h, y+v, pixSize+1, pixSize+1);
    }

    //MOVE PIXELS
    feu();
  }

  void feu() { 
    // MINITURE FIREWORKS 1978 !
    float movH = cos(frameCount%360*(s*0.03)) * 3; 
    float movV = sin(frameCount%360*(s*0.03)) * 3;
    
    if (randHV == 0) {
      v-=movV*0.5;
      v-=0.5;
      h+=movH*0.5;
    }
    else {
      v-=movV*3.5;
      h+=movH*3.5;
    }
    
    float movX = cos(frameCount%360*(s*0.90)) * s/signs; 
    float movY = sin(frameCount%360*(s*0.90)) * s/signs;
    x+=movX*0.6;
    y+=movY*0.6;
  }

  //PICK A RANDOM COLOUR FROM ARRAYLIST ABOVE
  color pickColour() {
    color pc = MYC[int(random(MYC.length))];
    return pc;
  }
}

void keyPressed() {
  if (key == 's') 
    saveFrame("img_###.png");
}

