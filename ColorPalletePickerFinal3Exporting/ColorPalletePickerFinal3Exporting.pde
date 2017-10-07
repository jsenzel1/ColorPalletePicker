
//
//
//
//
//
//Change These Variables
int colorsChecked = 0;
int changeCount = 0;
int maxRandX = 0;
int maxRandY = 0;
int pixSize = 1;
int pixelFactor = 1;
boolean circles = false;
//
//
//
//
//
//
//

boolean loadingTextOn;
boolean setupDone = false;
boolean picSetup = false;
int myPal[] = new int[8];
int idx = 0;
int HSBMODE = 0;





//Part1Vars
//
//
//
import drop.*;
SDrop drop;

PImage palPic;
PImage targetPic;
boolean clicker = false;
color globalC;
color clickedC;
int cIterator = 0;
boolean resized = false;
int counter=0;

color Colors[] = new color[100];
String cToString[] = new String[8];

PImage resizedPic;

int lenUp = -45;
int textX = 150;
boolean colorsPicked = false;
boolean loadedPalPic = false;
boolean loadedTargetPic = false;
boolean cUsedPrint = false;


//Imported drag and drop library Event Listener
void dropEvent(DropEvent theDropEvent) {
  if (loadedPalPic ==false) {
    println("");
    println("isFile()\t"+theDropEvent.isFile());
    println("isImage()\t"+theDropEvent.isImage());
    println("isURL()\t"+theDropEvent.isURL());

    // if the dropped object is an image, then 
    // load the image into our PImage.

    if (theDropEvent.isImage()) {
      println("### loading image ...");
      palPic = theDropEvent.loadImage();
      loadedPalPic = true;
    }
  }

  //Listener for the Second Picture
  if (loadedPalPic ==true && colorsPicked && targetPic == null) {
    palPic = null;
    println("");
    println("isFile()\t"+theDropEvent.isFile());
    println("isImage()\t"+theDropEvent.isImage());
    println("isURL()\t"+theDropEvent.isURL());

    // if the dropped object is an image, then 
    // load the image into our PImage.
    if (theDropEvent.isImage()) {

      println("### loading image ...");
      targetPic = theDropEvent.loadImage();
      loadingTextOn = true;
      fill(0);
      ellipse(width/2,height/2,250,250);
      //Leaves time to load image - immediate loading was a source of bugs in earlier versions
      delay(1000);
      loadedTargetPic = true;
      println("Target Pic Loaded");
      
    }
  }
}




//Mouse click listener for the first part - adds color codes to the pallette file

void mousePressed() {
  if (loadedPalPic==true) {
    if (mousePressed && clicker == false) {
      clicker = true;  

      Colors[cIterator] = globalC;
      cIterator++;


      //fill(globalC);
      rectMode(CORNER);
      clickedC = globalC;


      lenUp +=50;
    }
  }
}



void mouseReleased() {
  clicker = false;
}


void setup() {

  size(670, 400);
  background(255);
  drop = new SDrop(this);

  textAlign(CENTER, CENTER);
  textSize(30);
  noStroke();
}







