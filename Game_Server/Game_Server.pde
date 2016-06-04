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
      output[1] = (byte) s.clientCount;
      if (input.length > 1) {
        int z = 2;
        System.out.println(output.length);
        System.out.println(input.length);
      
        for (int y = 0; y < 9; y++) {
          if (y < input.length) {
          output[z] = input[y];
          }
          else {
            output[z] = 0;
          }
          z++;
        }
      }
      for (byte u : output) {
        System.out.print(u+" ");
      }
    }  
    s.write(output);
    s.write(9);
}

void serverEvent(Server someServer, Client someClient) {
  println("We have a new client: " + someClient.ip());
  s.write(new byte[]{'p',(byte) s.clientCount});
  s.write(9);
  output= new byte[11];
}