import processing.net.*;

Server s;
byte[] input, output;
int data[];

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
  for (int x = 0; x < s.clientCount; x++) {  
    Client c = s.available();
    if (c!=null) {  
      input = c.readBytes();
      if (input[0] == 'r'){
        output[0] = '1';
      }
      else if (input[0] == 'd'){
        output[0] = '2';
      }
      else{
        output[0] = '3';
      }
      if (input.length > 1) {
        int z = x*8+1;
        System.out.println(output.length);
        System.out.println(input.length);
      
        for (int y = 0; y < input.length; y++) {
          output[z] = input[y];
          z++;
        }
      }
      System.out.println(output);
    }  
    s.write(output);
  }
}

void serverEvent(Server someServer, Client someClient) {
  println("We have a new client: " + someClient.ip());
  s.write(new byte[]{'p',(byte) s.clientCount});
  output= new byte[8*s.clientCount+1];
}