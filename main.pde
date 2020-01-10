
///////////Global Scene/////////////
class scene {
  Player p;
  Platform[] pf;
  ArrayList<Collision> collision_list = new ArrayList<Collision>();;
  public scene()
  {};
}

scene s;
float t1,dt = 0;

void setup() {
  frameRate(5);
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
  
  s.p = new Player(180,height/2-30,16,30);
  
}


void draw() {
    println("----new step----");
    clear();   
    dt = 0.001*millis()-t1;
    t1 = 0.001*millis();
    if(dt>0.02)
      dt=0.02;
    //println(dt);
    s.p.physics.clear_physics(); 
    check_controller(s.p);
    s.p.grounding = false;
    
    s.p.physics.forces.add(s.p.physics.gravity());
    s.p.physics.forces.add(s.p.physics.fluid_friction());
    
    
    resolve_collisions_dynamic(s);
    
    s.p.physics.update_physics(s.p.geometry,dt);
    clear_collisions(s);
    detect_platform_collisions(s);
    resolve_collisions_static(s);
    
    
    
    
     //graphic
    draw_player(s.p);
    for(int i=0;i<s.pf.length;i++){
       draw_platform(s.pf[i]);
    }
    //display_collision_circle(s.p);
    display_stats();

}

void display_stats(){
  text("on ground : "+s.p.grounding,10,420);
  text("x ="+s.p.geometry.position.x,10,440);
  text("y ="+s.p.geometry.position.y,10,460);
  text("velocity x ="+s.p.physics.velocity.x,10,480);
  text("velocity y ="+s.p.physics.velocity.y,10,500);
}
