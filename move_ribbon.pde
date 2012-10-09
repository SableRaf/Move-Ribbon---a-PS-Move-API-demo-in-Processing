 /**
 * Move Ribbons Demo by Raphaël de Courville
 *
 * This sketch demonstrates how to implement tracking with the PS Move API in Processing
 *
 * Ribbon code by James Alliban (http://jamesalliban.wordpress.com/2008/12/04/2d-ribbons/)
 * Original Ribbon code by Eric Natzke (http://jot.eriknatzke.com/)
 *
 * PS Move API  by Thomas Perl <m@thp.io> and Benjamin Venditti <benjamin.venditti@gmail.com>
 * Sources available: https://github.com/thp/psmoveapi
 *
 * For download, build, install, and pairing instructions on Mac OS X, read "Get started with the PS Move API on Mac OS X" tutorial: http://goo.gl/B6FaL
 *
 **/

/*-------- INSTRUCTIONS --------- */

/*
Press D to show/hide tracking debug.

Calibration on Mac OS X with iSight/Facetime camera:
- Before you run the sketch, put the controller in front of the camera so that the sphere touches it
- As the sketch starts, the sphere lights up in white (it forces Auto-Exposure to accomodate so we can lock it at the right settings)
- The sphere starts blinking in its tracking color: move the controller further from the camera and keep it still
- The sketch should start after a few seconds. If the sphere keeps blinking for more than 15 seconds, stop the sketch and try again. Rebooting can help too.

*/  

boolean TESTING = false;
int ribbonAmount = 5;
int ribbonParticleAmount = 20;
float randomness = .2;
RibbonManager ribbonManager;

MoveManager moveManager; // 1) declare a move object

void setup()
{
  size(640, 480);
  //size(screenWidth, screenHeight);
  //size(displayWidth, displayHeight); // Processing 2.0 and up
  //noCursor();
  frameRate(30);
  background(0);
  
  // Ribbon stuff
  ribbonManager = new RibbonManager(ribbonAmount, ribbonParticleAmount, randomness, "colorPalette.jpg"); 
  ribbonManager.setRadiusMax(12);                 // default = 8
  ribbonManager.setRadiusDivide(10);              // default = 10
  ribbonManager.setGravity(.07);                   // default = .03
  ribbonManager.setFriction(1.1);                  // default = 1.1
  ribbonManager.setMaxDistance(40);               // default = 40
  ribbonManager.setDrag(2.5);                      // default = 2
  ribbonManager.setDragFlare(.015);                 // default = .008
  
  moveManager = new MoveManager(); // 2) create the move object
}                    
void draw()
{
  background(5,1,10);
  
  moveManager.update(); // 3) Action
  moveManager.draw(); // 4) Show results (right now, only used for debug)
  
  //ribbonManager.update(mouseX, mouseY);
  
  // 5) get x and y positions of the move. Note: "(int)moveManager.getPos().z" returns the radius
  int _x = (int)moveManager.getPos().x; // for mirror: width-(int)moveManager.getPos().x;
  int _y = (int)moveManager.getPos().y;
  ribbonManager.update(_x, _y); 
}

void keyPressed() {
 if(key == 'd' || key == 'D')
    moveManager.switchDebug(); // Show/hide debug
}
