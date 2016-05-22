import processing.net.*;

Server s;
String input, output;
int data[];

int player = 0;

boolean[] ready;
//int port = 5204;

void setup() {
  size(500, 500);
  // Starts a myServer on port 5204
  s = new Server(this, 61271);
  background(0);
  rectMode(CENTER);
  textAlign(CENTER, CENTER);
}

void draw() {
  Client c = s.available();
  output="";
  input="";
  if (c!=null) {  
    input = c.readString();
    if (input.equals("ready")){
      s.write("go");
    }
    else if (input.equals("dead")){
      s.write("end");
    }
    else{
      output=input;
    }
    System.out.println(output);
  }
  s.write(output);
}

void serverEvent(Server someServer, Client someClient) {
  println("We have a new client: " + someClient.ip());
  player++;
  s.write("new p"+player);
}