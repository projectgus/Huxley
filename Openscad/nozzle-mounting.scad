$fs = 0.01;

// External additions:
// 3mm copper/alu spacing plate for heat sink
// Longer M3 bolts - 35mm??? (check bolt length + hole depth to be sure

module solid_section() {
    translate([-20,0,0]) {
            cube([40,28.8,3.2]);
            translate([0,3,0]) {
                cube([40,25.8,5]);
                // main housing for the filament feedthrough above the fitting
                translate([10.5,21,0]) {
                    cube([19,8.5,12.2]);
                }
            }
    }
    for(mirror = [0,1]) {
        mirror([mirror,0,0]) {
            // left & right supports/spacers at bottom of bracket
            translate([9,3,0]) {
                cube([11,7,12.2]);
            }
            // left & right supports coming up alongside the M3 heatsink bolts
            translate([7.5,3,0]) {
                cube([3.0,23,12.2]);
            }
            translate([0,3,0]) {
                cube([8,21,8]);
            }
        }
    }
    // "guidance ears" at the top of the nozzle mounting, keep filament straight
    for(mirror = [1,0])
        mirror([mirror,0,0]) {
            translate([5.75,31.8,0]) {
                difference() {
                    cylinder(r=3.8,h=12.2);
                    translate([-1.6,0,0])
                        cube([6,3.8,12.2]);
                }
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
                // M3 bolt mounting holes
                cylinder(r=1.6,h=50);
            }
        }
    }
}

// filament_path
module filament_path() {
    rotate(-90, [1,0,0]) {
        translate([0,-8.2,0]) {
            cylinder(r=2,h=40);
            // bottom end, min 20.5mm deep 12mm diameter recess for push-to-fit connector
            cylinder(r=6,h=3+21);
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

nozzle_mounting();
