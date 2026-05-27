// ---------------------------------------------------------
// Draws the elevation path
// ---------------------------------------------------------

public class ElevationPathView extends View {
  private MapModel model;
  
  public ElevationPathView(MapModel model, int x, int y, int w, int h) {
    super(x, y, w, h);
    this.model = model;
  }
  
  public void drawView() {
    fill(255);
    text("Elevation Path View", x + 50, y + 50);
    
    if (this.isInside(mouseX, mouseY)) {
      stroke(255, 255, 0);
      line(mouseX, y, mouseX, y+h);
    }
    
    stroke(255, 0 ,0);
    
    // -----------------------------
    // Part 2: Draw elevation path
    // -----------------------------
    ArrayList<PVector> pts = model.getPath().getPoints();

    if (pts.size() < 2) {
        return;
    }
    ArrayList<Float> dist = new ArrayList<Float>();
    float totalDist = 0;
    dist.add(0.0);

    for (int i = 1; i < pts.size(); i++) {
        PVector a = pts.get(i-1);
        PVector b = pts.get(i);

        float d = dist(a.x, a.y, b.x, b.y);
        totalDist += d;

        dist.add(totalDist);
    }
    for (int i = 0; i < pts.size() - 1; i++) {
        PVector p1 = pts.get(i);
        PVector p2 = pts.get(i+1);

        float elev1 = model.getMap().getNormElevation(p1.x, p1.y);
        float elev2 = model.getMap().getNormElevation(p2.x, p2.y);

        float x1 = map(dist.get(i), 0, totalDist, this.x, this.x + this.w);
        float x2 = map(dist.get(i+1), 0, totalDist, this.x, this.x + this.w);

        float y1 = map(elev1, 0, 1, this.y + this.h, this.y);
        float y2 = map(elev2, 0, 1, this.y + this.h, this.y);

        line(x1,y1,x2,y2);
    }
    stroke(255,255,255);
    fill(0,0,255);
    
    // -----------------------------
    // Part 3: Save / Draw way points
    // -----------------------------
    ArrayList<PVector> wps = model.getPath().getWaypoints();
    ArrayList<PVector> pts2 = model.getPath().getPoints();

    if (pts2.size() > 1) {
    ArrayList<Float> dist2 = new ArrayList<Float>();
    float totalDist2 = 0;
    dist2.add(0.0);

    for (int i = 1; i < pts2.size(); i++) {
    totalDist2 += dist(pts2.get(i-1).x, pts2.get(i-1).y, pts2.get(i).x, pts2.get(i).y);
    dist2.add(totalDist2);
    }
    for (PVector wp : wps) {
        int index = pts2.indexOf(wp);
        float dx = dist2.get(index);
        float elev = model.getMap().getNormElevation(wp.x, wp.y);

        float sx = map(dx, 0, totalDist2, this.x, this.x + this.w);
        float sy = map(elev, 0, 1, this.y +this.h, this.y);

        ellipse(sx, sy, 10, 10);
    }
    }
  }

  
};
