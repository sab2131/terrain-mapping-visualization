// ---------------------------------------------------------
// Draws the Map for height image.
// ---------------------------------------------------------

public class MapView extends View {
  private MapModel model;
  private float zoom = 1.0;
  public float translateX = 0.0;
  public float translateY = 0.0;
  private PanZoomPage panZoomPage;
  PImage img;
  float imgScale;
  float aspect;
  
  public MapView(MapModel model, int x, int y, int w, int h) {
    super(x, y, w, h);
    this.model = model;
    if (model != null && model.getMap() != null) {
      img = model.getMap().getColorImage();
    } else {
      img = createImage(100,100, RGB);
    }
  
    panZoomPage = new PanZoomPage(x, y, w, h);
    panZoomPage.fitPageOnScreen();
    
    if (img.width > img.height) {
      imgScale = 1.0/img.width;
    } else {
      imgScale = 1.0/img.height;
    }
  }
  
  public void drawView() {
    // Center the map
    float imageX = panZoomPage.pageXtoScreenX(0.5);
    float imageY = panZoomPage.pageYtoScreenY(0.5);
    
    // Draw the map using the panZoomPage
    pushMatrix();
    translate(imageX, imageY);
    scale(1.0*panZoomPage.pageLengthToScreenLength(1.0)*imgScale);
    translate(-img.width/2,-img.height/2);
    image(img, 0, 0);
    popMatrix();
    
    // Show the cross hairs for querying the image
    if (this.isInside(mouseX, mouseY)) {
      stroke(200,0,0);
      line(mouseX,y, mouseX,y+h);
      line(x,mouseY, w+x,mouseY);
      fill(255,255,255);
      textSize(20);
      int imgX = screenXtoImageX(mouseX);
      int imgY = screenYtoImageY(mouseY);
      if (imgX >= 0 && imgX < img.width && imgY >= 0 && imgY < img.height) {
        text("" + imgX + ", " + imgY , mouseX+50, mouseY+50);
      }
    }
    
    strokeWeight(2);
    stroke(255,0,0);
    
    // -----------------------------
    // Part 1: Save / Draw Path
    // -----------------------------
    ArrayList<PVector> pts = model.getPath().getPoints();
    for (int i = 0; i < pts.size() - 1; i++) {
        PVector p1 = pts.get(i);
        PVector p2 = pts.get(i+1);

        float x1 = posXtoScreenX(p1.x);
        float y1 = posYtoScreenY(p1.y);
        float x2 = posXtoScreenX(p2.x);
        float y2 = posYtoScreenY(p2.y);

        line(x1, y1, x2, y2);
    }

      
    stroke(0,0,0);
    fill(255,255,0);
      
    // -----------------------------
    // Part 4: Save / Draw hover point
    // -----------------------------
    PVector hover = model.getPath().getHoverPoint();
    if (hover != null) {
        float sx = posXtoScreenX(hover.x);
        float sy = posYtoScreenY(hover.y);
        ellipse(sx, sy, 12, 12);
    }
    
    stroke(255,255,255);
    fill(0,0,255);
    
    // -----------------------------
    // Part 3: Save / Draw way points
    // -----------------------------
    ArrayList<PVector> wps = model.getPath().getWaypoints();
    for (PVector wp : wps) {
        float sx = posXtoScreenX(wp.x);
        float sy = posYtoScreenY(wp.y);
        ellipse(sx, sy, 10, 10);
    }
      
    strokeWeight(1);
    fill(0,0,0);
    stroke(0,0,0);
    
  }

  // Use the screen position to get the x value of the image
  public int screenXtoImageX(int screenX) {
    float x = panZoomPage.screenXtoPageX(screenX);
    return (int)((x-0.5 + img.width*imgScale/2)*img.width/(img.width*imgScale));
  }
  
  // Use the screen position to get the y value of the image
  public int screenYtoImageY(int screenY) {
    float y = panZoomPage.screenYtoPageY(screenY);
    return (int)((y-0.5 + img.height*imgScale/2)*img.height/(img.height*imgScale));
  }
  
  // Use the screen position to get the x value of the map position
  public float screenXtoPosX(int screenX) {
    float x = 1.0*screenXtoImageX(screenX);
    return x/img.width;
  }
  
  // Use the screen position to get the y value of the map position
  public float screenYtoPosY(int screenY) {
    float y = 1.0*screenYtoImageY(screenY);
    return y/img.height;
  }
  
  // Get the screen x position from the map x position
  public float posXtoScreenX(float posX) {
    return panZoomPage.pageXtoScreenX(posX*img.width*imgScale - img.width*imgScale/2.0 + 0.5);
  }
  
  // Get the screen y position from the map y position
  public float posYtoScreenY(float posY) {
    return panZoomPage.pageYtoScreenY(posY*img.height*imgScale - img.height*imgScale/2.0 + 0.5);
  }
}
