class Collision 
{
  Player player;
  public Collision()
  {
  }  
  public void resolve_dynamic()
  {
  }
  public void resolve_static()
  {
  } 
}


float collision_distance(Player p, Platform pf)
{
  float x0 = p.geometry.position.x;
  float y0 = p.geometry.position.y;
  float x1 =  pf.point1.x;
  float y1 =  pf.point1.y;
  float x2 =  pf.point2.x;
  float y2 =  pf.point2.y;
  
  float radius = p.geometry.size.x;//radius of circle 
  //(x0,y0) circle center, (x1,y1) (x2,y2) define the line direction
  float dy = y2-y1;
  float dx = x2-x1;
  return (dy*x0 - dx*y0 + x2*y1 - x1*y2)/mag(dy,dx) - radius;
}

boolean check_line_collision(Player p, Platform pf)
{
  float radius = p.geometry.size.x;//radius of circle
  float distance = collision_distance(p, pf) + radius;
  boolean xbounds = (p.geometry.position.x>pf.point1.x && 
                     p.geometry.position.x<pf.point2.x);
  return abs(distance)<radius && xbounds;
}

boolean check_point_collision(PVector p1, PVector p2, float radius1, float radius2)
{
  //display_collision_circle(p2,radius2);
  float distance = p1.dist(p2);
  return distance<(radius1+radius2);
}


boolean check_box_collision(Player p, Ladder l)
{
    float x1 = p.geometry.position.x-p.geometry.size.x/2;
    float y1 = p.geometry.position.y-p.geometry.size.y/2;
    float x2 = p.geometry.position.x+p.geometry.size.x/2;
    float y2 = p.geometry.position.y+p.geometry.size.y/2;
    //display_collision_box(new PVector(x1,y1), new PVector(x2,y2));
    
    float x3 = l.position.x-l.size.x/2;
    float y3 = l.position.y-l.size.y;
    float x4 = l.position.x+l.size.x/2;
    float y4 = l.position.y;
    //display_collision_box(new PVector(x3,y3), new PVector(x4,y4));
    
    boolean interx = x3<x2 && x1<x4;
    boolean intery = y3<y2 && y1<y4;
  
    return interx && intery;
}


void detect_platform_collisions(scene s)
{
  
  for(int i=0;i<s.pf.length;i++)
  {
    if(check_line_collision(s.p, s.pf[i])){
      s.collision_list.add(new Platform_Collision(
                                         s.p,
                                         s.pf[i],
                                         s.p.geometry.position.x,
                                         s.p.geometry.position.y,
                                         -collision_distance(s.p,s.pf[i])
                                         )
                           );
           //println("++collision detected++");
    }
  }
 
}

void clear_collisions(scene s)
{
   while(s.collision_list.size()>0)
      s.collision_list.remove(0);
}

void display_collision_box(PVector corner1,PVector corner2){
  stroke(255,255,255);
  noFill();
  rectMode(CORNERS);
  rect(corner1.x,corner1.y,corner2.x,corner2.y);
  point(corner1.x,corner1.y);
  point(corner2.x,corner2.y);
  noStroke();
  
}

void display_collision_circle(PVector center,float radius){
  stroke(255,255,255);
  noFill();
  circle(center.x,center.y,radius*2);
  noStroke();
}
