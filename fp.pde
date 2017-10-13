import java.awt.Robot;
import java.awt.AWTException;

PVector pos;
PVector look;
Robot robot;
int middleX;
int middleY;

boolean forward;
boolean back;

void setup() {
  fullScreen(P3D);
  pos = new PVector(0, -100, 0);
  look = new PVector(-100, 0, 0);
  noCursor();
  try {
    robot = new Robot();
  }
  catch(AWTException e) {
    println(e);
  }
  middleX = displayWidth / 2;
  middleY = displayHeight / 2;
  robot.mouseMove(middleX, middleY);
  mouseX = middleX;
  mouseY = middleY;
  updateCamera();
}

void draw() {
  background(0);
  fill(0, 100, 0);
  box(2000, 0, 2000);
  
  PVector lookHor = new PVector( look.x, look.z );
  PVector lookVer = new PVector( lookHor.mag(), look.y );
  lookHor.rotate( new PVector( middleX - mouseX, 400 ).heading() - PI / 2  );
  lookVer.rotate( new PVector( middleY - mouseY, 400 ).heading() - PI / 2 );
  float headingVer = lookVer.heading();
  if (headingVer > PI / 5 ) {
    lookVer.rotate( PI / 5 - headingVer );
  }
  lookHor.setMag( lookVer.x );
  look.x = lookHor.x;
  look.y = lookVer.y;
  look.z = lookHor.y;
  move();
  updateCamera();
  robot.mouseMove(middleX, middleY);
}

void updateCamera() {
  camera(pos.x, pos.y, pos.z, pos.x + look.x, pos.y + look.y, pos.z + look.z, 0, 1, 0);
}

void move() {
  if (forward && !back) {
    PVector move = new PVector(look.x, look.z);
    move.setMag(3);
    pos.add(move.x, 0, move.y);
  }
  else if (back && !forward) {
    PVector move = new PVector(look.x, look.z);
    move.setMag(2);
    pos.sub(move.x, 0, move.y);
  }
}

void keyPressed() {
  if (key == 'w' || key == 'W') {
    forward = true;
  }
  if (key == 's' || key == 'S') {
    back = true;
  }
}

void keyReleased() {
  if (key == 'w' || key == 'W') {
    forward = false;
  }
  if (key == 's' || key == 'S') {
    back = false;
  }
}