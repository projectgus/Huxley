include <./inc/mendel_misc.inc>;
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
difference() {
    cube([63.5,43,5]);
    // stepper mount cutout
    translate([23,23,-5]) cylinder(r=13,h=20);
    translate([-1,16,-5]) cube([27.5,30,20]);
    translate([7.5,10.5,-5]) stepper_hole(h=10);
    translate([7.5+26,10.5,-5]) stepper_hole(h=10);
    translate([7.5+26,10.5+26,-5]) stepper_hole(h=10);
}

// end plate, faces output of extruder
rotate(90, [1,0,0]) mirror([0,0,1]) {
    linear_extrude(height=5) {
        polygon([ [0,0], [0,5], [38,28], [43.5,28], [80,28],
                  [89.5,20], [89.5,0], [0,0] ]);
        translate([81,19.5]) circle(8.5);
    }
}

// main structural body of extruder
translate([40.5,0,0]) {
    linear_extrude(height=28) {
        polygon([[0,0], [0,5], [-3,5], [0,8],
                 [0,5], [0,25], [8,33], [8,43],
                 [23,43], [23,0], [0,0]]);
        translate([9,24]) circle(9);
    }
}

// triangular pivot mount for the pressure plate
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

# import("../Print-Huxley/Individual-STLs/M6-Block.stl");