class Ladder
{
  PVector position;
  PVector size;
  
  public Ladder(int x, int y, int h)
  {
    position = new PVector(x,y);
    size = new PVector(10,h);
  }
}

class Ladder_Collision extends Collision
{
  float distance, x, y;
  Ladder lad;
  Player player;
  public Ladder_Collision(Player p, Ladder lad)
  {
    this.player = p;
    this.lad = lad;
    
  } 
  
  public void resolve_dynamic()
  {
     PVector grav = player.physics.gravity();
     player.physics.forces.add(grav.mult(-1));
  }
  public void resolve_static()
  {
     println("resolving static ladder collision");
     player.geometry.position.x = lad.position.x;
     player.physics = new Physics();
     player.climbing = true;
     player.on_ground = false;
  } 
}


void draw_ladder(Ladder lad)
{
  stroke(90,190,50);
  line(lad.position.x-lad.size.x/2, 
       lad.position.y,
       lad.position.x-lad.size.x/2,
       lad.position.y-lad.size.y
       );
  line(lad.position.x+lad.size.x/2, 
       lad.position.y,
       lad.position.x+lad.size.x/2,
       lad.position.y-lad.size.y
       );
       
   for(int i=0;i< lad.size.y/10;i++)
     line(lad.position.x-lad.size.x/2, 
       lad.position.y-10*i,
       lad.position.x+lad.size.x/2,
       lad.position.y-10*i
       );
   
   noStroke();    
}
