include <Variables.scad>

// A Test to show the fin data was imported properly
//finForFinCan();

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

module finCan(finCanLength = 50.8, finCanInsideDiameter = 28.96, finCanWallThickness = 0.885, finCount = 3, launchLugInsideDiameter = 3, launchLugWallThickness = 0.5, launchLugPieceLength = 10, launchLugNumberOfPieces = 2, launchLugWallThicknessOffsetPercentage = 100)
{
    // Calculate some distances
    launchLugTotalLength = launchLugNumberOfPieces * launchLugPieceLength;
    launchLugTotalGapLength = finCanLength - launchLugTotalLength;
    launchLugNumberOfGaps = (launchLugNumberOfPieces - 1);
    gapBetweenLaunchLugPieces = launchLugTotalGapLength / (launchLugNumberOfPieces - 1);
    
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
                    translate(v = [finCanInsideDiameter / 2 + finCanWallThickness, 0, 0])
                    {
                        finForFinCan(finDXFFileName = finFileName);
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
                        difference()
                        {
                            // Launch Lug Body
                            cylinder(h = launchLugPieceLength, r = launchLugInsideDiameter / 2 + launchLugWallThickness);
                            
                            // Launch lug cutout
                            translate(v = [0, 0, -offsetMargin])
                            {
                                cylinder(h = launchLugPieceLength + 2 * offsetMargin, r = launchLugInsideDiameter / 2);
                            }
                        }
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

module finForFinCan(finThickness = 1)
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