// ---------------------------------------------------------
// The application contains a model, a view, and a controller.
//
// - The model is a particle simulation that is independent of
//   graphics and user interaction. (notice that the model does 
//   not know about the view or the controller).
//
// - The view simply draws the model
//
// - The controller is the heart of this specific application.
//   It is the glue that ties the model and the view together.
// ---------------------------------------------------------
public class MyTrailApplication {
  
  // The model
  private MapModel model;
  
  // The views
  private MapView mapView;
  private Spatial3DView spatialView;
  private ElevationPathView elevationPathView;
  
  // The Controller
  private Controller controller;
  
  public MyTrailApplication() {
    println("Creating Application");
    // Create the model and set the height map we are interested in working with
    //model = new MapModel("height_map.jpg", "height_map.png");
    println("Model created");
    //model = new MapModel("minneapolis.jpg", "minneapolis.jpg");
    //model = new MapModel("umn.jpg", "umn.jpg");
    //model = new MapModel("flower.jpg", "flower.jpg");
    model = new MapModel("sunflowers.png", "sunflowers.png");
   
    // Create the views
    mapView = new MapView(model,0,0, width/2-1,(int)(0.65*height));
    spatialView = new Spatial3DView(model, width/2+1,0, width/2,(int)(0.65*height));
    elevationPathView = new ElevationPathView(model, 0,(int)(0.65*height)+2, (int)(width*1.0),(int)(0.35*height)-2);
    
    // Create the controller that updates the model and queries the views
    controller = new Controller(model, mapView, spatialView, elevationPathView);
  }
  
  // This method is part of the update loop.
  public void update(float dt) {
    controller.update(dt);
  }
  
  // This method draws the views
  public void draw() {
    background(100, 100, 100);
    ellipseMode(RADIUS);
    mapView.draw();
    spatialView.draw();
    elevationPathView.draw();
  }
  
  // Getter for the controller for handling events
  public Controller getController() {
    return controller;
  }  
};
