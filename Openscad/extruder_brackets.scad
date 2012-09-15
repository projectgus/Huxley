use <mendel_misc.inc>;
use <configuration.scad>;
$fs = 0.01;
// exit hole for filament (w/ tube)
* translate([58.4,-1,15.5]) rotate(90, [1,0,0]) cylinder(r=3,h=5);

// main structure

module stepper_hole(h) {
    hull() {
        translate([-1.5,0,0]) cylinder(r=1.6,h=h);
        translate([1.5,0,0]) cylinder(r=1.6,h=h);
    }
}

// flat base plate, w/ stepper mount and one end of driveshaft
module baseplate() {
    difference() {
        cube([63.5,43,5]);
        // stepper mount cutout
        translate([23,23,-5]) cylinder(r=13,h=20);
        translate([-1,16,-5]) cube([27.5,30,20]);
        translate([7.5,10.5,-5]) stepper_hole(h=10);
        translate([7.5+26,10.5,-5]) stepper_hole(h=10);
        translate([7.5+26,10.5+26,-5]) stepper_hole(h=10);
    }
}

// end plate, faces output of extruder
module endplate() {
    difference() {
        rotate(90, [1,0,0]) mirror([0,0,1]) {
            linear_extrude(height=5) {
                polygon([ [0,0], [0,5], [38,28],
                          [43.5,28], [80,28],
                          [89.5,20], [89.5,0],
                          [0,0] ]);
                translate([81,19.5]) circle(8.5);
            }
        }
        // mounting holes
        rotate(90, [1,0,0]) mirror([0,0,1]) {
            for(x = [ -25, 25 ]) {
                translate([59+x,15,-10])
                    cylinder(r=1.7,h=100);
            }
        }
        // recess against pivot mount
        translate([71,27,2]) {
            cylinder(h=100,r=23);
        }
    }
}

// main structural body of extruder
module mainbody() {
    translate([40.5,0,0]) {
        linear_extrude(height=28) {
            polygon([[0,0], [0,5], [-3,5], [0,8],
                     [0,5], [0,25], [8,33], [8,43],
                     [23,43], [23,0], [0,0]]);
            translate([9,24]) circle(9);
        }
    }
}

// triangular pivot mount for the pressure plate
module pivotmount() {
    translate([63.5,5,11.5]) {
        difference() {
            linear_extrude(height=8) {
                polygon([ [0,0], [17, 0], [0, 10]]);
            }
            translate([4.75,3.6,-1]) {
                cylinder(h=100, r=1.65);
            }
        }
    }
}

// two bolt holes for the pivot tensioner
module pivotbolt() {
    cylinder(r=2.2,h=100);
    rotate(90, [0,0,1]) m3_nut_cavity(5);
}

module pivotboltholes() {
    rotate(90, [0,1,0]) {
        for(x = [ -8, -23 ]) {
            translate([x,36.6,51]) {
                pivotbolt();
            }
        }
    }
}

// drive shaft w/ bearing recesses
module driveshaft() {
    translate([55,23.6,0]) {
        cylinder(h=80,r=4);
        cylinder(h=5,r=9.7);
        translate([0,0,23])
            cylinder(h=6,r=9.7);
        translate([0,0,11.5]) {
            linear_extrude(height=20) {
                polygon([ [-4,0],
                          [10,-9.6],
                          [10, 9.5],
                          [0,0] ]);
            }
        }
        translate([5,0,0])
            cube([10,14,10], center=true);
    }
}

// filament path
module filament() {
    // captive nut properties:
    tolerance=0.5;
    nut_height=4+tolerance;
    nut_recess_width=8+tolerance; // flat side A/F
    nut_width_b=9.20+tolerance; // pointed side A/C
    recess_offset=25;

    rotate(270,[1,0,0]) {
        translate([58.5,-15.5,0]) {
            cylinder(r=1,h=100);
            translate([0,0,-1]) cylinder(r=3,h=6); // mounting hole
            translate([0,0,8]) {
                cylinder(r1=1,r2=4.2,h=12);
            }
            // slot for M5 captive nut insert, should be just wide
            // enough to drop an M5 in sideways, and have it line up
            // with the mounting hole
            translate([-nut_recess_width/2,-recess_offset+nut_width_b/2,2]) {
                cube([nut_recess_width,recess_offset,nut_height]);
            }

        }
    }
}

module m6_block() {
    difference() {
        union() {
            baseplate();
            endplate();
            mainbody();
            pivotmount();
        }
        driveshaft();
        filament();
        pivotboltholes();
    }
}

m6_block();

/*
translate([0,60,0])
    import("../Print-Huxley/Individual-STLs/M6-Block.stl");
*/