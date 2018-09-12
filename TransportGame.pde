PGraphics pg;
PImage car;
PImage wheel;

boolean pre = true;
boolean mousepressed = false;
boolean lastmouse = false;
int dragging = 0;
int offset = 0;

float midspeed = 30;
float speed = midspeed;
float minspeed = 10;
float maxspeed = 50;
float speedx = width / 2;

float midjump = 30;
float jump = midjump;
float minjump = 10;
float maxjump = 50;
float jumpx = width / 2;
 //<>//
float midgravity = 30;
float gravity = midgravity;
float mingravity = 10;
float maxgravity = 50;
float gravityx = width / 2;

float k = height / 800;
void setup() {
  size(800, 600);
  pg = createGraphics(800, 600);
  car = loadImage("car.png");
  wheel = loadImage("wheel.png");
}
void draw() {
  mousepressed = !lastmouse && mousePressed;
  lastmouse = mousePressed;
  strokeWeight(1);
  stroke(0);
  fill(0, 252, 233);
  rect(0, 0, width, height);
  if (pre) {
    textSize(height / 20);
    fill(252, 143, 0);
    text("Speed", width / 2 - textWidth("Speed")/2, 2 * height / 20);
    fill(0, 255, 0);
    rect(width / 4, height / 8, width / 2, height / 40);
    fill(255, 0, 0);
    speedx = width / 4 + (width / 2) * (speed - minspeed) / (maxspeed - minspeed);
    ellipse(speedx, height / 8 + height / 80, height / 20, height / 20);
    
    fill(252, 143, 0);
    text("Jump Speed", width / 2 - textWidth("Jump Speed")/2, 5 * height / 20);
    fill(0, 255, 0);
    rect(width / 4, 1.1 * height / 4, width / 2, height / 40);
    fill(255, 0, 0);
    jumpx = width / 4 + (width / 2) * (jump - minjump) / (maxjump - minjump);
    ellipse(jumpx ,1.1 * height / 4 + height / 80, height / 20, height / 20);
    
    fill(252, 143, 0);
    text("Gravity", width / 2 - textWidth("Gravity")/2, 8 * height / 20);
    fill(0, 255, 0);
    rect(width / 4, 1.7 * height / 4, width / 2, height / 40);
    fill(255, 0, 0);
    gravityx = width / 4 + (width / 2) * (gravity - mingravity) / (maxgravity - mingravity);
    ellipse(gravityx ,1.7 * height / 4 + height / 80, height / 20, height / 20);
    
    noFill();
    stroke(0);
    strokeWeight(5);
    rect(width / 4, 2 * height / 4, width / 2, 0.7 * height / 2);
    strokeWeight(1);
    fill(255, 255, 0);
    textSize(height / 5);
    text("Start", width / 2 - textWidth("Start")/2, height - 1.1 * height / 4);
    if (!mousePressed) {
      dragging = 0;
    } else if (mousepressed) {
      if (Math.pow(Math.pow(mouseX - speedx, 2) + Math.pow(mouseY - height / 8 - height / 80, 2), 0.5) < height / 40) {
        dragging = 1;
        offset = (int)(mouseX - speedx);
      } else if (Math.pow(Math.pow(mouseX - jumpx, 2) + Math.pow(mouseY - 1.1 * height / 4 - height / 80, 2), 0.5) < height / 40) {
        dragging = 2;
        offset = (int)(mouseX - jumpx);
      } else if (Math.pow(Math.pow(mouseX - gravityx, 2) + Math.pow(mouseY - 1.7 * height / 4 - height / 80, 2), 0.5) < height / 40) {
        dragging = 3;
        offset = (int)(mouseX - gravityx);
      }
    } else if (dragging > 0) {
    
    } else if (mouseX < 3 * width / 4 && mouseX > width / 4 && mouseY > height / 2 && mouseY < height / 2 + 0.7 * height / 2) {
      speed *= k;
      jump *= k;
      gravity *= k;
      pre = false;
    } else if (dragging > 0) {
      if (mouseX - offset > width / 4 && mouseX - offset < 3 * width / 4) {
        if (dragging == 1) {
          speedx = mouseX - offset;
          speed = (speedx - width / 4) / (width / 2) * (maxspeed - minspeed) + minspeed;
        } else if (dragging == 2) {
          jumpx = mouseX - offset;
          jump = (jumpx - width / 4) / (width / 2) * (maxjump - minjump) + minjump;
        } else if (dragging == 3) {
          gravityx = mouseX - offset;
          gravity = (gravityx - width / 4) / (width / 2) * (maxgravity - mingravity) + mingravity;
        }
      }
    }
  } else {
    //image(car, width / 4, 3 * height / 4, width / 2, height / 8);
  }
}
