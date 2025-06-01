import processing.sound.*;
PFont font;

// Page Variable
int currentPage = 1;

// Pendulum Variables
float angle = PI / 4;
float angleVelocity = 0;
float angleAcceleration = 0;
float ballRadius = 20;
float ropeLength = 150;
float gravity = 0.4;
boolean dragging = false;

// Electric Charges Variables
ArrayList<Charge> charges = new ArrayList<Charge>();
float minDistancePlus = 100;
float minDistanceMinus = 50;
PVector cursorPosition;

// Images
PImage cursorImg;
PImage plusImg;
PImage minusImg;

// Sound
SoundFile mySound;
boolean soundPlayed = false;

void setup() {
  size(600, 400);
  font = createFont("LEMONMILK-Bold.otf", 48);
  textFont(font);
  
  // Images of Electric Charges
  cursorPosition = new PVector(mouseX, mouseY);
  cursorImg = loadImage("plusv1.png");
  plusImg = loadImage("plusv1.png");
  minusImg = loadImage("minusv1.png");

  charges.add(new Charge(150, 200, 1));
  charges.add(new Charge(450, 200, -1));
  
  mySound = new SoundFile(this, "dischargeSound.mp3");
}

// Page Count
void draw() {
  if (currentPage == 1) {
    drawMainPage();
    if (mySound.isPlaying()) {
      mySound.stop();
    }
    soundPlayed = false;
  } else if (currentPage == 2) {
    drawSecondPage();
    if (mySound.isPlaying()) {
      mySound.stop();
    }
    soundPlayed = false;
  } else if (currentPage == 3) {
    if (!soundPlayed) {
      mySound.loop();
      soundPlayed = true;
    }
    drawThirdPage();
  }
}

// Home Page 
void drawMainPage() {
  background(123, 147, 156);
  textSize(36);
  textAlign(CENTER, CENTER);
  fill(0);
  text("FenLab 8", width / 2, height / 4);
   
   // Button 1
  fill(155, 140, 109);
  rect(175, 200, 250, 50);
  fill(255);
  textSize(22);
  text("İlk deneye geç", width / 2, 225);


}

// Second Page (Pendulum) 
void drawSecondPage() {
  background(123, 147, 156);
  float ropeXAxis = width / 2;
  float ropeYAxis = 100;

  if (dragging) {
    float dx = mouseX - ropeXAxis;
    angle = atan2(dx, ropeLength);
    angleVelocity = 0;
  } else {
    angleAcceleration = (-1 * gravity / ropeLength) * sin(angle);
    angleVelocity += angleAcceleration;
    angle += angleVelocity;
    angleVelocity *= 0.995;
  }

  float ballX = ropeXAxis + sin(angle) * ropeLength;
  float ballY = ropeYAxis + cos(angle) * ropeLength;

  // Rope
  stroke(0);
  strokeWeight(2);
  line(ropeXAxis, ropeYAxis, ballX, ballY);

  // Ball
  if (dragging) {
    fill(color(200, 50, 50));
  } else {
    fill(100);
  }
  strokeWeight(1);
  ellipse(ballX, ballY, ballRadius * 2, ballRadius * 2);

  // Button 2
  fill(155, 140, 109);
  rect(175, 300, 250, 50);
  fill(255);
  textSize(18);
  textAlign(CENTER, CENTER);
  text("Sonrakİ deneye geç", width / 2, 325);
  fill(0);
  text("Basİt Makİneler: Sarkaç", width / 2, 25);
}

// Third Page (Electric Charges)
void drawThirdPage() {
  background(123, 147, 156);
  cursorPosition.set(mouseX, mouseY);

  for (Charge c : charges) {
    float chargeDistance = PVector.dist(cursorPosition, c.position);
    float repelDist = c.q > 0 ? minDistancePlus : minDistanceMinus;

    if (chargeDistance < repelDist) {
      PVector dir = PVector.sub(cursorPosition, c.position);
      dir.normalize();
      dir.mult(repelDist);
      cursorPosition = PVector.add(c.position, dir);
    }
  }

  stroke(200);
  line(width / 2, 0, width / 2, height);

  for (Charge c : charges) {
    c.display();
  }

  imageMode(CENTER);
  image(cursorImg, cursorPosition.x, cursorPosition.y);

  // Button 3
  fill(155, 140, 109);
  rect(200, 330, 200, 40);
  fill(255);
  textSize(18);
  textAlign(CENTER, CENTER);
  text("Ana Sayfaya Dön", 300, 350);
  fill(0);
  text("Elektrİk Enerjİsİ: Yükler", width / 2, 25);

}

void mousePressed() {
  if (currentPage == 1 && mouseX > 175 && mouseX < 425 && mouseY > 200 && mouseY < 250) {
    currentPage = 2;
  } else if (currentPage == 2) {
    float ropeXAxis = width / 2;
    float ropeYAxis = 100;
    float x = ropeXAxis + sin(angle) * ropeLength;
    float y = ropeYAxis + cos(angle) * ropeLength;
    float distance = dist(mouseX, mouseY, x, y);

    if (distance < ballRadius + 5) {
      dragging = true;
      return;
    }

    if (mouseX > 175 && mouseX < 425 && mouseY > 300 && mouseY < 350) {
      currentPage = 3;
    }
  } else if (currentPage == 3 && mouseX > 200 && mouseX < 400 && mouseY > 330 && mouseY < 370) {
    currentPage = 1;
  }
}

void mouseReleased() {
  dragging = false;
}

// Charges Class 
class Charge {
  PVector position;
  float q;

  Charge(float x, float y, float q_) {
    position = new PVector(x, y);
    q = q_;
  }

  void display() {
    imageMode(CENTER);
    if (q > 0) {
      image(plusImg, position.x, position.y);
    } else {
      image(minusImg, position.x, position.y);
    }
  }
}
