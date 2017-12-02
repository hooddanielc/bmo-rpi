use <rounded_cube.scad>

tft_offset = 6;
tft_pcb_width = 85;
tft_pcb_height = 56;
pi_pcb_width = 85;
pi_pcb_height = 56;

// distance inbetween tft and pi pcb
pcb_distance = 17;

module pi_dummy() {
  cube([pi_pcb_width, pi_pcb_height, 1.6]);
}

module tft_dummy() {
  difference() {
    cube([tft_pcb_width, tft_pcb_height, 1.6]);
    translate([3.5, 3.5, -1]) cylinder(h = 3, r1 = 1.5, r2 = 1.5);
    translate([tft_pcb_width - 3.5, 3.5, -1]) cylinder(h = 3, r1 = 1.5, r2 = 1.5);
    translate([tft_pcb_width - 3.5, tft_pcb_height - 3.5, -1]) cylinder(h = 3, r1 = 1.5, r2 = 1.5);
  }
  translate([(tft_pcb_width - 70) / 2, tft_pcb_height - 50, 1.6]) cube([70, 50, 3.5]);
}

module body(size = [1, 1, 1]) {
  difference() {
    roundedcube(size = [size[0], size[1], size[2]], radius = 5);
    translate([3, 3, 3]) cube(size = [size[0] - 6, size[1] - 6, size[2] - 6], radius = 5);
  }
}

// dummies
pi_dummy();
translate([-tft_offset, 0, 17]) tft_dummy();

// body
difference() {
  color([0, 0, 0, 0.75]) translate([-14, -5, -5]) body(size = [105, 160, 35]);
  translate([-40, 0, 0]) cube(size = [105, 70, 35]);
}