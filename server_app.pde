import processing.net.*;

Server s;
String input;
int data[];
//int port = 5204;
int brushWidth;

void setup() {
  size(500, 500);
  // Starts a myServer on port 5204
  s = new Server(this, 5204);
  background(0);
  brushWidth = 1;
  rectMode(CENTER);
  textAlign(CENTER, CENTER);
}

void draw() {
  if (keyPressed /*&& !mousePressed*/) {
    checkKeys();
  }
  Client c = s.available();
  if (c!=null) {  
    input = c.readString();
    if (input.indexOf("\n")>=0) {
      input = input.substring(0, input.indexOf("\n"));
    }// Only up to the newline
    System.out.println(input);
    parseCommands();
  }
  if (mousePressed) {
    // Draw our line
    stroke(255);
    strokeWeight(brushWidth);
    line(pmouseX, pmouseY, mouseX, mouseY); 
    // Send mouse coords to other person
    s.write(brushWidth + " " + pmouseX + " " + pmouseY + " " + mouseX + " " + mouseY + "\n");
  }
  drawSizeIndicator(brushWidth);
}

void drawSizeIndicator(int size) {
  if (size>1) { 
    textSize(size/2);
    strokeWeight(1);
    fill(0);
    stroke(0);
    rect(size/2, size/2, size+PI, size+PI);
    stroke(255);
    fill(255);
    ellipse(size/2, size/2, size, size);
    fill(0);
    stroke(0);
    text(size, size/2, size/2);
  }
}

void serverEvent(Server someServer, Client someClient) {
  println("We have a new client: " + someClient.ip());
}

void checkKeys() {
  if (key == 'e') {
    s.write("erase\n");
    background(0);
  }
  if (key == 'd') {
    brushWidth++;
  }
  if (key == 'a') {
    if (brushWidth>1) {
      brushWidth--;
    }
  }
}
void parseCommands() {
  if (input.equals("erase")) {
    background(255);
  } else {
    data = int(split(input, ' '));  // Split values into an array
    if (data.length==5) {
      brushWidth = data[0];
      strokeWeight(brushWidth);
      line(data[1], data[2], data[3], data[4]);
    }
  }
}