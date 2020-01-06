static class controller {
  static boolean up = false;
  static boolean down = false;
  static boolean left = false;
  static boolean right = false;
  static boolean a = false;
  static boolean b = false;
  static boolean l = false;
  static boolean r = false;
  
  static void modify(boolean v, int k, int kCode){
    if(k==CODED){
      switch(kCode){
        case UP : controller.up = v;
        break;
        case DOWN : controller.down = v;
        break;
        case LEFT : controller.left = v;
        break;
        case RIGHT : controller.right = v;
        break;
      }
    }
    else {
      switch(k){
        case 'a' : controller.a = v;
        break;
        case 'b' : controller.b = v;
        break;
        case 'l' : controller.l = v;
        break;
        case 'r' : controller.r = v;
        break;
      }
    }
  }
}

void keyPressed(){
  controller.modify(true,key,keyCode);

}

void keyReleased(){
  controller.modify(false,key,keyCode);
}
