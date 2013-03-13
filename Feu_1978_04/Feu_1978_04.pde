
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
 VERSION_04
 Written by Louis Eveillard :
 http://louiseveillard.com/ 
 & developed from the 'Animator', 
 a sketch written by Casey Reas & Ben Fry.
 
 */

///////////////////////// GLOBALS ////////////////////////////

int currentFrame = 0;
PImage[] frames = new PImage[ 48 ];
int lastTime = 0;
int formeATracer;
color lestroke = color(floor(random(72,162)), 87, 128);


/////////////////////////// SETUP ////////////////////////////

void setup() 
{

  size(800, 600, OPENGL);

  strokeWeight(1);

  background(12,10,21);

  stroke(255);
  noFill();

  for (int i = 0; i < frames.length; i++)
  {
    frames[i] = get(); // Create a blank frame
  }
}

/////////////////////////// DRAW ////////////////////////////

void draw() {

  int currentTime = millis();
  if (currentTime > lastTime + 30 )
  {
    nextFrame();
    lastTime = currentTime;
  }
  if (mousePressed == true) 
  {
    if (pmouseX == 0 && pmouseY == 0) {
      pmouseX = mouseX;
      pmouseY = mouseY;
    }

    pushMatrix();
    translate (mouseX, mouseY);
    rotate (atan2( mouseY - pmouseY, mouseX - pmouseX ));

    float accX =  1+abs(pmouseX-mouseX)/10;
    float accY =  1+abs(pmouseY-mouseY)/10;

    for (int i=0; i < 2; i++) {
      strokeWeight(2-i);

      if (i == 0)      stroke(floor(random(72,162)), 87, 128);
      else if (i==1)       stroke(lestroke);

      pushMatrix();

      //line(pmouseX, pmouseY, mouseX, mouseY);
      if (formeATracer < frames.length/6) {
        point( 0, 0);
      }
      else if (formeATracer < 2*(frames.length/6)) {
        line (0, 0, pmouseX-mouseX, pmouseY-mouseY);
      }
      else if (formeATracer < 3*(frames.length/6)) {
        rotate( PI/2);
        arc(0, 0, formeATracer*accX, formeATracer*accY, PI/6, 5*PI/6);
      }
      else if (formeATracer < 4*(frames.length/6)) {
        ellipse ( 0, 0, formeATracer*accX, formeATracer*accY );
      }
      else if (formeATracer < 5*(frames.length/6)) {
        rect (-15, -15, formeATracer*accX, formeATracer*accY);
      }
      else if (formeATracer < 6*(frames.length/6)) {
        rotate( PI/2);
        triangle (-20, (formeATracer-10)*accY, 0, (-formeATracer+10)*accY, +20, (+formeATracer-10)*accY);
      }
      
      popMatrix();

    }

    popMatrix();

    formeATracer++;
    if (formeATracer > frames.length) {
      formeATracer = 0;
    }
  }

}

/////////////////////////// FUNCTIONS ////////////////////////////

void nextFrame() 
{
  frames[currentFrame] = get(); // Get the display window

  currentFrame = ( currentFrame + 1 ) % frames.length;

  //tint(255,100);
  pushMatrix();
  translate(width/2-1, height/2-1);
  image(frames[currentFrame], -width/2, -height/2);
  scale(1.1);
  noTint();
  tint(255, 240);
  image(frames[currentFrame], -width/2, -height/2);


  popMatrix();
}

void keyPressed() {
  if (key == ENTER) {
    background(0);
    for (int i=0; i < frames.length; i++) {
      frames[i] = get();
    }
  }

  if (key == 's') 
    saveFrame("img_###.png");
}


void mousePressed() {
  formeATracer = 0;
}

void mouseReleased() {
  // on change de couleur yay !
 lestroke = lerpColor(color(255,247,251), color(177,180,199),random(1));
}



