
///////////Global Scene/////////////
class scene {
  Player p;
  Platform[] pf;
  Ladder lad;
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

  s.pf = new Platform[3];
  s.pf[0] = new Platform(390,300,600,100);
  s.pf[1] = new Platform(200,300,355,300);
  s.pf[2] = new Platform(10,70,205,300);
  
  s.p = new Player(300,height/2-30,10,20);
  s.lad = new Ladder(250,300,200);
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
    display_stats();
    respawn(s.p);
    s.p.on_ground = false;
    
    physics_process(s.p.physics,s.p.geometry,dt, s.collision_list);
    //log_bilan_force();
    
    move_platform(s.pf[0]);
    clear_collisions(s);
    detect_platform_collisions(s);
    for (Collision collision : s.collision_list)
      collision_effect_static(collision);
    
     //graphic
    
    draw_ladder(s.lad);
    for(int i=0;i<s.pf.length;i++){
       draw_platform(s.pf[i]);
    }
    draw_player(s.p);
    //display_collision_circle(s.p);
    

}
