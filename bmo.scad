use <rounded_cube.scad>

tft_offset = 5.6;
tft_pcb_width = 85;
tft_pcb_height = 56;
tft_pcb_zheight = 1.6;
tft_screen_width = 70;
tft_screen_height = 50;
tft_screen_zheight = 3.9;
tft_screen_offset_x = 7.5;
tft_screen_offset_y = 6;
tft_screen_hole_width = 2.5;
tft_screen_hole_offsets = [
  [tft_pcb_width - 3.5, tft_pcb_height - 3.5],
  [3.5, tft_pcb_height - 3.5],
  [3.5, 3.5]
];

pi_pcb_width = 85;
pi_pcb_height = 56;
pi_pcb_zheight = 1.6;
pi_min_mount_distance = 3;

pi_ethernet_width = 22;
pi_ethernet_height = 16;
pi_ethernet_zheight = 14;
pi_ethernet_x = 65.8;
pi_ethernet_y = 2.6;

pi_usb_port_height = 13.2;
pi_usb_port_width = 17.1;
pi_usb_port_zheight = 15.7;
pi_usb_port_1_x = 70.5;
pi_usb_port_1_y = 22.7;
pi_usb_port_2_x = 70.5;
pi_usb_port_2_y = 41;

pi_hdmi_port_width = 15.1;
pi_hdmi_port_height = 11.6;
pi_hdmi_port_zheight = 6.5;
pi_hdmi_port_x = 25;
pi_hdmi_port_y = -2.1;

pi_usb_mini_port_width = 7.8;
pi_usb_mini_port_height = 5.7;
pi_usb_mini_port_zheight = 3.4;
pi_usb_mini_port_x = 6.9;
pi_usb_mini_port_y = -1.2;

pi_audio_width = 6.9;
pi_audio_height = 14.4;
pi_audio_zheight = 5.9;
pi_audio_x = 50.3;
pi_audio_y = -2.6;

pi_hardware_zheight = pi_pcb_zheight + pi_usb_port_zheight;

pi_pcb_hole_positions = [
  [3.5, 3.5],
  [3.5, pi_pcb_height - 3.5],
  [pi_pcb_width - 23.5, pi_pcb_height - 3.5],
  [pi_pcb_width - 23.5, 3.5]
];

// distance inbetween tft and pi pcb
pcb_distance = 17;

// total connected hardware dimension
hardware_width = pi_pcb_width;
hardware_height = pi_pcb_height;
hardware_zheight = pi_usb_port_zheight + pi_pcb_zheight;


// body measurements are relative to width and pi_pcb_height
// of screen. a width of 1.2 = 120% width of the screen. 
// a height of 2.2 = 220% height of the screen.

/* in our bmo reference image, we can calculate
 * the relative width and height related to width and height of
 * the screen we are using.
 * width is 120.4% screen width
 * height is 269.6% screen height
 */
inset_hole_length = 5;
inset_hole_width = 6;
bmo_hardware_wiggle_room = 1.5;
bmo_case_thickness = 2.5;
bmo_body_width = hardware_width + (bmo_case_thickness * 2) + (bmo_hardware_wiggle_room * 2);
bmo_body_height = 1.5 * bmo_body_width;
bmo_body_zheight = bmo_body_width * .48;
bmo_screen_x = ((bmo_body_width - tft_pcb_width) / 2);
bmo_screen_y = bmo_body_height - ( tft_pcb_height - tft_screen_height ) - bmo_screen_x;
bmo_screen_z = bmo_body_zheight - tft_pcb_zheight - inset_hole_length;
bmo_body_radius = 5;
bmo_screen_punch_radius = inset_hole_length - tft_screen_zheight;
bmo_screen_punch_width = tft_screen_width + (bmo_screen_punch_radius * 2);
bmo_screen_punch_height = tft_screen_height + (bmo_screen_punch_radius * 2);
bmo_screen_punch_x = ((bmo_body_width - bmo_screen_punch_width) / 2);
bmo_screen_punch_y = bmo_screen_y - bmo_screen_punch_height + ((bmo_screen_punch_height - tft_screen_height) / 2);
bmo_pi_punch_relief = 2;

