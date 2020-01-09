
///////////Global Scene/////////////
class scene {
  Player p;
  Platform[] pf;
  ArrayList<collision> collision_list = new ArrayList<collision>();;
  public scene()
  {};
}

scene s;
float t1,dt = 0;

void setup() {
  frameRate(30);
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
  
  s.p = new Player(230,height/2,16,20);
  
}


void draw() {
    clear();
    
     
     
    dt = 0.001*millis()-t1;
    t1 = 0.001*millis();
    if(dt>0.02)
      dt=0.02;
    //println(dt);
  
  
    
    check_controller(s.p);
  
    println("----new step----");
    s.p.physics.forces.add(s.p.physics.gravity());
    s.p.physics.forces.add(s.p.physics.fluid_friction());
    
    detect_platform_collisions(s);
    resolve_collisions(s);
    
    s.p.physics.update_physics(s.p.geometry,dt);
    s.p.physics.clear_physics();
    
     //graphic
    draw_player(s.p);
    for(int i=0;i<s.pf.length;i++){
       draw_platform(s.pf[i]);
    }
     display_stats();
   
   
   
}

void display_stats(){
  text("x ="+s.p.geometry.position.x,10,440);
  text("y ="+s.p.geometry.position.y,10,460);
  text("velocity x ="+s.p.physics.velocity.x,10,480);
  text("velocity y ="+s.p.physics.velocity.y,10,500);
}
