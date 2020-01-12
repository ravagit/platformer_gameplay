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
