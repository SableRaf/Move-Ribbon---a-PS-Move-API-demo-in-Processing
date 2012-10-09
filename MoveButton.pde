class MoveButton {
  int value;
  
  boolean isPressed;
  boolean isReleased;
  int active;
  int previouslyActive;
  
  MoveButton() {
    active = 0;
    previouslyActive = 0;
    isPressed = false;
    isReleased = false;
    value = 0;
  }

  /*---- Trying to detect press and release events... it's not very effective */
  
  void press() {
    previouslyActive = active;
    active = 1;
    if(active == 1 && previouslyActive == 0) {
      isPressed = true;
    } else {
      isPressed = false;
    }
  }

  void release() { 
    previouslyActive = active;
    active = 0;
    if(active == 1 && previouslyActive == 0) {
      isReleased = true;
    } else {
      isReleased = false;
    }
  }
  
  boolean isPressed() {
    return isPressed;
  }
  
  boolean isReleased() {
    return isReleased;
  }

  /*--------------------------------------------------------------------------- */

  void setValue(int _val) {   
    value = _val;
  }

  int getValue() {    
    return value;
  }
}

