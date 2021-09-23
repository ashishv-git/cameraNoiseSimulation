# cameraNoiseSimulation

#### About
This repository includes code for a MATLAB implementation of camera noise simulation.

The objective is to simulate the effect of three kinds of camera noise:

(1) Uncertainty associated with Poisson statistics of photons, 

(2) Read-out noise associated with electronics that reads out the pixels, and 

(3) Error introduced due to quantization of pixel values when an image is saved into some digital image format

for different number of photons.


#### Running the program:
The program may be executed by running the `CameraNoiseSimulation.m` script file with MATLAB. It does not require any input argument; it uses builtin demo `cameraman.tif` image which can be easily changed for a different input image within the code.


#### Results:
The simulation results for different number (10^4 to 10^8) of photons are in `imageResults` folder. For each choice of number of photons, there are three simulated image outputs:

(1) Poission realization

(2) Poisson realization with read noise

(3) Digital quantization of Poisson realization with read noise



