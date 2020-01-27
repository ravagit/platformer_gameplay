
///////////Global Scene/////////////
class scene {
  Player p;
  Platform[] pf;
  Ladder lad;
  Bar bar;
  ArrayList<Collision> collision_list = new ArrayList<Collision>();;
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

  s.pf = new Platform[4];
  s.pf[0] = new Platform(400,300,600,100);
  s.pf[1] = new Platform(100,300,255,300);
  s.pf[2] = new Platform(10,140,105,300);
  s.pf[3] = new Platform(100,115,305,115);
  
  s.p = new Player(150,height/2-30,10,20);
  s.lad = new Ladder(150,300,200);
  s.bar = new Bar(300,115,150,0);
}


void draw() {
    println("----new step----");
    clear();   
    dt = 0.001*millis()-t1;
    t1 = 0.001*millis();
    if(dt>0.02)
      dt=0.02;
   
    
     //----------STATIC PHASE---------------//
    
    respawn(s.p);
    s.p.on_ground = false;
   
   
    s.p.geometry.position.x += s.p.physics.velocity.x*dt
                              +0.5*s.p.physics.acceleration.x*dt*dt;
    s.p.geometry.position.y += s.p.physics.velocity.y*dt
                              +0.5*s.p.physics.acceleration.y*dt*dt;   
     
    move_platform(s.pf[0]);
    move_bar(s.bar);
    
    clear_collisions(s);
    detect_platform_collisions(s);
    check_controller_static(s.p);
    for (Collision collision : s.collision_list)
      collision.resolve_static();
    
    s.p.physics.apply_inertia();
    s.p.physics.velocity.x += s.p.physics.acceleration.x*dt;
    s.p.physics.velocity.y += s.p.physics.acceleration.y*dt;
    
    
    
    //----------DYNAMIC PHASE---------------//
    check_controller_dynamic(s.p);
    s.p.physics.forces.add(s.p.physics.gravity());
    s.p.physics.forces.add(s.p.physics.fluid_friction());
    
     for (Collision collision : s.collision_list){
       collision.resolve_dynamic();
    }
    
    s.p.physics.acceleration = s.p.physics.sumF();
    s.p.physics.clear_forces(); 
    
    s.p.physics.acceleration.x *= 1/s.p.physics.mass.x;
    s.p.physics.acceleration.y *= 1/s.p.physics.mass.y;
    
    //---------DRAW PHASE---------//
    draw_ladder(s.lad);
    draw_bar(s.bar);
    for(int i=0;i<s.pf.length;i++){
       draw_platform(s.pf[i]);
    }
    draw_player(s.p);
    display_stats();
    //display_collision_circle(s.p);

    

    
    

}
