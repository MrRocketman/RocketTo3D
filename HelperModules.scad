include <RocketParts.scad>

// Don't mess with this unless you really know what you're doing.
module noseConePolygon()
{
    // Rotate to the proper orientation for a rotate_extrude
    rotate(a = [180, 180, 90])
    {
        // X is the width of the svg, y is the height of the svg
        translate(v = [-noseConeTotalLength / 2, noseConeWidth / 4, 0])
        {
            // Scale the nose cone since RockSim is dumb and doesn't export normal mm units
            scale([25.4 / 90, -25.4 / 90, 1]) 
            {
                polygon(noseConePoints);
            }
        }
    }
}

// Don't mess with this unless you really know what you're doing.
module finPolygon()
{
    // X is the width of the svg, y is the height of the svg
    translate(v = [finLength / 2, finSemiSpan / 2, 0])
    {
        // Scale the fin since RockSim is dumb and doesn't export normal mm units
        scale([25.4 / 90, -25.4 / 90, 1]) 
        {
            polygon(finPoints);
        }
    }
}

// This module oriented an transaltes a fin for mounting on a body tube
module finOrientedForFinCan(finThickness = 1)
{
    // Move it up so the rootChord is on the body tube.
    // Move have the finThickness to get it positioned properly
    translate(v = [-offsetMargin, finThickness / 2, finRootChordLength])
    {
        // Rotate to the vertical position
        rotate(a = [90, 90, 0])
        {
            fin(finThickness = finThickness);
        }
    }
}