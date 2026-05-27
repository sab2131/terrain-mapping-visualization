import java.util.ArrayList;
// ---------------------------------------------------------
// In this application, the controller can update the model,
// query the view, and modify view display parameters
// ---------------------------------------------------------

public class Controller {
  // The model and view references
  private MapModel model;
  private MapView mapView;
  private Spatial3DView spatialView;
  private View elevationPathView;
  
  // Pass in the model and view for use
  Controller(MapModel model, MapView mapView, Spatial3DView spatialView, ElevationPathView elevationPathView) {
    this.model = model;
    this.mapView = mapView;
    this.spatialView = spatialView;
    this.elevationPathView = elevationPathView;
  }
  
  // Controls the update loop of the simulation
  public void update(float dt) {
    if (spatialView != null) {
      spatialView.setRotation(frameCount/1000.0);
    }
  }
  
  public void mousePressed() {
    if (mapView.isInside(mouseX, mouseY) && (mouseButton == CENTER || mouseButton == RIGHT)) {
      mapView.panZoomPage.mousePressed();
    }
    
    // -----------------------------
    // Part 1: Save / Draw Path
    // -----------------------------
     if (mouseButton == LEFT && mapView.isInside(mouseX, mouseY)){
        model.getPath().clearPoints();
     }
    // -----------------------------
    // Part 3: Save / Draw way points
    // -----------------------------
    if (mouseButton == LEFT && elevationPathView.isInside(mouseX, mouseY)) {
        ArrayList<PVector> pts = model.getPath().getPoints();
        if (pts.size() == 0 ) return;

        ArrayList<Float> dist = new ArrayList<Float>();
        float totalDist = 0;
        dist.add(0.0);
        for (int i = 1; i< pts.size(); i++) {
            totalDist += dist(pts.get(i-1).x, pts.get(i-1).y, pts.get(i).x, pts.get(i).y);
            dist.add(totalDist);
        }
        float mouseDist = map(mouseX, elevationPathView.x, elevationPathView.x + elevationPathView.w, 0, totalDist);

        int idx = 0;
        for (int i = 1; i < dist.size(); i++) {
        if (mouseDist <= dist.get(i)) {
        idx = i;
        break;
            }
        }

       PVector p = pts.get(idx);
       model.getPath().addWaypoint(p.x, p.y);
  }
  }
  public void mouseReleased() {
  }
  
  public void mouseDragged() {   
    if (mapView.isInside(mouseX, mouseY) && (mouseButton == CENTER || mouseButton == RIGHT)) {
      mapView.panZoomPage.mouseDragged();
    }
    
    // -----------------------------
    // Part 1: Save / Draw Path
    // -----------------------------
    if (mouseButton == LEFT && mapView.isInside(mouseX, mouseY) ) {
        float posX = mapView.screenXtoPosX(mouseX);
        float posY = mapView.screenYtoPosY(mouseY);
        model.getPath().addPoint(posX, posY);
    }
    // You should use mapView.screenXtoPosX(mouseX) and mapViewscreenYtoPosY(mouseY) to get the point on the map.
  }
  
  public void mouseMoved() {
    if (mapView.isInside(mouseX, mouseY)) {
      cursor(CROSS);
    }
    else {
      cursor(ARROW);
    }
    
    // -----------------------------
    // Part 4: Save / Draw hover point
    // -----------------------------
    if (elevationPathView.isInside(mouseX, mouseY)) {
        ArrayList<PVector> pts = model.getPath().getPoints();
        if (pts.size() == 0) return;

        ArrayList<Float> dist = new ArrayList<Float>();
        float totalDist = 0;
        dist.add(0.0);

        for (int i =1; i< pts.size(); i++) {
        totalDist+= dist(pts.get(i-1).x, pts.get(i-1).y, pts.get(i).x, pts.get(i).y);
        dist.add(totalDist);
        }
        float mouseDist = map(mouseX, elevationPathView.x, elevationPathView.x + elevationPathView.w, 0, totalDist);

        int idx = 0;
        for (int i = 1; i < dist.size(); i++) {
            if (mouseDist <= dist.get(i)) {
                idx = i;
                break;
            }
        }
       PVector p = pts.get(idx);
       model.getPath().setHoverPoint(p.x, p.y);
    }

  }
  
  public void mouseWheel(MouseEvent event) {
    if (mapView.isInside(mouseX, mouseY)) {
      mapView.panZoomPage.mouseWheel(event);
    }
    
    if (spatialView.isInside(mouseX, mouseY)) {
      spatialView.setZoom(spatialView.getZoom() + event.getCount()*0.1);
    }
  }
}