// inset hole stuff

module pi_dummy() {
  difference() {
    union() {
      cube([pi_pcb_width, pi_pcb_height, 1.6]);
      translate([pi_ethernet_x, pi_ethernet_y, pi_pcb_zheight])
        cube([pi_ethernet_width, pi_ethernet_height, pi_ethernet_zheight]);
      translate([pi_usb_port_1_x, pi_usb_port_1_y, pi_pcb_zheight])
        cube([pi_usb_port_width, pi_usb_port_height, pi_usb_port_zheight]);
      translate([pi_usb_port_2_x, pi_usb_port_2_y, pi_pcb_zheight])
        cube([pi_usb_port_width, pi_usb_port_height, pi_usb_port_zheight]);
      translate([pi_usb_mini_port_x, pi_usb_mini_port_y, pi_pcb_zheight])
        cube([pi_usb_mini_port_width, pi_usb_mini_port_height, pi_usb_mini_port_zheight]);
      translate([pi_audio_x, pi_audio_y, pi_pcb_zheight])
        cube([pi_audio_width, pi_audio_height, pi_audio_zheight]);
      translate([pi_hdmi_port_x, pi_hdmi_port_y, pi_pcb_zheight])
        cube([pi_hdmi_port_width, pi_hdmi_port_height, pi_audio_zheight]);
    }
    for (offset = pi_pcb_hole_positions) {
      translate(offset) cylinder(h = 3, r1 = tft_screen_hole_width/2, r2 = tft_screen_hole_width/2);
    }
  }
}

module tft_dummy() {
  difference() {
    cube([tft_pcb_width, tft_pcb_height, tft_pcb_zheight]);
    for (offset = tft_screen_hole_offsets) {
      translate(offset) cylinder(h = 3, r1 = tft_screen_hole_width/2, r2 = tft_screen_hole_width/2);
    }
  }
  translate([tft_screen_offset_x, tft_screen_offset_y, tft_pcb_zheight])
    cube([tft_screen_width, tft_screen_height, tft_screen_zheight]);
}

module body(size = [1, 1, 1], thickness = bmo_case_thickness) {
  sv = size;
  ct = thickness;
  difference() {
    roundedcube(size = [sv[0], sv[1], sv[2]], radius = bmo_body_radius);
    translate([bmo_case_thickness, bmo_case_thickness, bmo_case_thickness]) cube(size = [sv[0] - ct * 2, sv[1] - ct * 2, sv[2] - ct * 2], radius = 5);
  }
}

// origin is bottom left of screen surface
module connected_dummies() {
  fix_screen_origin_x = -tft_screen_offset_x + tft_offset;
  fix_screen_origin_y = -tft_screen_offset_y;
  fix_screen_origin_z = -tft_screen_zheight -tft_pcb_zheight - pcb_distance - pi_pcb_zheight;
  translate([fix_screen_origin_x, fix_screen_origin_y, fix_screen_origin_z]) {
    translate([pi_pcb_width, pi_pcb_height]) rotate([0, 0, 180]) pi_dummy();
    translate([-tft_offset, 0, pcb_distance + tft_pcb_zheight]) tft_dummy();
  }
}

module inset_hole(r=inset_hole_width / 2, h=inset_hole_length) {
  difference() {
    cylinder(r1=r, r2=r, h=h);
    cylinder(r1=2.5/2, r2=2.5/2, h=3.8);
  }
}

module screen_punch() {
  cube(size = [bmo_screen_punch_width, bmo_screen_punch_height, bmo_case_thickness + .1]);
}

