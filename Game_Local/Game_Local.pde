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
int projectileCount = 0;
float y=600;
float x=640;
float gravity = 2;
int time = 0;
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
int xcor2;
int ycor2;
int[] yv = new int[]{-36, -36};
int what = 1;

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
      println(); //<>//
      System.out.println("Player:" + pNum);
      for (byte n : input) {
        System.out.print(n+ " ");
      }
      
     } //<>// //<>// //<>// //<>// //<>//
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
      p[0] = new Bandit(100,550,true);
      p[1] = new Henry(1180,550,false);
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
    if (p[0].state != "jumping") {
      p[0].state = "walk";
    }
    if (p[1].state != "jumping") {
      p[1].state = "walk";
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
    //System.out.println(p[0].health + " " + p[1].health);
    if(projectiles!=null){
      //System.out.println(projectiles.toString());
      for (int i = 0; i<projectileCount; i++){
        //System.out.println(p[1].mana);
        if (projectiles.get(i) != null) {
          projectiles.get(i).display();
          if(projectiles.get(i).xCor()>1280||projectiles.get(i).xCor()<0){
            projectiles.remove(i);
            projectileCount--;
          }
        }        
      }
    }
  }
}

void process(byte[] data) {
  Projectile x = p[data[7]-1].combo(data);
    if (x== null) {
      if (data[0] == 8){
        if(p[data[7]-1].xcor>40 && p[data[7]-1].state != "jumping"){
          p[data[7]-1].setx(-7);
          p[data[7]-1].state = "walk";
          p[data[7]-1].right = false;
        }
        
      }
      if (data[1] == 8){
        if(p[data[7]-1].ycor>500 && p[data[7]-1].state != "jumping"){
          p[data[7]-1].sety(-4);
          p[data[7]-1].state = "walk";
        }
      }
      if (data[2] == 8){
        if(p[data[7]-1].ycor<650 && p[data[7]-1].state != "jumping"){
          p[data[7]-1].sety(4);
          p[data[7]-1].state = "walk";
        }
      }
      if (data[3] == 8){
        if(p[data[7]-1].xcor<1230 && p[data[7]-1].state != "jumping"){
          p[data[7]-1].setx(7);
          p[data[7]-1].state = "walk";
          p[data[7]-1].right = true;
        }
      }
      if (p[0].xcor == p[1].xcor && p[0].ycor == p[1].ycor && p[data[7]-1].state != "jumping") {
        if (data[0] == 8) {
          p[data[7]-1].setx(7);
        }
        if (data[1] == 8) {
          p[data[7]-1].sety(4);
        }
        if (data[2] == 8) {
          p[data[7]-1].sety(-4);
        }
        if (data[3] == 8) {
          p[data[7]-1].setx(-7);
        }
      }

      if (data[4] == 8 && p[data[7]-1].state != "jumping") {
        //punch
        if (data[7] == 1 && keys2[6]== 8 && p[1].block > 0) {
          p[1].block = p[1].block - 1;
          //punch blocked
        }
        else if (data[7] == 2 && keys1[6]== 8 && p[0].block > 0) {
          p[0].block = p[0].block - 1;
          //punch blocked
        }
        else if (data[7] == 1) {
          if ( (abs(p[0].xcor - p[1].xcor) < 70) && (abs(p[0].ycor - p[1].ycor) < 70)) {
            if ( (p[0].xcor > p[1].xcor && !p[0].right) || (p[0].xcor < p[1].xcor && p[0].right) ) {
              p[0].state = "punch";
              p[0].punch(p[1]);
            }
          }
        }
        else if (data[7] == 2) {
          if ( (abs(p[0].xcor - p[1].xcor) < 70) && (abs(p[0].ycor - p[1].ycor) < 70) ){
            if ( (p[0].xcor > p[1].xcor && p[1].right) || (p[0].xcor < p[1].xcor && !p[1].right) ) {
              p[0].state = "punch";
              p[1].punch(p[0]);
            }
          }
        }
      }
      else if (data[5] == 8 || p[data[7]-1].state == "jumping") {
        if ( p[data[7]-1].state != "jumping") {
          p[data[7]-1].state = "jumping";
          time =millis();
          System.out.println("okay");
          ycor1 = p[data[7]-1].ycor;
          println("state" + p[data[7]-1].state);
        }
        else {/*
          println(p[data[7]-1].xcor + " " + p[data[7]-1].ycor); 
          float timeNow = millis();
          float velocityIx = 7;
          float velocityIy = -35;
          float angleI = 70;
          p[data[7]-1].setx((int) (velocityIx*(timeNow/1000.0)) );
          println( (int) (velocityIy*(timeNow/1000.0)*sin(angleI) - .5*gravity*pow((timeNow/1000),2)) +ycor1);
            p[data[7]-1].sety( (int) (velocityIy*(timeNow/1000.0) - .5*gravity*pow((timeNow/1000),2)) );
          if ( p[data[7]-1].ycor > ycor1) {
            p[data[7]-1].sety(ycor1);
            p[data[7]-1].state = "walk";
          }*/
          int xv;
          if(data[0]==8){
            xv = -7;
          }
          else if(data[3]==8){
            xv = 7;
          }
          else{
            xv =0;
          }
          p[data[7]-1].setx(xv);            
          p[data[7]-1].sety(yv[data[7]-1]);
          yv[data[7]-1]+=3;
          if(p[data[7]-1].xcor < 40) {
            p[data[7]-1].xcor = 40;
          }
          if(p[data[7]-1].xcor >1230) {
            p[data[7]-1].xcor = 1230;
          }
          if(p[data[7]-1].ycor > ycor1){
            System.out.println("magic");
            println(p[data[7]-1].ycor);
            println(ycor1);
            p[data[7]-1].ycor = ycor1;
            p[data[7]-1].state = "walk";
            yv = new int[]{-36, -36};
          }
          println("state" + p[data[7]-1].state);
        
          println(p[data[7]-1].xcor + " " + p[data[7]-1].ycor); 
        //jump
        }
      }
      else if (data[6] == 8) {
        //block
      }
      if (data[0] == 0 && data[1] == 0 && data[2] == 0 && data[3] == 0 && data[4] == 0 && data[5] == 0 && data[6] == 0) {
        p[data[7]-1].state = "idle";
      }
    }
    else {
      projectiles.add(x);
      projectileCount++;
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
      p[0].block = 3;
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
      p[1].block = 3;
    }
  }   