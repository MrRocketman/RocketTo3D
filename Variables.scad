/* These are the instructions for getting your RockSim NOSE CONE data into this scad file
 * 1. Open your RockSim model.
 * 2. Select the Nose Cone and select Edit
 * 3. Set the noseConeLength and the noseConeWidth variables below according to the values in RockSim
 * 4. Set the noseConeShoulderLength and the noseConeShoulderWidth variables below according to the values in RockSim by going to the "shoulder" tab in RockSim 
 * 5. Select "Export Template" and save it as an svg file to somewhere you can find it.
 * 6. Download an install the "Inkscape to OpenSCAD Converter here -> http://www.thingiverse.com/thing:25036 according to the instructions on the page if you haven't done so already
 * 7. Open the exported svg in Inkscape
 * 8. Chose File->Document Properties-> Then change both sets of units to mm
 * 9. Chose Path->Object To Path after selecting the nose cone
 * 10. Click the "Edit Paths By Nodes" button on the left toolbar
 * 11. Select the center line and hit delete on your keyboard
 * 12. Select the far right line (The bottom of the shoulder) And hit the "Insert new node button"
 * 13. Drag select all of the ponts on the bottom half of the nose cone except for the tip of the nose cone and the new node on the bottom of the shoulder. Delete these nodes.
 * 14. "Shift" select the nodes on the tip of the nose cone and the midpoint of the bottom of the shoulder
 * 15. Click the "Delete segment between nodes" button
 * 16. Click the "Join selected nodes with new segment" button to add back a straight segment
 * 17. Click the "Select and tranform objects" button on the left toolbar (The Mouse Icon)
 * 18. Click on the nose cone and set the x,y coordinates on the top toolbar to 0,0
 * 19. Save the svg
 * 20. Select Extensions->Generate From Path->Paths To OpenSCAD
 * 21. Set the ouput file path to a place you can find it
 * 22. Leave the other two parameters alone and click "apply"
 * 23. Open the newly exported scad file and find "polygon" call. There should only be one polygon call. If there are more than one, OpenSCAD will not work. So make sure there's only 1! Copy the polygon's data (read: NOT the linear_extrude!) and paste it over the noseConePoints data below (In Variables.scad)
 * 24. Uncomment the test in NoseCone.scad to make sure everything worked. If it worked, now is the time to laugh maniacally!
 */

/* These are the instructions for getting your RockSim FIN data into this scad file
 * 1. Open your RockSim model.
 * 2. Select the Fin Set and select Edit
 * 3. Select "Export Template" and save it as an svg file to somewhere you can find it.
 * 4. Download an install the "Inkscape to OpenSCAD Converter here -> http://www.thingiverse.com/thing:25036 according to the instructions on the page if you haven't done so already
 * 5. Open the exported svg in Inkscape
 * 6. Chose File->Document Properties-> Then change both sets of units to mm
 * 7. Click the "Select and tranform objects" button on the left toolbar (The Mouse Icon)
 * 8. Click on the nose cone and set the x,y coordinates on the top toolbar to 0,0
 * 9. Chose Path->Object To Path after selecting the nose cone
 * 10. Set the finLength variable below to what inkscape says is the width in it's toolbar. And set the finSemiSpan variable below to what inkscape says is the height in it's toolbar.
 * 11. Click the "Edit Paths By Nodes" button on the left toolbar
 * 12. Select the fin
 * 13. Select the endpoint node of the root chord and set the finRootChordLength variable below to what inkscape says is the x location for the node
 * 14. Save the svg
 * 15. Select Extensions->Generate From Path->Paths To OpenSCAD
 * 16. Set the ouput file path to a place you can find it
 * 17. Leave the other two parameters alone and click "apply"
 * 18. Open the newly exported scad file and find "polygon" call. There should only be one polygon call. If there are more than one, OpenSCAD will not work. So make sure there's only 1! Copy the polygon's data (read: NOT the linear_extrude!) and paste it over the noseConePoints data below (In Variables.scad)
 * 19. Uncomment the test in Fins.scad to make sure everything worked. If it worked, now is the time to laugh maniacally!
 */

