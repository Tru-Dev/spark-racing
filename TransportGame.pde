PImage carIm;
PImage wheel;
PImage wheel1;
PImage wheel2;
PImage wheel3;
PImage wheel4;
PImage wheel5;
PImage wheel6;
int chosenwheel;
PImage ground;
PImage head;
PImage base;

float[] wheel1stats;
float[] wheel2stats;
float[] wheel3stats;
float[] wheel4stats;
float[] wheel5stats;
float[] wheel6stats;
float[][] wheelstats;

int groundy;
int groundx;
float groundoff;

boolean pre;
boolean mousepressed;
boolean lastmouse;
boolean space;
boolean lastspace;
boolean spacepressed;
int dragging;
int offset;

float midspeed;
float speed;
float minspeed;
float maxspeed;
float speedx;

float midjump;
float jump;
float minjump;
float maxjump;
float jumpx;
 //<>//
float midgravity;
float gravity;
float mingravity;
float maxgravity;
float gravityx;

float speedk = maxspeed - minspeed;
float jumpk = maxjump - minjump;
float gravityk = maxgravity - mingravity;

boolean temp;
int basepipetime;
int pipetime;
float c;
boolean gameover;
int frame;
float time;
float k;
Car car;
ArrayList<Pipe> pipes;
Pipe[][] map;
void setup() {
  size(1960, 1080);
  wheel1 = loadImage("wheel1.png");
  wheel2 = loadImage("wheel2.png");
  wheel3 = loadImage("wheel3.png");
  wheel4 = loadImage("wheel4.png");
  wheel5 = loadImage("wheel5.png");
  wheel6 = loadImage("wheel6.png");
  carIm = loadImage("car1.png");
  ground = loadImage("ground.png");
  head = loadImage("head.png");
  base = loadImage("base.png");
  chosenwheel = 1;
  
  wheel1stats = new float[]{midspeed, midjump, midgravity};
  wheel2stats = new float[]{midspeed + speedk / 4, midjump + jumpk / 4, midgravity + gravityk / 4};
  wheel3stats = new float[]{midspeed - speedk / 4, midjump - jumpk / 4, midgravity - gravityk / 4};
  wheel4stats = new float[]{midspeed - speedk / 2, midjump + jumpk / 2, midgravity - gravityk / 2};
  wheel5stats = new float[]{midspeed + speedk / 2, midjump - jumpk / 2, midgravity + gravityk / 2};
  wheel6stats = new float[]{midspeed  + speedk / 4, midjump - jumpk / 4, midgravity - gravityk / 4};
  wheelstats = new float[][]{wheel1stats, wheel2stats, wheel3stats, wheel4stats, wheel5stats, wheel6stats};
  
  groundy = 4 * height / 5;
  groundx = 0;
  groundoff = 1.1 * height / 100;
  
  pre = true;
  mousepressed = false;
  lastmouse = false;
  space = false;
  lastspace = false;
  spacepressed = false;
  dragging = 0;
  offset = 0;
  
  midspeed = 30;
  speed = midspeed;
  minspeed = 20;
  maxspeed = 40;
  speedx = width / 2;
  
  midjump = 30;
  jump = midjump;
  minjump = 25;
  maxjump = 35;
  jumpx = width / 2;
  
  midgravity = 2;
  gravity = midgravity;
  mingravity = 1.75;
  maxgravity = 2.25;
  gravityx = width / 2;
  
  temp = true;
  basepipetime = 120;
  pipetime = basepipetime;
  c = height / 10;
  gameover = false;
  time = 0;
  frame = 0;
  k = height / 1080.0;
  car = new Car(wheel);
  pipes = new ArrayList<Pipe>();
  map = new Pipe[][]{{new Pipe(c, c * 2, false), new Pipe(1.5 * c, 3 * c, false)}, {new Pipe(c, 3 * c, false), new Pipe(2 * c, 3 * c, false)}, {new Pipe(3 * c, 3 * c, false), new Pipe(2 * c, 3 * c, false)}, {new Pipe(3 * c, 3 * c, false), new Pipe(1.5 * c, 3 * c, false)}, {new Pipe(c, c * 7, true), new Pipe(1.5 * c, c * 6, true)}, {new Pipe(c, c * 4, true), new Pipe(c, c / 2, false), new Pipe(c / 2, c * 4, true), new Pipe(c / 2, c, false)}, {new Pipe(c, c * 5.5, true), new Pipe(c, c * 1, false), new Pipe(c, c * 4, true), new Pipe(c, c * 2, false)}, {new Pipe(c * 2, c * 5, true), new Pipe(c * 2, c * 1.5, false), new Pipe(c * 1.5, c * 5, true), new Pipe(c * 1.5, c, false)}};
}
void showscore() {
  stroke(0);
  fill(255, 0, 0);
  textSize(height / 20);
  text((int)(time) + "", width / 2 - textWidth((int)(time) + "") / 2, height / 20);
}
void showground() {
   image(ground, -groundx, groundy - groundoff, width, height - groundy);
   image(ground, width - groundx, groundy - groundoff, width, height - groundy);
   if (!gameover) {
     groundx += speed;
     if (groundx > width) {
       groundx -= width;
     }
   }
}
void keyPressed() {
  if (key == ' ') {
    space = !lastspace;
    lastspace = true;
    spacepressed = true;
  }
}
void keyReleased() {
  if (key == ' ') {
    lastspace = false;
    space = false;
    spacepressed = false;
  }
}
void draw() {
  if (!pre && !gameover) {
    frame++;
    time += 1 / 60.0;
  }
  mousepressed = !lastmouse && mousePressed;
  lastmouse = mousePressed;
  strokeWeight(1);
  stroke(0);
  fill(0, 252, 233);
  rect(0, 0, width, height);
  if (temp) {
    textSize(height / 20);
    fill(252, 143, 0);
    text("Choose wheel", width / 2 - textWidth("Choose, wheel") / 2, height / 10);
    image(wheel1, 0, 1.5 * height / 10, width / 8, width / 8);
    image(wheel2, width / 8 + width / 20, 1.5 * height / 10, width / 8, width / 8);
    image(wheel3, width / 4 + width / 10, 1.5 * height / 10, width / 8, width / 8);
    image(wheel4, 3 * width / 8 + 3 * width / 20, 1.5 * height / 10, width / 8, width / 8);
    image(wheel5, width / 2 + width / 5, 1.5 * height / 10, width / 8, width / 8);
    image(wheel6, 5 * width / 8 + width / 4, 1.5 * height / 10, width / 8, width / 8);
    image(wheel, width / 8, height / 2, height / 2, height / 2);
    text("Speed: " + wheelstats[chosenwheel][0], 3 * width / 8 + height / 2 - textWidth("Speed" + wheelstats[chosenwheel][0]) / 2, height / 2);
    text("Jumpspeed: " + wheelstats[chosenwheel][1], 3 * width / 8 + height / 2 - textWidth("Jumpspeed" + wheelstats[chosenwheel][1]) / 2, height / 2 + height / 10);
    text("Gravity: " + wheelstats[chosenwheel][2], 3 * width / 8 + height / 2 - textWidth("Gravity" + wheelstats[chosenwheel][2]) / 2, height / 2 + height / 5);
    textSize(height / 40);
    text("Press space to start", width - width / 4, 3 * height / 4);
    if (mousepressed && mouseY > 1.5 * height / 10) {
    }
    if (space) {
      speed = wheelstats[chosenwheel][0];
      jump = wheelstats[chosenwheel][1];
      gravity = wheelstats[chosenwheel[2];
      pre = false;
      temp = false;
    }
  }
  else if (pre) {
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
    }
    else if (mousepressed) {
      if (Math.pow(Math.pow(mouseX - speedx, 2) + Math.pow(mouseY - height / 8 - height / 80, 2), 0.5) < height / 40) {
        dragging = 1;
        offset = (int)(mouseX - speedx);
      } 
      else if (Math.pow(Math.pow(mouseX - jumpx, 2) + Math.pow(mouseY - 1.1 * height / 4 - height / 80, 2), 0.5) < height / 40) {
        dragging = 2;
        offset = (int)(mouseX - jumpx);
      } 
      else if (Math.pow(Math.pow(mouseX - gravityx, 2) + Math.pow(mouseY - 1.7 * height / 4 - height / 80, 2), 0.5) < height / 40) {
        dragging = 3;
        offset = (int)(mouseX - gravityx);
      }
      else if (mouseX < 3 * width / 4 && mouseX > width / 4 && mouseY > height / 2 && mouseY < height / 2 + 0.7 * height / 2) {
        speed *= k;
        jump *= k;
        gravity *= k;
        pre = false;
      }
    } 
    else if (dragging > 0) {
      if (mouseX - offset > width / 4 && mouseX - offset < 3 * width / 4) {
        if (dragging == 1) {
          speedx = mouseX - offset;
          speed = (speedx - width / 4) / (width / 2) * (maxspeed - minspeed) + minspeed;
        } 
        else if (dragging == 2) {
          jumpx = mouseX - offset;
          jump = (jumpx - width / 4) / (width / 2) * (maxjump - minjump) + minjump;
        } 
        else if (dragging == 3) {
          gravityx = mouseX - offset;
          gravity = (gravityx - width / 4) / (width / 2) * (maxgravity - mingravity) + mingravity;
        }
      }
    }
  }
  else {
    car.wheelIm = wheel;
    car.show();
    showground();
    if (car.grounded && space && !gameover) {
      car.grounded = false;
      space = false;
      car.speedy = jump;
    }
    if (frame % pipetime == 0) {
      if (pipetime > 45) {
        pipetime -= 6;
      }
      if (frame / pipetime - 1 <= 7) {
        if (Math.random() < 0.5) {
          if (map[frame / pipetime - 1].length == 2) {
            pipes.add(map[frame / pipetime - 1][0]);
          }
          else {
            pipes.add(map[frame / pipetime - 1][0]);
            pipes.add(map[frame / pipetime - 1][1]);
          }  
        }
        else {
          if (map[frame / pipetime - 1].length == 2) {
            pipes.add(map[frame / pipetime - 1][1]);
          }
          else {
            pipes.add(map[frame / pipetime - 1][2]);
            pipes.add(map[frame / pipetime - 1][3]);
          }
        }
      }
      else {
        float tempwidth = (float)((Math.random() + 1) * c);
        float height1 = (float)((Math.random() + 1) * 2.5 * c);
        float height2 = (float)((height - height1) * Math.random() / 2);
        pipes.add(new Pipe(tempwidth, height1, true));
        pipes.add(new Pipe(tempwidth, height2, false));
      }
    }
    for (int index = 0; index < pipes.size(); index++) {
      pipes.get(index).show();
      if (!pipes.get(index).alive) {
        pipes.remove(index);
        index--;
      }
    }
    showscore();
    if (gameover) {
      strokeWeight(1);
      stroke(255, 0, 0);
      textSize(height / 12);
      text("GAME OVER", width / 2 - textWidth("GAMEOVER") / 2, height / 2 - height / 12);
      textSize(height / 20);
      text("press SPACE to restart", width / 2 - textWidth("press SPACE to restart") / 2, height / 2 + height / 4);
      if (space) {
        time = 0;
        frame = 0;
        speedx = width / 2;
        speed = midspeed;
        jumpx = width / 2;
        jump = midjump;
        gravity = midgravity;
        gravityx = width / 2;
        gameover = false;
        pipes = new ArrayList<Pipe>();
        pre = true;
        car.y = groundy + this.height;
        pipetime = basepipetime;
        temp = true;
      }
    }
  }
}
class Car {
  PImage wheelIm;
  boolean grounded;
  int x;
  int y;
  float speedy;
  float xyratio;
  float wheelratio;
  float towheelx1;
  float towheelx2;
  float towheely;
  float length;
  float wheelsize;
  float height;
  float tirespin;
  float tireangle;
  Car(PImage wheeltype) {
    wheelIm = wheeltype;
    speedy = 0;
    grounded = true;
    x = width / 10;
    xyratio = 0.27467811158;
    wheelratio = 1.7253164557;
    towheelx1 = 10.614953271;
    towheelx2 = 1.37457044674;
    towheely = 1.82222222222;
    this.length = width / 5;
    wheelsize = this.length * xyratio / wheelratio;
    this.height = this.length * xyratio;
    tirespin = speed / (k * 100);
    tireangle = 0;
    y = (int)(groundy - this.height);
  }
  void show() {
    if (!grounded && !gameover) {
      y -= speedy;
      speedy -= gravity;
      if (spacepressed && speedy > 0) {
        speedy += gravity / 2;
      }
      if (y + this.height >= groundy && speedy < 0) {
        y = (int)(groundy + - this.height);
        speedy = 0;
        grounded = true;
      }
    }
    image(carIm, x, y, this.length, this.height);
    translate(x + this.length / towheelx1 + wheelsize / 2, y + this.height / towheely + wheelsize / 2);
    if (grounded && !gameover) {
      tireangle += tirespin;
      if (tireangle > 2 * Math.PI) {
        tireangle -= 2 * Math.PI;
      }
      rotate(tireangle);
    }
    image(wheel, -wheelsize / 2, -wheelsize / 2, wheelsize, wheelsize);
    if (grounded && !gameover) {
      rotate(-tireangle);
    }
    translate(-(x + this.length / towheelx1 + wheelsize / 2), -(y + this.height / towheely + wheelsize / 2));
    translate(x + this.length / towheelx2 + wheelsize / 2, y + this.height / towheely + wheelsize / 2);
    if (grounded && !gameover) {
      rotate(tireangle);
    }
    image(wheel, -wheelsize / 2, -wheelsize / 2, wheelsize, wheelsize);
    if (grounded && !gameover) {
      rotate(-tireangle);
    }
    translate(-(x + this.length / towheelx2 + wheelsize / 2), -(y + this.height / towheely + wheelsize / 2));
 }
}
class Pipe {
   int x;
   int y;
   int length;
   int height;
   boolean flip;
   boolean alive;
   float xtoy;
   Pipe(float xsize, float ysize, boolean swap) {
     x = width;
     flip = swap;
     this.length = (int)xsize;
     this.height = (int)ysize;
     alive = true;
     xtoy = 0.5;
     if (swap) {
       y = 0;
     }
     else {
       y = (int)(groundy - ysize + groundoff);
     }
   }
   void show() {
     if (alive) {
       if (!flip) {
         image(head, x, y, this.length, this.length * xtoy);
         image(base, x, y + this.length * xtoy, this.length, this.height - this.length * xtoy);
       }
       else {
         translate(x + this.length / 2, this.height - this.length * xtoy / 2);
         rotate((float)Math.PI);
         image(head, -this.length / 2, -this.length * xtoy / 2, this.length, this.length * xtoy);
         rotate(-(float)Math.PI);
         translate(-x - this.length / 2, -this.height + this.length * xtoy / 2);
         translate(x + this.length / 2, (this.height - this.length * xtoy) / 2);
         rotate((float)(Math.PI));
         image(base, -this.length / 2, -(this.height - this.length * xtoy) / 2, this.length, this.height - this.length * xtoy);
         rotate((float)(Math.PI));
         translate(-x - this.length / 2, -(this.height - this.length * xtoy) / 2);
       }
       if (!gameover) {
         x -= speed;
         if (x < -this.length) {
           alive = false;
         }
         if (car.x < x + this.length && car.x + car.length > x) {
           println(1);
           if (!flip && car.y - this.height / 10 > y) {
             gameover = true;
           }
           else if (flip && car.y + this.height / 6 < this.height) {
             gameover = true;
           }
         }
       }
     }
   }
 }
