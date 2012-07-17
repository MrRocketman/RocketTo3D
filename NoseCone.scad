include <Variables.scad>

// A Test to show the nose cone was imported properly
/*rotate_extrude(convexity = 10)
{
    noseConePolygon();
}*/

module noseConePolygon()
{
    // Rotate to the proper orientation for a rotate_extrude
    rotate(a = [180, 180, 90])
    {
        // X is the width of the svg, y is the height of the svg
        translate(v = [-noseConeTotalLength / 2, noseConeWidth / 4, 0])
        {
            scale([25.4 / 90, -25.4 / 90, 1]) 
            {
                polygon(noseConePoints);
            }
        }
    }
}

module noseCone(wallThickness = 1.17, addParachuteAttachmentHook = true, parachuteAttachmentHookSize = 5.0)
{
    scalePercentage = (noseConeWidth / 2 - wallThickness) / (noseConeWidth / 2);
    
    union()
    {
        // Create the nose cone
        difference()
        {
            // Create the nose Cone
            rotate_extrude(convexity = 10)
            {
                noseConePolygon();
            }
            
            // Cutout the inside of the nose cone
            rotate_extrude(convexity = 10)
            {
                scale([scalePercentage, scalePercentage, scalePercentage])
                {
                    noseConePolygon();
                }
            }
            
            // Cutout plength of shoulder length so a clean bottom can be added back in
            translate(v = [0, 0, -offsetMargin])
            {
                cylinder(r = noseConeShoulderWidth / 2 - wallThickness, h = wallThickness + 2 * offsetMargin);
            }
        }
        
        
        // Create the bottom face of the nose cone
        difference()
        {
            // Add back the bottom of the nose cone
            cylinder(r = noseConeShoulderWidth / 2, h = wallThickness);
            
            // Create the cutout for the parachuteHook
            if(addParachuteAttachmentHook)
            {
                translate(v = [0, 0, -offsetMargin])
                {
                    cylinder(r = parachuteAttachmentHookSize / 2, h = wallThickness + 2 * offsetMargin);
                }
            }
        }
        
        // Create the parachute attatchment hook
        if(addParachuteAttachmentHook)
        {
            // Move the hook on top of the bottom plate
            translate(v = [0, wallThickness / 2, 0])
            {
                rotate(a = [90, 0, 0])
                {
                    difference()
                    {
                        // Create the main cylinder
                        translate(v = [0, wallThickness, 0])
                        {
                            cylinder(r = parachuteAttachmentHookSize / 2 + wallThickness, h = wallThickness);
                        }
                        
                        // Main cylinder cutout
                        translate(v = [0, wallThickness, -offsetMargin])
                        {
                            cylinder(r = parachuteAttachmentHookSize / 2, h = wallThickness + 2 * offsetMargin);
                        }
                        // Cut off the bottom of the cylinder
                        translate(v = [-parachuteAttachmentHookSize - wallThickness - offsetMargin, -parachuteAttachmentHookSize - wallThickness - offsetMargin, -offsetMargin])
                        {
                            cube(size = [parachuteAttachmentHookSize * 2 + wallThickness * 2 + offsetMargin * 2, parachuteAttachmentHookSize + 2 * wallThickness + offsetMargin, wallThickness + 2 * offsetMargin]);
                        }
                    }
                }
            }
        }
    }
}