// You can change this to whatever resolution your heart desires
$fn = 64;

// You MUST change these variables in order for your custom nose cone to work properly
noseConeLength = 50.8;
noseConeWidth = 30.48;
noseConeShoulderLength = 17.78;
noseConeShoulderWidth = 28.96;
noseConePoints = [[-121.500000,26.999975],[-120.600000,26.729975],[-119.700000,26.459975],[-118.800000,26.189975],[-117.900000,25.919975],[-117.000000,25.649975],[-116.100000,25.379975],[-115.200000,25.109975],[-114.300000,24.839975],[-113.400000,24.569975],[-112.500000,24.299975],[-111.600000,24.029975],[-110.700000,23.759975],[-109.800000,23.489975],[-108.900000,23.219975],[-108.000000,22.949975],[-107.100000,22.679975],[-106.200000,22.409975],[-105.300000,22.139975],[-104.400000,21.869975],[-103.500000,21.599975],[-102.600000,21.329975],[-101.700000,21.059975],[-100.800000,20.789975],[-99.900000,20.519975],[-99.000000,20.249975],[-98.100000,19.979975],[-97.200000,19.709975],[-96.300000,19.439975],[-95.400000,19.169975],[-94.500000,18.899975],[-93.600000,18.629975],[-92.700000,18.359975],[-91.800000,18.089975],[-90.900000,17.819975],[-90.000000,17.549975],[-89.100000,17.279975],[-88.200000,17.009975],[-87.300000,16.739975],[-86.400000,16.469975],[-85.500000,16.199975],[-84.600000,15.929975],[-83.700000,15.659975],[-82.800000,15.389975],[-81.900000,15.119975],[-81.000000,14.849975],[-80.100000,14.579975],[-79.200000,14.309975],[-78.300000,14.039975],[-77.400000,13.769975],[-76.500000,13.499975],[-75.600000,13.229975],[-74.700000,12.959975],[-73.800000,12.689975],[-72.900000,12.419975],[-72.000000,12.149975],[-71.100000,11.879975],[-70.200000,11.609975],[-69.300000,11.339975],[-68.400000,11.069975],[-67.500000,10.799975],[-66.600000,10.529975],[-65.700000,10.259975],[-64.800000,9.989975],[-63.900000,9.719975],[-63.000000,9.449975],[-62.100000,9.179975],[-61.200000,8.909971],[-60.300000,8.639971],[-59.400000,8.369971],[-58.500000,8.099971],[-57.600000,7.829971],[-56.700000,7.559971],[-55.800000,7.289971],[-54.900000,7.019971],[-54.000000,6.749971],[-53.100000,6.479971],[-52.200000,6.209971],[-51.300000,5.939971],[-50.400000,5.669971],[-49.500000,5.399971],[-48.600000,5.129971],[-47.700000,4.859971],[-46.800000,4.589971],[-45.900000,4.319971],[-45.000000,4.049971],[-44.100000,3.779971],[-43.200000,3.509971],[-42.300000,3.239971],[-41.400000,2.969971],[-40.500000,2.699971],[-39.600000,2.429971],[-38.700000,2.159971],[-37.800000,1.889971],[-36.900000,1.619971],[-36.000000,1.349971],[-35.100000,1.079971],[-34.200000,0.809971],[-33.300000,0.539971],[-32.400000,0.269971],[-31.500000,-0.000029],[-30.600000,-0.270029],[-29.700000,-0.540029],[-28.800000,-0.810029],[-27.900000,-1.080029],[-27.000000,-1.350029],[-26.100000,-1.620029],[-25.200000,-1.890029],[-24.300000,-2.160029],[-23.400000,-2.430029],[-22.500000,-2.700029],[-21.600000,-2.970029],[-20.700000,-3.240029],[-19.800000,-3.510029],[-18.900000,-3.780029],[-18.000000,-4.050029],[-17.100000,-4.320029],[-16.200000,-4.590029],[-15.300000,-4.860029],[-14.400000,-5.130029],[-13.500000,-5.400029],[-12.600000,-5.670029],[-11.700000,-5.940029],[-10.800000,-6.210029],[-9.900000,-6.480029],[-9.000000,-6.750029],[-8.100000,-7.020029],[-7.200000,-7.290029],[-6.300000,-7.560029],[-5.400000,-7.830029],[-4.500000,-8.100029],[-3.600000,-8.370029],[-2.700000,-8.640029],[-1.800000,-8.910029],[-0.900000,-9.180029],[0.000000,-9.450029],[0.900000,-9.720029],[1.800000,-9.990029],[2.700000,-10.260029],[3.600000,-10.530029],[4.500000,-10.800029],[5.400000,-11.070029],[6.300000,-11.340029],[7.200000,-11.610029],[8.100000,-11.880029],[9.000000,-12.150029],[9.900000,-12.420029],[10.800000,-12.690029],[11.700000,-12.960029],[12.600000,-13.230029],[13.500000,-13.500029],[14.400000,-13.770029],[15.300000,-14.040029],[16.200000,-14.310029],[17.100000,-14.580029],[18.000000,-14.850029],[18.900000,-15.120029],[19.800000,-15.390029],[20.700000,-15.660029],[21.600000,-15.930029],[22.500000,-16.200029],[23.400000,-16.470029],[24.300000,-16.740029],[25.200000,-17.010029],[26.100000,-17.280029],[27.000000,-17.550029],[27.900000,-17.820029],[28.800000,-18.090029],[29.700000,-18.360029],[30.600000,-18.630029],[31.500000,-18.900029],[32.400000,-19.170029],[33.300000,-19.440029],[34.200000,-19.710029],[35.100000,-19.980029],[36.000000,-20.250029],[36.900000,-20.520029],[37.800000,-20.790029],[38.700000,-21.060029],[39.600000,-21.330029],[40.500000,-21.600029],[41.400000,-21.870029],[42.300000,-22.140029],[43.200000,-22.410029],[44.100000,-22.680029],[45.000000,-22.950029],[45.900000,-23.220029],[46.800000,-23.490029],[47.700000,-23.760029],[48.600000,-24.030029],[49.500000,-24.300029],[50.400000,-24.570029],[51.300000,-24.840029],[52.200000,-25.110029],[53.100000,-25.380029],[54.000000,-25.650029],[54.900000,-25.920029],[55.800000,-26.190029],[56.700000,-26.460029],[57.600000,-26.730029],[58.500000,-27.000029],[58.500000,-24.307112],[121.500000,-24.307112],[121.500000,27.000029]];

