/*
 * Slider Example
 *
 *   This example is of a slider that sends a value in the range of 0 to 1023.  
 *   Click and drag the mouse to move the slider.
 * 
 */
 

import spacebrew.*;

import processing.video.*;
Movie myMovie;

PImage img1;
PImage img2;

int movieCounter; 

String server="54.201.24.223";
String name="Pizza/Burger?";
String description ="Client that sends and receives range messages. Range values go from 0 to 1023.";


Spacebrew sb;

// Keep track of our current place in the range
int local_slider_val = 512;
int remote_slider_val = 512;

void setup() {
  
	size(1023,1023);
        img1 = loadImage("pizza.png");
        img2 = loadImage("burger2.jpg");
        
         myMovie = new Movie(this, "mka.mp4");
         
	// instantiate the spacebrewConnection variable
	sb = new Spacebrew( this );

	// declare your publishers
	sb.addPublish( "local_slider", "range", local_slider_val ); 


        // declare your subscribers
        sb.addSubscribe( "change_background", "boolean" );
	
        // connect!
	sb.connect(server, name, description );
        
        image(img1, 0, 0, width/2, height);
        image(img2, 512, 0, width/2, height);
        
  
}

void movieEvent(Movie movie){
  myMovie.read(); 

}

void draw() {
      
   
        
        if (movieCounter == 1){
         image(myMovie, 0, 0);
         myMovie.loop();
        }

}


void mouseDragged() {
  // Leaving 20 pixels at the end prevents the slider from going off the screen
  if (mouseX >= 0 && mouseX <=500) {
    local_slider_val = mouseX;
    sb.send("local_slider", local_slider_val);
    println(local_slider_val); 
  } 
  
 if (mouseX >= 520 && mouseX <=1023) {
    local_slider_val = mouseX;
    sb.send("local_slider", local_slider_val);
    println(local_slider_val); 

  }   
}

void onRangeMessage( String name, int value ){
	println("got range message " + name + " : " + value);
	remote_slider_val = value;
}

void onBooleanMessage(String name, boolean value){
  if (value == true){
        movieCounter = 1; 
        }
  }
  


