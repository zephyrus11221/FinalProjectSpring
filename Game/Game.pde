import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;
import processing.net.*; 
import java.util.*;

byte[] output, input;

ArrayList<Projectile> projectiles = new ArrayList<Projectile>();

PShape s;
PShape s2;

Player[] p;

int pNum = -1;

int test = 0;

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
byte[] keys;
boolean combat;

//character coordinates
int xcor1;
int ycor1;
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
  keys = new byte[7];
}

void draw(){
  output = new byte[9];
  //input = new byte[]{2,0,0,0,0,0};
  if (c.available()>0){
    input = c.readBytesUntil(9);
    if (input == null) {
      input = new byte[]{2,0,0,0,0,0};
    }
    c.clear();
     /*if (input.length > 8){
      if (Arrays.binarySearch(input,2,input.length,input[0]) > 0){
        byte[] temp = new byte[Arrays.binarySearch(input,2,input.length,input[0])];
        for (int v = 0; v < temp.length; v++) {
          temp[v] = input[v];
        }
        input = new byte[temp.length];
        input = temp;
      }*/
      //System.out.println("wOrks");
      println();
      System.out.println("Player:" + pNum);
      for (byte n : input) {
        System.out.print(n+ " ");
      }
      
     } //<>//
    //System.out.println("wOrks");
     if (input[0] == '1'){
      //System.out.println("wOrks");
      
       stage = "Map0";
      if ((int) input[1] > p.length) {
        Player[] temp = new Player[(int) input[1]];
        for (int h = 0; h < temp.length; h++) {
          if ( h < p.length) {
            temp[h] = p[h];
          }
          else {
            temp[h] = new Bandit();
          }
        }
        p = temp;
      }
    }
    if (input[0] == 'p') {
      System.out.println("horray");
    pNum = (int) input[1];
    p = new Player[pNum];
    int x = p.length;
      for (int y = 0; y < x; y++) {
      p[y] = new Bandit();
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
      c.write(new byte[]{'r'});
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
    image(b3, 640, 850, 1300, 600);
    image(b2, 640, 500, 1300, 176);
    process(input);
    for ( Player g : p) {
      g.display("hi");
    }
    output[0] = (byte) pNum;
    output[1] = 'B';
    try {
      wait(2000);
    }catch (Exception e) {
    }
    for (int x = 0; x < keys.length; x++) {
      output[x+2] = keys[x];
    }
    text(""+p[0].xcor+", "+p[0].ycor, 600, 500);
//    System.out.println(output);  
    //System.out.println();
    //for (byte v : output) {
   //   System.out.print(v+ " ");
   // }

    c.write(output);
    
    if(projectiles!=null){
      for (int i = 0; i<projectiles.size(); i++){
        System.out.println("hi");
        projectiles.get(i).display();
        if(projectiles.get(i).xCor()>1280||projectiles.get(i).xCor()<0){
          projectiles.remove(i);
        }
      }
    }
  }
}

  void process(byte[] data) {
      if (data.length == 12 && data[2]-1 < 10 && data[2]-1 >= 0) {
      if (data[4] == 8){
        if(p[data[2]-1].xcor>40){
          p[data[2]-1].setx(-7);
        }
      }
      if (data[5] == 8){
        if(p[data[2]-1].ycor>500){
          p[data[2]-1].sety(-4);
        }
      }
      if (data[6] == 8){
        if(p[data[2]-1].ycor<650){
          p[data[2]-1].sety(4);
        }
      }
      if (data[7] == 8){
        if(p[data[2]-1].xcor<1230){
          p[data[2]-1].setx(7);
        }
      }
      }
  }
  void keyPressed() {
    if (key=='a') {
      keys[0] = 8;
    }
    if (key=='w') {
      keys[1] = 8;
    }
    if (key=='s') {
      keys[2] = 8;
    }
    if (key=='d') {
      keys[3] = 8;
    }
    if (key=='j') {
      keys[4] = 8;
      projectiles.add(new Projectile(p[0].xcor, p[0].ycor));
    }
    if (key=='k') {
      keys[5] = 8;
    }
    if (key=='l') {
      keys[6] = 8;
    }
  }
  void keyReleased() {
    if (key=='a') {
      keys[0] = 0;
    }
    if (key=='w') {
      keys[1] = 0;
    }
    if (key=='s') {
      keys[2] = 0;
    }
    if (key=='d') {
      keys[3] = 0;
    }
    if (key=='j') {
      keys[4] = 0;
    }
    if (key=='k') {
      keys[5] = 0;
    }
    if (key=='l') {
      keys[6] = 0;
    }
  }   