void draw() {
  
  if(colorsPicked == false){

  if (loadedPalPic ==true && colorsPicked) {
    palPic = null;
  }

  if (frameCount % 30 == 0) {

    println(targetPic==null);
    counter++;
  }

  if (palPic != null) {
    imageMode(CORNER);
    palPic.resize(600, 400);
    resizedPic=palPic.get(); 
    resized=true;
  }

  //fill(255);
  //rect(600,0, 70,400);


  fill(clickedC);
  rect(600, lenUp, 70, 40);



  if (loadedPalPic == false) {
    textX = width/2; 
    textSize(16);
    fill(0);
    //not sure why just this text is oddly low res
    text("Drag and drop a picture that", textX, height/2-20);
    text("you want to extract the color pallete of", textX, height/2 +5);
   
  }

  if (loadedPalPic && colorsPicked==false ) {
    textSize(16);
    fill(0);
    text("Pic 1 loaded succesfully", width/2, height/2+45);
    //println("pic1Loaded");
  }



  if (loadedPalPic == true && colorsPicked==false) {

    rectMode(CORNER);

    if (colorsPicked == false && resized && loadedPalPic) {

      palPic.resize(600, 400);
      globalC = resizedPic.get(mouseX, mouseY);

      for (int x = 0; x< 600; x++) {
        for (int y = 0; y< 400; y++) {
          color tC = resizedPic.get(x, y);
          fill(tC);
          rect(x, y, 1, 1);
        }
      }

      fill(palPic.get(mouseX, mouseY));
      if (mouseX > width - 90) {
        fill(255);
      }
      ellipse(mouseX +15, mouseY -15, 37, 37);
      //println("Global C" + globalC);

      if (cIterator == 8) {
        for (int i=0; i<cToString.length; i++) { 
          cToString[i] = str(Colors[i]);
        }
        saveStrings("pallette.txt", cToString);
        colorsPicked = true;
        //stop();
      }
    }
  }
}




  //PART II//PART II//PART II//PART II//PART II//PART II//PART II//PART II//PART II
  //PART II//PART II//PART II//PART II//PART II//PART II//PART II//PART II//PART II
  //PART II//PART II//PART II//PART II//PART II//PART II//PART II//PART II//PART II
  //PART II//PART II//PART II//PART II//PART II//PART II//PART II//PART II//PART II
  //PART II//PART II//PART II//PART II//PART II//PART II//PART II//PART II//PART II
  //PART II//PART II//PART II//PART II//PART II//PART II//PART II//PART II//PART II
  //PART II//PART II//PART II//PART II//PART II//PART II//PART II//PART II//PART II
  //PART II//PART II//PART II//PART II//PART II//PART II//PART II//PART II//PART II
  //PART II//PART II//PART II//PART II//PART II//PART II//PART II//PART II//PART II
  //PART II//PART II//PART II//PART II//PART II//PART II//PART II//PART II//PART II




  if (colorsPicked) {
    
    if(loadingTextOn){
      
      fill(0);
      text("Loading...", width/2,height/2);
      
    }

    //Second Setup function made to run once
    if (setupDone == false) {

      noStroke();
      String[] stringPal = loadStrings("pallette.txt");
      for (int i = 0; i < stringPal.length; i++) {
        myPal[i] = int(stringPal[i]);
        println(myPal[i]);
        
      }
      print("Setup Complete");
      setupDone = true;
    }
  }
  
  if(cUsedPrint == false){
  for (int i = 0; i < myPal.length; i++) { 
        
        println(myPal[i]);
        //print("THEFORGOTTENFORLOOP");
      }
      cUsedPrint = true;
  }

  if (colorsPicked && setupDone) {
    fill(255);
    rect(0, 0, 600, 400);
    fill(0);
    text("Drag and drop a picture that", textX, height/2-20);
    text("you want to apply the selected pallete to", textX, height/2 +5);
    
  }

  if (loadedTargetPic) {

    if (picSetup == false) {
      targetPic.resize(600, 400);
      targetPic = targetPic.get();
      picSetup = true;
      println("pic setup done");
      println(targetPic.width, targetPic.height);
      
    }
   

    image(targetPic, 0, 0);


    background(255);
    if (HSBMODE == 0){
    rectMode(CORNER);
    
    //This is the meat of the Image processing
    //looks at a pixel of the second image, and get's it's color code
    //compares that color code to all the colors in the pallette
    //sees which color in the pallette that pixel is closest to
    //colors the pixel that color
    //moves on to the next pixel
    
      for (int x = 0; x< targetPic.width; x+=pixelFactor) {
        for (int y = 0; y< targetPic.height; y+=pixelFactor) {  
          color curCol = targetPic.get(x, y);
          int distance = abs(myPal[0] - curCol);
          for (int i = 1; i < myPal.length; i++) {
            int idistance = Math.abs(myPal[i] - curCol);
            if (idistance < distance) {
              idx = i;
              distance = idistance;
            }
          }
          fill(myPal[idx]);
          int randX = int(random(maxRandX));
          int randY = int(random(maxRandY));
          if (circles == true) {
            ellipse(x + randX, y +randY, pixSize, pixSize);
            idx = 0;
          }
          if (circles == false) {
            rect(x + randX, y +randY, pixSize, pixSize);
            idx = 0;
          }
        }
   
      }

      stop();
      println("DO NOT PASS GO OR RUN AFTER STOP()");
    }

    //end RGB mode

    if (HSBMODE ==1) {

      for (int x = 0; x< targetPic.width; x++) {
        for (int y = 0; y< targetPic.height; y++) {  
          color curCol = targetPic.get(x, y);
          int distance = Math.abs((int(hue(myPal[0]))- int(hue(curCol))));

          int curH = int(hue(curCol));
          int curS = int(saturation(curCol));
          int curB = int(brightness(curCol));


          for (int i = 0; i < myPal.length; i++) {
            int listH = int(hue(myPal[i]));
            int idistance = Math.abs(listH - curH);
            if (idistance < distance) {
              idx = i;
              distance = idistance;

              changeCount++;
            }


            colorsChecked++;
          }
          colorMode(HSB);
          //int curColInt = int(curCol);
          int newHue = int((hue(myPal[idx])));
          color changedHSB = color(newHue, curS, curB);
          fill(changedHSB);
          rect(x, y, 1, 1);
          //idx = 0;
        }
      }
      for (int i = 0; i < myPal.length; i++) {
        println("intPal " + myPal[i]);
      }
    }
  }
}