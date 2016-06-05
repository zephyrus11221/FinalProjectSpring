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
byte[] keys1;
byte[] keys2;
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
  //c = new Client(this, "127.0.0.1", 61271);
  keys1 = new byte[8];
  keys2 = new byte[8];
  keys1[7] = 1;
  keys2[7] = 2;
  p = new Player[2];
}

void draw(){
  output = new byte[9];
  /*input = new byte[]{2,0,0,0,0,0};
  if (c.available()>0){
    input = c.readBytesUntil(9);
    if (input == null) {
      input = new byte[]{2,0,0,0,0,0};
    }
    c.clear();

      //System.out.println("wOrks");
      println();
      System.out.println("Player:" + pNum);
      for (byte n : input) {
        System.out.print(n+ " ");
      }
      
     } //<>// //<>// //<>//
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
      p[y] = new Henry();
  }  
    }
*/
  if (stage.equals("Menu")){
    background(10,30,100);
    image(startScreen, 409, 100, 462, 123);
    textAlign(CENTER);
    fill(255, 255, 255);
    textSize(36);
    text("Press R to begin", 640, 300);
    text("Press I to view instructions", 640, 450);
    if (key=='r') {
      //c.write(new byte[]{'r'});
      combat = true;
      stage = "Map0";
      p[0] = new Henry();
      p[1] = new Henry();
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
    process(keys1);
    process(keys2);
    for ( Player g : p) {
      g.display("hi");
    }
    //output[0] = (byte) pNum;
    //output[1] = 'B';
   
    //for (int x = 0; x < keys.length; x++) {
     // output[x+2] = keys[x];
    //}
    text(""+p[0].xcor+", "+p[0].ycor, 600, 500);
//    System.out.println(output);  
    //System.out.println();
    //for (byte v : output) {
   //   System.out.print(v+ " ");
   // }

    //c.write(output);
    
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
      if (data[0] == 8){
        if(p[data[7]-1].xcor>40){
          p[data[7]-1].setx(-7);
        }
      }
      if (data[1] == 8){
        if(p[data[7]-1].ycor>500){
          p[data[7]-1].sety(-4);
        }
      }
      if (data[2] == 8){
        if(p[data[7]-1].ycor<650){
          p[data[7]-1].sety(4);
        }
      }
      if (data[3] == 8){
        if(p[data[7]-1].xcor<1230){
          p[data[7]-1].setx(7);
        }
      }
      if (data[4] == 8 && data[5] == 8 && data[6] == 8) {
        //combo
         projectiles.add(new Projectile(p[0].xcor, p[0].ycor));
      }
      else if (data[4] == 8) {
        //punch
        if (data[7] == 1 && keys2[6]== 8) {
          //punch blocked
        }
        else if (data[7] == 2 && keys1[6]== 8) {
          //punch blocked
        }
        else if (data[7] == 1) {
          if ( (abs(p[0].xcor - p[1].xcor) < 70) || (abs(p[0].ycor - p[1].ycor) < 70) ) {
            p[0].punch(p[1]);
          }
        }
        else if (data[7] == 2) {
          if ( (abs(p[0].xcor - p[1].xcor) < 70) || (abs(p[0].ycor - p[1].ycor) < 70) ){
            p[1].punch(p[0]);
          }
        }
      }
      else if (data[5] == 8) {
        //jump
      }
      else if (data[6] == 8) {
        //block
      }
      
    
  }
  void keyPressed() {
    if (key=='a') {
      keys1[0] = 8;
    }
    if (key=='w') {
      keys1[1] = 8;
    }
    if (key=='s') {
      keys1[2] = 8;
    }
    if (key=='d') {
      keys1[3] = 8;
    }
    if (key=='j') {
      keys1[4] = 8;
    }
    if (key=='k') {
      keys1[5] = 8;
    }
    if (key=='l') {
      keys1[6] = 8;
    }
    if(keyCode==LEFT ){
      keys2[0] = 8;
    }
    if(keyCode==UP){
      keys2[1] = 8;
    }
    if(keyCode==DOWN){
      keys2[2] = 8;
    }
    if(keyCode==RIGHT){
      keys2[3] = 8;
    }
    if(keyCode==97){
      keys2[4] = 8;
    }
    if(keyCode==98){
      keys2[5] = 8;
    }
    if(keyCode==99){
      keys2[6] = 8;
    }
  }
  void keyReleased() {
    if (key=='a') {
      keys1[0] = 0;
    }
    if (key=='w') {
      keys1[1] = 0;
    }
    if (key=='s') {
      keys1[2] = 0;
    }
    if (key=='d') {
      keys1[3] = 0;
    }
    if (key=='j') {
      keys1[4] = 0;
    }
    if (key=='k') {
      keys1[5] = 0;
    }
    if (key=='l') {
      keys1[6] = 0;
    }
    
    if(keyCode==LEFT ){
      keys2[0] = 0;
    }
    if(keyCode==UP){
      keys2[1] = 0;
    }
    if(keyCode==DOWN){
      keys2[2] = 0;
    }
    if(keyCode==RIGHT){
      keys2[3] = 0;
    }
    if(keyCode==97){
      keys2[4] = 0;
    }
    if(keyCode==98){
      keys2[5] = 0;
    }
    if(keyCode==99){
      keys2[6] = 0;
    }
  }   