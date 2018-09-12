PGraphics pg;
boolean pre = true;
boolean mousepressed = false;

int midspeed = 30;
int speed = midspeed;
int minspeed = 10;
int maxspeed = 50;

int midjump = 30;
int jump = midjump;
int minjump = 10;
int maxjump = 50;

int midgravity = 30;
int gravity = midgravity;
int mingravity = 10;
int maxgravity = 50;

float k = 1080 / height;
void setup() {
  size(1960, 1080);
  pg = createGraphics(1960, 1080);
}
void draw() {
  if (pre) {
    strokeWeight(1);
    stroke(0);
    fill(0, 252, 233);
    rect(0, 0, width, height);
    textSize(height / 20);
    fill(252, 143, 0);
    text("speed", width / 2 - width / 20, 2 * height / 20);
    fill(0, 255, 0);
    rect(width / 4, height / 8, width / 2, height / 40);
    fill(255, 0, 0);
    ellipse(width / 4 + (width / 2) * (speed - minspeed) / (maxspeed - minspeed),height / 8 + height / 80, height / 20, height / 20);
    
    fill(252, 143, 0);
    text("jumpspeed", width / 2 - 1.3 * width / 20, 5 * height / 20);
    fill(0, 255, 0);
    rect(width / 4, 1.1 * height / 4, width / 2, height / 40);
    fill(255, 0, 0);
    ellipse(width / 4 + (width / 2) * (jump - minjump) / (maxjump - minjump),1.1 * height / 4 + height / 80, height / 20, height / 20);
    
    fill(252, 143, 0);
    text("gravity", width / 2 - 1.12 * width / 20, 8 * height / 20);
    fill(0, 255, 0);
    rect(width / 4, 1.7 * height / 4, width / 2, height / 40);
    fill(255, 0, 0);
    ellipse(width / 4 + (width / 2) * (gravity - mingravity) / (maxgravity - mingravity),1.7 * height / 4 + height / 80, height / 20, height / 20);
    
    noFill();
    stroke(0);
    strokeWeight(5);
    rect(width / 4, 2 * height / 4, width / 2, 0.7 * height / 2);
    strokeWeight(1);
    fill(255, 255, 0);
    textSize(height / 5);
    text("start", width / 4 + width / 8, height - 1.1 * height / 4);
  }
}
