include <Variables.scad>
include <HelperModules.scad>

// This just makes a basic body tube
module bodyTube(bodyTubeLength = 100, bodyTubeInsideDiameter = 28.96, bodyTubeWallThickness = 0.885)
{
    difference()
    {
        // The main body tube cylinder
        cylinder(r = bodyTubeInsideDiameter / 2 + bodyTubeWallThickness, h = bodyTubeLength);
        
        // Cutout the inside to make it hollow
        translate(v = [0, 0, -offsetMargin])
        {
            cylinder(r = bodyTubeInsideDiameter / 2, h = bodyTubeLength + 2 * offsetMargin);
        }
    }
}

// This just makes a basic coupler
module coupler(couplerOutsideDiameter = 28.96, couplerWallThickness = 1.0, couplerLength = 28.96, centerMark = true)
{
    centerMarkLength = 0.25;
    centerMarkDepth = 0.40;
    
    difference()
    {
        // Main Coupler Body
        cylinder(r = couplerOutsideDiameter / 2, h = couplerLength);
        
        // Coupler Inside Cutout
        translate(v = [0, 0, -offsetMargin])
        {
            cylinder(r = couplerOutsideDiameter / 2 - couplerWallThickness, h = couplerLength + 2 * offsetMargin);
        }
        
        // Center Mark
        if(centerMark == true)
        {
            translate(v = [0, 0, couplerLength / 2 - centerMarkLength / 2])
            {
                difference()
                {
                    // Main Center Mark Cylinder
                    cylinder(r = couplerOutsideDiameter / 2 + offsetMargin, h = centerMarkLength);
                    
                    // Center Mark Center Cutout
                    translate(v = [0, 0, -offsetMargin])
                    {
                        cylinder(r = couplerOutsideDiameter / 2 - centerMarkDepth, h = centerMarkLength + 2 * offsetMargin);
                    }
                }
            }
        }
    }
}

module bulkHead(bulkHeadOutsideDiameter = 28.96, bulkHeadLength = 28.96)
{
    cylinder(r = bulkHeadOutsideDiameter / 2, h = bulkHeadLength);
}

// This just create a simple round launch lug
module launchLug(launchLugInsideDiameter = 4.8, launchLugWallThickness = 0.5, launchLugLength = 10)
{
    difference()
    {
        // Main Coupler Body
        cylinder(r = launchLugInsideDiameter / 2 + launchLugWallThickness, h = launchLugLength);
        
        // Coupler Inside Cutout
        translate(v = [0, 0, -offsetMargin])
        {
            cylinder(r = launchLugInsideDiameter / 2, h = launchLugLength + 2 * offsetMargin);
        }
    }
}

// This just creates a basic centering ring
module centeringRing(centeringRingOutsideDiameter = 28.96, centeringRingInsideDiameter = 23.96, centeringRingThickness = 2.54)
{
    difference()
    {
        // The main centering ring cylinder
        cylinder(r = centeringRingOutsideDiameter / 2, h = centeringRingThickness);
        
        // The center cutout
        translate(v = [0, 0, -offsetMargin])
        {
            cylinder(r = centeringRingInsideDiameter / 2, h = centeringRingThickness + 2 * offsetMargin);
        }
    }
}

// This takes your noseCone data from Variables.scad and makes a nose cone
module noseCone(noseConeWallThickness = 0.4 * 2, addParachuteAttachmentHook = true, parachuteAttachmentHookSize = 5.0)
{
    scalePercentage = (noseConeWidth / 2 - noseConeWallThickness) / (noseConeWidth / 2);
    
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
            translate(v = [0, 0, noseConeWallThickness / 2])
            {
                rotate_extrude(convexity = 10)
                {
                    scale([scalePercentage, scalePercentage, scalePercentage])
                    {
                        noseConePolygon();
                    }
                }
            }
            
            // Cutout plenty of shoulder length so a clean bottom can be added back in
            translate(v = [0, 0, -offsetMargin])
            {
                cylinder(r = noseConeShoulderWidth / 2 - noseConeWallThickness, h = noseConeWallThickness + 2 * offsetMargin);
            }
        }
        
        
        // Create the bottom face of the nose cone
        difference()
        {
            // Add back the bottom of the nose cone
            cylinder(r = noseConeShoulderWidth / 2, h = noseConeWallThickness);
            
            // Create the cutout for the parachuteHook
            if(addParachuteAttachmentHook)
            {
                translate(v = [0, 0, -offsetMargin])
                {
                    cylinder(r = parachuteAttachmentHookSize / 2, h = noseConeWallThickness + 2 * offsetMargin);
                }
            }
        }
        
        // Create the parachute attatchment hook
        if(addParachuteAttachmentHook)
        {
            // Move the hook on top of the bottom plate
            translate(v = [0, noseConeWallThickness / 2, 0])
            {
                rotate(a = [90, 0, 0])
                {
                    difference()
                    {
                        // Create the main cylinder
                        translate(v = [0, noseConeWallThickness, 0])
                        {
                            cylinder(r = parachuteAttachmentHookSize / 2 + noseConeWallThickness, h = noseConeWallThickness);
                        }
                        
                        // Main cylinder cutout
                        translate(v = [0, noseConeWallThickness, -offsetMargin])
                        {
                            cylinder(r = parachuteAttachmentHookSize / 2, h = noseConeWallThickness + 2 * offsetMargin);
                        }
                        // Cut off the bottom of the cylinder
                        translate(v = [-parachuteAttachmentHookSize - noseConeWallThickness - offsetMargin, -parachuteAttachmentHookSize - noseConeWallThickness - 2 * offsetMargin, -offsetMargin])
                        {
                            cube(size = [parachuteAttachmentHookSize * 2 + noseConeWallThickness * 2 + offsetMargin * 2, parachuteAttachmentHookSize + 2 * noseConeWallThickness + offsetMargin, noseConeWallThickness + 2 * offsetMargin]);
                        }
                    }
                }
            }
        }
    }
}

// This module oriented an transaltes a fin for mounting on a body tube
module fin(finThickness = 1)
{
    // Make the fin
    linear_extrude(height = finThickness)
    {
        finPolygon();
    }
}