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
  boolean grounding = false;
  
  
  public Player(float x,float y,float w,float h){
    geometry = new Geometry(x,y,w,h);
    physics = new Physics();
  }
  
  public void crouch()
  {
    //physics.forces.add(new PVector(0,1000));
  }
  
  public void jump()
  {
    physics.forces.add(new PVector(0,-10000));
    //physics.velocity.y = 1;
  }
  
  public void walk(float dir)
  {
    physics.forces.add(new PVector(30000*dir,0));
  }
   
}


void check_controller(Player p){ 
  if(controller.up)
    p.jump();
  if(controller.down)
    p.crouch();
  if(controller.left)
    p.walk(-1);
  if(controller.right)
    p.walk(1);
}



void draw_player(Player p){
  fill(250,130,100);
  rectMode(CENTER);
  rect(p.geometry.position.x, p.geometry.position.y, p.geometry.size.x, p.geometry.size.y);
  //circle(p.geometry.position.x,p.geometry.position.y,p.geometry.size.x*2);
}
