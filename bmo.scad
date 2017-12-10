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

// origin is bottom left of pcb. the bottom has the tag,
// hanging down and the camera is pointed toward you
camera_pcb_width = 24;
camera_pcb_height = 25;
camera_pcb_zheight = 1.6;
camera_lens_width = 7.9;
camera_lens_height = 7.9;
camera_lens_zheight = 6.1;
camera_pcb_holes = [
  [1.6, camera_pcb_height - 1.6],
  [1.6, 8.5],
  [camera_pcb_width - 1.6, 8.5],
  [camera_pcb_width - 1.6, camera_pcb_height - 1.6]
];


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
inset_hole_width = 7.0;
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
  // tan(82) = (h / 4 * 3)
  // tan(82) = (h / 4 * 3) / x
  // tan(82)x = (h / 4 * 3)
  // x = (h / 4 * 3) / tan(82)

  hole_length = h / 4 * 3;
  eight_degree_taper = hole_length / tan(82);
  hole_punch_width = 2;
  rad1 = hole_punch_width;
  rad2 = abs(hole_punch_width - eight_degree_taper);

  color([0, 0, 1, 1]) difference() {
    union() {
      cylinder(r1=r, r2=r, h=h, $fn = 100);
      children();
    }
    translate([0, 0, 0]) {
      cylinder(r1=rad1, r2=rad2, h=h, $fn = 30);
    }
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

module camera_dummy() {
  difference() {
    union() {
      cube([camera_pcb_width, camera_pcb_height, camera_pcb_zheight]);
      translate([
        (camera_pcb_width / 2) - (camera_lens_width / 2),
        (camera_pcb_height / 2) - (camera_lens_height / 2),
        camera_pcb_zheight
      ]) cube([camera_lens_width, camera_lens_height, camera_lens_zheight]);
    }
    for (hole = camera_pcb_holes) {
      translate([hole[0], hole[1], 0]) cylinder($fn=20, r1 = 1.0, r2 = 1.0, h = camera_pcb_zheight);
    }
  }
}

module positioned_camera_dummy() {
  translate([
    (bmo_body_width / 2) + (camera_pcb_height / 2),
    bmo_body_height - bmo_case_thickness - (pi_pcb_height / 2),
    camera_pcb_zheight + camera_lens_zheight
  ]) {
    rotate([0, 180, 90]) camera_dummy();
  }
}

module positioned_camera_inset_holes() {
  translate([
    (bmo_body_width / 2) + (camera_pcb_height / 2),
    bmo_body_height - bmo_case_thickness - (pi_pcb_height / 2),
    camera_lens_zheight
  ]) {
    rotate([0, 180, 90]) {
      for (hole = camera_pcb_holes) {
        translate([hole[0], hole[1], 0]) inset_hole(h = camera_lens_zheight - 0.1);
      }
    }
  }
}

module corner_inset_hole(length = bmo_body_zheight - bmo_case_thickness * 3) {
  inset_hole(h = length, flip = true) {
    difference() {
      union() {
        translate([
          -inset_hole_width / 2,
          -inset_hole_width / 2,
          0
        ]) cube([inset_hole_width / 2, inset_hole_width / 2, length]);
        translate([-inset_hole_width / 2, 0, 0]) cube([inset_hole_width / 2, inset_hole_width, length]);
        translate([0, -inset_hole_width / 2, 0]) cube([inset_hole_width, inset_hole_width / 2, length]);
      }
      translate([inset_hole_width, 0, 0]) cylinder($fn = 100, r1=inset_hole_width / 2, r2=inset_hole_width / 2, h=length);
      translate([0, inset_hole_width, 0]) cylinder($fn = 100, r1=inset_hole_width / 2, r2=inset_hole_width / 2, h=length);
    }
  }
}


// not meant to be printed, just for dreaming
module dummies() {
  // dummies
  translate([
    bmo_screen_x,
    bmo_screen_y - tft_pcb_height,
    bmo_screen_z
  ]) tft_dummy();

  translate([
    bmo_body_width - pi_pcb_width - bmo_case_thickness,
    bmo_body_height - bmo_case_thickness,
    pi_hardware_zheight + bmo_body_radius
  ]) rotate([180, 0, 0]) {
    pi_dummy();
  }

  positioned_camera_dummy();
}

//dummies();

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

    //cube(size = [bmo_body_width, bmo_body_height / 2, bmo_body_zheight]);
  }

  translate([bmo_screen_punch_x, bmo_screen_punch_y, bmo_body_zheight - bmo_screen_punch_radius]) screen_punch_rims();

  // pi beam
  translate([
    bmo_case_thickness,
    bmo_body_height - bmo_case_thickness - pi_pcb_height - inset_hole_width + pi_pcb_hole_positions[0][1] + (inset_hole_width / 2),
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
    inset_hole(h = 10) {
      translate([-inset_hole_width / 2, 0, 0]) cube([inset_hole_width, inset_hole_width - bmo_case_thickness, 10]);
    }
  }

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
    inset_hole(h = 10) {
      translate([-inset_hole_width / 2, 0, 0]) cube([inset_hole_width, inset_hole_width - bmo_case_thickness, 10]);
    }
  }

  translate([
    bmo_case_thickness + inset_hole_width / 2,
    bmo_case_thickness + inset_hole_width / 2,
    bmo_case_thickness * 2
  ]) {
    corner_inset_hole();
  }

  translate([
    bmo_body_width - (bmo_case_thickness + inset_hole_width / 2),
    bmo_case_thickness + inset_hole_width / 2,
    bmo_case_thickness * 2
  ]) rotate([0, 0, 90]) {
    corner_inset_hole();
  }
}

// body bottom
// union() {
//   difference() {
//     color([0, 0, 1, 0.75]) body(size = [bmo_body_width, bmo_body_height, bmo_body_zheight]);
//     translate([0, 0, bmo_body_radius])
//       cube(size = [bmo_body_width, bmo_body_height, bmo_body_zheight]);
//     // pi punch holes
//     translate([
//         bmo_body_width - pi_pcb_width - bmo_case_thickness,
//         bmo_body_height - bmo_case_thickness,
//         pi_hardware_zheight + bmo_body_radius
//       ])
//         rotate([180, 0, 0])
//           punch_pi_holes();
//     positioned_camera_dummy();
//   }
//   color([1, 0, 0.5]) positioned_camera_inset_holes();
// }
