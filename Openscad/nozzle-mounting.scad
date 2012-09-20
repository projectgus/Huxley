$fs = 0.01;

module solid_section() {
    translate([-20,0,0]) {
            cube([40,28.8,3.2]);
            translate([0,3,0]) {
                cube([40,25.8,5]);
                cube([40,7,11.2]);
                translate([13.5,0,0])
                    cube([13,31.8,12.2]);
            }
    }
}

// the original model has nice angled corners.
// Emulating them the crummy way here
module angular_edges() {
    // base corners
    for(m = [0,1]) {
        mirror([m,0,0]) {
            translate([-20,0,0]) {
                rotate(45,[0,0,1])
                    cube([1.4,5,10],center=true);
            }
            translate([-20,30.5,0]) {
                rotate(31,[0,0,1])
                    cube([10,8,10],center=true);
            }
        }
    }
}

// recessed hole for a self-tapper screw
module self_tapper_hole() {
    translate([0,0,-1])
        cylinder(r=1.7,h=30);
    translate([0,0,1.5]) {
        cylinder(r1=1.7,r2=3,h=1.65);
        translate([0,0,1.65])
            cylinder(r=3,h=20);
    }
}

// holes to mount the bracket to the x axis bracket
module xaxis_mounting_holes() {
    for(x = [-12.5, 12.5]) {
        for(y = [2.9, 26]) {
            translate([x,y,0])
                self_tapper_hole();
        }
        hull() {
            for(y = [14,19]) {
                translate([x,y,0]) {
                    cylinder(h=20,r=2.5);
                }
            }
        }
    }
}

// holes to mount the bracket to the heat sink
module heat_sink_mounting_holes() {
    rotate(-90, [1,0,0]) {
        for(x = [-7.5,7.5]) {
            translate([x,-8,0]) {
                cylinder(r=1.6,h=16);
                translate([0,-3.2,0])
                    cube([3.2,6.4,25], center=true);
                translate([0,0,9]) {
                    translate([0,-2.0,4])
                        cube([7.4,5.0,8], center=true);
                    cylinder(r=3.7,h=8);
                }
            }
        }
    }
}

// filament_path
module filament_path() {
    // captive nut properties
    tolerance=0.5;
    nut_height=4+tolerance;
    nut_recess_width=8+tolerance; // flat side A/F
    nut_width_b=9.20+tolerance; // pointed side A/C
    recess_offset=25;

    rotate(-90, [1,0,0]) {
        translate([0,-8.2,0]) {
            cylinder(r=1.0,h=40);
            // end piece
            translate([0,0,30]) {
                cylinder(r=2.75,h=6);
            }
            // slot to drop in nut
            translate([-nut_width_b/2,-recess_offset+nut_recess_width/2,29]) {
                cube([nut_width_b,recess_offset,nut_height]);
            }
        }
    }
}

module nozzle_mounting() {
    difference() {
        solid_section();
        angular_edges();
        xaxis_mounting_holes();
        heat_sink_mounting_holes();
        filament_path();
    }
}

//heat_sink_mounting_holes();
nozzle_mounting();
//filament_path();