module screen_punch_rims($fn = 30) {
  difference() {
    union() {
      rotate([-90, 0, 0])
        cylinder(h = bmo_screen_punch_height, r1 = bmo_screen_punch_radius, r2 = bmo_screen_punch_radius);
      translate([bmo_screen_punch_width, 0, 0])
        rotate([-90, 0, 0])
          cylinder(h = bmo_screen_punch_height, r1 = bmo_screen_punch_radius, r2 = bmo_screen_punch_radius);
      rotate([0, 90, 0])
        translate([0, bmo_screen_punch_height, 0])
          cylinder(h = bmo_screen_punch_width, r1 = bmo_screen_punch_radius, r2 = bmo_screen_punch_radius);
      rotate([0, 90, 0])
        cylinder(h = bmo_screen_punch_width, r1 = bmo_screen_punch_radius, r2 = bmo_screen_punch_radius);
    }
    translate([-bmo_screen_punch_radius, -bmo_screen_punch_radius, -bmo_screen_punch_radius])
      cube([
        bmo_screen_punch_width + (bmo_screen_punch_radius * 2),
        bmo_screen_punch_height + (bmo_screen_punch_radius * 2),
        bmo_screen_punch_radius
      ]);
  }
}

module punch_pi_holes() {
  o = 5; // offset
  r = bmo_pi_punch_relief; // relief
  rh = r / 2;
  translate([pi_ethernet_x, pi_ethernet_y - rh, pi_pcb_zheight - rh])
    cube([pi_ethernet_width + o, pi_ethernet_height + r, pi_ethernet_zheight + r]);
  translate([pi_usb_port_1_x, pi_usb_port_1_y - rh, pi_pcb_zheight - rh])
    cube([pi_usb_port_width + o, pi_usb_port_height + r, pi_usb_port_zheight + r]);
  translate([pi_usb_port_2_x, pi_usb_port_2_y - rh, pi_pcb_zheight - rh])
    cube([pi_usb_port_width + o, pi_usb_port_height + r, pi_usb_port_zheight + r]);
  translate([pi_usb_mini_port_x - rh, pi_usb_mini_port_y - o, pi_pcb_zheight - rh])
    cube([pi_usb_mini_port_width + r, pi_usb_mini_port_height + o, pi_usb_mini_port_zheight + r]);
  translate([pi_audio_x - rh, pi_audio_y - o, pi_pcb_zheight - rh])
    cube([pi_audio_width + r, pi_audio_height + o, pi_audio_zheight + r]);
  translate([pi_hdmi_port_x - rh, pi_hdmi_port_y - o, pi_pcb_zheight - rh])
    cube([pi_hdmi_port_width + r, pi_hdmi_port_height + o, pi_audio_zheight + r]);
}

module pi_beam() {
  cube([bmo_body_width - (bmo_case_thickness * 2), inset_hole_width, inset_hole_width]);
}

// dummies
// translate([
//   bmo_screen_x,
//   bmo_screen_y - tft_pcb_height,
//   bmo_screen_z
// ]) tft_dummy();

// translate([
//   bmo_body_width - pi_pcb_width - bmo_case_thickness,
//   bmo_body_height - bmo_case_thickness,
//   pi_hardware_zheight + bmo_body_radius
// ]) rotate([180, 0, 0]) {
//   pi_dummy();
// }

// body
union() {
  difference() {
    color([0, 1, 0, 0.75]) body(size = [bmo_body_width, bmo_body_height, bmo_body_zheight]);
    //translate([0, -40, 0]) cube(size = [bmo_body_width, bmo_body_height, bmo_body_zheight]);
    //translate([-20, bmo_body_height - 5, 0]) cube(size = [bmo_body_width, bmo_body_height, bmo_body_zheight]);
    cube(size = [bmo_body_width, bmo_body_height, bmo_body_radius]);
    translate([bmo_screen_punch_x, bmo_screen_punch_y, bmo_body_zheight - bmo_case_thickness - .1 ]) screen_punch();
  
    // pi punch holes
    translate([
      bmo_body_width - pi_pcb_width - bmo_case_thickness,
      bmo_body_height - bmo_case_thickness,
      pi_hardware_zheight + bmo_body_radius
    ])
      rotate([180, 0, 0])
        punch_pi_holes();
  }
  translate([bmo_screen_punch_x, bmo_screen_punch_y, bmo_body_zheight - bmo_screen_punch_radius]) screen_punch_rims();
  translate([
    bmo_case_thickness,
    bmo_body_height - bmo_case_thickness - pi_pcb_height,
    pi_hardware_zheight + bmo_body_radius + inset_hole_length
  ]) pi_beam();

