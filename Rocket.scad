include <Variables.scad>
include <RocketParts.scad>
include <HelperModules.scad>

//finCan(addFins = false, finCanLength = 100, finCanInsideDiameter = 24.13, finCanWallThickness = 0.40 * 2);
//coupler(couplerInsideDiameter = 24.13, couplerWallThickness = 0.40 * 2, couplerLength = 60);
//bodyTube(bodyTubeInsideDiameter = 24.13, bodyTubeWallThickness = 0.40 * 2, bodyTubeLength = 100);
//noseCone();
//fin(finThickness = 1.5);

// This makes a fin can. It needs to be refactored
module finCan(finCanLength = finRootChordLength, finCanInsideDiameter = 28.96, finCanWallThickness = 0.885, finThickness = finThickness, finCount = 3, addFins = true, launchLugInsideDiameter = 4.8, launchLugWallThickness = 0.5, launchLugPieceLength = 15, launchLugNumberOfPieces = 2, launchLugWallThicknessOffsetPercentage = 50)
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
            if(addFins == true)
            {
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
                        // Create the launch lug
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
        
        // Create the fin throught the wall mount cutouts
        if(addFins == false)
        {
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
        }
    }
}


/* This module lays out the fins flat and groups them together. Use the finLayout variable to get specific layouts.
 *
 * e.g finsForPrinting(finThickness = finThickness, finXSpacing = 60, finYSpacing = 30, maxFinsInXDirection = 2, maxFinsInYDirection = 4, finLayout = [[1, 1], [1, 0], [1, 0], [1, 0]]);
 * This above example will have two columns of fins like this:  F
 *                                                              F
 *                                                              F
 *                                                              F F
 */
module finsForPrinting(finThickness = 1, finCount = 4, finXSpacing = 25, finYSpacing = 25, maxFinsInXDirection = 2, maxFinsInYDirection = 2, finLayout = [[1, 1], [1, 1]])
{
    for(i = [0 : maxFinsInXDirection - 1])
    {
        for(i2 = [0 : maxFinsInYDirection - 1])
        {
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