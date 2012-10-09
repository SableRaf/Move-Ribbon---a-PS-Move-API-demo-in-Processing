import io.thp.psmove.*;

PSMove move;
PSMoveTracker tracker;

Boolean isDebug = true;
Boolean alert = false;

// position values
float posX;
float posY;
float posZ;

// color values for the sphere
short r[];
short g[];
short b[];

// Button objects for dealing with input
MoveButton moveBtn;
MoveButton squareBtn;
MoveButton triangleBtn;
MoveButton crossBtn;
MoveButton circleBtn;
MoveButton startBtn;
MoveButton selectBtn;
MoveButton psBtn;

int triggerValue = 0;

// Used to get and display the tracker image
byte [] pixels;
PImage img;
int captureWidth, captureHeight;

int isFound = 0; // will be nonzero if tracker finds the sphere

int alertCount = 10; // countdown for alerts (higher number means longer alert)
int alertTime = alertCount;

class MoveManager { 

  MoveManager() {
    init();
  }

  void init() {    
    move = new PSMove();
    move.set_leds(255, 255, 255);
    move.update_leds();
    tracker = new PSMoveTracker();

    posX = 0;
    posY = 0;
    posZ = 0;

    r = new short[1];
    g = new short[1];
    b = new short[1];

    moveBtn = new MoveButton();
    squareBtn = new MoveButton();
    triangleBtn = new MoveButton();
    crossBtn = new MoveButton();
    circleBtn = new MoveButton();
    startBtn = new MoveButton();
    selectBtn = new MoveButton();
    psBtn = new MoveButton();

    while (tracker.enable (move) != Status.Tracker_CALIBRATED);
  }

  void update() {
    trackingUpdate();
    buttonsUpdate();
  }

  PVector getPos() {
    PVector _pos = new PVector (posX, posY, posZ);
    return _pos;
  }

  void trackingUpdate() {

    tracker.update_image();
    isFound = tracker.update();

    tracker.get_color(move, r, g, b);
    move.set_leds(r[0], g[0], b[0]);
    move.update_leds();

    PSMoveTrackerRGBImage captureImg = tracker.get_image();
    if (pixels == null) {
      pixels = new byte[captureImg.getSize()];
    }
    captureImg.get_bytes(pixels);
    if (img == null) {
      captureWidth = captureImg.getWidth();
      captureHeight = captureImg.getHeight();
      img = createImage(captureWidth, captureHeight, RGB);
    }
    img.loadPixels();
    for (int i=0; i<img.pixels.length; i++) {
      // We need to AND the values with 0xFF to convert them to unsigned values
      img.pixels[i] = color(pixels[i*3] & 0xFF, pixels[i*3+1] & 0xFF, pixels[i*3+2] & 0xFF);
    }

    // where is the sphere?
    float x[]      = new float[1];
    float y[]      = new float[1];
    float radius[] = new float[1];
    tracker.get_position(move, x, y, radius);

    // adjust the values to fit the dimensions of the application's window
    posX = map(x[0], 0, captureWidth, 0, width);
    posY = map(y[0], 0, captureHeight, 0, height);
    posZ = radius[0]; // TODO: adjust ratio

    //println("x: "+ x[0] +" y: "+ y[0] + " r: " + radius[0]);

    img.updatePixels();

    /* rumble when the tracker looses the sphere */
    if (isFound == 0 && alertTime>0)
    {
      alert();
      alertTime--;
    } 
    else if (isFound == 1) {
      alertTime = alertCount;
      alert = false;
    } 
    else {
      alert = false;
    }
  }

  void buttonsUpdate() {
    while (move.poll () != 0) {

      triggerValue = move.get_trigger();

      int buttons = move.get_buttons();
      if ((buttons & Button.Btn_MOVE.swigValue()) != 0) {
        moveBtn.press();
      } 
      else {
        moveBtn.release();
      }

      if ((buttons & Button.Btn_SQUARE.swigValue()) != 0) {
        squareBtn.press();
      } 
      else {
        squareBtn.release();
      }

      if ((buttons & Button.Btn_TRIANGLE.swigValue()) != 0) {
        triangleBtn.press();
      } 
      else {
        triangleBtn.release();
      }

      if ((buttons & Button.Btn_CROSS.swigValue()) != 0) {
        crossBtn.press();
      } 
      else {
        crossBtn.release();
      }

      if ((buttons & Button.Btn_CIRCLE.swigValue()) != 0) {
        circleBtn.press();
      } 
      else {
        circleBtn.release();
      }

      if ((buttons & Button.Btn_SELECT.swigValue()) != 0) {
        selectBtn.press();
      } 
      else {
        selectBtn.release();
      }

      if ((buttons & Button.Btn_START.swigValue()) != 0) {
        startBtn.press();
      } 
      else {
        startBtn.release();
      }

      if ((buttons & Button.Btn_PS.swigValue()) != 0) {
        psBtn.press();
      } 
      else {
        psBtn.release();
      }
    }
  }

  void draw() {
    if (isDebug) {
      image(img, (width/2)-(captureWidth/2), (height/2)-(captureHeight/2));
    }
  }

  void switchDebug() {
    isDebug = !isDebug;
  }
  
  void alert() {
    alert = true;
    // do something...
  }
}

