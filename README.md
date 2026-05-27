# Trail Mapper - Interactive Terrain & Path Visualization
An interactive geospatial visualization system built in Java (Processing) using MVC architecture that enables users to draw and analyze custom paths on a topographic map with real-time elevation graphs and dynamic waypoint tracking.

## Features
- Draw and edit custom paths on real topographic maps
- Real time elevation graphs that updates as you move along a path
- Add and draw waypoints that dynamically update linked 2D views
- MVC architecture separating data, logic and display layers

## Tech Stack
- Java (Processing)
- MVC Architecture
- 2D Graphics Rendering

## How to Run
1. Download and install [Processing](https://processing.org/download)

## Project Structure
- 'MapModel.pde' - data layer managing path and waypoint state
- 'Controller.pde' - handles user input and updates the model
- 'MapView.pde' / 'ElevationPathView.pde' - rendering and display logic
- 'data/' - topographic map and elevation data