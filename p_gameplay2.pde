
///////////Global Scene/////////////
class scene {
  player p;
  Platform[] pf;
  ArrayList<collision> collision_list = new ArrayList<collision>();;
  public scene()
  {};
}

scene s;
int t1,dt = 0;

void setup() {
  frameRate = 30;
  size(700, 500);
  background(0);
  noStroke();  
  noSmooth();
  PFont georgia;
  georgia = createFont("Georgia",12);
  textFont(georgia);
  rectMode(CENTER);
  
  s = new scene();

  s.pf = new Platform[3];
  s.pf[0] = new Platform(350,300,600,100);
  s.pf[1] = new Platform(200,300,355,300);
  s.pf[2] = new Platform(10,70,205,300);
  
  s.p = new player(230,height/4,16,20);
  
}


void draw() {
    dt = millis()-t1;
    t1 = millis();
    //println(dt);
  
  
    check_controller(s.p);
  
    apply_gravity(s.p.physics);
    apply_friction(s.p.physics); 
    
    
    
    detect_platform_collisions(s);
    resolve_collisions(s);
    
    resolve_forces(s.p.physics, 12);
    update_position(s.p.geometry,s.p.physics, 12);
   
    
     //graphic
    clear();
   
    draw_player(s.p);
    for(int i=0;i<s.pf.length;i++){
       draw_platform(s.pf[i]);
    }
     display_stats();
   
}

void display_stats(){
  text("velocity x ="+s.p.physics.velocity.x,10,480);
  text("velocity y ="+s.p.physics.velocity.y,10,500);
}
