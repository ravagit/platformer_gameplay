class Geometry 
{
  PVector size;
  PVector position;
  
  public Geometry(float x, float y, float w, float h){
    this.position = new PVector(x,y);
    this.size = new PVector(w,h);
  };
}

//////////////////////player//////////////////////////
class Player 
{
  Geometry geometry;
  Physics physics;
  //state
  String state;
  boolean on_ground = false;
  PVector spawn_point;
  
  
  public Player(float x,float y,float w,float h){
    spawn_point = new PVector(x,y);
    geometry = new Geometry(x,y,w,h);
    physics = new Physics();
  }
  
  public void crouch()
  {
    //physics.forces.add(new PVector(0,1000));
  }
  
  public void jump()
  {
    if(on_ground)
    {
      physics.forces.add(new PVector(0,-100000));
      //physics.velocity.y = 0;
      on_ground = false;
    }
      
    //physics.velocity.y = 1;
  }
  
  public void walk(float dir)
  {
    physics.forces.add(new PVector(30000*dir,0));
  }
  
  public void action()
  {
    
  }
   
}


void check_controller(Player p){ 
  if(controller.up)
    {
    p.jump();
    controller.up = false;
    }
  if(controller.down)
    p.crouch();
  if(controller.left)
    p.walk(-1);
  if(controller.right)
    p.walk(1);
  if(controller.a)
    p.action();
}

void respawn(Player p)
{
  if(p.geometry.position.x <0 
  || p.geometry.position.x >width 
  || p.geometry.position.y >height
  )
  {
    p.geometry.position = p.spawn_point;
    p.physics = new Physics();
  }
}

void draw_player(Player p){
  fill(250,130,100);
  rectMode(CENTER);
  rect(p.geometry.position.x, p.geometry.position.y, p.geometry.size.x, p.geometry.size.y);
}

void display_stats(){
 
  text("on ground : "+s.p.on_ground,10,420);
  text("a x ="+s.p.physics.acceleration.x,10,440);
  text("a y ="+s.p.physics.acceleration.y,10,460);
  text("velocity x ="+s.p.physics.velocity.x,10,480);
  text("velocity y ="+s.p.physics.velocity.y,10,500);
}
