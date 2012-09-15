$fs = 0.01;

module solid_section() {
    translate([-20,0,0]) {
            cube([40,28.8,3.2]);
            translate([0,3,0]) {
                cube([40,25.8,5]);
                cube([40,7,11.2]);
                translate([13.5,0,0])
                    cube([13,25,11.2]);
            }
    }
}

// the original model has nice angled corners.
// Emulating them the crummy way here
module angular_edges() {
    translate([-20,30.5,0]) {
        rotate(27,[1,0,0])
            cube([40,5,15]);
    }
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
                cylinder(r=1.6,h=20);
                translate([0,-3.2,0])
                    cube([3.2,6.4,25], center=true);
                translate([0,0,9])
                    cylinder(r=3.7,h=50);
            }
        }
    }
}

// filament_path
module filament_path() {
    rotate(-90, [1,0,0]) {
        translate([0,-8.15,0]) {
            cylinder(r=2.15,h=30);
            cylinder(r=3.3,h=16);
            translate([0,0,16])
                cylinder(r1=3.3,r2=2.2,h=1.2);
            translate([0,0,25.5]) {
                    cylinder(r1=2.2,r2=3.5,h=3.2);
            }
            translate([-3.3,-6.6,0]) {
                cube([6.6,6.6,16]);
            }
            translate([0,-6.6,21]) {
                cube([4,14,12], center=true);
                for(r = [-45,45]) {
                    rotate(r,[0,0,1]) {
                        cube([5,10,10], center=true);
                    }
                }
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

translate([0,-30,0])
    import("../Print-Huxley/Individual-STLs/nozzle-mounting.stl");
translate([42,0,0])
    import("../Print-Huxley/Individual-STLs/nozzle-mounting.stl");


