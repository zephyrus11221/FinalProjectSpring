import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;
import processing.net.*; 


String output, input;

PShape s;
PShape s2;

Player[] p;

int pNum = -1;

float y=600;
float x=640;

AudioPlayer player;
Minim minim;//audio context

Client c;

float screenX=1280;
float screenY=720;

float[] xPos, yPos;
float g;

String stage;
PImage startScreen;
PFont title;

float velocity=8;

float rotate=PI/100;

boolean[] ATKDown;
boolean[] DEFDown;
boolean[] JMPDown;
boolean[] dDown;
boolean[] aDown;
boolean[] wDown;
boolean[] sDown;

boolean combat;

//character coordinates
int xcor1 = 100;
int ycor1 = 500;

void setup(){
  size(1280, 720);
  startScreen = loadImage("menu.jpg");
  textureMode(NORMAL);
  stage = "Menu";
  image(startScreen, 0, 0, 308, 82);
  title = createFont("font", 500, true);
  fill(255);
  stroke(color(44, 48, 32));
  minim = new Minim(this);
  player = minim.loadFile("main.mp3", 2048);
  player.loop();
  c = new Client(this, "127.0.0.1", 61271); 
}

void draw(){
  output = "";
  if (c.available()>0){
    input = c.readString();
    if (input.equals("go")){
      stage = "Map0";
    }
    if (input.substring(0,input.length()-1).equals("new p")&&pNum==-1){
      System.out.println("hello");
      pNum=(int)Integer.parseInt(input.substring(input.length()-1));
    }
  }
  if (stage.equals("Menu")){
    background(10,30,100);
    image(startScreen, 409, 100, 462, 123);
    textAlign(CENTER);
    fill(255, 255, 255);
    textSize(36);
    text("Press R to begin", 640, 300);
    text("Press I to view instructions", 640, 450);
    if (key=='r') {
      c.write("ready");
      combat = true;
    }
    if (key=='i'){
      stage="Instructions";
    }
  }
  if (stage.equals("Map0")){
    background(0,0,0);
    PImage b1,b2,b3;
    b1 = loadImage("back1.jpg");//794x101
    b2 = loadImage("back2.jpg");
    b3 = loadImage("back3.JPG");
    imageMode(CENTER);
    image(b1, 640, 300, 1300, 176);
    image(b3, 640, 650, 1300, 400);
    image(b2, 640, 500, 1300, 176);

    Player p1 = new Bandit();
    if (key=='a') {
      if (xcor1 > 0) {
        xcor1 -= 10;
      }
      p1.display(xcor1,ycor1,"p1");
      key = '\u0000';
    }
    if (key=='w') {
      if (ycor1 > 0) {
        ycor1 -= 10;
      }
      p1.display(xcor1,ycor1,"p1");
      key = '\u0000';
    }
    if (key=='s') {
      ycor1 += 10;
      p1.display(xcor1,ycor1,"p1");
      key = '\u0000';  
    }
    if (key=='d') {
      xcor1 += 10;
      p1.display(xcor1,ycor1,"p1");
      key = '\u0000';
    }      
    else {
      p1.display(xcor1,ycor1,"p1");
    }
    System.out.println(output);  
    c.write(pNum+output+' ');
  }
}