// You also MUST change these variables to get your custom fins to work
finLength = 123.987;
finSemiSpan = 48.041;
finRootChordLength = 50.8;
finThickness = 2.38;
finPoints = [[-39.600000,85.050000],[219.600000,-85.050000],[212.400000,-85.050000],[200.905200,-85.050000],[193.968000,-85.050000],[188.524800,-85.050000],[182.806200,-84.505748],[175.500000,-83.218113],[169.200000,-81.450000],[162.900000,-79.679412],[155.809800,-77.229567],[150.367500,-75.150000],[143.118000,-71.948970],[135.974700,-68.908860],[128.503800,-65.250000],[119.700000,-60.470100],[107.100000,-53.936910],[0.900000,6.084000],[-43.200000,30.750300],[-68.400000,45.450000],[-80.100000,51.750000],[-85.832100,54.450000],[-96.454800,58.950000],[-103.500000,61.650000],[-110.700000,64.350000],[-118.800000,67.050000],[-124.884000,68.850000],[-130.500000,70.650000],[-136.800000,72.450000],[-144.900000,74.250000],[-149.400000,75.150000],[-158.419170,76.950000],[-169.200000,78.750000],[-176.122890,79.638300],[-184.975110,80.550000],[-195.540480,81.563400],[-204.083370,82.609200],[-209.700000,83.306700],[-213.323598,83.829600],[-219.600000,85.050000]];

// ***** Don't change these variables ******//
offsetMargin = 0.1;
noseConeTotalLength = noseConeLength + noseConeShoulderLength;