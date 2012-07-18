include <Variables.scad>
include <NoseCone.scad>
include <Fins.scad>

//translate(v = [0, 0, 32]) noseCone();
//bodyTube();
finCan();
//finsForPrinting(finThickness = finThickness, finXSpacing = finLength  / 2, finYSpacing = finSemiSpan / 2, maxFinsInXDirection = 2, maxFinsInYDirection = 4, finLayout = [[1, 1], [1, 0], [1, 0], [1, 0]]);
//coupler();
//centeringRing();

// A Test to show the nose cone was imported properly
/*rotate_extrude(convexity = 10)
 {
 noseConePolygon();
 }*/

// A Test to show the fin data was imported properly
//finForFinCan();

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

module centeringRing(centeringRingOutsideDiameter = 28.96, centeringRingInsideDiameter = 23.96, centeringRingThickness = 2.54)
{
    difference()
    {
        cylinder(r = centeringRingOutsideDiameter / 2, h = centeringRingThickness);
        
        translate(v = [0, 0, -offsetMargin])
        {
            cylinder(r = centeringRingInsideDiameter / 2, h = centeringRingThickness + 2 * offsetMargin);
        }
    }
}

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

module finPolygon()
{
    // X is the width of the svg, y is the height of the svg
    translate(v = [finLength / 2, finSemiSpan / 2, 0])
    {
        scale([25.4 / 90, -25.4 / 90, 1]) 
        {
            polygon(finPoints);
        }
    }
}

module finCan(finCanLength = finRootChordLength, finCanInsideDiameter = 28.96, finCanWallThickness = 0.885, finThickness = finThickness, finCount = 3, launchLugInsideDiameter = 4.8, launchLugWallThickness = 0.5, launchLugPieceLength = 10, launchLugNumberOfPieces = 2, launchLugWallThicknessOffsetPercentage = 50)
{
    // Calculate some distances
    launchLugTotalLength = launchLugNumberOfPieces * launchLugPieceLength;
    launchLugTotalGapLength = finCanLength - launchLugTotalLength;
    launchLugNumberOfGaps = (launchLugNumberOfPieces - 1);
    gapBetweenLaunchLugPieces = launchLugTotalGapLength / (launchLugNumberOfPieces - 1);
    finCanWallThickness = (finThroughTheWallMountDepth > 0.0 ? finThroughTheWallMountDepth : finCanWallThickness);
    
    difference()
    {
        union()
        {
            // Create the fin can
            cylinder(h = finCanLength, r = finCanInsideDiameter / 2 + finCanWallThickness);
            
            // Create the fins
            for(i = [0 : finCount - 1])
            {
                rotate([0, 0, i * (360 / finCount)])
                {
                    translate(v = [finCanInsideDiameter / 2 + finCanWallThickness - (finThroughTheWallMountDepth > 0.0 ? finThroughTheWallMountDepth : 0), 0, 0])
                    {
                        finOrientedForFinCan(finThickness = finThickness);
                    }
                }
            }
            
            // Add the launch lug
            for(i = [0 : launchLugNumberOfPieces - 1])
            {
                // Rotate the lug inbetween the fins
                rotate([0, 0, 180 / finCount])
                {
                    // Move the lug to the edge of the fin can + the offset
                    translate([finCanInsideDiameter / 2 + finCanWallThickness + launchLugInsideDiameter / 2 + (launchLugWallThicknessOffsetPercentage / 100) * launchLugWallThickness - offsetMargin, 0, i * gapBetweenLaunchLugPieces + i * launchLugPieceLength])
                    {
                        launchLug(launchLugWallThickness = launchLugWallThickness, launchLugInsideDiameter = launchLugInsideDiameter, launchLugLength = launchLugPieceLength);
                    }
                }
            }
        }
        
        // Fin can cutout
        translate(v = [0, 0, -offsetMargin])
        {
            cylinder(h = finCanLength + 2 * offsetMargin, r = finCanInsideDiameter / 2);
        }
    }
}

module finOrientedForFinCan(finThickness = 1)
{
    translate(v = [-offsetMargin, finThickness / 2, finRootChordLength])
    {
        rotate(a = [90, 90, 0])
        {
            linear_extrude(height = finThickness)
            {
                finPolygon();
            }
        }
    }
}

module finsForPrinting(finThickness = 1, finCount = 4, finXSpacing = 25, finYSpacing = 25, maxFinsInXDirection = 2, maxFinsInYDirection = 2, finLayout = [[1, 1], [1, 1]])
{
    for(i = [0 : maxFinsInXDirection - 1])
    {
        for(i2 = [0 : maxFinsInYDirection - 1])
        {
            //            echo("i2", i2);
            //            echo("i", i);
            //            echo("finLayout[][]:", finLayout[i2][i]);
            if(finLayout[i2][i] == 1 || finLayout == true)
            {
                translate(v = [i * finXSpacing, i2 * finYSpacing, 0])
                {
                    linear_extrude(height = finThickness)
                    {
                        finPolygon();
                    }
                }
            }
        }
    }
}

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