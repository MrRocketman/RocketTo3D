include <Variables.scad>
include <NoseCone.scad>
include <Fins.scad>

//translate(v = [0, 0, 32]) noseCone();
//bodyTube();
//finCan();
//finsForPrinting(finThickness = finThickness, finXSpacing = finLength  / 2, finYSpacing = finSemiSpan / 2, maxFinsInXDirection = 2, maxFinsInYDirection = 4, finLayout = [[1, 1], [1, 0], [1, 0], [1, 0]]);
coupler();

module bodyTube(tubeLength = 100, tubeInsideDiameter = 28.96, tubeWallThickness = 0.885)
{
    difference()
    {
        cylinder(r = tubeInsideDiameter / 2 + tubeWallThickness, h = tubeLength);
        
        translate(v = [0, 0, -offsetMargin])
        {
            cylinder(r = tubeInsideDiameter / 2, h = tubeLength + 2 * offsetMargin);
        }
    }
}

module coupler(couplerOutsideDiameter = 28.96, couplerWallThickness = 1.0, couplerLength = 57.92, centerMark = true)
{
    centerMarkLength = 0.25;
    centerMarkDepth = 0.15;
    
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

module centeringRing(centeringRingOutsideDiameter = 28.96, centeringRingInsideDiameter = 23.96, centeringRingThickness = 5.0)
{
    
}