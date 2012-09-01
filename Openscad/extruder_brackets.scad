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

# import("../Print-Huxley/Individual-STLs/M6-Block.stl");