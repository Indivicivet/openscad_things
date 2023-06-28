handle_width = 36;
thin_handle_len = 6;
pole_width = 30;
block_y = 35;
block_z = 61;
block_x = 164;
handle_angle = 50;
handle_centerpoint = [0, -10, 40];

color(alpha=0.5)
rotate([90, 0, 0])
cylinder(h=1000, d=pole_width, center=true)
	;

color(alpha=0.5)
translate(handle_centerpoint)
rotate([handle_angle, 0, 0])
union() {
	cylinder(h=100, d=handle_width)
		;
	translate([0, 0, thin_handle_len])
	cylinder(h=100, d=handle_width + 4)
		;
}

color(alpha=0.5)
difference() {
	translate([0, 0, 20])
	intersection() {
		cube([block_x, block_y, block_z], center=true)
			;
		cube([pole_width * 2, 999, 999], center=true)
			;
	}
	cube([pole_width + 2, 999, pole_width + 2], center=true)
		;
	translate([0, 0, 30])
	rotate([90 + handle_angle, 0, 0])
	translate([-99, 10, -99])
	cube([999, 999, 999])
		;
	translate([0, 0, 30])
	rotate([270 + handle_angle, 0, 0])
	translate([-99, 10, -0.5 * (pole_width + 2)])
	cube([999, 999, pole_width + 2])
		;
	translate(handle_centerpoint)
	rotate([handle_angle, 0, 0])
	cylinder(h=999, d=7, center=true)
		;
}