  // tft hole mounts
  translate([
    bmo_screen_x + tft_screen_hole_offsets[2][0],
    bmo_screen_y - tft_pcb_height + tft_screen_hole_offsets[2][1],
    bmo_body_zheight - inset_hole_length
  ]) inset_hole();

  translate([
    bmo_screen_x + tft_screen_hole_offsets[1][0],
    bmo_screen_y - tft_pcb_height + tft_screen_hole_offsets[1][1],
    bmo_body_zheight - inset_hole_length
  ]) inset_hole();

  translate([
    bmo_screen_x + tft_screen_hole_offsets[0][0],
    bmo_screen_y - tft_pcb_height + tft_screen_hole_offsets[0][1],
    bmo_body_zheight - inset_hole_length
  ]) inset_hole();

  // pi pcb mount holes
  translate([
    bmo_body_width - pi_pcb_width - bmo_case_thickness + pi_pcb_hole_positions[0][0],
    bmo_body_height - bmo_case_thickness - pi_pcb_hole_positions[0][1],
    pi_hardware_zheight + bmo_body_radius
  ]) {
    inset_hole(h = 10);
  }
  translate([
    bmo_body_width - pi_pcb_width - bmo_case_thickness + pi_pcb_hole_positions[0][0] - (inset_hole_width / 2),
    bmo_body_height - bmo_case_thickness - pi_pcb_hole_positions[0][1],
    pi_hardware_zheight + bmo_body_radius
  ]) cube([inset_hole_width, inset_hole_width, 10]);

  translate([
    bmo_body_width - pi_pcb_width - bmo_case_thickness + pi_pcb_hole_positions[1][0],
    bmo_body_height - bmo_case_thickness - pi_pcb_hole_positions[1][1],
    pi_hardware_zheight + bmo_body_radius
  ]) {
    inset_hole();
  }

  translate([
    bmo_body_width - pi_pcb_width - bmo_case_thickness + pi_pcb_hole_positions[2][0],
    bmo_body_height - bmo_case_thickness - pi_pcb_hole_positions[2][1],
    pi_hardware_zheight + bmo_body_radius
  ]) {
    inset_hole();
  }

  translate([
    bmo_body_width - pi_pcb_width - bmo_case_thickness + pi_pcb_hole_positions[3][0],
    bmo_body_height - bmo_case_thickness - pi_pcb_hole_positions[3][1],
    pi_hardware_zheight + bmo_body_radius
  ]) {
    inset_hole(h = 10);
  }
  translate([
    bmo_body_width - pi_pcb_width - bmo_case_thickness + pi_pcb_hole_positions[3][0] - (inset_hole_width / 2),
    bmo_body_height - bmo_case_thickness - pi_pcb_hole_positions[3][1],
    pi_hardware_zheight + bmo_body_radius
  ]) cube([inset_hole_width, inset_hole_width, 10]);
}

// body bottom
difference() {
  color([0, 0, 1, 0.5]) body(size = [bmo_body_width, bmo_body_height, bmo_body_zheight]);
  translate([0, 0, bmo_body_radius])
    cube(size = [bmo_body_width, bmo_body_height, bmo_body_zheight]);
  // pi punch holes
  translate([
      bmo_body_width - pi_pcb_width - bmo_case_thickness,
      bmo_body_height - bmo_case_thickness,
      pi_hardware_zheight + bmo_body_radius
    ])
      rotate([180, 0, 0])
        punch_pi_holes();
}
