
 Move Ribbons Demo by Raphaël de Courville

 This sketch demonstrates how to implement tracking with the PS Move API in Processing
 See video demonstration: https://vimeo.com/51133900

 Ribbon code by James Alliban (http://jamesalliban.wordpress.com/2008/12/04/2d-ribbons/)
 Original Ribbon code by Eric Natzke (http://jot.eriknatzke.com/)

 PS Move API  by Thomas Perl <m@thp.io> and Benjamin Venditti <benjamin.venditti@gmail.com>
 Sources available: https://github.com/thp/psmoveapi

 For download, build, install, and pairing instructions on Mac OS X, read "Get started with the PS Move API on Mac OS X" tutorial: http://goo.gl/B6FaL



/*-------- INSTRUCTIONS --------- */

Press D to show/hide tracking debug.

Calibration on Mac OS X with iSight/Facetime camera:
- Before you run the sketch, put the controller in front of the camera so that the sphere touches it
- As the sketch starts, the sphere lights up in white (it forces Auto-Exposure to accomodate so we can lock it at the right settings)
- The sphere starts blinking in its tracking color: move the controller further from the camera and keep it still
- The sketch should start after a few seconds. If the sphere keeps blinking for more than 15 seconds, stop the sketch and try again. Rebooting can help too.

