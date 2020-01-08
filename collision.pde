class collision 
{
  float distance,playerx,playery;
  Platform platform;
  public collision(Platform pf, float x, float y)
  {
    this.platform = pf;
    this.playerx = x;
    this.playery = y;
  } 
}

boolean check_line_collision(player p, Platform pf)
{
  float x0 = p.geometry.position.x;
  float y0 = p.geometry.position.y;
  float x1 =  pf.point1.x;
  float y1 =  pf.point1.y;
  float x2 =  pf.point2.x;
  float y2 =  pf.point2.y;
  
  float radius = p.geometry.size.x;//radius of circle 
  //display_collision_circle(p.geometry.position,radius);
  //(x0,y0) circle center, (x1,y1) (x2,y2) define the line direction
  float dy = y2-y1;
  float dx = x2-x1;
  float distance = (dy*x0 - dx*y0 + x2*y1 - x1*y2)/mag(dy,dx);
  return abs(distance)<radius && (x0>x1 && x0<x2);
}

void detect_platform_collisions(scene s)
{
  
  for(int i=0;i<s.pf.length;i++)
  {
    if(check_line_collision(s.p,s.pf[i]))
      s.collision_list.add(new collision(s.pf[i],s.p.geometry.position.x,s.p.geometry.position.y));
  }
 
}

void resolve_collisions(scene s)
{
  
  //println("collision size :"+s.collision_list.size());
  collision tmp;
  while(s.collision_list.size()>0)
  {
    tmp = s.collision_list.get(0);
    s.collision_list.remove(0);
    
    boolean from_up,from_down = false;
    from_up = tmp.playery > tmp.platform.get_y(tmp.playerx);
    from_down = !from_up;
    text("colliding",10,400);

    stand_on_platform(s.p.geometry, s.p.physics,tmp.platform);
    
  }
}


void display_collision_box(PVector corner1,PVector corner2){
  stroke(0,255,0);
  noFill();
  rectMode(CORNERS);
  rect(corner1.x,corner1.y,corner2.x,corner2.y);
  point(corner1.x,corner1.y);
  point(corner2.x,corner2.y);
  noStroke();
  
}

void display_collision_circle(PVector center, float radius){
  stroke(0,255,0);
  noFill();
  circle(center.x,center.y,radius*2);
  noStroke();
}
