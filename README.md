# traffic_lights
Simulate Traffic Lights at intersection

## Approach

### Important

1. Only one light can be switched on at same time for a single traffic light.
1. Make sure red light is switched on at another direction before switch to green light at this direction.


### Step One: Define Models

1. `ColorLight` model which stores color information and on/off state of the light.
1. `TrafficLight` model keeps reference to 3 `ColorLight` with `red`, `yellow` and `green`. This model is responsible for switch on/off lights in correct order. `TrafficLight` can be switched on/off, when it's on, it should start with green light. When it reaches red light, it should notify it's observer, so observer will know it's safe to switch other `TrafficLight` to green.
1. `Intersection` model keeps two `TrafficLight` objects for different direction. It's main goal is to coordinate two `TrafficLight` to switch on the correct light.
1. Make sure all model passes tests.

### Step Two: Make UI Components

1. `LightView` binds a `ColorLight` object, it use it's color to draw the light and listen to the state change of the light in order to update itself.
1. `TrafficLightsView` grounps three `LightView` and binds to `TrafficLight` object. 
1. Make sure all views passes tests.

### Step Three: Connect everything

1. Layout components on Storyboard
1. Connect UI with models in ViewController


### Have Fun!
