; HEADER_BLOCK_START
; BambuStudio 02.01.01.52
; model printing time: 7m 54s; total estimated time: 14m 18s
; total layer number: 50
; total filament length [mm] : 264.76
; total filament volume [cm^3] : 636.81
; total filament weight [g] : 0.81
; filament_density: 1.27
; filament_diameter: 1.75
; max_z_height: 10.00
; filament: 1
; HEADER_BLOCK_END

; CONFIG_BLOCK_START
; accel_to_decel_enable = 0
; accel_to_decel_factor = 50%
; activate_air_filtration = 0
; additional_cooling_fan_speed = 0
; apply_scarf_seam_on_circles = 1
; auxiliary_fan = 0
; bed_custom_model = 
; bed_custom_texture = 
; bed_exclude_area = 
; bed_temperature_formula = by_first_filament
; before_layer_change_gcode = 
; best_object_pos = 0.7,0.5
; bottom_color_penetration_layers = 3
; bottom_shell_layers = 3
; bottom_shell_thickness = 0
; bottom_surface_pattern = monotonic
; bridge_angle = 0
; bridge_flow = 1
; bridge_no_support = 0
; bridge_speed = 40
; brim_object_gap = 0.1
; brim_type = auto_brim
; brim_width = 5
; chamber_temperatures = 0
; change_filament_gcode = ;===== A1mini 20250206 =====\nG392 S0\nM1007 S0\nM620 S[next_extruder]A\nM204 S9000\nG1 Z{max_layer_z + 3.0} F1200\n\nM400\nM106 P1 S0\nM106 P2 S0\n{if old_filament_temp > 142 && next_extruder < 255}\nM104 S[old_filament_temp]\n{endif}\n\nG1 X180 F18000\n\n{if long_retractions_when_cut[previous_extruder]}\nM620.11 S1 I[previous_extruder] E-{retraction_distances_when_cut[previous_extruder]} F1200\n{else}\nM620.11 S0\n{endif}\nM400\n\nM620.1 E F[old_filament_e_feedrate] T{nozzle_temperature_range_high[previous_extruder]}\nM620.10 A0 F[old_filament_e_feedrate]\nT[next_extruder]\nM620.1 E F[new_filament_e_feedrate] T{nozzle_temperature_range_high[next_extruder]}\nM620.10 A1 F[new_filament_e_feedrate] L[flush_length] H[nozzle_diameter] T[nozzle_temperature_range_high]\n\nG1 Y90 F9000\n\n{if next_extruder < 255}\n\n{if long_retractions_when_cut[previous_extruder]}\nM620.11 S1 I[previous_extruder] E{retraction_distances_when_cut[previous_extruder]} F{old_filament_e_feedrate}\nM628 S1\nG92 E0\nG1 E{retraction_distances_when_cut[previous_extruder]} F[old_filament_e_feedrate]\nM400\nM629 S1\n{else}\nM620.11 S0\n{endif}\n\nM400\nG92 E0\nM628 S0\n\n{if flush_length_1 > 1}\n; FLUSH_START\n; always use highest temperature to flush\nM400\nM1002 set_filament_type:UNKNOWN\nM109 S[nozzle_temperature_range_high]\nM106 P1 S60\n{if flush_length_1 > 23.7}\nG1 E23.7 F{old_filament_e_feedrate} ; do not need pulsatile flushing for start part\nG1 E{(flush_length_1 - 23.7) * 0.02} F50\nG1 E{(flush_length_1 - 23.7) * 0.23} F{old_filament_e_feedrate}\nG1 E{(flush_length_1 - 23.7) * 0.02} F50\nG1 E{(flush_length_1 - 23.7) * 0.23} F{new_filament_e_feedrate}\nG1 E{(flush_length_1 - 23.7) * 0.02} F50\nG1 E{(flush_length_1 - 23.7) * 0.23} F{new_filament_e_feedrate}\nG1 E{(flush_length_1 - 23.7) * 0.02} F50\nG1 E{(flush_length_1 - 23.7) * 0.23} F{new_filament_e_feedrate}\n{else}\nG1 E{flush_length_1} F{old_filament_e_feedrate}\n{endif}\n; FLUSH_END\nG1 E-[old_retract_length_toolchange] F1800\nG1 E[old_retract_length_toolchange] F300\nM400\nM1002 set_filament_type:{filament_type[next_extruder]}\n{endif}\n\n{if flush_length_1 > 45 && flush_length_2 > 1}\n; WIPE\nM400\nM106 P1 S178\nM400 S3\nG1 X-3.5 F18000\nG1 X-13.5 F3000\nG1 X-3.5 F18000\nG1 X-13.5 F3000\nG1 X-3.5 F18000\nG1 X-13.5 F3000\nM400\nM106 P1 S0\n{endif}\n\n{if flush_length_2 > 1}\nM106 P1 S60\n; FLUSH_START\nG1 E{flush_length_2 * 0.18} F{new_filament_e_feedrate}\nG1 E{flush_length_2 * 0.02} F50\nG1 E{flush_length_2 * 0.18} F{new_filament_e_feedrate}\nG1 E{flush_length_2 * 0.02} F50\nG1 E{flush_length_2 * 0.18} F{new_filament_e_feedrate}\nG1 E{flush_length_2 * 0.02} F50\nG1 E{flush_length_2 * 0.18} F{new_filament_e_feedrate}\nG1 E{flush_length_2 * 0.02} F50\nG1 E{flush_length_2 * 0.18} F{new_filament_e_feedrate}\nG1 E{flush_length_2 * 0.02} F50\n; FLUSH_END\nG1 E-[new_retract_length_toolchange] F1800\nG1 E[new_retract_length_toolchange] F300\n{endif}\n\n{if flush_length_2 > 45 && flush_length_3 > 1}\n; WIPE\nM400\nM106 P1 S178\nM400 S3\nG1 X-3.5 F18000\nG1 X-13.5 F3000\nG1 X-3.5 F18000\nG1 X-13.5 F3000\nG1 X-3.5 F18000\nG1 X-13.5 F3000\nM400\nM106 P1 S0\n{endif}\n\n{if flush_length_3 > 1}\nM106 P1 S60\n; FLUSH_START\nG1 E{flush_length_3 * 0.18} F{new_filament_e_feedrate}\nG1 E{flush_length_3 * 0.02} F50\nG1 E{flush_length_3 * 0.18} F{new_filament_e_feedrate}\nG1 E{flush_length_3 * 0.02} F50\nG1 E{flush_length_3 * 0.18} F{new_filament_e_feedrate}\nG1 E{flush_length_3 * 0.02} F50\nG1 E{flush_length_3 * 0.18} F{new_filament_e_feedrate}\nG1 E{flush_length_3 * 0.02} F50\nG1 E{flush_length_3 * 0.18} F{new_filament_e_feedrate}\nG1 E{flush_length_3 * 0.02} F50\n; FLUSH_END\nG1 E-[new_retract_length_toolchange] F1800\nG1 E[new_retract_length_toolchange] F300\n{endif}\n\n{if flush_length_3 > 45 && flush_length_4 > 1}\n; WIPE\nM400\nM106 P1 S178\nM400 S3\nG1 X-3.5 F18000\nG1 X-13.5 F3000\nG1 X-3.5 F18000\nG1 X-13.5 F3000\nG1 X-3.5 F18000\nG1 X-13.5 F3000\nM400\nM106 P1 S0\n{endif}\n\n{if flush_length_4 > 1}\nM106 P1 S60\n; FLUSH_START\nG1 E{flush_length_4 * 0.18} F{new_filament_e_feedrate}\nG1 E{flush_length_4 * 0.02} F50\nG1 E{flush_length_4 * 0.18} F{new_filament_e_feedrate}\nG1 E{flush_length_4 * 0.02} F50\nG1 E{flush_length_4 * 0.18} F{new_filament_e_feedrate}\nG1 E{flush_length_4 * 0.02} F50\nG1 E{flush_length_4 * 0.18} F{new_filament_e_feedrate}\nG1 E{flush_length_4 * 0.02} F50\nG1 E{flush_length_4 * 0.18} F{new_filament_e_feedrate}\nG1 E{flush_length_4 * 0.02} F50\n; FLUSH_END\n{endif}\n\nM629\n\nM400\nM106 P1 S60\nM109 S[new_filament_temp]\nG1 E5 F{new_filament_e_feedrate} ;Compensate for filament spillage during waiting temperature\nM400\nG92 E0\nG1 E-[new_retract_length_toolchange] F1800\nM400\nM106 P1 S178\nM400 S3\nG1 X-3.5 F18000\nG1 X-13.5 F3000\nG1 X-3.5 F18000\nG1 X-13.5 F3000\nG1 X-3.5 F18000\nG1 X-13.5 F3000\nG1 X-3.5 F18000\nG1 X-13.5 F3000\nM400\nG1 Z{max_layer_z + 3.0} F3000\nM106 P1 S0\n{if layer_z <= (initial_layer_print_height + 0.001)}\nM204 S[initial_layer_acceleration]\n{else}\nM204 S[default_acceleration]\n{endif}\n{else}\nG1 X[x_after_toolchange] Y[y_after_toolchange] Z[z_after_toolchange] F12000\n{endif}\n\nM622.1 S0\nM9833 F{outer_wall_volumetric_speed/2.4} A0.3 ; cali dynamic extrusion compensation\nM1002 judge_flag filament_need_cali_flag\nM622 J1\n  G92 E0\n  G1 E-[new_retract_length_toolchange] F1800\n  M400\n  \n  M106 P1 S178\n  M400 S7\n  G1 X0 F18000\n  G1 X-13.5 F3000\n  G1 X0 F18000 ;wipe and shake\n  G1 X-13.5 F3000\n  G1 X0 F12000 ;wipe and shake\n  G1 X-13.5 F3000\n  G1 X0 F12000 ;wipe and shake\n  M400\n  M106 P1 S0 \nM623\n\nM621 S[next_extruder]A\nG392 S0\n\nM1007 S1\n
; circle_compensation_manual_offset = 0
; circle_compensation_speed = 200
; close_fan_the_first_x_layers = 3
; complete_print_exhaust_fan_speed = 70
; cool_plate_temp = 0
; cool_plate_temp_initial_layer = 0
; counter_coef_1 = 0
; counter_coef_2 = 0.008
; counter_coef_3 = -0.041
; counter_limit_max = 0.033
; counter_limit_min = -0.035
; curr_bed_type = Textured PEI Plate
; default_acceleration = 5000
; default_filament_colour = ""
; default_filament_profile = "Bambu PLA Basic @BBL A1M"
; default_jerk = 0
; default_nozzle_volume_type = Standard
; default_print_profile = 0.20mm Standard @BBL A1M
; deretraction_speed = 30
; detect_floating_vertical_shell = 1
; detect_narrow_internal_solid_infill = 1
; detect_overhang_wall = 1
; detect_thin_wall = 1
; diameter_limit = 50
; different_settings_to_system = bridge_speed;default_acceleration;detect_thin_wall;enable_prime_tower;enable_support;gap_infill_speed;initial_layer_acceleration;initial_layer_speed;inner_wall_acceleration;inner_wall_speed;internal_solid_infill_line_width;internal_solid_infill_speed;outer_wall_acceleration;overhang_1_4_speed;overhang_2_4_speed;overhang_4_4_speed;overhang_totally_speed;prime_tower_infill_gap;prime_tower_rib_wall;skeleton_infill_density;skin_infill_density;sparse_infill_acceleration;sparse_infill_density;sparse_infill_pattern;sparse_infill_speed;support_line_width;support_speed;top_shell_layers;top_surface_speed;travel_acceleration;wall_generator;wall_loops;filament_start_gcode;machine_start_gcode
; draft_shield = disabled
; during_print_exhaust_fan_speed = 70
; elefant_foot_compensation = 0
; enable_arc_fitting = 1
; enable_circle_compensation = 0
; enable_long_retraction_when_cut = 2
; enable_overhang_bridge_fan = 1
; enable_overhang_speed = 1
; enable_pre_heating = 0
; enable_pressure_advance = 0
; enable_prime_tower = 0
; enable_support = 1
; enforce_support_layers = 0
; eng_plate_temp = 70
; eng_plate_temp_initial_layer = 70
; ensure_vertical_shell_thickness = enabled
; exclude_object = 1
; extruder_ams_count = 1#0|4#0;1#0|4#0
; extruder_clearance_dist_to_rod = 56.5
; extruder_clearance_height_to_lid = 180
; extruder_clearance_height_to_rod = 25
; extruder_clearance_max_radius = 73
; extruder_colour = #018001
; extruder_offset = 0x0
; extruder_printable_area = 
; extruder_type = Direct Drive
; extruder_variant_list = "Direct Drive Standard"
; fan_cooling_layer_time = 30
; fan_max_speed = 90
; fan_min_speed = 40
; filament_adhesiveness_category = 300
; filament_change_length = 10
; filament_colour = #FFFF80
; filament_cost = 30
; filament_density = 1.27
; filament_diameter = 1.75
; filament_end_gcode = "; filament end gcode \n\n"
; filament_extruder_variant = "Direct Drive Standard"
; filament_flow_ratio = 0.95
; filament_flush_temp = 0
; filament_flush_volumetric_speed = 0
; filament_ids = GFG99
; filament_is_support = 0
; filament_map = 1
; filament_map_mode = Auto For Flush
; filament_max_volumetric_speed = 8
; filament_minimal_purge_on_wipe_tower = 15
; filament_notes = 
; filament_pre_cooling_temperature = 0
; filament_prime_volume = 45
; filament_printable = 3
; filament_ramming_travel_time = 0
; filament_ramming_volumetric_speed = -1
; filament_scarf_gap = 0%
; filament_scarf_height = 10%
; filament_scarf_length = 10
; filament_scarf_seam_type = none
; filament_self_index = 1
; filament_settings_id = "Generic PETG Flow Rate Calibrated"
; filament_shrink = 100%
; filament_soluble = 0
; filament_start_gcode = "; filament start gcode\n; Add a marker at the start of each layer\nM73 P{((layer_num+1)/total_layer_count)*100}\n{if (bed_temperature[current_extruder] >80)||(bed_temperature_initial_layer[current_extruder] >80)}M106 P3 S255\n{elsif (bed_temperature[current_extruder] >60)||(bed_temperature_initial_layer[current_extruder] >60)}M106 P3 S180\n{endif}\n\n{if activate_air_filtration[current_extruder] && support_air_filtration}\nM106 P3 S{during_print_exhaust_fan_speed_num[current_extruder]} \n{endif}"
; filament_type = PETG
; filament_vendor = Generic
; filename_format = {input_filename_base}_{filament_type[0]}_{print_time}.gcode
; filter_out_gap_fill = 0
; first_layer_print_sequence = 0
; flush_into_infill = 0
; flush_into_objects = 0
; flush_into_support = 1
; flush_multiplier = 1
; flush_volumes_matrix = 0
; flush_volumes_vector = 140,140
; full_fan_speed_layer = 0
; fuzzy_skin = none
; fuzzy_skin_point_distance = 0.8
; fuzzy_skin_thickness = 0.3
; gap_infill_speed = 150
; gcode_add_line_number = 0
; gcode_flavor = marlin
; grab_length = 17.4
; has_scarf_joint_seam = 1
; head_wrap_detect_zone = 156x152,180x152,180x180,156x180
; hole_coef_1 = 0
; hole_coef_2 = -0.008
; hole_coef_3 = 0.23415
; hole_limit_max = 0.22
; hole_limit_min = 0.088
; host_type = octoprint
; hot_plate_temp = 70
; hot_plate_temp_initial_layer = 70
; hotend_cooling_rate = 2
; hotend_heating_rate = 2
; impact_strength_z = 10
; independent_support_layer_height = 1
; infill_combination = 0
; infill_direction = 45
; infill_jerk = 9
; infill_lock_depth = 1
; infill_rotate_step = 0
; infill_shift_step = 0.4
; infill_wall_overlap = 15%
; inherits_group = "0.20mm Strength @BBL A1M";"Generic PETG @BBL A1M";"Bambu Lab A1 mini 0.4 nozzle"
; initial_layer_acceleration = 300
; initial_layer_flow_ratio = 1
; initial_layer_infill_speed = 105
; initial_layer_jerk = 9
; initial_layer_line_width = 0.5
; initial_layer_print_height = 0.2
; initial_layer_speed = 30
; initial_layer_travel_acceleration = 6000
; inner_wall_acceleration = 3000
; inner_wall_jerk = 9
; inner_wall_line_width = 0.45
; inner_wall_speed = 100
; interface_shells = 0
; interlocking_beam = 0
; interlocking_beam_layer_count = 2
; interlocking_beam_width = 0.8
; interlocking_boundary_avoidance = 2
; interlocking_depth = 2
; interlocking_orientation = 22.5
; internal_bridge_support_thickness = 0.8
; internal_solid_infill_line_width = 0.45
; internal_solid_infill_pattern = zig-zag
; internal_solid_infill_speed = 140
; ironing_direction = 45
; ironing_flow = 10%
; ironing_inset = 0.21
; ironing_pattern = zig-zag
; ironing_spacing = 0.15
; ironing_speed = 30
; ironing_type = no ironing
; is_infill_first = 0
; layer_change_gcode = ; layer num/total_layer_count: {layer_num+1}/[total_layer_count]\n; update layer progress\nM73 L{layer_num+1}\nM991 S0 P{layer_num} ;notify layer change\n
; layer_height = 0.2
; line_width = 0.42
; long_retractions_when_cut = 0
; long_retractions_when_ec = 0
; machine_end_gcode = ;===== date: 20231229 =====================\n;turn off nozzle clog detect\nG392 S0\n\nM400 ; wait for buffer to clear\nG92 E0 ; zero the extruder\nG1 E-0.8 F1800 ; retract\nG1 Z{max_layer_z + 0.5} F900 ; lower z a little\nG1 X0 Y{first_layer_center_no_wipe_tower[1]} F18000 ; move to safe pos\nG1 X-13.0 F3000 ; move to safe pos\n{if !spiral_mode && print_sequence != "by object"}\nM1002 judge_flag timelapse_record_flag\nM622 J1\nM400 P100\nM971 S11 C11 O0\nM400 P100\nM971 S11 C11 O0\nM400 P100\nM971 S11 C11 O0\nM400 P100\nM971 S11 C11 O0\nM400 P100\nM971 S11 C11 O0\nM400 P100\nM971 S11 C11 O0\nM400 P100\nM971 S11 C11 O0\nM400 P100\nM971 S11 C11 O0\nM400 P100\nM971 S11 C11 O0\nM400 P100\nM971 S11 C11 O0\nM400 P100\nM971 S11 C11 O0\nM400 P100\nM971 S11 C11 O0\nM400 P100\nM971 S11 C11 O0\nM400 P100\nM971 S11 C11 O0\nM400 P100\nM971 S11 C11 O0\nM400 P100\nM971 S11 C11 O0\nM400 P100\nM971 S11 C11 O0\nM400 P100\nM971 S11 C11 O0\nM400 P100\nM971 S11 C11 O0\nM400 P100\nM971 S11 C11 O0\nM400 P100\nM971 S11 C11 O0\nM400 P100\nM971 S11 C11 O0\nM400 P100\nM971 S11 C11 O0\nM400 P100\nM971 S11 C11 O0\nM400 P100\nM971 S11 C11 O0\nM400 P100\nM971 S11 C11 O0\nM400 P100\nM971 S11 C11 O0\nM400 P100\nM971 S11 C11 O0\nM400 P100\nM971 S11 C11 O0\nM400 P100\nM971 S11 C11 O0\nM991 S0 P-1 ;end timelapse at safe pos\nM623\n{endif}\n\nM140 S0 ; turn off bed\nM106 S0 ; turn off fan\nM106 P2 S0 ; turn off remote part cooling fan\nM106 P3 S0 ; turn off chamber cooling fan\n\n;G1 X27 F15000 ; wipe\n\n; pull back filament to AMS\nM620 S255\nG1 X181 F12000\nT255\nG1 X0 F18000\nG1 X-13.0 F3000\nG1 X0 F18000 ; wipe\nM621 S255\n\nM104 S0 ; turn off hotend\n\nM400 ; wait all motion done\nM17 S\nM17 Z0.4 ; lower z motor current to reduce impact if there is something in the bottom\n{if (max_layer_z + 100.0) < 180}\n    G1 Z{max_layer_z + 100.0} F600\n    G1 Z{max_layer_z +98.0}\n{else}\n    G1 Z180 F600\n    G1 Z180\n{endif}\nM400 P100\nM17 R ; restore z current\n\nG90\nG1 X-13 Y180 F3600\n\nG91\nG1 Z-1 F600\nG90\nM83\n\nM220 S100  ; Reset feedrate magnitude\nM201.2 K1.0 ; Reset acc magnitude\nM73.2   R1.0 ;Reset left time magnitude\nM1002 set_gcode_claim_speed_level : 0\n\n;=====printer finish  sound=========\nM17\nM400 S1\nM1006 S1\nM1006 A0 B20 L100 C37 D20 M100 E42 F20 N100\nM1006 A0 B10 L100 C44 D10 M100 E44 F10 N100\nM1006 A0 B10 L100 C46 D10 M100 E46 F10 N100\nM1006 A44 B20 L100 C39 D20 M100 E48 F20 N100\nM1006 A0 B10 L100 C44 D10 M100 E44 F10 N100\nM1006 A0 B10 L100 C0 D10 M100 E0 F10 N100\nM1006 A0 B10 L100 C39 D10 M100 E39 F10 N100\nM1006 A0 B10 L100 C0 D10 M100 E0 F10 N100\nM1006 A0 B10 L100 C44 D10 M100 E44 F10 N100\nM1006 A0 B10 L100 C0 D10 M100 E0 F10 N100\nM1006 A0 B10 L100 C39 D10 M100 E39 F10 N100\nM1006 A0 B10 L100 C0 D10 M100 E0 F10 N100\nM1006 A44 B10 L100 C0 D10 M100 E48 F10 N100\nM1006 A0 B10 L100 C0 D10 M100 E0 F10 N100\nM1006 A44 B20 L100 C41 D20 M100 E49 F20 N100\nM1006 A0 B20 L100 C0 D20 M100 E0 F20 N100\nM1006 A0 B20 L100 C37 D20 M100 E37 F20 N100\nM1006 W\n;=====printer finish  sound=========\nM400 S1\nM18 X Y Z\n
; machine_load_filament_time = 28
; machine_max_acceleration_e = 5000,5000
; machine_max_acceleration_extruding = 20000,20000
; machine_max_acceleration_retracting = 5000,5000
; machine_max_acceleration_travel = 9000,9000
; machine_max_acceleration_x = 20000,20000
; machine_max_acceleration_y = 20000,20000
; machine_max_acceleration_z = 1500,1500
; machine_max_jerk_e = 3,3
; machine_max_jerk_x = 9,9
; machine_max_jerk_y = 9,9
; machine_max_jerk_z = 5,5
; machine_max_speed_e = 30,30
; machine_max_speed_x = 500,200
; machine_max_speed_y = 500,200
; machine_max_speed_z = 30,30
; machine_min_extruding_rate = 0,0
; machine_min_travel_rate = 0,0
; machine_pause_gcode = M400 U1
; machine_start_gcode = ;===== machine: A1 mini =========================\n;===== date: 20240620 =====================\n\n;===== start to heat heatbead&hotend==========\nM1002 gcode_claim_action : 2\nM1002 set_filament_type:{filament_type[initial_no_support_extruder]}\nM104 S170\nM140 S[bed_temperature_initial_layer_single]\nG392 S0 ;turn off clog detect\nM9833.2\n;=====start printer sound ===================\nM17\nM400 S1\nM1006 S1\nM1006 A0 B0 L100 C37 D10 M100 E37 F10 N100\nM1006 A0 B0 L100 C41 D10 M100 E41 F10 N100\nM1006 A0 B0 L100 C44 D10 M100 E44 F10 N100\nM1006 A0 B10 L100 C0 D10 M100 E0 F10 N100\nM1006 A43 B10 L100 C39 D10 M100 E46 F10 N100\nM1006 A0 B0 L100 C0 D10 M100 E0 F10 N100\nM1006 A0 B0 L100 C39 D10 M100 E43 F10 N100\nM1006 A0 B0 L100 C0 D10 M100 E0 F10 N100\nM1006 A0 B0 L100 C41 D10 M100 E41 F10 N100\nM1006 A0 B0 L100 C44 D10 M100 E44 F10 N100\nM1006 A0 B0 L100 C49 D10 M100 E49 F10 N100\nM1006 A0 B0 L100 C0 D10 M100 E0 F10 N100\nM1006 A44 B10 L100 C39 D10 M100 E48 F10 N100\nM1006 A0 B0 L100 C0 D10 M100 E0 F10 N100\nM1006 A0 B0 L100 C39 D10 M100 E44 F10 N100\nM1006 A0 B0 L100 C0 D10 M100 E0 F10 N100\nM1006 A43 B10 L100 C39 D10 M100 E46 F10 N100\nM1006 W\nM18\n;=====avoid end stop =================\nG91\nG380 S2 Z30 F1200\nG380 S3 Z-20 F1200\nG1 Z5 F1200\nG90\n\n;===== reset machine status =================\nM204 S6000\n\nM630 S0 P0\nG91\nM17 Z0.3 ; lower the z-motor current\n\nG90\nM17 X0.7 Y0.9 Z0.5 ; reset motor current to default\nM960 S5 P1 ; turn on logo lamp\nG90\nM83\nM220 S100 ;Reset Feedrate\nM221 S100 ;Reset Flowrate\nM73.2   R1.0 ;Reset left time magnitude\n;====== cog noise reduction=================\nM982.2 S1 ; turn on cog noise reduction\n\n;===== prepare print temperature and material ==========\nM400\nM18\nM109 S100 H170\nM104 S170\nM400\nM17\nM400\nG28 X\n\nM211 X0 Y0 Z0 ;turn off soft endstop ; turn off soft endstop to prevent protential logic problem\n\nM975 S1 ; turn on\n\nG1 X0.0 F30000\nG1 X-13.5 F3000\n\nM620 M ;enable remap\nM620 S[initial_no_support_extruder]A   ; switch material if AMS exist\n    G392 S0 ;turn on clog detect\n    M1002 gcode_claim_action : 4\n    M400\n    M1002 set_filament_type:UNKNOWN\n    M109 S[nozzle_temperature_initial_layer]\n    M104 S250\n    M400\n    T[initial_no_support_extruder]\n    G1 X-13.5 F3000\n    M400\n    M620.1 E F{filament_max_volumetric_speed[initial_no_support_extruder]/2.4053*60} T{nozzle_temperature_range_high[initial_no_support_extruder]}\n    M109 S250 ;set nozzle to common flush temp\n    M106 P1 S0\n    G92 E0\n    G1 E50 F200\n    M400\n    M1002 set_filament_type:{filament_type[initial_no_support_extruder]}\n    M104 S{nozzle_temperature_range_high[initial_no_support_extruder]}\n    G92 E0\n    G1 E50 F{filament_max_volumetric_speed[initial_no_support_extruder]/2.4053*60}\n    M400\n    M106 P1 S178\n    G92 E0\n    G1 E5 F{filament_max_volumetric_speed[initial_no_support_extruder]/2.4053*60}\n    M109 S{nozzle_temperature_initial_layer[initial_no_support_extruder]-20} ; drop nozzle temp, make filament shink a bit\n    M104 S{nozzle_temperature_initial_layer[initial_no_support_extruder]-40}\n    G92 E0\n    G1 E-0.5 F300\n\n    G1 X0 F30000\n    G1 X-13.5 F3000\n    G1 X0 F30000 ;wipe and shake\n    G1 X-13.5 F3000\n    G1 X0 F12000 ;wipe and shake\n    G1 X0 F30000\n    G1 X-13.5 F3000\n    M109 S{nozzle_temperature_initial_layer[initial_no_support_extruder]-40}\n    G392 S0 ;turn off clog detect\nM621 S[initial_no_support_extruder]A\n\nM400\nM106 P1 S0\n;===== prepare print temperature and material end =====\n\n\n;===== mech mode fast check============================\nM1002 gcode_claim_action : 3\nG0 X25 Y175 F20000 ; find a soft place to home\n;M104 S0\nG28 Z P0 T300; home z with low precision,permit 300deg temperature\nG29.2 S0 ; turn off ABL\nM104 S170\n\n; build plate detect\nM1002 judge_flag build_plate_detect_flag\nM622 S1\n  G39.4\n  M400\nM623\n\nG1 Z5 F3000\n; G1 X90 Y-1 F30000\n; M400 P200\n; M970.3 Q1 A7 K0 O2\n; M974 Q1 S2 P0\n\n; G1 X90 Y0 Z5 F30000\n; M400 P200\n; M970 Q0 A10 B50 C90 H15 K0 M20 O3\n; M974 Q0 S2 P0\n\n; M975 S1\n; G1 F30000\nG1 X-1 Y10\nG28 X ; re-home XY\n\n;===== wipe nozzle ===============================\nM1002 gcode_claim_action : 14\nM975 S1\n\nM104 S170 ; set temp down to heatbed acceptable\nM106 S255 ; turn on fan (G28 has turn off fan)\nM211 S; push soft endstop status\nM211 X0 Y0 Z0 ;turn off Z axis endstop\n\nM83\nG1 E-1 F500\nG90\nM83\n\nM109 S170\nM104 S140\nG0 X90 Y-4 F30000\nG380 S3 Z-5 F1200\nG1 Z2 F1200\nG1 X91 F10000\nG380 S3 Z-5 F1200\nG1 Z2 F1200\nG1 X92 F10000\nG380 S3 Z-5 F1200\nG1 Z2 F1200\nG1 X93 F10000\nG380 S3 Z-5 F1200\nG1 Z2 F1200\nG1 X94 F10000\nG380 S3 Z-5 F1200\nG1 Z2 F1200\nG1 X95 F10000\nG380 S3 Z-5 F1200\nG1 Z2 F1200\nG1 X96 F10000\nG380 S3 Z-5 F1200\nG1 Z2 F1200\nG1 X97 F10000\nG380 S3 Z-5 F1200\nG1 Z2 F1200\nG1 X98 F10000\nG380 S3 Z-5 F1200\nG1 Z2 F1200\nG1 X99 F10000\nG380 S3 Z-5 F1200\nG1 Z2 F1200\nG1 X99 F10000\nG380 S3 Z-5 F1200\nG1 Z2 F1200\nG1 X99 F10000\nG380 S3 Z-5 F1200\nG1 Z2 F1200\nG1 X99 F10000\nG380 S3 Z-5 F1200\nG1 Z2 F1200\nG1 X99 F10000\nG380 S3 Z-5 F1200\n\nG1 Z5 F30000\n;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;\nG1 X25 Y175 F30000.1 ;Brush material\nG1 Z0.2 F30000.1\nG1 Y185\nG91\nG1 X-30 F30000\nG1 Y-2\nG1 X27\nG1 Y1.5\nG1 X-28\nG1 Y-2\nG1 X30\nG1 Y1.5\nG1 X-30\nG90\nM83\n\nG1 Z5 F3000\nG0 X50 Y175 F20000 ; find a soft place to home\nG28 Z P0 T300; home z with low precision, permit 300deg temperature\nG29.2 S0 ; turn off ABL\n\nG0 X85 Y185 F10000 ;move to exposed steel surface and stop the nozzle\nG0 Z-1.01 F10000\nG91\n\nG2 I1 J0 X2 Y0 F2000.1\nG2 I-0.75 J0 X-1.5\nG2 I1 J0 X2\nG2 I-0.75 J0 X-1.5\nG2 I1 J0 X2\nG2 I-0.75 J0 X-1.5\nG2 I1 J0 X2\nG2 I-0.75 J0 X-1.5\nG2 I1 J0 X2\nG2 I-0.75 J0 X-1.5\nG2 I1 J0 X2\nG2 I-0.75 J0 X-1.5\nG2 I1 J0 X2\nG2 I-0.75 J0 X-1.5\nG2 I1 J0 X2\nG2 I-0.75 J0 X-1.5\nG2 I1 J0 X2\nG2 I-0.75 J0 X-1.5\nG2 I1 J0 X2\nG2 I-0.75 J0 X-1.5\n\nG90\nG1 Z5 F30000\nG1 X25 Y175 F30000.1 ;Brush material\nG1 Z0.2 F30000.1\nG1 Y185\nG91\nG1 X-30 F30000\nG1 Y-2\nG1 X27\nG1 Y1.5\nG1 X-28\nG1 Y-2\nG1 X30\nG1 Y1.5\nG1 X-30\nG90\nM83\n\nG1 Z5\nG0 X55 Y175 F20000 ; find a soft place to home\nG28 Z P0 T300; home z with low precision, permit 300deg temperature\nG29.2 S0 ; turn off ABL\n\nG1 Z10\nG1 X85 Y185\nG1 Z-1.01\nG1 X95\nG1 X90\n\nM211 R; pop softend status\n\nM106 S0 ; turn off fan , too noisy\n;===== wipe nozzle end ================================\n\n\n;===== wait heatbed  ====================\nM1002 gcode_claim_action : 2\nM104 S0\nM190 S[bed_temperature_initial_layer_single];set bed temp\nM109 S140\n\nG1 Z5 F3000\nG29.2 S1\nG1 X10 Y10 F20000\n\n;===== bed leveling ==================================\n;M1002 set_flag g29_before_print_flag=1\nM1002 judge_flag g29_before_print_flag\nM622 J1\n    M1002 gcode_claim_action : 1\n    G29 A1 X{first_layer_print_min[0]} Y{first_layer_print_min[1]} I{first_layer_print_size[0]} J{first_layer_print_size[1]}\n    M400\n    M500 ; save cali data\nM623\n;===== bed leveling end ================================\n\n;===== home after wipe mouth============================\nM1002 judge_flag g29_before_print_flag\nM622 J0\n\n    M1002 gcode_claim_action : 13\n    G28 T145\n\nM623\n\n;===== home after wipe mouth end =======================\n\nM975 S1 ; turn on vibration supression\n;===== nozzle load line ===============================\nM975 S1\nG90\nM83\nT1000\n\nG1 X-13.5 Y0 Z10 F10000\nG1 E1.2 F500\nM400\nM1002 set_filament_type:UNKNOWN\nM109 S{nozzle_temperature[initial_extruder]}\nM400\n\nM412 S1 ;    ===turn on  filament runout detection===\nM400 P10\n\nG392 S0 ;turn on clog detect\n\nM620.3 W1; === turn on filament tangle detection===\nM400 S2\n\nM1002 set_filament_type:{filament_type[initial_no_support_extruder]}\n;M1002 set_flag extrude_cali_flag=1\nM1002 judge_flag extrude_cali_flag\nM622 J1\n    M1002 gcode_claim_action : 8\n    \n    M400\n    M900 K0.0 L1000.0 M1.0\n    G90\n    M83\n    G0 X68 Y-4 F30000\n    G0 Z0.3 F18000 ;Move to start position\n    M400\n    G0 X88 E10  F{outer_wall_volumetric_speed/(24/20)    * 60}\n    G0 X93 E.3742  F{outer_wall_volumetric_speed/(0.3*0.5)/4     * 60}\n    G0 X98 E.3742  F{outer_wall_volumetric_speed/(0.3*0.5)     * 60}\n    G0 X103 E.3742  F{outer_wall_volumetric_speed/(0.3*0.5)/4     * 60}\n    G0 X108 E.3742  F{outer_wall_volumetric_speed/(0.3*0.5)     * 60}\n    G0 X113 E.3742  F{outer_wall_volumetric_speed/(0.3*0.5)/4     * 60}\n    G0 Y0 Z0 F20000\n    M400\n    \n    G1 X-13.5 Y0 Z10 F10000\n    M400\n    \n    G1 E10 F{outer_wall_volumetric_speed/2.4*60}\n    M983 F{outer_wall_volumetric_speed/2.4} A0.3 H[nozzle_diameter]; cali dynamic extrusion compensation\n    M106 P1 S178\n    M400 S7\n    G1 X0 F18000\n    G1 X-13.5 F3000\n    G1 X0 F18000 ;wipe and shake\n    G1 X-13.5 F3000\n    G1 X0 F12000 ;wipe and shake\n    G1 X-13.5 F3000\n    M400\n    M106 P1 S0\n\n    M1002 judge_last_extrude_cali_success\n    M622 J0\n        M983 F{outer_wall_volumetric_speed/2.4} A0.3 H[nozzle_diameter]; cali dynamic extrusion compensation\n        M106 P1 S178\n        M400 S7\n        G1 X0 F18000\n        G1 X-13.5 F3000\n        G1 X0 F18000 ;wipe and shake\n        G1 X-13.5 F3000\n        G1 X0 F12000 ;wipe and shake\n        M400\n        M106 P1 S0\n    M623\n    \n    G1 X-13.5 F3000\n    M400\n    M984 A0.1 E1 S1 F{outer_wall_volumetric_speed/2.4} H[nozzle_diameter]\n    M106 P1 S178\n    M400 S7\n    G1 X0 F18000\n    G1 X-13.5 F3000\n    G1 X0 F18000 ;wipe and shake\n    G1 X-13.5 F3000\n    G1 X0 F12000 ;wipe and shake\n    G1 X-13.5 F3000\n    M400\n    M106 P1 S0\n\nM623 ; end of "draw extrinsic para cali paint"\n\n;===== extrude cali test ===============================\nM104 S{nozzle_temperature_initial_layer[initial_extruder]}\nG90\nM83\nG0 X68 Y-2.5 F30000\nG0 Z0.3 F18000 ;Move to start position\nG0 X88 E10  F{outer_wall_volumetric_speed/(24/20)    * 60}\nG0 X93 E.3742  F{outer_wall_volumetric_speed/(0.3*0.5)/4     * 60}\nG0 X98 E.3742  F{outer_wall_volumetric_speed/(0.3*0.5)     * 60}\nG0 X103 E.3742  F{outer_wall_volumetric_speed/(0.3*0.5)/4     * 60}\nG0 X108 E.3742  F{outer_wall_volumetric_speed/(0.3*0.5)     * 60}\nG0 X113 E.3742  F{outer_wall_volumetric_speed/(0.3*0.5)/4     * 60}\nG0 X115 Z0 F20000\nG0 Z5\nM400\n\n;========turn off light and wait extrude temperature =============\nM1002 gcode_claim_action : 0\n\nM400 ; wait all motion done before implement the emprical L parameters\n\n;===== for Textured PEI Plate , lower the nozzle as the nozzle was touching topmost of the texture when homing ==\n;curr_bed_type={curr_bed_type}\n{if curr_bed_type=="Textured PEI Plate"}\nG29.1 Z{-0.02} ; for Textured PEI Plate\n{endif}\n\nM960 S1 P0 ; turn off laser\nM960 S2 P0 ; turn off laser\nM106 S0 ; turn off fan\nM106 P2 S0 ; turn off big fan\nM106 P3 S0 ; turn off chamber fan\n\nM975 S1 ; turn on mech mode supression\nG90\nM83\nT1000\n\nM211 X0 Y0 Z0 ;turn off soft endstop\nM1007 S1\n\n\n\n
; machine_switch_extruder_time = 0
; machine_unload_filament_time = 34
; master_extruder_id = 1
; max_bridge_length = 0
; max_layer_height = 0.28
; max_travel_detour_distance = 0
; min_bead_width = 85%
; min_feature_size = 25%
; min_layer_height = 0.08
; minimum_sparse_infill_area = 15
; mmu_segmented_region_interlocking_depth = 0
; mmu_segmented_region_max_width = 0
; nozzle_diameter = 0.4
; nozzle_height = 4.76
; nozzle_temperature = 255
; nozzle_temperature_initial_layer = 255
; nozzle_temperature_range_high = 270
; nozzle_temperature_range_low = 220
; nozzle_type = stainless_steel
; nozzle_volume = 92
; nozzle_volume_type = Standard
; only_one_wall_first_layer = 0
; ooze_prevention = 0
; other_layers_print_sequence = 0
; other_layers_print_sequence_nums = 0
; outer_wall_acceleration = 4000
; outer_wall_jerk = 9
; outer_wall_line_width = 0.42
; outer_wall_speed = 60
; overhang_1_4_speed = 10
; overhang_2_4_speed = 20
; overhang_3_4_speed = 30
; overhang_4_4_speed = 40
; overhang_fan_speed = 90
; overhang_fan_threshold = 10%
; overhang_threshold_participating_cooling = 95%
; overhang_totally_speed = 50
; physical_extruder_map = 0
; post_process = 
; pre_start_fan_time = 0
; precise_outer_wall = 0
; precise_z_height = 0
; pressure_advance = 0.02
; prime_tower_brim_width = 3
; prime_tower_enable_framework = 0
; prime_tower_extra_rib_length = 0
; prime_tower_fillet_wall = 1
; prime_tower_flat_ironing = 0
; prime_tower_infill_gap = 100%
; prime_tower_lift_height = -1
; prime_tower_lift_speed = 90
; prime_tower_max_speed = 90
; prime_tower_rib_wall = 0
; prime_tower_rib_width = 8
; prime_tower_skip_points = 1
; prime_tower_width = 35
; print_compatible_printers = "Bambu Lab A1 mini 0.4 nozzle"
; print_extruder_id = 1
; print_extruder_variant = "Direct Drive Standard"
; print_flow_ratio = 1
; print_sequence = by layer
; print_settings_id = PETG - 0.20mm
; printable_area = 0x0,180x0,180x180,0x180
; printable_height = 180
; printer_extruder_id = 1
; printer_extruder_variant = "Direct Drive Standard"
; printer_model = Bambu Lab A1 mini
; printer_notes = 
; printer_settings_id = Bambu Lab A1 mini 0.4 nozzle - NOVIBE
; printer_structure = i3
; printer_technology = FFF
; printer_variant = 0.4
; printhost_authorization_type = key
; printhost_ssl_ignore_revoke = 0
; printing_by_object_gcode = 
; process_notes = 
; raft_contact_distance = 0.1
; raft_expansion = 1.5
; raft_first_layer_density = 90%
; raft_first_layer_expansion = 2
; raft_layers = 0
; reduce_crossing_wall = 0
; reduce_fan_stop_start_freq = 1
; reduce_infill_retraction = 1
; required_nozzle_HRC = 3
; resolution = 0.012
; retract_before_wipe = 0%
; retract_length_toolchange = 2
; retract_lift_above = 0
; retract_lift_below = 179
; retract_restart_extra = 0
; retract_restart_extra_toolchange = 0
; retract_when_changing_layer = 1
; retraction_distances_when_cut = 18
; retraction_distances_when_ec = 0
; retraction_length = 0.8
; retraction_minimum_travel = 1
; retraction_speed = 30
; role_base_wipe_speed = 1
; scan_first_layer = 0
; scarf_angle_threshold = 155
; seam_gap = 15%
; seam_position = aligned
; seam_slope_conditional = 1
; seam_slope_entire_loop = 0
; seam_slope_inner_walls = 1
; seam_slope_steps = 10
; silent_mode = 0
; single_extruder_multi_material = 1
; skeleton_infill_density = 15%
; skeleton_infill_line_width = 0.45
; skin_infill_density = 15%
; skin_infill_depth = 2
; skin_infill_line_width = 0.45
; skirt_distance = 2
; skirt_height = 1
; skirt_loops = 0
; slice_closing_radius = 0.049
; slicing_mode = regular
; slow_down_for_layer_cooling = 1
; slow_down_layer_time = 12
; slow_down_min_speed = 20
; small_perimeter_speed = 50%
; small_perimeter_threshold = 0
; smooth_coefficient = 80
; smooth_speed_discontinuity_area = 1
; solid_infill_filament = 1
; sparse_infill_acceleration = 5500
; sparse_infill_anchor = 400%
; sparse_infill_anchor_max = 20
; sparse_infill_density = 15%
; sparse_infill_filament = 1
; sparse_infill_line_width = 0.45
; sparse_infill_pattern = gyroid
; sparse_infill_speed = 150
; spiral_mode = 0
; spiral_mode_max_xy_smoothing = 200%
; spiral_mode_smooth = 0
; standby_temperature_delta = -5
; start_end_points = 30x-3,54x245
; supertack_plate_temp = 70
; supertack_plate_temp_initial_layer = 70
; support_air_filtration = 0
; support_angle = 0
; support_base_pattern = default
; support_base_pattern_spacing = 2.5
; support_bottom_interface_spacing = 0.5
; support_bottom_z_distance = 0.2
; support_chamber_temp_control = 0
; support_critical_regions_only = 0
; support_expansion = 0
; support_filament = 0
; support_interface_bottom_layers = 2
; support_interface_filament = 0
; support_interface_loop_pattern = 0
; support_interface_not_for_body = 1
; support_interface_pattern = auto
; support_interface_spacing = 0.5
; support_interface_speed = 80
; support_interface_top_layers = 2
; support_line_width = 0.5
; support_object_first_layer_gap = 0.2
; support_object_xy_distance = 0.35
; support_on_build_plate_only = 0
; support_remove_small_overhang = 1
; support_speed = 100
; support_style = default
; support_threshold_angle = 30
; support_top_z_distance = 0.2
; support_type = tree(auto)
; symmetric_infill_y_axis = 0
; temperature_vitrification = 70
; template_custom_gcode = 
; textured_plate_temp = 70
; textured_plate_temp_initial_layer = 70
; thick_bridges = 0
; thumbnail_size = 50x50
; time_lapse_gcode = ;===================== date: 20250206 =====================\n{if !spiral_mode && print_sequence != "by object"}\n; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer\n; SKIPPABLE_START\n; SKIPTYPE: timelapse\nM622.1 S1 ; for prev firware, default turned on\nM1002 judge_flag timelapse_record_flag\nM622 J1\nG92 E0\nG1 Z{max_layer_z + 0.4}\nG1 X0 Y{first_layer_center_no_wipe_tower[1]} F18000 ; move to safe pos\nG1 X-13.0 F3000 ; move to safe pos\nM400\nM1004 S5 P1  ; external shutter\nM400 P300\nM971 S11 C11 O0\nG92 E0\nG1 X0 F18000\nM623\n\n; SKIPTYPE: head_wrap_detect\nM622.1 S1\nM1002 judge_flag g39_3rd_layer_detect_flag\nM622 J1\n    ; enable nozzle clog detect at 3rd layer\n    {if layer_num == 2}\n      M400\n      G90\n      M83\n      M204 S5000\n      G0 Z2 F4000\n      G0 X187 Y178 F20000\n      G39 S1 X187 Y178\n      G0 Z2 F4000\n    {endif}\n\n\n    M622.1 S1\n    M1002 judge_flag g39_detection_flag\n    M622 J1\n      {if !in_head_wrap_detect_zone}\n        M622.1 S0\n        M1002 judge_flag g39_mass_exceed_flag\n        M622 J1\n        {if layer_num > 2}\n            G392 S0\n            M400\n            G90\n            M83\n            M204 S5000\n            G0 Z{max_layer_z + 0.4} F4000\n            G39.3 S1\n            G0 Z{max_layer_z + 0.4} F4000\n            G392 S0\n          {endif}\n        M623\n    {endif}\n    M623\nM623\n; SKIPPABLE_END\n{endif}\n\n\n
; timelapse_type = 0
; top_area_threshold = 200%
; top_color_penetration_layers = 5
; top_one_wall_type = all top
; top_shell_layers = 3
; top_shell_thickness = 1
; top_solid_infill_flow_ratio = 1
; top_surface_acceleration = 2000
; top_surface_jerk = 9
; top_surface_line_width = 0.42
; top_surface_pattern = monotonicline
; top_surface_speed = 30
; travel_acceleration = 8000
; travel_jerk = 9
; travel_speed = 700
; travel_speed_z = 0
; tree_support_branch_angle = 45
; tree_support_branch_diameter = 2
; tree_support_branch_diameter_angle = 5
; tree_support_branch_distance = 5
; tree_support_wall_count = 0
; upward_compatible_machine = "Bambu Lab P1S 0.4 nozzle";"Bambu Lab P1P 0.4 nozzle";"Bambu Lab X1 0.4 nozzle";"Bambu Lab X1 Carbon 0.4 nozzle";"Bambu Lab X1E 0.4 nozzle";"Bambu Lab A1 0.4 nozzle";"Bambu Lab H2D 0.4 nozzle"
; use_firmware_retraction = 0
; use_relative_e_distances = 1
; vertical_shell_speed = 80%
; wall_distribution_count = 1
; wall_filament = 1
; wall_generator = arachne
; wall_loops = 3
; wall_sequence = inner wall/outer wall
; wall_transition_angle = 10
; wall_transition_filter_deviation = 25%
; wall_transition_length = 100%
; wipe = 1
; wipe_distance = 2
; wipe_speed = 80%
; wipe_tower_no_sparse_layers = 0
; wipe_tower_rotation_angle = 0
; wipe_tower_x = 15
; wipe_tower_y = 158.571
; xy_contour_compensation = 0
; xy_hole_compensation = 0
; z_direction_outwall_speed_continuous = 0
; z_hop = 0.4
; z_hop_types = Auto Lift
; CONFIG_BLOCK_END

; EXECUTABLE_BLOCK_START
M73 P0 R14
M201 X20000 Y20000 Z1500 E5000
M203 X500 Y500 Z30 E30
M204 P20000 R5000 T20000
M205 X9.00 Y9.00 Z5.00 E3.00
M106 S0
M106 P2 S0
; FEATURE: Custom
;===== machine: A1 mini =========================
;===== date: 20240620 =====================

;===== start to heat heatbead&hotend==========
M1002 gcode_claim_action : 2
M1002 set_filament_type:PETG
M104 S170
M140 S70
G392 S0 ;turn off clog detect
M9833.2
;=====start printer sound ===================
M17
M400 S1
M1006 S1
M1006 A0 B0 L100 C37 D10 M100 E37 F10 N100
M1006 A0 B0 L100 C41 D10 M100 E41 F10 N100
M1006 A0 B0 L100 C44 D10 M100 E44 F10 N100
M1006 A0 B10 L100 C0 D10 M100 E0 F10 N100
M1006 A43 B10 L100 C39 D10 M100 E46 F10 N100
M1006 A0 B0 L100 C0 D10 M100 E0 F10 N100
M1006 A0 B0 L100 C39 D10 M100 E43 F10 N100
M1006 A0 B0 L100 C0 D10 M100 E0 F10 N100
M1006 A0 B0 L100 C41 D10 M100 E41 F10 N100
M1006 A0 B0 L100 C44 D10 M100 E44 F10 N100
M1006 A0 B0 L100 C49 D10 M100 E49 F10 N100
M1006 A0 B0 L100 C0 D10 M100 E0 F10 N100
M1006 A44 B10 L100 C39 D10 M100 E48 F10 N100
M1006 A0 B0 L100 C0 D10 M100 E0 F10 N100
M1006 A0 B0 L100 C39 D10 M100 E44 F10 N100
M1006 A0 B0 L100 C0 D10 M100 E0 F10 N100
M1006 A43 B10 L100 C39 D10 M100 E46 F10 N100
M1006 W
M18
;=====avoid end stop =================
G91
G380 S2 Z30 F1200
G380 S3 Z-20 F1200
G1 Z5 F1200
G90

;===== reset machine status =================
M204 S6000

M630 S0 P0
G91
M17 Z0.3 ; lower the z-motor current

G90
M17 X0.7 Y0.9 Z0.5 ; reset motor current to default
M960 S5 P1 ; turn on logo lamp
G90
M83
M220 S100 ;Reset Feedrate
M221 S100 ;Reset Flowrate
M73.2   R1.0 ;Reset left time magnitude
;====== cog noise reduction=================
M982.2 S1 ; turn on cog noise reduction

;===== prepare print temperature and material ==========
M400
M18
M109 S100 H170
M104 S170
M400
M17
M400
G28 X

M211 X0 Y0 Z0 ;turn off soft endstop ; turn off soft endstop to prevent protential logic problem

M975 S1 ; turn on

G1 X0.0 F30000
G1 X-13.5 F3000

M620 M ;enable remap
M620 S0A   ; switch material if AMS exist
    G392 S0 ;turn on clog detect
    M1002 gcode_claim_action : 4
    M400
    M1002 set_filament_type:UNKNOWN
    M109 S255
    M104 S250
    M400
    T0
    G1 X-13.5 F3000
    M400
    M620.1 E F199.559 T270
    M109 S250 ;set nozzle to common flush temp
    M106 P1 S0
    G92 E0
M73 P3 R13
    G1 E50 F200
    M400
    M1002 set_filament_type:PETG
    M104 S270
    G92 E0
    G1 E50 F199.559
    M400
    M106 P1 S178
    G92 E0
M73 P35 R9
    G1 E5 F199.559
    M109 S235 ; drop nozzle temp, make filament shink a bit
    M104 S215
    G92 E0
M73 P37 R8
    G1 E-0.5 F300

    G1 X0 F30000
    G1 X-13.5 F3000
    G1 X0 F30000 ;wipe and shake
    G1 X-13.5 F3000
    G1 X0 F12000 ;wipe and shake
    G1 X0 F30000
    G1 X-13.5 F3000
    M109 S215
    G392 S0 ;turn off clog detect
M621 S0A

M400
M106 P1 S0
;===== prepare print temperature and material end =====


;===== mech mode fast check============================
M1002 gcode_claim_action : 3
G0 X25 Y175 F20000 ; find a soft place to home
;M104 S0
G28 Z P0 T300; home z with low precision,permit 300deg temperature
G29.2 S0 ; turn off ABL
M104 S170

; build plate detect
M1002 judge_flag build_plate_detect_flag
M622 S1
  G39.4
  M400
M623

G1 Z5 F3000
; G1 X90 Y-1 F30000
; M400 P200
; M970.3 Q1 A7 K0 O2
; M974 Q1 S2 P0

; G1 X90 Y0 Z5 F30000
; M400 P200
; M970 Q0 A10 B50 C90 H15 K0 M20 O3
; M974 Q0 S2 P0

; M975 S1
; G1 F30000
G1 X-1 Y10
G28 X ; re-home XY

;===== wipe nozzle ===============================
M1002 gcode_claim_action : 14
M975 S1

M104 S170 ; set temp down to heatbed acceptable
M106 S255 ; turn on fan (G28 has turn off fan)
M211 S; push soft endstop status
M211 X0 Y0 Z0 ;turn off Z axis endstop

M83
G1 E-1 F500
G90
M83

M109 S170
M104 S140
G0 X90 Y-4 F30000
G380 S3 Z-5 F1200
G1 Z2 F1200
G1 X91 F10000
G380 S3 Z-5 F1200
M73 P38 R8
G1 Z2 F1200
G1 X92 F10000
G380 S3 Z-5 F1200
G1 Z2 F1200
G1 X93 F10000
G380 S3 Z-5 F1200
G1 Z2 F1200
G1 X94 F10000
G380 S3 Z-5 F1200
G1 Z2 F1200
G1 X95 F10000
G380 S3 Z-5 F1200
G1 Z2 F1200
G1 X96 F10000
G380 S3 Z-5 F1200
G1 Z2 F1200
G1 X97 F10000
G380 S3 Z-5 F1200
G1 Z2 F1200
G1 X98 F10000
G380 S3 Z-5 F1200
G1 Z2 F1200
G1 X99 F10000
G380 S3 Z-5 F1200
G1 Z2 F1200
G1 X99 F10000
G380 S3 Z-5 F1200
G1 Z2 F1200
G1 X99 F10000
G380 S3 Z-5 F1200
G1 Z2 F1200
G1 X99 F10000
G380 S3 Z-5 F1200
G1 Z2 F1200
G1 X99 F10000
G380 S3 Z-5 F1200

G1 Z5 F30000
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
G1 X25 Y175 F30000.1 ;Brush material
G1 Z0.2 F30000.1
G1 Y185
G91
G1 X-30 F30000
G1 Y-2
G1 X27
G1 Y1.5
G1 X-28
G1 Y-2
G1 X30
G1 Y1.5
G1 X-30
G90
M83

G1 Z5 F3000
G0 X50 Y175 F20000 ; find a soft place to home
G28 Z P0 T300; home z with low precision, permit 300deg temperature
G29.2 S0 ; turn off ABL

G0 X85 Y185 F10000 ;move to exposed steel surface and stop the nozzle
G0 Z-1.01 F10000
G91

G2 I1 J0 X2 Y0 F2000.1
G2 I-0.75 J0 X-1.5
G2 I1 J0 X2
G2 I-0.75 J0 X-1.5
G2 I1 J0 X2
G2 I-0.75 J0 X-1.5
G2 I1 J0 X2
G2 I-0.75 J0 X-1.5
G2 I1 J0 X2
G2 I-0.75 J0 X-1.5
G2 I1 J0 X2
G2 I-0.75 J0 X-1.5
G2 I1 J0 X2
G2 I-0.75 J0 X-1.5
G2 I1 J0 X2
G2 I-0.75 J0 X-1.5
G2 I1 J0 X2
G2 I-0.75 J0 X-1.5
G2 I1 J0 X2
G2 I-0.75 J0 X-1.5

G90
G1 Z5 F30000
G1 X25 Y175 F30000.1 ;Brush material
G1 Z0.2 F30000.1
G1 Y185
G91
G1 X-30 F30000
G1 Y-2
G1 X27
G1 Y1.5
G1 X-28
G1 Y-2
G1 X30
G1 Y1.5
G1 X-30
G90
M83

G1 Z5
G0 X55 Y175 F20000 ; find a soft place to home
G28 Z P0 T300; home z with low precision, permit 300deg temperature
G29.2 S0 ; turn off ABL

G1 Z10
G1 X85 Y185
G1 Z-1.01
G1 X95
G1 X90

M211 R; pop softend status

M106 S0 ; turn off fan , too noisy
;===== wipe nozzle end ================================


;===== wait heatbed  ====================
M1002 gcode_claim_action : 2
M104 S0
M190 S70;set bed temp
M109 S140

G1 Z5 F3000
G29.2 S1
G1 X10 Y10 F20000

;===== bed leveling ==================================
;M1002 set_flag g29_before_print_flag=1
M1002 judge_flag g29_before_print_flag
M622 J1
    M1002 gcode_claim_action : 1
    G29 A1 X85 Y85 I10 J10
    M400
    M500 ; save cali data
M623
;===== bed leveling end ================================

;===== home after wipe mouth============================
M1002 judge_flag g29_before_print_flag
M622 J0

    M1002 gcode_claim_action : 13
    G28 T145

M623

;===== home after wipe mouth end =======================

M975 S1 ; turn on vibration supression
;===== nozzle load line ===============================
M975 S1
G90
M83
T1000

G1 X-13.5 Y0 Z10 F10000
G1 E1.2 F500
M400
M1002 set_filament_type:UNKNOWN
M109 S255
M400

M412 S1 ;    ===turn on  filament runout detection===
M400 P10

G392 S0 ;turn on clog detect

M620.3 W1; === turn on filament tangle detection===
M400 S2

M1002 set_filament_type:PETG
;M1002 set_flag extrude_cali_flag=1
M1002 judge_flag extrude_cali_flag
M622 J1
    M1002 gcode_claim_action : 8
    
    M400
    M900 K0.0 L1000.0 M1.0
    G90
    M83
    G0 X68 Y-4 F30000
    G0 Z0.3 F18000 ;Move to start position
    M400
    G0 X88 E10  F271.497
    G0 X93 E.3742  F452.496
    G0 X98 E.3742  F1809.98
    G0 X103 E.3742  F452.496
    G0 X108 E.3742  F1809.98
    G0 X113 E.3742  F452.496
    G0 Y0 Z0 F20000
    M400
    
    G1 X-13.5 Y0 Z10 F10000
    M400
    
    G1 E10 F113.124
    M983 F1.8854 A0.3 H0.4; cali dynamic extrusion compensation
    M106 P1 S178
    M400 S7
    G1 X0 F18000
    G1 X-13.5 F3000
    G1 X0 F18000 ;wipe and shake
    G1 X-13.5 F3000
    G1 X0 F12000 ;wipe and shake
    G1 X-13.5 F3000
    M400
    M106 P1 S0

    M1002 judge_last_extrude_cali_success
    M622 J0
        M983 F1.8854 A0.3 H0.4; cali dynamic extrusion compensation
        M106 P1 S178
        M400 S7
        G1 X0 F18000
M73 P39 R8
        G1 X-13.5 F3000
        G1 X0 F18000 ;wipe and shake
        G1 X-13.5 F3000
        G1 X0 F12000 ;wipe and shake
        M400
        M106 P1 S0
    M623
    
M73 P40 R8
    G1 X-13.5 F3000
    M400
    M984 A0.1 E1 S1 F1.8854 H0.4
    M106 P1 S178
    M400 S7
    G1 X0 F18000
    G1 X-13.5 F3000
    G1 X0 F18000 ;wipe and shake
    G1 X-13.5 F3000
    G1 X0 F12000 ;wipe and shake
    G1 X-13.5 F3000
    M400
    M106 P1 S0

M623 ; end of "draw extrinsic para cali paint"

;===== extrude cali test ===============================
M104 S255
G90
M83
G0 X68 Y-2.5 F30000
G0 Z0.3 F18000 ;Move to start position
G0 X88 E10  F271.497
G0 X93 E.3742  F452.496
G0 X98 E.3742  F1809.98
G0 X103 E.3742  F452.496
G0 X108 E.3742  F1809.98
G0 X113 E.3742  F452.496
G0 X115 Z0 F20000
G0 Z5
M400

;========turn off light and wait extrude temperature =============
M1002 gcode_claim_action : 0

M400 ; wait all motion done before implement the emprical L parameters

;===== for Textured PEI Plate , lower the nozzle as the nozzle was touching topmost of the texture when homing ==
;curr_bed_type=Textured PEI Plate

G29.1 Z-0.02 ; for Textured PEI Plate


M960 S1 P0 ; turn off laser
M960 S2 P0 ; turn off laser
M106 S0 ; turn off fan
M106 P2 S0 ; turn off big fan
M106 P3 S0 ; turn off chamber fan

M975 S1 ; turn on mech mode supression
G90
M83
T1000

M211 X0 Y0 Z0 ;turn off soft endstop
M1007 S1



; MACHINE_START_GCODE_END
; filament start gcode
; Add a marker at the start of each layer
M73 P0
M106 P3 S180


;VT0
G90
G21
M83 ; use relative distances for extrusion
M981 S1 P20000 ;open spaghetti detector
; CHANGE_LAYER
; Z_HEIGHT: 0.2
; LAYER_HEIGHT: 0.2
M73 P41 R8
G1 E-.8 F1800
; layer num/total_layer_count: 1/50
; update layer progress
M73 L1
M991 S0 P0 ;notify layer change

M106 S0
M106 P2 S0
; OBJECT_ID: 91
G1 X93.836 Y93.836 F42000
M204 S6000
G1 Z.4
G1 Z.2
M73 P42 R8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.49999
G1 F1202
M204 S300
G1 X86.164 Y93.836 E.27699
G1 X86.164 Y86.164 E.27699
G1 X93.836 Y86.164 E.27699
G1 X93.836 Y90 E.1385
M73 P43 R8
G1 X93.836 Y93.776 E.13633
M204 S6000
G1 X94.293 Y94.293 F42000
G1 F1202
M204 S300
G1 X85.707 Y94.293 E.31
G1 X85.707 Y85.707 E.31
G1 X94.293 Y85.707 E.31
G1 X94.293 Y90 E.155
G1 X94.293 Y94.233 E.15283
M204 S6000
G1 X94.75 Y94.75 F42000
; FEATURE: Outer wall
G1 F1202
M204 S300
G1 X85.25 Y94.75 E.343
G1 X85.25 Y85.25 E.343
G1 X94.75 Y85.25 E.343
G1 X94.75 Y90 E.1715
M73 P44 R7
G1 X94.75 Y94.69 E.16933
; WIPE_START
G1 F1800
G1 X92.75 Y94.703 E-.76
; WIPE_END
G1 E-.04
M204 S6000
G17
G3 Z.6 I1.217 J0 P1  F42000
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z0.6
G1 X0 Y90 F18000 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
M1002 judge_flag g39_3rd_layer_detect_flag
M622 J1
    ; enable nozzle clog detect at 3rd layer
    


    M622.1 S1
    M1002 judge_flag g39_detection_flag
    M622 J1
      
        M622.1 S0
        M1002 judge_flag g39_mass_exceed_flag
        M622 J1
        
        M623
    
    M623
M623
; SKIPPABLE_END




G1 X92.696 Y86.347 F42000
G1 Z.2
G1 E.8 F1800
; FEATURE: Bottom surface
; LINE_WIDTH: 0.51551
G1 F1202
M204 S300
G1 X93.447 Y87.098 E.03966
G1 X93.447 Y87.766 E.02495
G1 X92.234 Y86.553 E.06408
G1 X91.565 Y86.553 E.02495
G1 X93.447 Y88.435 E.09937
G1 X93.447 Y89.103 E.02495
G1 X90.897 Y86.553 E.13465
G1 X90.228 Y86.553 E.02495
M73 P45 R7
G1 X93.447 Y89.772 E.16994
G1 X93.447 Y90.44 E.02495
G1 X89.56 Y86.553 E.20522
G1 X88.892 Y86.553 E.02495
G1 X93.447 Y91.108 E.24051
G1 X93.447 Y91.777 E.02495
G1 X88.223 Y86.553 E.27579
G1 X87.555 Y86.553 E.02495
G1 X93.447 Y92.445 E.31108
G1 X93.447 Y93.113 E.02495
G1 X86.887 Y86.553 E.34636
G1 X86.553 Y86.553 E.01247
G1 X86.553 Y86.887 E.01248
G1 X93.113 Y93.447 E.34636
G1 X92.445 Y93.447 E.02495
G1 X86.553 Y87.555 E.31107
G1 X86.553 Y88.224 E.02495
G1 X91.776 Y93.447 E.27579
G1 X91.108 Y93.447 E.02495
G1 X86.553 Y88.892 E.2405
G1 X86.553 Y89.56 E.02495
G1 X90.44 Y93.447 E.20522
G1 X89.771 Y93.447 E.02495
G1 X86.553 Y90.229 E.16993
G1 X86.553 Y90.897 E.02495
G1 X89.103 Y93.447 E.13465
G1 X88.435 Y93.447 E.02495
G1 X86.553 Y91.565 E.09937
G1 X86.553 Y92.234 E.02495
G1 X87.766 Y93.447 E.06408
G1 X87.098 Y93.447 E.02495
G1 X86.347 Y92.696 E.03965
; CHANGE_LAYER
; Z_HEIGHT: 0.4
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F5078.398
G1 X87.098 Y93.447 E-.40365
G1 X87.766 Y93.447 E-.25397
G1 X87.576 Y93.257 E-.10238
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 2/50
; update layer progress
M73 L2
M991 S0 P1 ;notify layer change

; open powerlost recovery
M1003 S1
; OBJECT_ID: 91
M204 S8000
G17
G3 Z.6 I-.138 J1.209 P1  F42000
G1 X93.991 Y93.991 Z.6
G1 Z.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.44999
G1 F1339
M204 S3000
G1 X86.009 Y93.991 E.25666
G1 X86.009 Y86.009 E.25666
G1 X93.991 Y86.009 E.25666
M73 P46 R7
G1 X93.991 Y90 E.12833
G1 X93.991 Y93.931 E.1264
M204 S8000
G1 X94.398 Y94.398 F42000
G1 F1339
M204 S3000
G1 X85.602 Y94.398 E.28284
G1 X85.602 Y85.602 E.28284
G1 X94.398 Y85.602 E.28284
G1 X94.398 Y90 E.14142
G1 X94.398 Y94.338 E.13949
M204 S8000
G1 X94.79 Y94.79 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F1339
M204 S4000
G1 X85.21 Y94.79 E.28535
G1 X85.21 Y85.21 E.28535
G1 X94.79 Y85.21 E.28535
G1 X94.79 Y90 E.14267
G1 X94.79 Y94.73 E.14089
; WIPE_START
G1 F3600
M204 S5000
G1 X92.79 Y94.743 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S8000
G17
G3 Z.8 I1.217 J0 P1  F42000
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z0.8
G1 X0 Y90 F18000 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
M1002 judge_flag g39_3rd_layer_detect_flag
M622 J1
    ; enable nozzle clog detect at 3rd layer
    


    M622.1 S1
    M1002 judge_flag g39_detection_flag
    M622 J1
      
        M622.1 S0
        M1002 judge_flag g39_mass_exceed_flag
        M622 J1
        
        M623
    
    M623
M623
; SKIPPABLE_END




G1 X92.981 Y93.828 F42000
G1 Z.4
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.46157
G1 F1339
M204 S5000
G1 X93.645 Y93.164 E.03107
G1 X93.645 Y92.572 E.01958
G1 X92.572 Y93.645 E.05019
G1 X91.98 Y93.645 E.01958
G1 X93.645 Y91.98 E.07788
G1 X93.645 Y91.388 E.01958
G1 X91.388 Y93.645 E.10557
G1 X90.796 Y93.645 E.01958
G1 X93.645 Y90.796 E.13326
G1 X93.645 Y90.203 E.01958
G1 X90.203 Y93.645 E.16095
G1 X89.611 Y93.645 E.01958
G1 X93.645 Y89.611 E.18864
G1 X93.645 Y89.019 E.01958
G1 X89.019 Y93.645 E.21633
G1 X88.427 Y93.645 E.01958
G1 X93.645 Y88.427 E.24402
G1 X93.645 Y87.835 E.01958
G1 X87.835 Y93.645 E.27171
G1 X87.243 Y93.645 E.01958
G1 X93.645 Y87.243 E.2994
G1 X93.645 Y86.651 E.01958
G1 X86.651 Y93.645 E.32709
G1 X86.355 Y93.645 E.00979
G1 X86.355 Y93.349 E.00979
G1 X93.349 Y86.355 E.32708
G1 X92.757 Y86.355 E.01958
M73 P47 R7
G1 X86.355 Y92.757 E.29939
G1 X86.355 Y92.165 E.01958
G1 X92.165 Y86.355 E.2717
G1 X91.573 Y86.355 E.01958
G1 X86.355 Y91.573 E.24401
G1 X86.355 Y90.981 E.01958
G1 X90.981 Y86.355 E.21632
G1 X90.388 Y86.355 E.01958
G1 X86.355 Y90.388 E.18863
G1 X86.355 Y89.796 E.01958
G1 X89.796 Y86.355 E.16094
G1 X89.204 Y86.355 E.01958
G1 X86.355 Y89.204 E.13325
G1 X86.355 Y88.612 E.01958
G1 X88.612 Y86.355 E.10556
G1 X88.02 Y86.355 E.01958
G1 X86.355 Y88.02 E.07787
G1 X86.355 Y87.428 E.01958
G1 X87.428 Y86.355 E.05018
G1 X86.836 Y86.355 E.01958
G1 X86.172 Y87.019 E.03106
; CHANGE_LAYER
; Z_HEIGHT: 0.6
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F5732.712
G1 X86.836 Y86.355 E-.35693
G1 X87.428 Y86.355 E-.22498
G1 X87.097 Y86.687 E-.17809
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 3/50
; update layer progress
M73 L3
M991 S0 P2 ;notify layer change

; OBJECT_ID: 91
M204 S8000
G17
G3 Z.8 I-.885 J.835 P1  F42000
G1 X93.991 Y93.991 Z.8
G1 Z.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.44999
G1 F1338
M204 S3000
G1 X86.009 Y93.991 E.25666
G1 X86.009 Y86.009 E.25666
G1 X93.991 Y86.009 E.25666
G1 X93.991 Y90 E.12833
G1 X93.991 Y93.931 E.1264
M204 S8000
G1 X94.398 Y94.398 F42000
G1 F1338
M204 S3000
G1 X85.602 Y94.398 E.28284
G1 X85.602 Y85.602 E.28284
G1 X94.398 Y85.602 E.28284
G1 X94.398 Y90 E.14142
G1 X94.398 Y94.338 E.13949
M204 S8000
G1 X94.79 Y94.79 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F1338
M204 S4000
G1 X85.21 Y94.79 E.28535
G1 X85.21 Y85.21 E.28535
G1 X94.79 Y85.21 E.28535
G1 X94.79 Y90 E.14267
G1 X94.79 Y94.73 E.14089
; WIPE_START
G1 F3600
M204 S5000
G1 X92.79 Y94.743 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S8000
G17
G3 Z1 I1.217 J0 P1  F42000
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z1
G1 X0 Y90 F18000 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
M1002 judge_flag g39_3rd_layer_detect_flag
M622 J1
    ; enable nozzle clog detect at 3rd layer
    
      M400
      G90
      M83
      M204 S5000
      G0 Z2 F4000
      G0 X187 Y178 F20000
      G39 S1 X187 Y178
      G0 Z2 F4000
    


    M622.1 S1
    M1002 judge_flag g39_detection_flag
    M622 J1
      
        M622.1 S0
        M1002 judge_flag g39_mass_exceed_flag
        M622 J1
        
        M623
    
    M623
M623
; SKIPPABLE_END




G1 X87.019 Y93.828 F42000
G1 Z.6
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.46157
G1 F1338
M204 S5000
G1 X86.355 Y93.164 E.03106
G1 X86.355 Y92.572 E.01958
G1 X87.428 Y93.645 E.05018
G1 X88.02 Y93.645 E.01958
G1 X86.355 Y91.98 E.07787
M73 P48 R7
G1 X86.355 Y91.388 E.01958
G1 X88.612 Y93.645 E.10556
G1 X89.204 Y93.645 E.01958
G1 X86.355 Y90.796 E.13325
G1 X86.355 Y90.204 E.01958
G1 X89.796 Y93.645 E.16094
G1 X90.388 Y93.645 E.01958
G1 X86.355 Y89.612 E.18863
G1 X86.355 Y89.019 E.01958
G1 X90.981 Y93.645 E.21632
G1 X91.573 Y93.645 E.01958
G1 X86.355 Y88.427 E.24401
G1 X86.355 Y87.835 E.01958
G1 X92.165 Y93.645 E.2717
G1 X92.757 Y93.645 E.01958
G1 X86.355 Y87.243 E.29939
G1 X86.355 Y86.651 E.01958
G1 X93.349 Y93.645 E.32708
G1 X93.645 Y93.645 E.00979
G1 X93.645 Y93.349 E.00979
G1 X86.651 Y86.355 E.32709
G1 X87.243 Y86.355 E.01958
G1 X93.645 Y92.757 E.2994
G1 X93.645 Y92.165 E.01958
G1 X87.835 Y86.355 E.27171
G1 X88.427 Y86.355 E.01958
G1 X93.645 Y91.573 E.24402
G1 X93.645 Y90.981 E.01958
G1 X89.019 Y86.355 E.21633
G1 X89.611 Y86.355 E.01958
G1 X93.645 Y90.389 E.18864
G1 X93.645 Y89.797 E.01958
G1 X90.203 Y86.355 E.16095
G1 X90.796 Y86.355 E.01958
G1 X93.645 Y89.204 E.13326
G1 X93.645 Y88.612 E.01958
G1 X91.388 Y86.355 E.10557
G1 X91.98 Y86.355 E.01958
G1 X93.645 Y88.02 E.07788
G1 X93.645 Y87.428 E.01958
G1 X92.572 Y86.355 E.05019
G1 X93.164 Y86.355 E.01958
G1 X93.828 Y87.019 E.03107
; CHANGE_LAYER
; Z_HEIGHT: 0.8
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F5732.712
G1 X93.164 Y86.355 E-.35698
G1 X92.572 Y86.355 E-.22498
G1 X92.903 Y86.686 E-.17804
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 4/50
; update layer progress
M73 L4
M991 S0 P3 ;notify layer change

M106 S229.5
; OBJECT_ID: 91
M204 S8000
G17
G3 Z1 I-1.204 J.179 P1  F42000
G1 X93.991 Y93.991 Z1
G1 Z.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.44999
M73 P49 R7
G1 F1200
M204 S3000
G1 X86.009 Y93.991 E.25666
G1 X86.009 Y86.009 E.25666
G1 X93.991 Y86.009 E.25666
G1 X93.991 Y90 E.12833
G1 X93.991 Y93.931 E.1264
M204 S8000
G1 X94.398 Y94.398 F42000
G1 F1200
M204 S3000
G1 X85.602 Y94.398 E.28284
G1 X85.602 Y85.602 E.28284
G1 X94.398 Y85.602 E.28284
G1 X94.398 Y90 E.14142
G1 X94.398 Y94.338 E.13949
M204 S8000
G1 X94.79 Y94.79 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F1200
M204 S4000
G1 X85.21 Y94.79 E.28535
G1 X85.21 Y85.21 E.28535
G1 X94.79 Y85.21 E.28535
G1 X94.79 Y90 E.14267
G1 X94.79 Y94.73 E.14089
; WIPE_START
G1 F3600
M204 S5000
G1 X92.79 Y94.743 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S8000
G17
G3 Z1.2 I1.217 J0 P1  F42000
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z1.2
G1 X0 Y90 F18000 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
M1002 judge_flag g39_3rd_layer_detect_flag
M622 J1
    ; enable nozzle clog detect at 3rd layer
    


    M622.1 S1
    M1002 judge_flag g39_detection_flag
    M622 J1
      
        M622.1 S0
        M1002 judge_flag g39_mass_exceed_flag
        M622 J1
        
            G392 S0
            M400
            G90
            M83
            M204 S5000
            G0 Z1.2 F4000
            G39.3 S1
            G0 Z1.2 F4000
            G392 S0
          
        M623
    
    M623
M623
; SKIPPABLE_END




G1 X93.645 Y92.205 F42000
G1 Z.8
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1200
M204 S5500
G1 X93.645 Y90.577 E.05236
G2 X92.075 Y93.057 I1.504 J2.689 E.09839
G1 X92.307 Y93.494 E.01591
G1 X92.588 Y93.645 E.01025
G1 X91.267 Y93.645 E.04249
G1 X91.187 Y93.494 E.00549
G3 X89.25 Y92.184 I2.506 J-5.79 E.07563
G3 X88.581 Y90.437 I3.581 J-2.374 E.06065
G1 X88.813 Y90 E.01591
G2 X90.75 Y88.69 I-2.506 J-5.79 E.07563
G2 X91.419 Y86.943 I-3.581 J-2.374 E.06065
G1 X91.187 Y86.506 E.01591
G1 X90.906 Y86.355 E.01025
G1 X92.227 Y86.355 E.04249
G1 X92.307 Y86.506 E.00549
G3 X93.645 Y87.273 I-4.696 J9.732 E.04963
G1 X93.645 Y88.902 E.05236
M204 S8000
G1 X87.256 Y86.355 F42000
G1 F1200
M204 S5500
G1 X86.355 Y86.355 E.02896
M73 P50 R7
G1 X86.355 Y87.083 E.0234
G3 X87.925 Y89.563 I-1.504 J2.689 E.09839
G1 X87.693 Y90 E.01591
G2 X86.355 Y90.768 I4.697 J9.735 E.04963
G1 X86.355 Y92.396 E.05236
; CHANGE_LAYER
; Z_HEIGHT: 1
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F5895.652
M204 S5000
G1 X86.355 Y90.768 E-.61876
G1 X86.678 Y90.583 E-.14125
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 5/50
; update layer progress
M73 L5
M991 S0 P4 ;notify layer change

; OBJECT_ID: 91
M204 S8000
G17
G3 Z1.2 I-.514 J1.103 P1  F42000
G1 X93.991 Y93.991 Z1.2
G1 Z1
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.44999
G1 F1200
M204 S3000
G1 X86.009 Y93.991 E.25666
G1 X86.009 Y86.009 E.25666
G1 X93.991 Y86.009 E.25666
G1 X93.991 Y90 E.12833
G1 X93.991 Y93.931 E.1264
M204 S8000
G1 X94.398 Y94.398 F42000
G1 F1200
M204 S3000
G1 X85.602 Y94.398 E.28284
G1 X85.602 Y85.602 E.28284
G1 X94.398 Y85.602 E.28284
G1 X94.398 Y90 E.14142
G1 X94.398 Y94.338 E.13949
M204 S8000
G1 X94.79 Y94.79 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F1200
M204 S4000
G1 X85.21 Y94.79 E.28535
G1 X85.21 Y85.21 E.28535
G1 X94.79 Y85.21 E.28535
G1 X94.79 Y90 E.14267
G1 X94.79 Y94.73 E.14089
; WIPE_START
G1 F3600
M204 S5000
G1 X92.79 Y94.743 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S8000
G17
G3 Z1.4 I1.217 J0 P1  F42000
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z1.4
G1 X0 Y90 F18000 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
M1002 judge_flag g39_3rd_layer_detect_flag
M622 J1
    ; enable nozzle clog detect at 3rd layer
    


    M622.1 S1
    M1002 judge_flag g39_detection_flag
    M622 J1
      
        M622.1 S0
        M1002 judge_flag g39_mass_exceed_flag
        M622 J1
        
            G392 S0
            M400
            G90
            M83
            M204 S5000
            G0 Z1.4 F4000
            G39.3 S1
            G0 Z1.4 F4000
            G392 S0
          
        M623
    
    M623
M623
; SKIPPABLE_END




G1 X86.355 Y92.458 F42000
G1 Z1
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1200
M204 S5500
G1 X86.355 Y90.83 E.05236
G1 X86.506 Y90.739 E.00566
G1 X87.379 Y90.451 E.02957
G1 X87.816 Y90.44 E.01405
G1 X88.253 Y90.725 E.01677
G1 X88.69 Y91.451 E.02726
G2 X90.874 Y93.043 I2.677 J-1.379 E.09011
G1 X91.31 Y93.054 E.01405
G1 X91.747 Y92.769 E.01677
G1 X92.184 Y92.043 E.02726
G3 X93.645 Y90.689 I2.554 J1.291 E.06541
G1 X93.645 Y87.335 E.10785
G1 X92.621 Y86.957 E.03511
G1 X92.184 Y86.946 E.01405
G1 X91.747 Y87.231 E.01677
G1 X91.31 Y87.957 E.02726
G3 X89.127 Y89.549 I-2.677 J-1.379 E.09011
G1 X88.69 Y89.56 E.01405
G1 X88.253 Y89.275 E.01677
G1 X87.816 Y88.549 E.02726
G2 X86.355 Y87.195 I-2.554 J1.291 E.06542
G1 X86.355 Y86.355 E.02701
M73 P51 R7
G1 X87.144 Y86.355 E.02536
; CHANGE_LAYER
; Z_HEIGHT: 1.2
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F5895.652
M204 S5000
G1 X86.355 Y86.355 E-.29963
G1 X86.355 Y87.195 E-.31913
G1 X86.683 Y87.37 E-.14124
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 6/50
; update layer progress
M73 L6
M991 S0 P5 ;notify layer change

; OBJECT_ID: 91
M204 S8000
G17
G3 Z1.4 I-.817 J.902 P1  F42000
G1 X93.991 Y93.991 Z1.4
M73 P51 R6
G1 Z1.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.44999
G1 F1200
M204 S3000
G1 X86.009 Y93.991 E.25666
G1 X86.009 Y86.009 E.25666
G1 X93.991 Y86.009 E.25666
G1 X93.991 Y90 E.12833
G1 X93.991 Y93.931 E.1264
M204 S8000
G1 X94.398 Y94.398 F42000
G1 F1200
M204 S3000
G1 X85.602 Y94.398 E.28284
G1 X85.602 Y85.602 E.28284
G1 X94.398 Y85.602 E.28284
G1 X94.398 Y90 E.14142
G1 X94.398 Y94.338 E.13949
M204 S8000
G1 X94.79 Y94.79 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F1200
M204 S4000
G1 X85.21 Y94.79 E.28535
G1 X85.21 Y85.21 E.28535
G1 X94.79 Y85.21 E.28535
G1 X94.79 Y90 E.14267
G1 X94.79 Y94.73 E.14089
; WIPE_START
G1 F3600
M204 S5000
G1 X92.79 Y94.743 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S8000
G17
G3 Z1.6 I1.217 J0 P1  F42000
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z1.6
G1 X0 Y90 F18000 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
M1002 judge_flag g39_3rd_layer_detect_flag
M622 J1
    ; enable nozzle clog detect at 3rd layer
    


    M622.1 S1
    M1002 judge_flag g39_detection_flag
    M622 J1
      
        M622.1 S0
        M1002 judge_flag g39_mass_exceed_flag
        M622 J1
        
            G392 S0
            M400
            G90
            M83
            M204 S5000
            G0 Z1.6 F4000
            G39.3 S1
            G0 Z1.6 F4000
            G392 S0
          
        M623
    
    M623
M623
; SKIPPABLE_END




G1 X86.355 Y92.502 F42000
G1 Z1.2
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1200
M204 S5500
G1 X86.355 Y90.873 E.05236
G1 X87.379 Y90.661 E.03363
G3 X88.253 Y91.118 I-.05 J1.159 E.03274
G1 X89.127 Y92.165 E.04385
G2 X90.874 Y92.833 I1.772 J-2.017 E.06143
G2 X91.747 Y92.376 I-.05 J-1.159 E.03274
G1 X92.621 Y91.329 E.04385
G3 X93.645 Y90.779 I1.601 J1.754 E.03776
G1 X93.645 Y87.379 E.10934
G1 X92.621 Y87.167 E.03363
G2 X91.747 Y87.624 I.05 J1.159 E.03274
G1 X90.874 Y88.671 E.04385
G3 X89.127 Y89.339 I-1.772 J-2.017 E.06143
G3 X88.253 Y88.882 I.05 J-1.159 E.03274
G1 X87.379 Y87.835 E.04385
G2 X86.355 Y87.285 I-1.601 J1.755 E.03776
G1 X86.355 Y86.355 E.0299
G1 X87.054 Y86.355 E.02246
; CHANGE_LAYER
; Z_HEIGHT: 1.4
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F5895.652
M204 S5000
G1 X86.355 Y86.355 E-.26546
G1 X86.355 Y87.285 E-.3533
G1 X86.702 Y87.419 E-.14124
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 7/50
; update layer progress
M73 L7
M991 S0 P6 ;notify layer change

; OBJECT_ID: 91
M204 S8000
G17
G3 Z1.6 I-.815 J.904 P1  F42000
G1 X93.991 Y93.991 Z1.6
M73 P52 R6
G1 Z1.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.44999
G1 F1200
M204 S3000
G1 X86.009 Y93.991 E.25666
G1 X86.009 Y86.009 E.25666
G1 X93.991 Y86.009 E.25666
G1 X93.991 Y90 E.12833
G1 X93.991 Y93.931 E.1264
M204 S8000
G1 X94.398 Y94.398 F42000
G1 F1200
M204 S3000
G1 X85.602 Y94.398 E.28284
G1 X85.602 Y85.602 E.28284
G1 X94.398 Y85.602 E.28284
G1 X94.398 Y90 E.14142
G1 X94.398 Y94.338 E.13949
M204 S8000
G1 X94.79 Y94.79 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F1200
M204 S4000
G1 X85.21 Y94.79 E.28535
G1 X85.21 Y85.21 E.28535
G1 X94.79 Y85.21 E.28535
G1 X94.79 Y90 E.14267
G1 X94.79 Y94.73 E.14089
; WIPE_START
G1 F3600
M204 S5000
G1 X92.79 Y94.743 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S8000
G17
G3 Z1.8 I1.217 J0 P1  F42000
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z1.8
G1 X0 Y90 F18000 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
M1002 judge_flag g39_3rd_layer_detect_flag
M622 J1
    ; enable nozzle clog detect at 3rd layer
    


    M622.1 S1
    M1002 judge_flag g39_detection_flag
    M622 J1
      
        M622.1 S0
        M1002 judge_flag g39_mass_exceed_flag
        M622 J1
        
            G392 S0
            M400
            G90
            M83
            M204 S5000
            G0 Z1.8 F4000
            G39.3 S1
            G0 Z1.8 F4000
            G392 S0
          
        M623
    
    M623
M623
; SKIPPABLE_END




G1 X86.355 Y92.524 F42000
G1 Z1.4
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1200
M204 S5500
G1 X86.355 Y90.895 E.05236
G3 X87.816 Y91.01 I.609 J1.608 E.04869
G3 X89.127 Y92.253 I-7.168 J8.87 E.05813
G2 X91.31 Y92.484 I1.283 J-1.695 E.07421
G2 X92.621 Y91.241 I-7.167 J-8.869 E.05813
G3 X93.645 Y90.827 I1.44 J2.089 E.03581
G1 X93.645 Y87.401 E.11017
G2 X92.184 Y87.516 I-.608 J1.607 E.04868
G2 X90.874 Y88.759 I7.168 J8.87 E.05813
G3 X88.69 Y88.99 I-1.283 J-1.695 E.07421
G3 X87.379 Y87.747 I7.168 J-8.87 E.05813
G2 X86.355 Y87.333 I-1.44 J2.09 E.03581
G1 X86.355 Y86.355 E.03145
G1 X87.006 Y86.355 E.02092
; CHANGE_LAYER
; Z_HEIGHT: 1.6
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F5895.652
M204 S5000
G1 X86.355 Y86.355 E-.24716
G1 X86.355 Y87.333 E-.3716
G1 X86.714 Y87.432 E-.14124
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 8/50
; update layer progress
M73 L8
M991 S0 P7 ;notify layer change

; OBJECT_ID: 91
M204 S8000
G17
G3 Z1.8 I-.815 J.904 P1  F42000
G1 X93.991 Y93.991 Z1.8
G1 Z1.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.44999
G1 F1200
M204 S3000
G1 X86.009 Y93.991 E.25666
G1 X86.009 Y86.009 E.25666
G1 X93.991 Y86.009 E.25666
G1 X93.991 Y90 E.12833
G1 X93.991 Y93.931 E.1264
M204 S8000
G1 X94.398 Y94.398 F42000
M73 P53 R6
G1 F1200
M204 S3000
G1 X85.602 Y94.398 E.28284
G1 X85.602 Y85.602 E.28284
G1 X94.398 Y85.602 E.28284
G1 X94.398 Y90 E.14142
G1 X94.398 Y94.338 E.13949
M204 S8000
G1 X94.79 Y94.79 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F1200
M204 S4000
G1 X85.21 Y94.79 E.28535
G1 X85.21 Y85.21 E.28535
G1 X94.79 Y85.21 E.28535
G1 X94.79 Y90 E.14267
G1 X94.79 Y94.73 E.14089
; WIPE_START
G1 F3600
M204 S5000
G1 X92.79 Y94.743 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S8000
G17
G3 Z2 I1.217 J0 P1  F42000
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z2
G1 X0 Y90 F18000 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
M1002 judge_flag g39_3rd_layer_detect_flag
M622 J1
    ; enable nozzle clog detect at 3rd layer
    


    M622.1 S1
    M1002 judge_flag g39_detection_flag
    M622 J1
      
        M622.1 S0
        M1002 judge_flag g39_mass_exceed_flag
        M622 J1
        
            G392 S0
            M400
            G90
            M83
            M204 S5000
            G0 Z2 F4000
            G39.3 S1
            G0 Z2 F4000
            G392 S0
          
        M623
    
    M623
M623
; SKIPPABLE_END




G1 X86.355 Y92.527 F42000
G1 Z1.6
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1200
M204 S5500
G1 X86.355 Y90.898 E.05236
G3 X87.379 Y90.973 I.354 J2.207 E.03332
G3 X88.69 Y92.029 I-2.256 J4.139 E.05442
G2 X91.747 Y91.896 I1.466 J-1.504 E.11025
G3 X93.645 Y90.87 I2.036 J1.498 E.07167
G1 X93.645 Y87.404 E.11144
G2 X92.621 Y87.479 I-.354 J2.208 E.03332
G2 X91.31 Y88.535 I2.256 J4.139 E.05441
G3 X88.253 Y88.401 I-1.466 J-1.504 E.11025
G2 X86.355 Y87.375 I-2.036 J1.498 E.07167
G1 X86.355 Y86.355 E.03281
G1 X86.963 Y86.355 E.01955
; CHANGE_LAYER
; Z_HEIGHT: 1.8
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F5895.652
M204 S5000
G1 X86.355 Y86.355 E-.23106
G1 X86.355 Y87.375 E-.3877
G1 X86.723 Y87.428 E-.14124
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 9/50
; update layer progress
M73 L9
M991 S0 P8 ;notify layer change

; OBJECT_ID: 91
M204 S8000
G17
G3 Z2 I-.816 J.903 P1  F42000
G1 X93.991 Y93.991 Z2
G1 Z1.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.44999
G1 F1200
M204 S3000
G1 X86.009 Y93.991 E.25666
G1 X86.009 Y86.009 E.25666
G1 X93.991 Y86.009 E.25666
G1 X93.991 Y90 E.12833
G1 X93.991 Y93.931 E.1264
M204 S8000
G1 X94.398 Y94.398 F42000
G1 F1200
M204 S3000
G1 X85.602 Y94.398 E.28284
G1 X85.602 Y85.602 E.28284
G1 X94.398 Y85.602 E.28284
G1 X94.398 Y90 E.14142
G1 X94.398 Y94.338 E.13949
M204 S8000
G1 X94.79 Y94.79 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F1200
M204 S4000
M73 P54 R6
G1 X85.21 Y94.79 E.28535
G1 X85.21 Y85.21 E.28535
G1 X94.79 Y85.21 E.28535
G1 X94.79 Y90 E.14267
G1 X94.79 Y94.73 E.14089
; WIPE_START
G1 F3600
M204 S5000
G1 X92.79 Y94.743 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S8000
G17
G3 Z2.2 I1.217 J0 P1  F42000
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z2.2
G1 X0 Y90 F18000 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
M1002 judge_flag g39_3rd_layer_detect_flag
M622 J1
    ; enable nozzle clog detect at 3rd layer
    


    M622.1 S1
    M1002 judge_flag g39_detection_flag
    M622 J1
      
        M622.1 S0
        M1002 judge_flag g39_mass_exceed_flag
        M622 J1
        
            G392 S0
            M400
            G90
            M83
            M204 S5000
            G0 Z2.2 F4000
            G39.3 S1
            G0 Z2.2 F4000
            G392 S0
          
        M623
    
    M623
M623
; SKIPPABLE_END




G1 X93.645 Y92.522 F42000
G1 Z1.8
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1200
M204 S5500
G1 X93.645 Y90.893 E.05236
G2 X91.747 Y91.694 I-.21 J2.151 E.06904
G3 X88.253 Y91.8 I-1.789 J-1.315 E.12942
G2 X86.355 Y90.883 I-1.86 J1.428 E.0703
G1 X86.355 Y87.399 E.11203
G3 X88.253 Y88.2 I.21 J2.151 E.06904
G2 X91.747 Y88.306 I1.789 J-1.315 E.12942
G3 X93.645 Y87.389 I1.86 J1.428 E.07029
G1 X93.645 Y86.355 E.03324
G1 X93.05 Y86.355 E.01912
; CHANGE_LAYER
; Z_HEIGHT: 2
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F5895.652
M204 S5000
G1 X93.645 Y86.355 E-.22597
G1 X93.645 Y87.389 E-.39279
G1 X93.274 Y87.42 E-.14124
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 10/50
; update layer progress
M73 L10
M991 S0 P9 ;notify layer change

; OBJECT_ID: 91
M204 S8000
G17
G3 Z2.2 I-1.21 J.132 P1  F42000
G1 X93.991 Y93.991 Z2.2
G1 Z2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.44999
G1 F1200
M204 S3000
G1 X86.009 Y93.991 E.25666
G1 X86.009 Y86.009 E.25666
G1 X93.991 Y86.009 E.25666
G1 X93.991 Y90 E.12833
G1 X93.991 Y93.931 E.1264
M204 S8000
G1 X94.398 Y94.398 F42000
G1 F1200
M204 S3000
G1 X85.602 Y94.398 E.28284
G1 X85.602 Y85.602 E.28284
G1 X94.398 Y85.602 E.28284
G1 X94.398 Y90 E.14142
G1 X94.398 Y94.338 E.13949
M204 S8000
G1 X94.79 Y94.79 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F1200
M204 S4000
G1 X85.21 Y94.79 E.28535
G1 X85.21 Y85.21 E.28535
G1 X94.79 Y85.21 E.28535
G1 X94.79 Y90 E.14267
G1 X94.79 Y94.73 E.14089
; WIPE_START
M73 P55 R6
G1 F3600
M204 S5000
G1 X92.79 Y94.743 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S8000
G17
G3 Z2.4 I1.217 J0 P1  F42000
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z2.4
G1 X0 Y90 F18000 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
M1002 judge_flag g39_3rd_layer_detect_flag
M622 J1
    ; enable nozzle clog detect at 3rd layer
    


    M622.1 S1
    M1002 judge_flag g39_detection_flag
    M622 J1
      
        M622.1 S0
        M1002 judge_flag g39_mass_exceed_flag
        M622 J1
        
            G392 S0
            M400
            G90
            M83
            M204 S5000
            G0 Z2.4 F4000
            G39.3 S1
            G0 Z2.4 F4000
            G392 S0
          
        M623
    
    M623
M623
; SKIPPABLE_END




G1 X93.645 Y92.527 F42000
G1 Z2
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1200
M204 S5500
G1 X93.645 Y90.899 E.05236
G2 X91.747 Y91.487 I-.477 J1.816 E.06732
G3 X89.127 Y92.593 I-2.154 J-1.446 E.09681
G3 X87.816 Y91.554 I1.549 J-3.298 E.05427
G2 X86.355 Y90.85 I-1.669 J1.596 E.05329
G1 X86.355 Y87.405 E.11077
G3 X88.253 Y87.993 I.477 J1.816 E.06733
G2 X90.874 Y89.099 I2.154 J-1.446 E.09681
G2 X92.184 Y88.059 I-1.549 J-3.298 E.05427
G3 X93.645 Y87.355 I1.669 J1.596 E.05328
G1 X93.645 Y86.355 E.03217
G1 X93.017 Y86.355 E.0202
; CHANGE_LAYER
; Z_HEIGHT: 2.2
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F5895.652
M204 S5000
G1 X93.645 Y86.355 E-.23866
G1 X93.645 Y87.355 E-.38011
G1 X93.281 Y87.433 E-.14124
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 11/50
; update layer progress
M73 L11
M991 S0 P10 ;notify layer change

; OBJECT_ID: 91
M204 S8000
G17
G3 Z2.4 I-1.21 J.131 P1  F42000
G1 X93.991 Y93.991 Z2.4
G1 Z2.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.44999
G1 F1200
M204 S3000
G1 X86.009 Y93.991 E.25666
G1 X86.009 Y86.009 E.25666
G1 X93.991 Y86.009 E.25666
G1 X93.991 Y90 E.12833
G1 X93.991 Y93.931 E.1264
M204 S8000
G1 X94.398 Y94.398 F42000
G1 F1200
M204 S3000
G1 X85.602 Y94.398 E.28284
G1 X85.602 Y85.602 E.28284
G1 X94.398 Y85.602 E.28284
G1 X94.398 Y90 E.14142
G1 X94.398 Y94.338 E.13949
M204 S8000
G1 X94.79 Y94.79 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F1200
M204 S4000
G1 X85.21 Y94.79 E.28535
G1 X85.21 Y85.21 E.28535
G1 X94.79 Y85.21 E.28535
G1 X94.79 Y90 E.14267
G1 X94.79 Y94.73 E.14089
; WIPE_START
G1 F3600
M204 S5000
M73 P56 R6
G1 X92.79 Y94.743 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S8000
G17
G3 Z2.6 I1.217 J0 P1  F42000
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z2.6
G1 X0 Y90 F18000 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
M1002 judge_flag g39_3rd_layer_detect_flag
M622 J1
    ; enable nozzle clog detect at 3rd layer
    


    M622.1 S1
    M1002 judge_flag g39_detection_flag
    M622 J1
      
        M622.1 S0
        M1002 judge_flag g39_mass_exceed_flag
        M622 J1
        
            G392 S0
            M400
            G90
            M83
            M204 S5000
            G0 Z2.6 F4000
            G39.3 S1
            G0 Z2.6 F4000
            G392 S0
          
        M623
    
    M623
M623
; SKIPPABLE_END




G1 X93.645 Y92.514 F42000
G1 Z2.2
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1200
M204 S5500
G1 X93.645 Y90.886 E.05236
G1 X92.621 Y90.746 E.03324
G2 X91.747 Y91.251 I.204 J1.361 E.03323
G1 X90.874 Y92.206 E.04161
G3 X88.69 Y92.605 I-1.44 J-1.703 E.07473
G3 X87.379 Y91.289 I4.106 J-5.397 E.05992
G2 X86.355 Y90.812 I-1.429 J1.733 E.03672
G1 X86.355 Y87.392 E.10999
G1 X87.379 Y87.252 E.03324
G3 X88.253 Y87.757 I-.204 J1.361 E.03323
G1 X89.127 Y88.711 E.04161
G2 X91.31 Y89.111 I1.44 J-1.703 E.07473
G2 X92.621 Y87.795 I-4.107 J-5.398 E.05992
G3 X93.645 Y87.318 I1.429 J1.733 E.03672
G1 X93.645 Y86.355 E.03097
G1 X92.98 Y86.355 E.02139
; CHANGE_LAYER
; Z_HEIGHT: 2.4
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F5895.652
M204 S5000
G1 X93.645 Y86.355 E-.25281
G1 X93.645 Y87.318 E-.36595
G1 X93.291 Y87.431 E-.14124
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 12/50
; update layer progress
M73 L12
M991 S0 P11 ;notify layer change

; OBJECT_ID: 91
M204 S8000
G17
G3 Z2.6 I-1.21 J.129 P1  F42000
G1 X93.991 Y93.991 Z2.6
G1 Z2.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.44999
G1 F1200
M204 S3000
G1 X86.009 Y93.991 E.25666
G1 X86.009 Y86.009 E.25666
G1 X93.991 Y86.009 E.25666
G1 X93.991 Y90 E.12833
G1 X93.991 Y93.931 E.1264
M204 S8000
G1 X94.398 Y94.398 F42000
G1 F1200
M204 S3000
G1 X85.602 Y94.398 E.28284
G1 X85.602 Y85.602 E.28284
G1 X94.398 Y85.602 E.28284
G1 X94.398 Y90 E.14142
G1 X94.398 Y94.338 E.13949
M204 S8000
G1 X94.79 Y94.79 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F1200
M204 S4000
G1 X85.21 Y94.79 E.28535
G1 X85.21 Y85.21 E.28535
G1 X94.79 Y85.21 E.28535
G1 X94.79 Y90 E.14267
G1 X94.79 Y94.73 E.14089
; WIPE_START
G1 F3600
M204 S5000
G1 X92.79 Y94.743 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S8000
G17
G3 Z2.8 I1.217 J0 P1  F42000
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
M73 P57 R6
G1 Z2.8
G1 X0 Y90 F18000 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
M1002 judge_flag g39_3rd_layer_detect_flag
M622 J1
    ; enable nozzle clog detect at 3rd layer
    


    M622.1 S1
    M1002 judge_flag g39_detection_flag
    M622 J1
      
        M622.1 S0
        M1002 judge_flag g39_mass_exceed_flag
        M622 J1
        
            G392 S0
            M400
            G90
            M83
            M204 S5000
            G0 Z2.8 F4000
            G39.3 S1
            G0 Z2.8 F4000
            G392 S0
          
        M623
    
    M623
M623
; SKIPPABLE_END




G1 X93.645 Y92.481 F42000
G1 Z2.4
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1200
M204 S5500
G1 X93.645 Y90.853 E.05236
G1 X92.621 Y90.556 E.03429
G1 X92.184 Y90.609 E.01415
G1 X91.747 Y90.938 E.01758
G1 X90.874 Y92.122 E.04733
G3 X88.69 Y92.885 I-1.837 J-1.751 E.07724
G1 X88.253 Y92.557 E.01758
G1 X87.379 Y91.372 E.04733
G2 X86.355 Y90.735 I-1.82 J1.784 E.03916
G1 X86.355 Y87.359 E.10857
G1 X87.379 Y87.062 E.03429
G1 X87.816 Y87.115 E.01415
G1 X88.253 Y87.443 E.01758
G1 X89.127 Y88.628 E.04733
G2 X91.31 Y89.391 I1.837 J-1.751 E.07724
G1 X91.747 Y89.062 E.01758
G1 X92.621 Y87.878 E.04733
G3 X93.645 Y87.241 I1.82 J1.785 E.03915
G1 X93.645 Y86.355 E.02848
G1 X92.902 Y86.355 E.02388
; CHANGE_LAYER
; Z_HEIGHT: 2.6
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F5895.652
M204 S5000
G1 X93.645 Y86.355 E-.2822
G1 X93.645 Y87.241 E-.33656
G1 X93.307 Y87.397 E-.14124
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 13/50
; update layer progress
M73 L13
M991 S0 P12 ;notify layer change

; OBJECT_ID: 91
M204 S8000
G17
G3 Z2.8 I-1.21 J.125 P1  F42000
G1 X93.991 Y93.991 Z2.8
G1 Z2.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.44999
G1 F1200
M204 S3000
G1 X86.009 Y93.991 E.25666
G1 X86.009 Y86.009 E.25666
G1 X93.991 Y86.009 E.25666
G1 X93.991 Y90 E.12833
G1 X93.991 Y93.931 E.1264
M204 S8000
G1 X94.398 Y94.398 F42000
G1 F1200
M204 S3000
G1 X85.602 Y94.398 E.28284
G1 X85.602 Y85.602 E.28284
G1 X94.398 Y85.602 E.28284
G1 X94.398 Y90 E.14142
G1 X94.398 Y94.338 E.13949
M204 S8000
G1 X94.79 Y94.79 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F1200
M204 S4000
G1 X85.21 Y94.79 E.28535
G1 X85.21 Y85.21 E.28535
G1 X94.79 Y85.21 E.28535
G1 X94.79 Y90 E.14267
G1 X94.79 Y94.73 E.14089
; WIPE_START
G1 F3600
M204 S5000
G1 X92.79 Y94.743 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S8000
G17
G3 Z3 I1.217 J0 P1  F42000
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z3
G1 X0 Y90 F18000 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
M1002 judge_flag g39_3rd_layer_detect_flag
M622 J1
    ; enable nozzle clog detect at 3rd layer
    


    M622.1 S1
    M1002 judge_flag g39_detection_flag
    M622 J1
      
        M622.1 S0
        M1002 judge_flag g39_mass_exceed_flag
        M622 J1
        
            G392 S0
            M400
            G90
            M83
            M204 S5000
            G0 Z3 F4000
            G39.3 S1
            G0 Z3 F4000
            G392 S0
          
        M623
    
    M623
M623
; SKIPPABLE_END




G1 X93.645 Y92.425 F42000
M73 P58 R6
G1 Z2.6
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1200
M204 S5500
G1 X93.645 Y90.796 E.05236
G2 X92.184 Y90.198 I-3.242 J5.829 E.05089
G1 X91.747 Y90.301 E.01443
G3 X90.437 Y92.504 I-5.684 J-1.891 E.08304
G3 X88.69 Y93.296 I-3.235 J-4.807 E.06198
G1 X88.253 Y93.193 E.01443
G2 X86.943 Y90.991 I-5.684 J1.891 E.08304
G2 X86.355 Y90.629 I-1.229 J1.339 E.02231
G1 X86.355 Y87.302 E.10699
G3 X87.816 Y86.704 I3.242 J5.83 E.05089
G1 X88.253 Y86.807 E.01443
M73 P58 R5
G2 X89.563 Y89.009 I5.684 J-1.891 E.08304
G2 X91.31 Y89.802 I3.235 J-4.806 E.06198
G1 X91.747 Y89.699 E.01443
G3 X93.057 Y87.497 I5.684 J1.891 E.08304
G3 X93.645 Y87.135 I1.228 J1.339 E.02231
G1 X93.645 Y86.355 E.02509
G1 X92.797 Y86.355 E.02727
; CHANGE_LAYER
; Z_HEIGHT: 2.8
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F5895.652
M204 S5000
G1 X93.645 Y86.355 E-.32229
G1 X93.645 Y87.135 E-.29647
G1 X93.328 Y87.33 E-.14124
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 14/50
; update layer progress
M73 L14
M991 S0 P13 ;notify layer change

; OBJECT_ID: 91
M204 S8000
G17
G3 Z3 I-1.211 J.12 P1  F42000
G1 X93.991 Y93.991 Z3
G1 Z2.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.44999
G1 F1200
M204 S3000
G1 X86.009 Y93.991 E.25666
G1 X86.009 Y86.009 E.25666
G1 X93.991 Y86.009 E.25666
G1 X93.991 Y90 E.12833
G1 X93.991 Y93.931 E.1264
M204 S8000
G1 X94.398 Y94.398 F42000
G1 F1200
M204 S3000
G1 X85.602 Y94.398 E.28284
G1 X85.602 Y85.602 E.28284
G1 X94.398 Y85.602 E.28284
G1 X94.398 Y90 E.14142
G1 X94.398 Y94.338 E.13949
M204 S8000
G1 X94.79 Y94.79 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F1200
M204 S4000
G1 X85.21 Y94.79 E.28535
G1 X85.21 Y85.21 E.28535
G1 X94.79 Y85.21 E.28535
G1 X94.79 Y90 E.14267
G1 X94.79 Y94.73 E.14089
; WIPE_START
G1 F3600
M204 S5000
G1 X92.79 Y94.743 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S8000
G17
G3 Z3.2 I1.217 J0 P1  F42000
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z3.2
G1 X0 Y90 F18000 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
M1002 judge_flag g39_3rd_layer_detect_flag
M622 J1
    ; enable nozzle clog detect at 3rd layer
    


    M622.1 S1
    M1002 judge_flag g39_detection_flag
    M622 J1
      
        M622.1 S0
        M1002 judge_flag g39_mass_exceed_flag
        M622 J1
        
            G392 S0
            M400
            G90
            M83
            M204 S5000
            G0 Z3.2 F4000
            G39.3 S1
            G0 Z3.2 F4000
            G392 S0
          
        M623
    
    M623
M623
; SKIPPABLE_END




G1 X93.645 Y92.357 F42000
G1 Z2.8
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1200
M204 S5500
G1 X93.645 Y90.728 E.05236
G1 X92.6 Y90 E.04096
G1 X92.286 Y89.563 E.0173
G1 X92.259 Y89.127 E.01407
M73 P59 R5
G3 X93.645 Y86.934 I3.382 J.604 E.08554
G1 X93.645 Y86.355 E.0186
G1 X92.595 Y86.355 E.03376
M204 S8000
G1 X86.355 Y88.863 F42000
G1 F1200
M204 S5500
G1 X86.355 Y87.234 E.05236
G1 X87.4 Y86.506 E.04096
G1 X87.509 Y86.355 E.00597
G1 X89.322 Y86.355 E.05831
G2 X88.765 Y87.379 I.487 J.929 E.03976
G2 X89.641 Y89.127 I2.977 J-.4 E.06402
G1 X90.894 Y90 E.04912
G1 X91.208 Y90.437 E.0173
G1 X91.236 Y90.874 E.01407
G3 X90.359 Y92.621 I-2.977 J-.4 E.06402
G1 X89.106 Y93.494 E.04912
G1 X88.997 Y93.645 E.00596
G1 X87.184 Y93.645 E.05831
G2 X87.741 Y92.621 I-.487 J-.928 E.03976
G2 X86.355 Y90.518 I-2.749 J.305 E.08407
G1 X86.355 Y92.147 E.05236
; CHANGE_LAYER
; Z_HEIGHT: 3
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F5895.652
M204 S5000
G1 X86.355 Y90.518 E-.61876
G1 X86.66 Y90.731 E-.14124
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 15/50
; update layer progress
M73 L15
M991 S0 P14 ;notify layer change

; OBJECT_ID: 91
M204 S8000
G17
G3 Z3.2 I-.494 J1.112 P1  F42000
G1 X93.991 Y93.991 Z3.2
G1 Z3
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.44999
G1 F1200
M204 S3000
G1 X86.009 Y93.991 E.25666
G1 X86.009 Y86.009 E.25666
G1 X93.991 Y86.009 E.25666
G1 X93.991 Y90 E.12833
G1 X93.991 Y93.931 E.1264
M204 S8000
G1 X94.398 Y94.398 F42000
G1 F1200
M204 S3000
G1 X85.602 Y94.398 E.28284
G1 X85.602 Y85.602 E.28284
G1 X94.398 Y85.602 E.28284
G1 X94.398 Y90 E.14142
G1 X94.398 Y94.338 E.13949
M204 S8000
G1 X94.79 Y94.79 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F1200
M204 S4000
G1 X85.21 Y94.79 E.28535
G1 X85.21 Y85.21 E.28535
G1 X94.79 Y85.21 E.28535
G1 X94.79 Y90 E.14267
G1 X94.79 Y94.73 E.14089
; WIPE_START
G1 F3600
M204 S5000
G1 X92.79 Y94.743 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S8000
G17
G3 Z3.4 I1.217 J0 P1  F42000
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z3.4
G1 X0 Y90 F18000 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
M1002 judge_flag g39_3rd_layer_detect_flag
M622 J1
    ; enable nozzle clog detect at 3rd layer
    


    M622.1 S1
    M1002 judge_flag g39_detection_flag
    M622 J1
      
        M622.1 S0
        M1002 judge_flag g39_mass_exceed_flag
        M622 J1
        
            G392 S0
            M400
            G90
            M83
            M204 S5000
            G0 Z3.4 F4000
            G39.3 S1
            G0 Z3.4 F4000
            G392 S0
          
        M623
    
    M623
M623
; SKIPPABLE_END




G1 X93.645 Y92.247 F42000
G1 Z3
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1200
M204 S5500
G1 X93.645 Y90.618 E.05236
G1 X92.942 Y90 E.03009
G3 X92.457 Y89.127 I.785 J-1.008 E.03302
G3 X93.645 Y86.859 I2.574 J-.096 E.08614
G1 X93.645 Y86.355 E.0162
G1 X92.52 Y86.355 E.03616
M204 S8000
M73 P60 R5
G1 X86.355 Y88.753 F42000
G1 F1200
M204 S5500
G1 X86.355 Y87.124 E.05236
G2 X87.181 Y86.355 I-1.928 J-2.898 E.03645
G1 X89.619 Y86.355 E.0784
G2 X88.963 Y87.379 I1.21 J1.498 E.03981
G1 X89.07 Y88.253 E.0283
G2 X89.559 Y89.127 I2.344 J-.74 E.03243
G3 X90.91 Y90.437 I-3.313 J4.765 E.06077
G1 X91.037 Y90.874 E.01463
G1 X90.93 Y91.747 E.0283
G3 X90.441 Y92.621 I-2.344 J-.74 E.03243
G1 X89.325 Y93.645 E.0487
G1 X86.887 Y93.645 E.0784
G2 X87.543 Y92.621 I-1.21 J-1.498 E.0398
G1 X87.436 Y91.747 E.0283
G2 X86.355 Y90.353 I-2.699 J.977 E.05766
G1 X86.355 Y91.981 E.05236
; CHANGE_LAYER
; Z_HEIGHT: 3.2
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F5895.652
M204 S5000
G1 X86.355 Y90.353 E-.61876
G1 X86.634 Y90.599 E-.14124
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 16/50
; update layer progress
M73 L16
M991 S0 P15 ;notify layer change

; OBJECT_ID: 91
M204 S8000
G17
G3 Z3.4 I-.51 J1.105 P1  F42000
G1 X93.991 Y93.991 Z3.4
G1 Z3.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.44999
G1 F1200
M204 S3000
G1 X86.009 Y93.991 E.25666
G1 X86.009 Y86.009 E.25666
G1 X93.991 Y86.009 E.25666
G1 X93.991 Y90 E.12833
G1 X93.991 Y93.931 E.1264
M204 S8000
G1 X94.398 Y94.398 F42000
G1 F1200
M204 S3000
G1 X85.602 Y94.398 E.28284
G1 X85.602 Y85.602 E.28284
G1 X94.398 Y85.602 E.28284
G1 X94.398 Y90 E.14142
G1 X94.398 Y94.338 E.13949
M204 S8000
G1 X94.79 Y94.79 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F1200
M204 S4000
G1 X85.21 Y94.79 E.28535
G1 X85.21 Y85.21 E.28535
G1 X94.79 Y85.21 E.28535
G1 X94.79 Y90 E.14267
G1 X94.79 Y94.73 E.14089
; WIPE_START
G1 F3600
M204 S5000
G1 X92.79 Y94.743 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S8000
G17
G3 Z3.6 I1.217 J0 P1  F42000
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z3.6
G1 X0 Y90 F18000 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
M1002 judge_flag g39_3rd_layer_detect_flag
M622 J1
    ; enable nozzle clog detect at 3rd layer
    


    M622.1 S1
    M1002 judge_flag g39_detection_flag
    M622 J1
      
        M622.1 S0
        M1002 judge_flag g39_mass_exceed_flag
        M622 J1
        
            G392 S0
            M400
            G90
            M83
            M204 S5000
            G0 Z3.6 F4000
            G39.3 S1
            G0 Z3.6 F4000
            G392 S0
          
        M623
    
    M623
M623
; SKIPPABLE_END




G1 X93.645 Y92.058 F42000
G1 Z3.2
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1200
M204 S5500
G1 X93.645 Y90.429 E.05236
G3 X92.618 Y89.127 I2 J-2.631 E.05391
G3 X93.645 Y86.651 I2.499 J-.414 E.09079
G1 X93.645 Y86.355 E.00952
G1 X92.313 Y86.355 E.04284
M204 S8000
G1 X86.355 Y88.563 F42000
M73 P61 R5
G1 F1200
M204 S5500
G1 X86.355 Y86.935 E.05236
G2 X86.941 Y86.355 I-2.465 J-3.074 E.02655
G1 X89.855 Y86.355 E.09372
G2 X89.124 Y87.379 I1.85 J2.092 E.04081
G2 X89.841 Y89.563 I2.317 J.449 E.0772
G3 X90.876 Y90.874 I-2.006 J2.647 E.05427
G3 X90.159 Y93.057 I-2.317 J.449 E.0772
G2 X89.565 Y93.645 I2.496 J3.115 E.0269
G1 X86.651 Y93.645 E.09372
G2 X87.382 Y92.621 I-1.849 J-2.092 E.0408
G2 X86.355 Y90.145 I-2.499 J-.414 E.09079
G1 X86.355 Y91.774 E.05236
; CHANGE_LAYER
; Z_HEIGHT: 3.4
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F5895.652
M204 S5000
G1 X86.355 Y90.145 E-.61876
G1 X86.609 Y90.417 E-.14124
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 17/50
; update layer progress
M73 L17
M991 S0 P16 ;notify layer change

; OBJECT_ID: 91
M204 S8000
G17
G3 Z3.6 I-.53 J1.095 P1  F42000
G1 X93.991 Y93.991 Z3.6
G1 Z3.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.44999
G1 F1200
M204 S3000
G1 X86.009 Y93.991 E.25666
G1 X86.009 Y86.009 E.25666
G1 X93.991 Y86.009 E.25666
G1 X93.991 Y90 E.12833
G1 X93.991 Y93.931 E.1264
M204 S8000
G1 X94.398 Y94.398 F42000
G1 F1200
M204 S3000
G1 X85.602 Y94.398 E.28284
G1 X85.602 Y85.602 E.28284
G1 X94.398 Y85.602 E.28284
G1 X94.398 Y90 E.14142
G1 X94.398 Y94.338 E.13949
M204 S8000
G1 X94.79 Y94.79 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F1200
M204 S4000
G1 X85.21 Y94.79 E.28535
G1 X85.21 Y85.21 E.28535
G1 X94.79 Y85.21 E.28535
G1 X94.79 Y90 E.14267
G1 X94.79 Y94.73 E.14089
; WIPE_START
G1 F3600
M204 S5000
G1 X92.79 Y94.743 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S8000
G17
G3 Z3.8 I1.217 J0 P1  F42000
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z3.8
G1 X0 Y90 F18000 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
M1002 judge_flag g39_3rd_layer_detect_flag
M622 J1
    ; enable nozzle clog detect at 3rd layer
    


    M622.1 S1
    M1002 judge_flag g39_detection_flag
    M622 J1
      
        M622.1 S0
        M1002 judge_flag g39_mass_exceed_flag
        M622 J1
        
            G392 S0
            M400
            G90
            M83
            M204 S5000
            G0 Z3.8 F4000
            G39.3 S1
            G0 Z3.8 F4000
            G392 S0
          
        M623
    
    M623
M623
; SKIPPABLE_END




G1 X93.645 Y91.883 F42000
G1 Z3.4
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1200
M204 S5500
G1 X93.645 Y90.254 E.05236
G3 X93.005 Y89.563 I10.521 J-10.383 E.0303
G3 X93.589 Y86.506 I1.904 J-1.221 E.11039
G2 X93.645 Y86.355 I-.055 J-.106 E.00567
G1 X90.051 Y86.355 E.11557
G2 X89.511 Y86.943 I8.949 J8.768 E.02566
G2 X90.095 Y90 I1.904 J1.221 E.11039
G3 X90.632 Y92.621 I-1.313 J1.635 E.09329
G3 X89.769 Y93.645 I-6.312 J-4.441 E.04311
G1 X86.455 Y93.645 E.10657
G2 X87.381 Y91.747 I-1.47 J-1.892 E.07032
G2 X86.355 Y89.938 I-2.829 J.409 E.06846
M73 P62 R5
G1 X86.355 Y86.76 E.10218
G2 X86.737 Y86.355 I-6.164 J-6.185 E.0179
G1 X88.365 Y86.355 E.05236
; CHANGE_LAYER
; Z_HEIGHT: 3.6
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F5895.652
M204 S5000
G1 X86.737 Y86.355 E-.61876
G1 X86.482 Y86.626 E-.14124
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 18/50
; update layer progress
M73 L18
M991 S0 P17 ;notify layer change

; OBJECT_ID: 91
M204 S8000
G17
G3 Z3.8 I-.852 J.869 P1  F42000
G1 X93.991 Y93.991 Z3.8
G1 Z3.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.44999
G1 F1200
M204 S3000
G1 X86.009 Y93.991 E.25666
G1 X86.009 Y86.009 E.25666
G1 X93.991 Y86.009 E.25666
G1 X93.991 Y90 E.12833
G1 X93.991 Y93.931 E.1264
M204 S8000
G1 X94.398 Y94.398 F42000
G1 F1200
M204 S3000
G1 X85.602 Y94.398 E.28284
G1 X85.602 Y85.602 E.28284
G1 X94.398 Y85.602 E.28284
G1 X94.398 Y90 E.14142
G1 X94.398 Y94.338 E.13949
M204 S8000
G1 X94.79 Y94.79 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F1200
M204 S4000
G1 X85.21 Y94.79 E.28535
G1 X85.21 Y85.21 E.28535
G1 X94.79 Y85.21 E.28535
G1 X94.79 Y90 E.14267
G1 X94.79 Y94.73 E.14089
; WIPE_START
G1 F3600
M204 S5000
G1 X92.79 Y94.743 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S8000
G17
G3 Z4 I1.217 J0 P1  F42000
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z4
G1 X0 Y90 F18000 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
M1002 judge_flag g39_3rd_layer_detect_flag
M622 J1
    ; enable nozzle clog detect at 3rd layer
    


    M622.1 S1
    M1002 judge_flag g39_detection_flag
    M622 J1
      
        M622.1 S0
        M1002 judge_flag g39_mass_exceed_flag
        M622 J1
        
            G392 S0
            M400
            G90
            M83
            M204 S5000
            G0 Z4 F4000
            G39.3 S1
            G0 Z4 F4000
            G392 S0
          
        M623
    
    M623
M623
; SKIPPABLE_END




G1 X93.645 Y87.872 F42000
G1 Z3.6
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1200
M204 S5500
G1 X93.645 Y86.355 E.04879
G1 X93.534 Y86.355 E.00357
G2 X92.618 Y88.253 I1.448 J1.868 E.07023
G2 X93.645 Y90.049 I2.842 J-.433 E.06806
G1 X93.645 Y93.229 E.10225
G2 X93.252 Y93.645 I5.602 J5.681 E.0184
G1 X89.961 Y93.645 E.10585
G2 X90.5 Y93.057 I-7.922 J-7.815 E.02565
G2 X89.894 Y90 I-1.927 J-1.207 E.11043
G3 X89.374 Y87.379 I1.319 J-1.623 E.09319
G3 X90.242 Y86.355 I6.558 J4.676 E.04322
G1 X86.355 Y86.355 E.12499
G1 X86.355 Y89.735 E.10867
G1 X86.612 Y90 E.01188
G3 X87.382 Y91.747 I-1.406 J1.663 E.06355
M73 P63 R5
G3 X86.355 Y93.544 I-2.842 J-.433 E.06806
G1 X86.355 Y91.915 E.05236
; CHANGE_LAYER
; Z_HEIGHT: 3.8
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F5895.652
M204 S5000
G1 X86.355 Y93.544 E-.61876
G1 X86.613 Y93.276 E-.14124
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 19/50
; update layer progress
M73 L19
M991 S0 P18 ;notify layer change

; OBJECT_ID: 91
M204 S8000
G17
G3 Z4 I-.117 J1.211 P1  F42000
G1 X93.991 Y93.991 Z4
G1 Z3.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.44999
G1 F1200
M204 S3000
G1 X86.009 Y93.991 E.25666
G1 X86.009 Y86.009 E.25666
G1 X93.991 Y86.009 E.25666
G1 X93.991 Y90 E.12833
G1 X93.991 Y93.931 E.1264
M204 S8000
G1 X94.398 Y94.398 F42000
G1 F1200
M204 S3000
G1 X85.602 Y94.398 E.28284
G1 X85.602 Y85.602 E.28284
G1 X94.398 Y85.602 E.28284
G1 X94.398 Y90 E.14142
G1 X94.398 Y94.338 E.13949
M204 S8000
G1 X94.79 Y94.79 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F1200
M204 S4000
G1 X85.21 Y94.79 E.28535
G1 X85.21 Y85.21 E.28535
G1 X94.79 Y85.21 E.28535
G1 X94.79 Y90 E.14267
G1 X94.79 Y94.73 E.14089
; WIPE_START
G1 F3600
M204 S5000
G1 X92.79 Y94.743 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S8000
G17
G3 Z4.2 I1.217 J0 P1  F42000
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z4.2
G1 X0 Y90 F18000 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
M1002 judge_flag g39_3rd_layer_detect_flag
M622 J1
    ; enable nozzle clog detect at 3rd layer
    


    M622.1 S1
    M1002 judge_flag g39_detection_flag
    M622 J1
      
        M622.1 S0
        M1002 judge_flag g39_mass_exceed_flag
        M622 J1
        
            G392 S0
            M400
            G90
            M83
            M204 S5000
            G0 Z4.2 F4000
            G39.3 S1
            G0 Z4.2 F4000
            G392 S0
          
        M623
    
    M623
M623
; SKIPPABLE_END




G1 X93.645 Y91.38 F42000
G1 Z3.8
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1200
M204 S5500
G1 X93.645 Y93.009 E.05236
G2 X93.047 Y93.645 I5.139 J5.429 E.02809
G1 X90.173 Y93.645 E.09242
G2 X90.884 Y92.621 I-2.05 J-2.184 E.0404
G2 X90.525 Y90.874 I-2.195 J-.459 E.05899
G3 X89.307 Y89.563 I10.596 J-11.072 E.05756
G3 X89.475 Y87.379 I1.883 J-.954 E.07405
G2 X90.447 Y86.355 I-8.273 J-8.83 E.04545
G1 X93.322 Y86.355 E.09242
G2 X92.61 Y87.379 I2.05 J2.184 E.0404
G2 X92.969 Y89.127 I2.195 J.459 E.05899
G1 X93.645 Y89.827 E.03129
G1 X93.645 Y88.198 E.05236
M204 S8000
G1 X86.355 Y87.886 F42000
G1 F1200
M204 S5500
G1 X86.355 Y89.514 E.05236
M73 P64 R5
G3 X87.39 Y90.874 I-2.437 J2.93 E.05541
G3 X87.031 Y92.621 I-2.195 J.459 E.05899
G1 X86.355 Y93.321 E.03129
G1 X86.355 Y93.645 E.01042
G1 X87.659 Y93.645 E.04194
; CHANGE_LAYER
; Z_HEIGHT: 4
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F5895.652
M204 S5000
G1 X86.355 Y93.645 E-.49565
G1 X86.355 Y93.321 E-.12311
G1 X86.613 Y93.053 E-.14124
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 20/50
; update layer progress
M73 L20
M991 S0 P19 ;notify layer change

; OBJECT_ID: 91
M204 S8000
G17
G3 Z4.2 I-.153 J1.207 P1  F42000
G1 X93.991 Y93.991 Z4.2
G1 Z4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.44999
G1 F1200
M204 S3000
G1 X86.009 Y93.991 E.25666
G1 X86.009 Y86.009 E.25666
G1 X93.991 Y86.009 E.25666
G1 X93.991 Y90 E.12833
G1 X93.991 Y93.931 E.1264
M204 S8000
G1 X94.398 Y94.398 F42000
G1 F1200
M204 S3000
G1 X85.602 Y94.398 E.28284
G1 X85.602 Y85.602 E.28284
G1 X94.398 Y85.602 E.28284
G1 X94.398 Y90 E.14142
G1 X94.398 Y94.338 E.13949
M204 S8000
G1 X94.79 Y94.79 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F1200
M204 S4000
G1 X85.21 Y94.79 E.28535
G1 X85.21 Y85.21 E.28535
G1 X94.79 Y85.21 E.28535
G1 X94.79 Y90 E.14267
G1 X94.79 Y94.73 E.14089
; WIPE_START
G1 F3600
M204 S5000
G1 X92.79 Y94.743 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S8000
G17
G3 Z4.4 I1.217 J0 P1  F42000
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z4.4
G1 X0 Y90 F18000 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
M1002 judge_flag g39_3rd_layer_detect_flag
M622 J1
    ; enable nozzle clog detect at 3rd layer
    


    M622.1 S1
    M1002 judge_flag g39_detection_flag
    M622 J1
      
        M622.1 S0
        M1002 judge_flag g39_mass_exceed_flag
        M622 J1
        
            G392 S0
            M400
            G90
            M83
            M204 S5000
            G0 Z4.4 F4000
            G39.3 S1
            G0 Z4.4 F4000
            G392 S0
          
        M623
    
    M623
M623
; SKIPPABLE_END




G1 X93.645 Y91.24 F42000
G1 Z4
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1200
M204 S5500
G1 X93.645 Y92.869 E.05236
G2 X92.803 Y93.645 I1.836 J2.835 E.03699
G1 X90.395 Y93.645 E.07743
G2 X91.048 Y92.621 I-1.17 J-1.465 E.03977
G1 X90.933 Y91.747 E.02833
G2 X90.436 Y90.874 I-2.35 J.76 E.03255
G3 X89.075 Y89.563 I3.129 J-4.609 E.06103
G1 X88.952 Y89.127 E.01459
G1 X89.067 Y88.253 E.02833
G3 X89.564 Y87.379 I2.35 J.759 E.03255
M73 P65 R5
G1 X90.691 Y86.355 E.04897
G1 X93.099 Y86.355 E.07743
G2 X92.447 Y87.379 I1.17 J1.466 E.03977
G1 X92.561 Y88.253 E.02833
G2 X93.645 Y89.637 I2.697 J-.996 E.05744
G1 X93.645 Y88.008 E.05236
M204 S8000
G1 X86.355 Y87.746 F42000
G1 F1200
M204 S5500
G1 X86.355 Y89.374 E.05236
G3 X87.43 Y90.437 I-2.551 J3.657 E.04884
G1 X87.554 Y90.874 E.01459
M73 P65 R4
G1 X87.439 Y91.747 E.02833
G3 X86.355 Y93.131 I-2.697 J-.996 E.05744
G1 X86.355 Y93.645 E.01653
G1 X87.47 Y93.645 E.03584
; CHANGE_LAYER
; Z_HEIGHT: 4.2
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F5895.652
M204 S5000
G1 X86.355 Y93.645 E-.42348
G1 X86.355 Y93.131 E-.19529
G1 X86.636 Y92.887 E-.14124
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 21/50
; update layer progress
M73 L21
M991 S0 P20 ;notify layer change

; OBJECT_ID: 91
M204 S8000
G17
G3 Z4.4 I-.181 J1.203 P1  F42000
G1 X93.991 Y93.991 Z4.4
G1 Z4.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.44999
G1 F1200
M204 S3000
G1 X86.009 Y93.991 E.25666
G1 X86.009 Y86.009 E.25666
G1 X93.991 Y86.009 E.25666
G1 X93.991 Y90 E.12833
G1 X93.991 Y93.931 E.1264
M204 S8000
G1 X94.398 Y94.398 F42000
G1 F1200
M204 S3000
G1 X85.602 Y94.398 E.28284
G1 X85.602 Y85.602 E.28284
G1 X94.398 Y85.602 E.28284
G1 X94.398 Y90 E.14142
G1 X94.398 Y94.338 E.13949
M204 S8000
G1 X94.79 Y94.79 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F1200
M204 S4000
G1 X85.21 Y94.79 E.28535
G1 X85.21 Y85.21 E.28535
G1 X94.79 Y85.21 E.28535
G1 X94.79 Y90 E.14267
G1 X94.79 Y94.73 E.14089
; WIPE_START
G1 F3600
M204 S5000
G1 X92.79 Y94.743 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S8000
G17
G3 Z4.6 I1.217 J0 P1  F42000
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z4.6
G1 X0 Y90 F18000 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
M1002 judge_flag g39_3rd_layer_detect_flag
M622 J1
    ; enable nozzle clog detect at 3rd layer
    


    M622.1 S1
    M1002 judge_flag g39_detection_flag
    M622 J1
      
        M622.1 S0
        M1002 judge_flag g39_mass_exceed_flag
        M622 J1
        
            G392 S0
            M400
            G90
            M83
            M204 S5000
            G0 Z4.6 F4000
            G39.3 S1
            G0 Z4.6 F4000
            G392 S0
          
        M623
    
    M623
M623
; SKIPPABLE_END




G1 X93.645 Y91.132 F42000
G1 Z4.2
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1200
M204 S5500
G1 X93.645 Y92.76 E.05236
G1 X92.574 Y93.494 E.04174
G1 X92.468 Y93.645 E.00593
G1 X90.701 Y93.645 E.05682
G2 X91.248 Y92.621 I-.458 J-.904 E.03978
G2 X90.354 Y90.874 I-3.003 J.434 E.06426
G1 X89.08 Y90 E.04969
G1 X88.771 Y89.563 E.0172
G1 X88.752 Y89.127 E.01406
M73 P66 R4
G3 X89.646 Y87.379 I3.003 J.435 E.06426
G1 X90.92 Y86.506 E.04969
G1 X91.027 Y86.355 E.00594
G1 X92.794 Y86.355 E.05682
G2 X92.246 Y87.379 I.458 J.904 E.03978
G2 X93.645 Y89.57 I3.466 J-.672 E.0856
G1 X93.645 Y87.942 E.05236
M204 S8000
G1 X86.355 Y87.638 F42000
G1 F1200
M204 S5500
G1 X86.355 Y89.266 E.05236
G1 X87.426 Y90 E.04175
G1 X87.735 Y90.437 E.0172
G1 X87.754 Y90.874 E.01406
G3 X86.355 Y92.967 I-2.766 J-.335 E.08401
G1 X86.355 Y93.645 E.0218
G1 X87.305 Y93.645 E.03056
; CHANGE_LAYER
; Z_HEIGHT: 4.4
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F5895.652
M204 S5000
G1 X86.355 Y93.645 E-.36113
G1 X86.355 Y92.967 E-.25763
G1 X86.662 Y92.757 E-.14124
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 22/50
; update layer progress
M73 L22
M991 S0 P21 ;notify layer change

; OBJECT_ID: 91
M204 S8000
G17
G3 Z4.6 I-.202 J1.2 P1  F42000
G1 X93.991 Y93.991 Z4.6
G1 Z4.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.44999
G1 F1200
M204 S3000
G1 X86.009 Y93.991 E.25666
G1 X86.009 Y86.009 E.25666
G1 X93.991 Y86.009 E.25666
G1 X93.991 Y90 E.12833
G1 X93.991 Y93.931 E.1264
M204 S8000
G1 X94.398 Y94.398 F42000
G1 F1200
M204 S3000
G1 X85.602 Y94.398 E.28284
G1 X85.602 Y85.602 E.28284
G1 X94.398 Y85.602 E.28284
G1 X94.398 Y90 E.14142
G1 X94.398 Y94.338 E.13949
M204 S8000
G1 X94.79 Y94.79 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F1200
M204 S4000
G1 X85.21 Y94.79 E.28535
G1 X85.21 Y85.21 E.28535
G1 X94.79 Y85.21 E.28535
G1 X94.79 Y90 E.14267
G1 X94.79 Y94.73 E.14089
; WIPE_START
G1 F3600
M204 S5000
G1 X92.79 Y94.743 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S8000
G17
G3 Z4.8 I1.217 J0 P1  F42000
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z4.8
G1 X0 Y90 F18000 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
M1002 judge_flag g39_3rd_layer_detect_flag
M622 J1
    ; enable nozzle clog detect at 3rd layer
    


    M622.1 S1
    M1002 judge_flag g39_detection_flag
    M622 J1
      
        M622.1 S0
        M1002 judge_flag g39_mass_exceed_flag
        M622 J1
        
            G392 S0
            M400
            G90
            M83
            M204 S5000
            G0 Z4.8 F4000
            G39.3 S1
            G0 Z4.8 F4000
            G392 S0
          
        M623
    
    M623
M623
; SKIPPABLE_END




G1 X87.196 Y93.645 F42000
G1 Z4.4
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1200
M204 S5500
G1 X86.355 Y93.645 E.02705
G1 X86.355 Y92.858 E.02531
G2 X86.943 Y92.502 I-.608 J-1.666 E.02223
G2 X88.253 Y90.375 I-4.439 J-4.202 E.08089
G1 X88.69 Y90.228 E.01482
G3 X90.437 Y90.992 I-1.235 J5.202 E.06165
G3 X91.747 Y93.119 I-4.439 J4.202 E.08089
G1 X92.184 Y93.266 E.01482
G2 X93.645 Y92.694 I-1.449 J-5.85 E.0506
G1 X93.645 Y89.364 E.10709
G3 X93.057 Y89.008 I.607 J-1.665 E.02222
M73 P67 R4
G3 X91.747 Y86.881 I4.439 J-4.202 E.08089
G1 X91.31 Y86.734 E.01482
G2 X89.563 Y87.498 I1.235 J5.203 E.06165
G2 X88.253 Y89.625 I4.439 J4.202 E.08089
G1 X87.816 Y89.772 E.01482
G3 X86.355 Y89.2 I1.448 J-5.849 E.0506
G1 X86.355 Y87.571 E.05236
; CHANGE_LAYER
; Z_HEIGHT: 4.6
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F5895.652
M204 S5000
G1 X86.355 Y89.2 E-.61876
G1 X86.693 Y89.354 E-.14124
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 23/50
; update layer progress
M73 L23
M991 S0 P22 ;notify layer change

; OBJECT_ID: 91
M204 S8000
G17
G3 Z4.8 I-.653 J1.027 P1  F42000
G1 X93.991 Y93.991 Z4.8
G1 Z4.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.44999
G1 F1200
M204 S3000
G1 X86.009 Y93.991 E.25666
G1 X86.009 Y86.009 E.25666
G1 X93.991 Y86.009 E.25666
G1 X93.991 Y90 E.12833
G1 X93.991 Y93.931 E.1264
M204 S8000
G1 X94.398 Y94.398 F42000
G1 F1200
M204 S3000
G1 X85.602 Y94.398 E.28284
G1 X85.602 Y85.602 E.28284
G1 X94.398 Y85.602 E.28284
G1 X94.398 Y90 E.14142
G1 X94.398 Y94.338 E.13949
M204 S8000
G1 X94.79 Y94.79 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F1200
M204 S4000
G1 X85.21 Y94.79 E.28535
G1 X85.21 Y85.21 E.28535
G1 X94.79 Y85.21 E.28535
G1 X94.79 Y90 E.14267
G1 X94.79 Y94.73 E.14089
; WIPE_START
G1 F3600
M204 S5000
G1 X92.79 Y94.743 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S8000
G17
G3 Z5 I1.217 J0 P1  F42000
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z5
G1 X0 Y90 F18000 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
M1002 judge_flag g39_3rd_layer_detect_flag
M622 J1
    ; enable nozzle clog detect at 3rd layer
    


    M622.1 S1
    M1002 judge_flag g39_detection_flag
    M622 J1
      
        M622.1 S0
        M1002 judge_flag g39_mass_exceed_flag
        M622 J1
        
            G392 S0
            M400
            G90
            M83
            M204 S5000
            G0 Z5 F4000
            G39.3 S1
            G0 Z5 F4000
            G392 S0
          
        M623
    
    M623
M623
; SKIPPABLE_END




G1 X87.093 Y93.645 F42000
G1 Z4.6
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1200
M204 S5500
G1 X86.355 Y93.645 E.02372
G1 X86.355 Y92.754 E.02864
G2 X87.379 Y92.127 I-.77 J-2.408 E.03899
G1 X88.253 Y90.96 E.04688
G1 X88.69 Y90.628 E.01764
G3 X90.874 Y91.367 I.376 J2.483 E.07703
G1 X91.747 Y92.535 E.04688
G2 X92.621 Y92.926 I.783 J-.576 E.03218
G1 X93.645 Y92.639 E.0342
G1 X93.645 Y89.26 E.10865
G3 X92.621 Y88.633 I.77 J-2.408 E.03899
G1 X91.747 Y87.466 E.04688
G1 X91.31 Y87.134 E.01764
G2 X89.127 Y87.873 I-.376 J2.483 E.07703
G1 X88.253 Y89.04 E.04688
G3 X87.379 Y89.432 I-.783 J-.576 E.03218
G1 X86.355 Y89.145 E.03421
G1 X86.355 Y87.516 E.05236
; CHANGE_LAYER
; Z_HEIGHT: 4.8
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F5895.652
M204 S5000
G1 X86.355 Y89.145 E-.61876
G1 X86.713 Y89.245 E-.14125
; WIPE_END
M73 P68 R4
G1 E-.04 F1800
; layer num/total_layer_count: 24/50
; update layer progress
M73 L24
M991 S0 P23 ;notify layer change

; OBJECT_ID: 91
M204 S8000
G17
G3 Z5 I-.665 J1.019 P1  F42000
G1 X93.991 Y93.991 Z5
G1 Z4.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.44999
G1 F1200
M204 S3000
G1 X86.009 Y93.991 E.25666
G1 X86.009 Y86.009 E.25666
G1 X93.991 Y86.009 E.25666
G1 X93.991 Y90 E.12833
G1 X93.991 Y93.931 E.1264
M204 S8000
G1 X94.398 Y94.398 F42000
G1 F1200
M204 S3000
G1 X85.602 Y94.398 E.28284
G1 X85.602 Y85.602 E.28284
G1 X94.398 Y85.602 E.28284
G1 X94.398 Y90 E.14142
G1 X94.398 Y94.338 E.13949
M204 S8000
G1 X94.79 Y94.79 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F1200
M204 S4000
G1 X85.21 Y94.79 E.28535
G1 X85.21 Y85.21 E.28535
G1 X94.79 Y85.21 E.28535
G1 X94.79 Y90 E.14267
G1 X94.79 Y94.73 E.14089
; WIPE_START
G1 F3600
M204 S5000
G1 X92.79 Y94.743 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S8000
G17
G3 Z5.2 I1.217 J0 P1  F42000
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z5.2
G1 X0 Y90 F18000 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
M1002 judge_flag g39_3rd_layer_detect_flag
M622 J1
    ; enable nozzle clog detect at 3rd layer
    


    M622.1 S1
    M1002 judge_flag g39_detection_flag
    M622 J1
      
        M622.1 S0
        M1002 judge_flag g39_mass_exceed_flag
        M622 J1
        
            G392 S0
            M400
            G90
            M83
            M204 S5000
            G0 Z5.2 F4000
            G39.3 S1
            G0 Z5.2 F4000
            G392 S0
          
        M623
    
    M623
M623
; SKIPPABLE_END




G1 X87.017 Y93.645 F42000
G1 Z4.8
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1200
M204 S5500
G1 X86.355 Y93.645 E.02128
G1 X86.355 Y92.678 E.03108
G2 X87.379 Y92.211 I-.384 J-2.198 E.0366
G3 X88.69 Y90.903 I5.634 J4.335 E.0597
G3 X90.874 Y91.284 I.762 J2.085 E.07464
G1 X91.747 Y92.228 E.04137
G2 X92.621 Y92.739 I1.098 J-.876 E.03328
G1 X93.645 Y92.607 E.0332
G1 X93.645 Y89.184 E.11007
G3 X92.621 Y88.716 I.385 J-2.198 E.0366
G2 X91.31 Y87.409 I-5.634 J4.336 E.0597
G2 X89.127 Y87.789 I-.762 J2.085 E.07464
G1 X88.253 Y88.734 E.04137
G3 X87.379 Y89.244 I-1.098 J-.876 E.03328
G1 X86.355 Y89.113 E.03321
G1 X86.355 Y87.484 E.05236
; CHANGE_LAYER
; Z_HEIGHT: 5
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F5895.652
M204 S5000
G1 X86.355 Y89.113 E-.61876
G1 X86.724 Y89.16 E-.14124
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 25/50
; update layer progress
M73 L25
M991 S0 P24 ;notify layer change

; OBJECT_ID: 91
M204 S8000
G17
G3 Z5.2 I-.674 J1.013 P1  F42000
G1 X93.991 Y93.991 Z5.2
G1 Z5
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.44999
G1 F1200
M204 S3000
G1 X86.009 Y93.991 E.25666
M73 P69 R4
G1 X86.009 Y86.009 E.25666
G1 X93.991 Y86.009 E.25666
G1 X93.991 Y90 E.12833
G1 X93.991 Y93.931 E.1264
M204 S8000
G1 X94.398 Y94.398 F42000
G1 F1200
M204 S3000
G1 X85.602 Y94.398 E.28284
G1 X85.602 Y85.602 E.28284
G1 X94.398 Y85.602 E.28284
G1 X94.398 Y90 E.14142
G1 X94.398 Y94.338 E.13949
M204 S8000
G1 X94.79 Y94.79 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F1200
M204 S4000
G1 X85.21 Y94.79 E.28535
G1 X85.21 Y85.21 E.28535
G1 X94.79 Y85.21 E.28535
G1 X94.79 Y90 E.14267
G1 X94.79 Y94.73 E.14089
; WIPE_START
G1 F3600
M204 S5000
G1 X92.79 Y94.743 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S8000
G17
G3 Z5.4 I1.217 J0 P1  F42000
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z5.4
G1 X0 Y90 F18000 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
M1002 judge_flag g39_3rd_layer_detect_flag
M622 J1
    ; enable nozzle clog detect at 3rd layer
    


    M622.1 S1
    M1002 judge_flag g39_detection_flag
    M622 J1
      
        M622.1 S0
        M1002 judge_flag g39_mass_exceed_flag
        M622 J1
        
            G392 S0
            M400
            G90
            M83
            M204 S5000
            G0 Z5.4 F4000
            G39.3 S1
            G0 Z5.4 F4000
            G392 S0
          
        M623
    
    M623
M623
; SKIPPABLE_END




G1 X86.981 Y93.645 F42000
G1 Z5
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1200
M204 S5500
G1 X86.355 Y93.645 E.02012
G1 X86.355 Y92.642 E.03224
G2 X87.816 Y91.95 I-.188 J-2.285 E.05312
G3 X89.127 Y90.909 I2.924 J2.335 E.05427
G3 X91.747 Y91.994 I.489 J2.526 E.0966
G2 X93.645 Y92.595 I1.434 J-1.233 E.0674
G1 X93.645 Y89.148 E.11085
G3 X92.184 Y88.456 I.188 J-2.285 E.05312
G2 X90.874 Y87.415 I-2.924 J2.335 E.05427
G2 X88.253 Y88.5 I-.489 J2.526 E.0966
G3 X86.355 Y89.101 I-1.434 J-1.233 E.06741
G1 X86.355 Y87.473 E.05236
; CHANGE_LAYER
; Z_HEIGHT: 5.2
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F5895.652
M204 S5000
G1 X86.355 Y89.101 E-.61876
G1 X86.725 Y89.141 E-.14124
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 26/50
; update layer progress
M73 L26
M991 S0 P25 ;notify layer change

; OBJECT_ID: 91
M204 S8000
G17
G3 Z5.4 I-.676 J1.012 P1  F42000
G1 X93.991 Y93.991 Z5.4
G1 Z5.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.44999
G1 F1200
M204 S3000
G1 X86.009 Y93.991 E.25666
G1 X86.009 Y86.009 E.25666
G1 X93.991 Y86.009 E.25666
G1 X93.991 Y90 E.12833
G1 X93.991 Y93.931 E.1264
M204 S8000
G1 X94.398 Y94.398 F42000
G1 F1200
M204 S3000
G1 X85.602 Y94.398 E.28284
G1 X85.602 Y85.602 E.28284
G1 X94.398 Y85.602 E.28284
G1 X94.398 Y90 E.14142
M73 P70 R4
G1 X94.398 Y94.338 E.13949
M204 S8000
G1 X94.79 Y94.79 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F1200
M204 S4000
G1 X85.21 Y94.79 E.28535
G1 X85.21 Y85.21 E.28535
G1 X94.79 Y85.21 E.28535
G1 X94.79 Y90 E.14267
G1 X94.79 Y94.73 E.14089
; WIPE_START
G1 F3600
M204 S5000
G1 X92.79 Y94.743 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S8000
G17
G3 Z5.6 I1.217 J0 P1  F42000
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z5.6
G1 X0 Y90 F18000 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
M1002 judge_flag g39_3rd_layer_detect_flag
M622 J1
    ; enable nozzle clog detect at 3rd layer
    


    M622.1 S1
    M1002 judge_flag g39_detection_flag
    M622 J1
      
        M622.1 S0
        M1002 judge_flag g39_mass_exceed_flag
        M622 J1
        
            G392 S0
            M400
            G90
            M83
            M204 S5000
            G0 Z5.6 F4000
            G39.3 S1
            G0 Z5.6 F4000
            G392 S0
          
        M623
    
    M623
M623
; SKIPPABLE_END




G1 X86.949 Y93.645 F42000
G1 Z5.2
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1200
M204 S5500
G1 X86.355 Y93.645 E.01908
G1 X86.355 Y92.61 E.03328
G2 X88.253 Y91.706 I.058 J-2.323 E.07015
G3 X91.747 Y91.788 I1.715 J1.401 E.12952
G2 X93.645 Y92.602 I1.705 J-1.358 E.06916
G1 X93.645 Y89.116 E.1121
G3 X91.747 Y88.212 I-.058 J-2.323 E.07014
G2 X88.253 Y88.294 I-1.715 J1.401 E.12952
G3 X86.355 Y89.108 I-1.705 J-1.358 E.06917
G1 X86.355 Y87.479 E.05236
; CHANGE_LAYER
; Z_HEIGHT: 5.4
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F5895.652
M204 S5000
G1 X86.355 Y89.108 E-.61876
G1 X86.727 Y89.099 E-.14124
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 27/50
; update layer progress
M73 L27
M991 S0 P26 ;notify layer change

; OBJECT_ID: 91
M204 S8000
G17
G3 Z5.6 I-.68 J1.009 P1  F42000
G1 X93.991 Y93.991 Z5.6
G1 Z5.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.44999
G1 F1200
M204 S3000
G1 X86.009 Y93.991 E.25666
G1 X86.009 Y86.009 E.25666
G1 X93.991 Y86.009 E.25666
G1 X93.991 Y90 E.12833
G1 X93.991 Y93.931 E.1264
M204 S8000
G1 X94.398 Y94.398 F42000
G1 F1200
M204 S3000
G1 X85.602 Y94.398 E.28284
G1 X85.602 Y85.602 E.28284
G1 X94.398 Y85.602 E.28284
G1 X94.398 Y90 E.14142
G1 X94.398 Y94.338 E.13949
M204 S8000
G1 X94.79 Y94.79 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F1200
M204 S4000
G1 X85.21 Y94.79 E.28535
G1 X85.21 Y85.21 E.28535
G1 X94.79 Y85.21 E.28535
G1 X94.79 Y90 E.14267
G1 X94.79 Y94.73 E.14089
; WIPE_START
G1 F3600
M204 S5000
G1 X92.79 Y94.743 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S8000
G17
G3 Z5.8 I1.217 J0 P1  F42000
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z5.8
M73 P71 R4
G1 X0 Y90 F18000 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
M1002 judge_flag g39_3rd_layer_detect_flag
M622 J1
    ; enable nozzle clog detect at 3rd layer
    


    M622.1 S1
    M1002 judge_flag g39_detection_flag
    M622 J1
      
        M622.1 S0
        M1002 judge_flag g39_mass_exceed_flag
        M622 J1
        
            G392 S0
            M400
            G90
            M83
            M204 S5000
            G0 Z5.8 F4000
            G39.3 S1
            G0 Z5.8 F4000
            G392 S0
          
        M623
    
    M623
M623
; SKIPPABLE_END




G1 X93.035 Y93.645 F42000
G1 Z5.4
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1200
M204 S5500
G1 X93.645 Y93.645 E.01962
G1 X93.645 Y92.627 E.03274
G3 X91.747 Y91.587 I.161 J-2.546 E.07186
G2 X88.69 Y91.475 I-1.581 J1.376 E.11027
G3 X87.379 Y92.529 I-3.474 J-2.977 E.05439
G3 X86.355 Y92.596 I-.653 J-2.138 E.0333
G1 X86.355 Y89.132 E.11137
G2 X88.253 Y88.093 I-.161 J-2.546 E.07186
G3 X91.31 Y87.981 I1.581 J1.376 E.11027
G2 X92.621 Y89.035 I3.474 J-2.976 E.05439
G2 X93.645 Y89.102 I.653 J-2.138 E.0333
G1 X93.645 Y87.473 E.05236
; CHANGE_LAYER
; Z_HEIGHT: 5.6
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F5895.652
M204 S5000
G1 X93.645 Y89.102 E-.61876
G1 X93.274 Y89.121 E-.14124
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 28/50
; update layer progress
M73 L28
M991 S0 P27 ;notify layer change

; OBJECT_ID: 91
M204 S8000
G17
G3 Z5.8 I-1.204 J.177 P1  F42000
G1 X93.991 Y93.991 Z5.8
G1 Z5.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.44999
G1 F1200
M204 S3000
G1 X86.009 Y93.991 E.25666
G1 X86.009 Y86.009 E.25666
G1 X93.991 Y86.009 E.25666
G1 X93.991 Y90 E.12833
G1 X93.991 Y93.931 E.1264
M204 S8000
G1 X94.398 Y94.398 F42000
G1 F1200
M204 S3000
G1 X85.602 Y94.398 E.28284
G1 X85.602 Y85.602 E.28284
G1 X94.398 Y85.602 E.28284
G1 X94.398 Y90 E.14142
G1 X94.398 Y94.338 E.13949
M204 S8000
G1 X94.79 Y94.79 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F1200
M204 S4000
G1 X85.21 Y94.79 E.28535
G1 X85.21 Y85.21 E.28535
G1 X94.79 Y85.21 E.28535
G1 X94.79 Y90 E.14267
G1 X94.79 Y94.73 E.14089
; WIPE_START
G1 F3600
M204 S5000
G1 X92.79 Y94.743 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S8000
G17
G3 Z6 I1.217 J0 P1  F42000
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z6
G1 X0 Y90 F18000 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
M1002 judge_flag g39_3rd_layer_detect_flag
M622 J1
    ; enable nozzle clog detect at 3rd layer
    


    M622.1 S1
    M1002 judge_flag g39_detection_flag
    M622 J1
      
        M622.1 S0
        M1002 judge_flag g39_mass_exceed_flag
        M622 J1
        
            G392 S0
            M400
            G90
            M83
            M204 S5000
            G0 Z6 F4000
            G39.3 S1
            G0 Z6 F4000
            G392 S0
          
        M623
    
    M623
M623
; SKIPPABLE_END




G1 X92.991 Y93.645 F42000
G1 Z5.6
M73 P72 R4
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1200
M204 S5500
M73 P72 R3
G1 X93.645 Y93.645 E.02102
G1 X93.645 Y92.67 E.03134
G3 X92.621 Y92.248 I.437 J-2.513 E.03591
G2 X91.31 Y90.998 I-7.968 J7.04 E.0583
G2 X89.127 Y91.247 I-.885 J1.938 E.07426
G3 X87.816 Y92.497 I-7.968 J-7.041 E.05831
G3 X86.355 Y92.6 I-.84 J-1.503 E.04865
G1 X86.355 Y89.176 E.1101
G2 X87.379 Y88.754 I-.437 J-2.513 E.03591
G3 X88.69 Y87.503 I7.968 J7.04 E.05831
G3 X90.874 Y87.752 I.885 J1.939 E.07426
G2 X92.184 Y89.002 I7.968 J-7.04 E.05831
G2 X93.645 Y89.106 I.84 J-1.503 E.04864
G1 X93.645 Y87.477 E.05236
; CHANGE_LAYER
; Z_HEIGHT: 5.8
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F5895.652
M204 S5000
G1 X93.645 Y89.106 E-.61876
G1 X93.279 Y89.173 E-.14125
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 29/50
; update layer progress
M73 L29
M991 S0 P28 ;notify layer change

; OBJECT_ID: 91
M204 S8000
G17
G3 Z6 I-1.204 J.178 P1  F42000
G1 X93.991 Y93.991 Z6
G1 Z5.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.44999
G1 F1200
M204 S3000
G1 X86.009 Y93.991 E.25666
G1 X86.009 Y86.009 E.25666
G1 X93.991 Y86.009 E.25666
G1 X93.991 Y90 E.12833
G1 X93.991 Y93.931 E.1264
M204 S8000
G1 X94.398 Y94.398 F42000
G1 F1200
M204 S3000
G1 X85.602 Y94.398 E.28284
G1 X85.602 Y85.602 E.28284
G1 X94.398 Y85.602 E.28284
G1 X94.398 Y90 E.14142
G1 X94.398 Y94.338 E.13949
M204 S8000
G1 X94.79 Y94.79 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F1200
M204 S4000
G1 X85.21 Y94.79 E.28535
G1 X85.21 Y85.21 E.28535
G1 X94.79 Y85.21 E.28535
G1 X94.79 Y90 E.14267
G1 X94.79 Y94.73 E.14089
; WIPE_START
G1 F3600
M204 S5000
G1 X92.79 Y94.743 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S8000
G17
G3 Z6.2 I1.217 J0 P1  F42000
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z6.2
G1 X0 Y90 F18000 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
M1002 judge_flag g39_3rd_layer_detect_flag
M622 J1
    ; enable nozzle clog detect at 3rd layer
    


    M622.1 S1
    M1002 judge_flag g39_detection_flag
    M622 J1
      
        M622.1 S0
        M1002 judge_flag g39_mass_exceed_flag
        M622 J1
        
            G392 S0
            M400
            G90
            M83
            M204 S5000
            G0 Z6.2 F4000
            G39.3 S1
            G0 Z6.2 F4000
            G392 S0
          
        M623
    
    M623
M623
; SKIPPABLE_END




G1 X92.942 Y93.645 F42000
G1 Z5.8
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
M73 P73 R3
G1 F1200
M204 S5500
G1 X93.645 Y93.645 E.02261
G1 X93.645 Y92.72 E.02975
G3 X92.621 Y92.161 I.6 J-2.317 E.0379
G1 X91.747 Y91.1 E.04418
G2 X90.874 Y90.651 I-.905 J.685 E.03268
G2 X89.127 Y91.334 I.051 J2.705 E.0616
G1 X88.253 Y92.394 E.04418
G3 X87.379 Y92.844 I-.905 J-.685 E.03268
G1 X86.355 Y92.623 E.03369
G1 X86.355 Y89.225 E.10925
G2 X87.379 Y88.666 I-.6 J-2.316 E.03791
G1 X88.253 Y87.606 E.04418
G3 X89.127 Y87.156 I.905 J.685 E.03268
G3 X90.874 Y87.839 I-.051 J2.705 E.0616
G1 X91.747 Y88.9 E.04418
G2 X92.621 Y89.35 I.905 J-.685 E.03268
G1 X93.645 Y89.129 E.03369
G1 X93.645 Y87.501 E.05236
; CHANGE_LAYER
; Z_HEIGHT: 6
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F5895.652
M204 S5000
G1 X93.645 Y89.129 E-.61876
G1 X93.282 Y89.207 E-.14124
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 30/50
; update layer progress
M73 L30
M991 S0 P29 ;notify layer change

; OBJECT_ID: 91
M204 S8000
G17
G3 Z6.2 I-1.204 J.179 P1  F42000
G1 X93.991 Y93.991 Z6.2
G1 Z6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.44999
G1 F1200
M204 S3000
G1 X86.009 Y93.991 E.25666
G1 X86.009 Y86.009 E.25666
G1 X93.991 Y86.009 E.25666
G1 X93.991 Y90 E.12833
G1 X93.991 Y93.931 E.1264
M204 S8000
G1 X94.398 Y94.398 F42000
G1 F1200
M204 S3000
G1 X85.602 Y94.398 E.28284
G1 X85.602 Y85.602 E.28284
G1 X94.398 Y85.602 E.28284
G1 X94.398 Y90 E.14142
G1 X94.398 Y94.338 E.13949
M204 S8000
G1 X94.79 Y94.79 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F1200
M204 S4000
G1 X85.21 Y94.79 E.28535
G1 X85.21 Y85.21 E.28535
G1 X94.79 Y85.21 E.28535
G1 X94.79 Y90 E.14267
G1 X94.79 Y94.73 E.14089
; WIPE_START
G1 F3600
M204 S5000
G1 X92.79 Y94.743 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S8000
G17
G3 Z6.4 I1.217 J0 P1  F42000
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z6.4
G1 X0 Y90 F18000 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
M1002 judge_flag g39_3rd_layer_detect_flag
M622 J1
    ; enable nozzle clog detect at 3rd layer
    


    M622.1 S1
    M1002 judge_flag g39_detection_flag
    M622 J1
      
        M622.1 S0
        M1002 judge_flag g39_mass_exceed_flag
        M622 J1
        
            G392 S0
            M400
            G90
            M83
            M204 S5000
            G0 Z6.4 F4000
            G39.3 S1
            G0 Z6.4 F4000
            G392 S0
          
        M623
    
    M623
M623
; SKIPPABLE_END




G1 X92.85 Y93.645 F42000
G1 Z6
M73 P74 R3
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1200
M204 S5500
G1 X93.645 Y93.645 E.02555
G1 X93.645 Y92.811 E.02681
G3 X92.184 Y91.435 I1.115 J-2.647 E.06592
G1 X91.747 Y90.693 E.0277
G1 X91.31 Y90.417 E.01662
G1 X90.874 Y90.438 E.01406
G2 X88.69 Y92.059 I.529 J2.995 E.09067
G1 X88.253 Y92.801 E.0277
G1 X87.816 Y93.078 E.01662
G1 X87.379 Y93.057 E.01406
G1 X86.355 Y92.668 E.03523
G1 X86.355 Y89.317 E.10775
G2 X87.816 Y87.941 I-1.114 J-2.647 E.06592
G1 X88.253 Y87.199 E.0277
G1 X88.69 Y86.922 E.01662
G1 X89.127 Y86.944 E.01406
G3 X91.31 Y88.565 I-.529 J2.995 E.09067
G1 X91.747 Y89.307 E.0277
G1 X92.184 Y89.584 E.01662
G1 X92.621 Y89.562 E.01406
G1 X93.494 Y89.266 E.02966
G1 X93.645 Y89.174 E.00568
G1 X93.645 Y87.546 E.05236
; CHANGE_LAYER
; Z_HEIGHT: 6.2
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F5895.652
M204 S5000
G1 X93.645 Y89.174 E-.61876
G1 X93.494 Y89.266 E-.06707
G1 X93.309 Y89.329 E-.07417
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 31/50
; update layer progress
M73 L31
M991 S0 P30 ;notify layer change

; OBJECT_ID: 91
M204 S8000
G17
G3 Z6.4 I-1.204 J.176 P1  F42000
G1 X93.991 Y93.991 Z6.4
G1 Z6.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.44999
G1 F1200
M204 S3000
G1 X86.009 Y93.991 E.25666
G1 X86.009 Y86.009 E.25666
G1 X93.991 Y86.009 E.25666
G1 X93.991 Y90 E.12833
G1 X93.991 Y93.931 E.1264
M204 S8000
G1 X94.398 Y94.398 F42000
G1 F1200
M204 S3000
G1 X85.602 Y94.398 E.28284
G1 X85.602 Y85.602 E.28284
G1 X94.398 Y85.602 E.28284
G1 X94.398 Y90 E.14142
G1 X94.398 Y94.338 E.13949
M204 S8000
G1 X94.79 Y94.79 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F1200
M204 S4000
G1 X85.21 Y94.79 E.28535
G1 X85.21 Y85.21 E.28535
G1 X94.79 Y85.21 E.28535
G1 X94.79 Y90 E.14267
G1 X94.79 Y94.73 E.14089
; WIPE_START
G1 F3600
M204 S5000
G1 X92.79 Y94.743 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S8000
G17
G3 Z6.6 I1.217 J0 P1  F42000
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z6.6
G1 X0 Y90 F18000 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
M73 P75 R3
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
M1002 judge_flag g39_3rd_layer_detect_flag
M622 J1
    ; enable nozzle clog detect at 3rd layer
    


    M622.1 S1
    M1002 judge_flag g39_detection_flag
    M622 J1
      
        M622.1 S0
        M1002 judge_flag g39_mass_exceed_flag
        M622 J1
        
            G392 S0
            M400
            G90
            M83
            M204 S5000
            G0 Z6.6 F4000
            G39.3 S1
            G0 Z6.6 F4000
            G392 S0
          
        M623
    
    M623
M623
; SKIPPABLE_END




G1 X92.736 Y93.645 F42000
G1 Z6.2
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1200
M204 S5500
G1 X93.645 Y93.645 E.02924
G1 X93.645 Y92.926 E.02312
G3 X92.746 Y92.184 I1.168 J-2.332 E.03781
G3 X92.101 Y90.437 I3.419 J-2.254 E.06041
G1 X92.348 Y90 E.01614
G2 X93.645 Y89.238 I-4.925 J-9.859 E.04841
G1 X93.645 Y87.609 E.05236
M204 S8000
G1 X86.355 Y87.803 F42000
G1 F1200
M204 S5500
G1 X86.355 Y89.432 E.05236
G2 X87.899 Y86.943 I-1.485 J-2.645 E.0983
G1 X87.652 Y86.506 E.01614
G1 X87.379 Y86.355 E.01003
G1 X88.769 Y86.355 E.04469
G1 X88.854 Y86.506 E.00557
G3 X90.749 Y87.816 I-2.591 J5.772 E.07449
G3 X91.393 Y89.563 I-3.419 J2.254 E.06041
G1 X91.146 Y90 E.01614
G2 X89.251 Y91.31 I2.591 J5.772 E.07449
G2 X88.607 Y93.057 I3.419 J2.254 E.06041
G1 X88.854 Y93.494 E.01614
G1 X89.127 Y93.645 E.01002
G1 X87.737 Y93.645 E.04469
G1 X87.652 Y93.494 E.00557
G3 X86.355 Y92.732 I4.927 J-9.862 E.04841
G1 X86.355 Y91.103 E.05236
; CHANGE_LAYER
; Z_HEIGHT: 6.4
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F5895.652
M204 S5000
G1 X86.355 Y92.732 E-.61876
G1 X86.676 Y92.92 E-.14124
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 32/50
; update layer progress
M73 L32
M991 S0 P31 ;notify layer change

; OBJECT_ID: 91
M204 S8000
G17
G3 Z6.6 I-.176 J1.204 P1  F42000
G1 X93.991 Y93.991 Z6.6
G1 Z6.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.44999
G1 F1200
M204 S3000
G1 X86.009 Y93.991 E.25666
G1 X86.009 Y86.009 E.25666
G1 X93.991 Y86.009 E.25666
G1 X93.991 Y90 E.12833
G1 X93.991 Y93.931 E.1264
M204 S8000
G1 X94.398 Y94.398 F42000
G1 F1200
M204 S3000
G1 X85.602 Y94.398 E.28284
G1 X85.602 Y85.602 E.28284
G1 X94.398 Y85.602 E.28284
G1 X94.398 Y90 E.14142
G1 X94.398 Y94.338 E.13949
M204 S8000
G1 X94.79 Y94.79 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F1200
M204 S4000
G1 X85.21 Y94.79 E.28535
G1 X85.21 Y85.21 E.28535
G1 X94.79 Y85.21 E.28535
G1 X94.79 Y90 E.14267
G1 X94.79 Y94.73 E.14089
; WIPE_START
G1 F3600
M204 S5000
G1 X92.79 Y94.743 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S8000
G17
G3 Z6.8 I1.217 J0 P1  F42000
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z6.8
G1 X0 Y90 F18000 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
M1002 judge_flag g39_3rd_layer_detect_flag
M622 J1
    ; enable nozzle clog detect at 3rd layer
    


    M622.1 S1
    M1002 judge_flag g39_detection_flag
    M622 J1
      
        M622.1 S0
        M1002 judge_flag g39_mass_exceed_flag
        M622 J1
        
            G392 S0
            M400
            G90
            M83
            M204 S5000
            G0 Z6.8 F4000
            G39.3 S1
            G0 Z6.8 F4000
            G392 S0
          
        M623
    
    M623
M623
; SKIPPABLE_END




M73 P76 R3
G1 X92.578 Y93.645 F42000
G1 Z6.4
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1200
M204 S5500
G1 X93.645 Y93.645 E.03432
G1 X93.645 Y93.084 E.01804
G3 X92.369 Y90.874 I1.486 J-2.331 E.0853
G3 X92.8 Y90 I1.074 J-.013 E.03251
G1 X93.645 Y89.326 E.03475
G1 X93.645 Y87.698 E.05236
M204 S8000
G1 X86.355 Y87.938 F42000
G1 F1200
M204 S5500
G1 X86.355 Y89.567 E.05236
G2 X87.544 Y86.943 I-1.224 J-2.136 E.09895
G2 X87.011 Y86.355 I-1.518 J.841 E.02574
G1 X89.187 Y86.355 E.06996
G1 X90.401 Y87.379 E.05109
G3 X91.039 Y89.563 I-1.72 J1.687 E.07619
G1 X90.695 Y90 E.01788
G1 X89.599 Y90.874 E.04506
G2 X88.962 Y93.057 I1.72 J1.687 E.07619
G2 X89.494 Y93.645 I1.517 J-.841 E.02573
G1 X87.319 Y93.645 E.06996
G1 X86.355 Y92.82 E.04078
G1 X86.355 Y91.192 E.05236
; CHANGE_LAYER
; Z_HEIGHT: 6.6
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F5895.652
M204 S5000
G1 X86.355 Y92.82 E-.61876
G1 X86.638 Y93.062 E-.14124
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 33/50
; update layer progress
M73 L33
M991 S0 P32 ;notify layer change

; OBJECT_ID: 91
M204 S8000
G17
G3 Z6.8 I-.153 J1.207 P1  F42000
G1 X93.991 Y93.991 Z6.8
G1 Z6.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.44999
G1 F1200
M204 S3000
G1 X86.009 Y93.991 E.25666
G1 X86.009 Y86.009 E.25666
G1 X93.991 Y86.009 E.25666
G1 X93.991 Y90 E.12833
G1 X93.991 Y93.931 E.1264
M204 S8000
G1 X94.398 Y94.398 F42000
G1 F1200
M204 S3000
G1 X85.602 Y94.398 E.28284
G1 X85.602 Y85.602 E.28284
G1 X94.398 Y85.602 E.28284
G1 X94.398 Y90 E.14142
G1 X94.398 Y94.338 E.13949
M204 S8000
G1 X94.79 Y94.79 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F1200
M204 S4000
G1 X85.21 Y94.79 E.28535
G1 X85.21 Y85.21 E.28535
G1 X94.79 Y85.21 E.28535
G1 X94.79 Y90 E.14267
G1 X94.79 Y94.73 E.14089
; WIPE_START
G1 F3600
M204 S5000
G1 X92.79 Y94.743 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S8000
G17
G3 Z7 I1.217 J0 P1  F42000
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z7
G1 X0 Y90 F18000 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
M1002 judge_flag g39_3rd_layer_detect_flag
M622 J1
    ; enable nozzle clog detect at 3rd layer
    


    M622.1 S1
    M1002 judge_flag g39_detection_flag
    M622 J1
      
        M622.1 S0
        M1002 judge_flag g39_mass_exceed_flag
        M622 J1
        
            G392 S0
            M400
            G90
            M83
            M204 S5000
            G0 Z7 F4000
            G39.3 S1
            G0 Z7 F4000
            G392 S0
          
        M623
    
    M623
M623
; SKIPPABLE_END




G1 X92.423 Y93.645 F42000
G1 Z6.6
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1200
M204 S5500
G1 X93.645 Y93.645 E.03929
G1 X93.645 Y93.239 E.01307
G3 X92.546 Y90.874 I1.409 J-2.092 E.08812
M73 P77 R3
G3 X93.645 Y89.452 I2.981 J1.169 E.05855
G1 X93.645 Y87.824 E.05236
M204 S8000
G1 X86.355 Y88.116 F42000
G1 F1200
M204 S5500
G1 X86.355 Y89.744 E.05236
G2 X87.454 Y87.379 I-1.409 J-2.092 E.08813
G2 X86.765 Y86.355 I-2.319 J.816 E.04012
G1 X89.459 Y86.355 E.08662
G2 X90.487 Y87.379 I5.568 J-4.563 E.04676
G3 X90.783 Y89.563 I-1.678 J1.339 E.07442
G3 X89.513 Y90.874 I-7.099 J-5.609 E.05877
G2 X89.217 Y93.057 I1.678 J1.339 E.07442
G2 X89.741 Y93.645 I3.16 J-2.29 E.02534
G1 X87.047 Y93.645 E.08662
G2 X86.355 Y92.947 I-3.792 J3.066 E.03167
G1 X86.355 Y91.318 E.05236
; CHANGE_LAYER
; Z_HEIGHT: 6.8
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F5895.652
M204 S5000
G1 X86.355 Y92.947 E-.61876
G1 X86.617 Y93.211 E-.14124
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 34/50
; update layer progress
M73 L34
M991 S0 P33 ;notify layer change

; OBJECT_ID: 91
M204 S8000
G17
G3 Z7 I-.128 J1.21 P1  F42000
G1 X93.991 Y93.991 Z7
G1 Z6.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.44999
G1 F1200
M204 S3000
G1 X86.009 Y93.991 E.25666
G1 X86.009 Y86.009 E.25666
G1 X93.991 Y86.009 E.25666
G1 X93.991 Y90 E.12833
G1 X93.991 Y93.931 E.1264
M204 S8000
G1 X94.398 Y94.398 F42000
G1 F1200
M204 S3000
G1 X85.602 Y94.398 E.28284
G1 X85.602 Y85.602 E.28284
G1 X94.398 Y85.602 E.28284
G1 X94.398 Y90 E.14142
G1 X94.398 Y94.338 E.13949
M204 S8000
G1 X94.79 Y94.79 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F1200
M204 S4000
G1 X85.21 Y94.79 E.28535
G1 X85.21 Y85.21 E.28535
G1 X94.79 Y85.21 E.28535
G1 X94.79 Y90 E.14267
G1 X94.79 Y94.73 E.14089
; WIPE_START
G1 F3600
M204 S5000
G1 X92.79 Y94.743 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S8000
G17
G3 Z7.2 I1.217 J0 P1  F42000
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z7.2
G1 X0 Y90 F18000 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
M1002 judge_flag g39_3rd_layer_detect_flag
M622 J1
    ; enable nozzle clog detect at 3rd layer
    


    M622.1 S1
    M1002 judge_flag g39_detection_flag
    M622 J1
      
        M622.1 S0
        M1002 judge_flag g39_mass_exceed_flag
        M622 J1
        
            G392 S0
            M400
            G90
            M83
            M204 S5000
            G0 Z7.2 F4000
            G39.3 S1
            G0 Z7.2 F4000
            G392 S0
          
        M623
    
    M623
M623
; SKIPPABLE_END




G1 X92.208 Y93.645 F42000
G1 Z6.8
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1200
M204 S5500
G1 X93.645 Y93.645 E.04622
G1 X93.645 Y93.454 E.00614
G3 X92.693 Y90.874 I1.422 J-1.99 E.09392
G3 X93.645 Y89.66 I3.543 J1.799 E.04993
G1 X93.645 Y88.031 E.05236
M204 S8000
G1 X86.355 Y88.331 F42000
G1 F1200
M204 S5500
M73 P78 R3
G1 X86.355 Y89.96 E.05236
G2 X87.307 Y87.379 I-1.422 J-1.991 E.09393
G2 X86.546 Y86.355 I-3.158 J1.553 E.04128
G1 X89.676 Y86.355 E.10066
G3 X90.583 Y87.379 I-8.13 J8.111 E.04401
G3 X90.191 Y90 I-1.733 J1.081 E.09272
G2 X89.198 Y92.621 I1.418 J2.035 E.09576
G2 X89.96 Y93.645 I3.158 J-1.554 E.04127
G1 X86.83 Y93.645 E.10066
G2 X86.355 Y93.154 I-4.018 J3.409 E.02198
G1 X86.355 Y91.526 E.05236
; CHANGE_LAYER
; Z_HEIGHT: 7
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F5895.652
M204 S5000
G1 X86.355 Y93.154 E-.61876
G1 X86.613 Y93.421 E-.14124
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 35/50
; update layer progress
M73 L35
M991 S0 P34 ;notify layer change

; OBJECT_ID: 91
M204 S8000
G17
G3 Z7.2 I-.094 J1.213 P1  F42000
G1 X93.991 Y93.991 Z7.2
G1 Z7
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.44999
G1 F1200
M204 S3000
G1 X86.009 Y93.991 E.25666
G1 X86.009 Y86.009 E.25666
G1 X93.991 Y86.009 E.25666
G1 X93.991 Y90 E.12833
G1 X93.991 Y93.931 E.1264
M204 S8000
G1 X94.398 Y94.398 F42000
G1 F1200
M204 S3000
G1 X85.602 Y94.398 E.28284
G1 X85.602 Y85.602 E.28284
G1 X94.398 Y85.602 E.28284
G1 X94.398 Y90 E.14142
G1 X94.398 Y94.338 E.13949
M204 S8000
G1 X94.79 Y94.79 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F1200
M204 S4000
G1 X85.21 Y94.79 E.28535
G1 X85.21 Y85.21 E.28535
G1 X94.79 Y85.21 E.28535
G1 X94.79 Y90 E.14267
G1 X94.79 Y94.73 E.14089
; WIPE_START
G1 F3600
M204 S5000
G1 X92.79 Y94.743 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S8000
G17
G3 Z7.4 I1.217 J0 P1  F42000
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z7.4
G1 X0 Y90 F18000 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
M1002 judge_flag g39_3rd_layer_detect_flag
M622 J1
    ; enable nozzle clog detect at 3rd layer
    


    M622.1 S1
    M1002 judge_flag g39_detection_flag
    M622 J1
      
        M622.1 S0
        M1002 judge_flag g39_mass_exceed_flag
        M622 J1
        
            G392 S0
            M400
            G90
            M83
            M204 S5000
            G0 Z7.4 F4000
            G39.3 S1
            G0 Z7.4 F4000
            G392 S0
          
        M623
    
    M623
M623
; SKIPPABLE_END




G1 X93.645 Y92.038 F42000
G1 Z7
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1200
M204 S5500
G1 X93.623 Y93.645 E.05168
G3 X92.803 Y92.621 I3.849 J-3.924 E.0423
G3 X93.506 Y90 I2.038 J-.858 E.09393
G1 X93.645 Y89.85 E.00657
G1 X93.645 Y86.679 E.10196
G3 X93.343 Y86.355 I41.262 J-38.718 E.01425
G1 X89.871 Y86.355 E.11165
G3 X90.691 Y87.379 I-3.849 J3.924 E.0423
G3 X89.988 Y90 I-2.038 J.858 E.09393
G2 X90.012 Y93.494 I1.35 J1.738 E.12981
M73 P79 R3
G1 X90.151 Y93.645 E.0066
G1 X86.635 Y93.645 E.11307
G3 X86.355 Y93.344 I38.572 J-36.182 E.01321
G1 X86.355 Y90.174 E.10195
M73 P79 R2
G2 X87.197 Y89.127 I-3.929 J-4.021 E.04331
G2 X86.494 Y86.506 I-2.038 J-.858 E.09393
G1 X86.355 Y86.356 E.00658
G1 X86.355 Y87.984 E.05236
; CHANGE_LAYER
; Z_HEIGHT: 7.2
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F5895.652
M204 S5000
G1 X86.355 Y86.356 E-.61876
G1 X86.494 Y86.506 E-.07775
G1 X86.608 Y86.628 E-.06349
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 36/50
; update layer progress
M73 L36
M991 S0 P35 ;notify layer change

; OBJECT_ID: 91
M204 S8000
G17
G3 Z7.4 I-.859 J.862 P1  F42000
G1 X93.991 Y93.991 Z7.4
G1 Z7.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.44999
G1 F1200
M204 S3000
G1 X86.009 Y93.991 E.25666
G1 X86.009 Y86.009 E.25666
G1 X93.991 Y86.009 E.25666
G1 X93.991 Y90 E.12833
G1 X93.991 Y93.931 E.1264
M204 S8000
G1 X94.398 Y94.398 F42000
G1 F1200
M204 S3000
G1 X85.602 Y94.398 E.28284
G1 X85.602 Y85.602 E.28284
G1 X94.398 Y85.602 E.28284
G1 X94.398 Y90 E.14142
G1 X94.398 Y94.338 E.13949
M204 S8000
G1 X94.79 Y94.79 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F1200
M204 S4000
G1 X85.21 Y94.79 E.28535
G1 X85.21 Y85.21 E.28535
G1 X94.79 Y85.21 E.28535
G1 X94.79 Y90 E.14267
G1 X94.79 Y94.73 E.14089
; WIPE_START
G1 F3600
M204 S5000
G1 X92.79 Y94.743 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S8000
G17
G3 Z7.6 I1.217 J0 P1  F42000
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z7.6
G1 X0 Y90 F18000 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
M1002 judge_flag g39_3rd_layer_detect_flag
M622 J1
    ; enable nozzle clog detect at 3rd layer
    


    M622.1 S1
    M1002 judge_flag g39_detection_flag
    M622 J1
      
        M622.1 S0
        M1002 judge_flag g39_mass_exceed_flag
        M622 J1
        
            G392 S0
            M400
            G90
            M83
            M204 S5000
            G0 Z7.6 F4000
            G39.3 S1
            G0 Z7.6 F4000
            G392 S0
          
        M623
    
    M623
M623
; SKIPPABLE_END




G1 X93.645 Y91.692 F42000
G1 Z7.2
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1200
M204 S5500
G1 X93.645 Y90.064 E.05236
G2 X92.677 Y92.621 I1.434 J2.004 E.09319
G2 X93.432 Y93.645 I3.017 J-1.433 E.04116
G1 X90.348 Y93.645 E.09917
G3 X89.429 Y92.621 I9.174 J-9.152 E.04426
G3 X89.785 Y90 I1.705 J-1.103 E.09261
G2 X90.817 Y87.379 I-1.428 J-2.077 E.09611
G2 X90.063 Y86.355 I-3.017 J1.433 E.04117
G1 X93.147 Y86.355 E.09917
G2 X93.645 Y86.866 I3.732 J-3.139 E.02298
G1 X93.645 Y88.495 E.05236
M204 S8000
M73 P80 R2
G1 X87.769 Y86.355 F42000
G1 F1200
M204 S5500
G1 X86.355 Y86.355 E.04546
G1 X86.355 Y86.57 E.0069
G3 X87.323 Y89.127 I-1.434 J2.005 E.09319
G3 X86.355 Y90.361 I-3.418 J-1.684 E.0508
G1 X86.355 Y91.989 E.05236
; CHANGE_LAYER
; Z_HEIGHT: 7.4
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F5895.652
M204 S5000
G1 X86.355 Y90.361 E-.61876
G1 X86.61 Y90.09 E-.14124
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 37/50
; update layer progress
M73 L37
M991 S0 P36 ;notify layer change

; OBJECT_ID: 91
M204 S8000
G17
G3 Z7.6 I-.569 J1.076 P1  F42000
G1 X93.991 Y93.991 Z7.6
G1 Z7.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.44999
G1 F1200
M204 S3000
G1 X86.009 Y93.991 E.25666
G1 X86.009 Y86.009 E.25666
G1 X93.991 Y86.009 E.25666
G1 X93.991 Y90 E.12833
G1 X93.991 Y93.931 E.1264
M204 S8000
G1 X94.398 Y94.398 F42000
G1 F1200
M204 S3000
G1 X85.602 Y94.398 E.28284
G1 X85.602 Y85.602 E.28284
G1 X94.398 Y85.602 E.28284
G1 X94.398 Y90 E.14142
G1 X94.398 Y94.338 E.13949
M204 S8000
G1 X94.79 Y94.79 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F1200
M204 S4000
G1 X85.21 Y94.79 E.28535
G1 X85.21 Y85.21 E.28535
G1 X94.79 Y85.21 E.28535
G1 X94.79 Y90 E.14267
G1 X94.79 Y94.73 E.14089
; WIPE_START
G1 F3600
M204 S5000
G1 X92.79 Y94.743 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S8000
G17
G3 Z7.8 I1.217 J0 P1  F42000
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z7.8
G1 X0 Y90 F18000 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
M1002 judge_flag g39_3rd_layer_detect_flag
M622 J1
    ; enable nozzle clog detect at 3rd layer
    


    M622.1 S1
    M1002 judge_flag g39_detection_flag
    M622 J1
      
        M622.1 S0
        M1002 judge_flag g39_mass_exceed_flag
        M622 J1
        
            G392 S0
            M400
            G90
            M83
            M204 S5000
            G0 Z7.8 F4000
            G39.3 S1
            G0 Z7.8 F4000
            G392 S0
          
        M623
    
    M623
M623
; SKIPPABLE_END




G1 X93.645 Y91.906 F42000
G1 Z7.4
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1200
M204 S5500
G1 X93.645 Y90.278 E.05236
G2 X92.527 Y92.621 I1.384 J2.098 E.08771
G2 X93.21 Y93.645 I2.211 J-.734 E.04005
G1 X90.569 Y93.645 E.08491
G2 X89.523 Y92.621 I-5.007 J4.067 E.04717
G3 X89.191 Y90.437 I1.672 J-1.372 E.07455
G3 X90.477 Y89.127 I6.38 J4.975 E.05916
G2 X90.809 Y86.943 I-1.672 J-1.372 E.07456
G2 X90.284 Y86.355 I-2.835 J2.004 E.02538
G1 X92.925 Y86.355 E.08491
G2 X93.645 Y87.07 I3.489 J-2.795 E.03269
G1 X93.645 Y88.698 E.05236
M204 S8000
G1 X87.555 Y86.355 F42000
M73 P81 R2
G1 F1200
M204 S5500
G1 X86.355 Y86.355 E.03858
G1 X86.355 Y86.784 E.01378
G1 X86.983 Y87.379 E.02782
G3 X87.315 Y89.563 I-1.672 J1.372 E.07456
G3 X86.355 Y90.564 I-4.862 J-3.703 E.04469
G1 X86.355 Y92.192 E.05236
; CHANGE_LAYER
; Z_HEIGHT: 7.6
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F5895.652
M204 S5000
G1 X86.355 Y90.564 E-.61876
G1 X86.612 Y90.296 E-.14125
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 38/50
; update layer progress
M73 L38
M991 S0 P37 ;notify layer change

; OBJECT_ID: 91
M204 S8000
G17
G3 Z7.8 I-.545 J1.088 P1  F42000
G1 X93.991 Y93.991 Z7.8
G1 Z7.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.44999
G1 F1200
M204 S3000
G1 X86.009 Y93.991 E.25666
G1 X86.009 Y86.009 E.25666
G1 X93.991 Y86.009 E.25666
G1 X93.991 Y90 E.12833
G1 X93.991 Y93.931 E.1264
M204 S8000
G1 X94.398 Y94.398 F42000
G1 F1200
M204 S3000
G1 X85.602 Y94.398 E.28284
G1 X85.602 Y85.602 E.28284
G1 X94.398 Y85.602 E.28284
G1 X94.398 Y90 E.14142
G1 X94.398 Y94.338 E.13949
M204 S8000
G1 X94.79 Y94.79 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F1200
M204 S4000
G1 X85.21 Y94.79 E.28535
G1 X85.21 Y85.21 E.28535
G1 X94.79 Y85.21 E.28535
G1 X94.79 Y90 E.14267
G1 X94.79 Y94.73 E.14089
; WIPE_START
G1 F3600
M204 S5000
G1 X92.79 Y94.743 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S8000
G17
G3 Z8 I1.217 J0 P1  F42000
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z8
G1 X0 Y90 F18000 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
M1002 judge_flag g39_3rd_layer_detect_flag
M622 J1
    ; enable nozzle clog detect at 3rd layer
    


    M622.1 S1
    M1002 judge_flag g39_detection_flag
    M622 J1
      
        M622.1 S0
        M1002 judge_flag g39_mass_exceed_flag
        M622 J1
        
            G392 S0
            M400
            G90
            M83
            M204 S5000
            G0 Z8 F4000
            G39.3 S1
            G0 Z8 F4000
            G392 S0
          
        M623
    
    M623
M623
; SKIPPABLE_END




G1 X93.645 Y92.043 F42000
G1 Z7.6
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1200
M204 S5500
G1 X93.645 Y90.414 E.05236
G2 X92.346 Y92.621 I1.58 J2.416 E.0853
G2 X92.76 Y93.494 I1.027 J.048 E.03237
G1 X92.955 Y93.645 E.0079
G1 X90.851 Y93.645 E.06765
G1 X90.734 Y93.494 E.00613
G1 X89.608 Y92.621 E.04582
G3 X88.927 Y90.437 I1.728 J-1.737 E.07654
G1 X89.266 Y90 E.01778
G1 X90.392 Y89.127 E.04582
G2 X91.073 Y86.943 I-1.729 J-1.737 E.07654
G2 X90.54 Y86.355 I-1.415 J.749 E.02579
G1 X92.643 Y86.355 E.06765
M73 P82 R2
G1 X92.76 Y86.506 E.00614
G1 X93.645 Y87.192 E.036
G1 X93.645 Y88.821 E.05236
M204 S8000
G1 X87.38 Y86.355 F42000
G1 F1200
M204 S5500
G1 X86.355 Y86.355 E.03296
G1 X86.355 Y86.958 E.0194
G3 X87.654 Y89.127 I-1.337 J2.274 E.08476
G3 X87.24 Y90 I-1.027 J.048 E.03237
G1 X86.355 Y90.686 E.036
G1 X86.355 Y92.315 E.05236
; CHANGE_LAYER
; Z_HEIGHT: 7.8
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F5895.652
M204 S5000
G1 X86.355 Y90.686 E-.61876
G1 X86.649 Y90.459 E-.14124
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 39/50
; update layer progress
M73 L39
M991 S0 P38 ;notify layer change

; OBJECT_ID: 91
M204 S8000
G17
G3 Z8 I-.528 J1.097 P1  F42000
G1 X93.991 Y93.991 Z8
G1 Z7.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.44999
G1 F1200
M204 S3000
G1 X86.009 Y93.991 E.25666
G1 X86.009 Y86.009 E.25666
G1 X93.991 Y86.009 E.25666
G1 X93.991 Y90 E.12833
G1 X93.991 Y93.931 E.1264
M204 S8000
G1 X94.398 Y94.398 F42000
G1 F1200
M204 S3000
G1 X85.602 Y94.398 E.28284
G1 X85.602 Y85.602 E.28284
G1 X94.398 Y85.602 E.28284
G1 X94.398 Y90 E.14142
G1 X94.398 Y94.338 E.13949
M204 S8000
G1 X94.79 Y94.79 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F1200
M204 S4000
G1 X85.21 Y94.79 E.28535
G1 X85.21 Y85.21 E.28535
G1 X94.79 Y85.21 E.28535
G1 X94.79 Y90 E.14267
G1 X94.79 Y94.73 E.14089
; WIPE_START
G1 F3600
M204 S5000
G1 X92.79 Y94.743 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S8000
G17
G3 Z8.2 I1.217 J0 P1  F42000
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z8.2
G1 X0 Y90 F18000 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
M1002 judge_flag g39_3rd_layer_detect_flag
M622 J1
    ; enable nozzle clog detect at 3rd layer
    


    M622.1 S1
    M1002 judge_flag g39_detection_flag
    M622 J1
      
        M622.1 S0
        M1002 judge_flag g39_mass_exceed_flag
        M622 J1
        
            G392 S0
            M400
            G90
            M83
            M204 S5000
            G0 Z8.2 F4000
            G39.3 S1
            G0 Z8.2 F4000
            G392 S0
          
        M623
    
    M623
M623
; SKIPPABLE_END




G1 X93.645 Y92.214 F42000
G1 Z7.8
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1200
M204 S5500
G1 X93.645 Y90.586 E.05236
G2 X92.048 Y93.057 I1.526 J2.737 E.0985
G1 X92.263 Y93.494 E.01565
G1 X92.553 Y93.645 E.0105
G1 X91.305 Y93.645 E.04011
G1 X91.231 Y93.494 E.0054
G3 X89.249 Y92.184 I2.408 J-5.798 E.07688
G3 X88.554 Y90.437 I3.77 J-2.511 E.0609
G1 X88.769 Y90 E.01565
G2 X90.751 Y88.69 I-2.408 J-5.798 E.07688
G2 X91.446 Y86.943 I-3.77 J-2.511 E.0609
M73 P83 R2
G1 X91.231 Y86.506 E.01565
G1 X90.941 Y86.355 E.01051
G1 X92.189 Y86.355 E.04012
G1 X92.263 Y86.506 E.0054
G3 X93.645 Y87.278 I-4.423 J9.537 E.05095
G1 X93.645 Y88.906 E.05236
M204 S8000
G1 X87.247 Y86.355 F42000
G1 F1200
M204 S5500
G1 X86.355 Y86.355 E.02868
G1 X86.355 Y87.091 E.02368
G3 X87.88 Y89.127 I-1.488 J2.704 E.08429
G3 X87.737 Y90 I-.684 J.336 E.03037
G2 X86.355 Y90.772 I4.426 J9.542 E.05096
G1 X86.355 Y92.401 E.05236
; CHANGE_LAYER
; Z_HEIGHT: 8
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F5895.652
M204 S5000
G1 X86.355 Y90.772 E-.61876
G1 X86.68 Y90.591 E-.14125
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 40/50
; update layer progress
M73 L40
M991 S0 P39 ;notify layer change

; OBJECT_ID: 91
M204 S8000
G17
G3 Z8.2 I-.513 J1.103 P1  F42000
G1 X93.991 Y93.991 Z8.2
G1 Z8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.44999
G1 F1200
M204 S3000
G1 X86.009 Y93.991 E.25666
G1 X86.009 Y86.009 E.25666
G1 X93.991 Y86.009 E.25666
G1 X93.991 Y90 E.12833
G1 X93.991 Y93.931 E.1264
M204 S8000
G1 X94.398 Y94.398 F42000
G1 F1200
M204 S3000
G1 X85.602 Y94.398 E.28284
G1 X85.602 Y85.602 E.28284
G1 X94.398 Y85.602 E.28284
G1 X94.398 Y90 E.14142
G1 X94.398 Y94.338 E.13949
M204 S8000
G1 X94.79 Y94.79 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F1200
M204 S4000
G1 X85.21 Y94.79 E.28535
G1 X85.21 Y85.21 E.28535
G1 X94.79 Y85.21 E.28535
G1 X94.79 Y90 E.14267
G1 X94.79 Y94.73 E.14089
; WIPE_START
G1 F3600
M204 S5000
G1 X92.79 Y94.743 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S8000
G17
G3 Z8.4 I1.217 J0 P1  F42000
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z8.4
G1 X0 Y90 F18000 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
M1002 judge_flag g39_3rd_layer_detect_flag
M622 J1
    ; enable nozzle clog detect at 3rd layer
    


    M622.1 S1
    M1002 judge_flag g39_detection_flag
    M622 J1
      
        M622.1 S0
        M1002 judge_flag g39_mass_exceed_flag
        M622 J1
        
            G392 S0
            M400
            G90
            M83
            M204 S5000
            G0 Z8.4 F4000
            G39.3 S1
            G0 Z8.4 F4000
            G392 S0
          
        M623
    
    M623
M623
; SKIPPABLE_END




G1 X86.355 Y92.461 F42000
G1 Z8
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1200
M204 S5500
G1 X86.355 Y90.833 E.05236
G1 X87.379 Y90.465 E.035
G1 X87.816 Y90.463 E.01405
G1 X88.253 Y90.755 E.01691
G1 X89.127 Y92.09 E.0513
G2 X90.874 Y93.029 I2.274 J-2.135 E.06491
G1 X91.31 Y93.032 E.01405
G1 X91.747 Y92.739 E.01691
G1 X92.621 Y91.404 E.0513
G3 X93.645 Y90.695 I2.011 J1.81 E.04042
G1 X93.645 Y87.339 E.10794
G1 X92.621 Y86.971 E.03499
M73 P84 R2
G1 X92.184 Y86.968 E.01405
G1 X91.747 Y87.261 E.01691
G1 X90.874 Y88.596 E.0513
G3 X89.127 Y89.535 I-2.274 J-2.134 E.06491
G1 X88.69 Y89.538 E.01405
G1 X88.253 Y89.245 E.01691
G1 X87.379 Y87.91 E.0513
G2 X86.355 Y87.201 I-2.011 J1.81 E.04042
G1 X86.355 Y86.355 E.0272
G1 X87.138 Y86.355 E.02516
; CHANGE_LAYER
; Z_HEIGHT: 8.2
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F5895.652
M204 S5000
G1 X86.355 Y86.355 E-.29735
G1 X86.355 Y87.201 E-.32141
G1 X86.684 Y87.373 E-.14124
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 41/50
; update layer progress
M73 L41
M991 S0 P40 ;notify layer change

; OBJECT_ID: 91
M204 S8000
G17
G3 Z8.4 I-.817 J.902 P1  F42000
G1 X93.991 Y93.991 Z8.4
G1 Z8.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.44999
G1 F1200
M204 S3000
G1 X86.009 Y93.991 E.25666
G1 X86.009 Y86.009 E.25666
G1 X93.991 Y86.009 E.25666
G1 X93.991 Y90 E.12833
G1 X93.991 Y93.931 E.1264
M204 S8000
G1 X94.398 Y94.398 F42000
G1 F1200
M204 S3000
G1 X85.602 Y94.398 E.28284
G1 X85.602 Y85.602 E.28284
G1 X94.398 Y85.602 E.28284
G1 X94.398 Y90 E.14142
G1 X94.398 Y94.338 E.13949
M204 S8000
G1 X94.79 Y94.79 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F1200
M204 S4000
G1 X85.21 Y94.79 E.28535
G1 X85.21 Y85.21 E.28535
G1 X94.79 Y85.21 E.28535
G1 X94.79 Y90 E.14267
G1 X94.79 Y94.73 E.14089
; WIPE_START
G1 F3600
M204 S5000
G1 X92.79 Y94.743 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S8000
G17
G3 Z8.6 I1.217 J0 P1  F42000
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z8.6
G1 X0 Y90 F18000 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
M1002 judge_flag g39_3rd_layer_detect_flag
M622 J1
    ; enable nozzle clog detect at 3rd layer
    


    M622.1 S1
    M1002 judge_flag g39_detection_flag
    M622 J1
      
        M622.1 S0
        M1002 judge_flag g39_mass_exceed_flag
        M622 J1
        
            G392 S0
            M400
            G90
            M83
            M204 S5000
            G0 Z8.6 F4000
            G39.3 S1
            G0 Z8.6 F4000
            G392 S0
          
        M623
    
    M623
M623
; SKIPPABLE_END




G1 X86.355 Y92.503 F42000
G1 Z8.2
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1200
M204 S5500
G1 X86.355 Y90.875 E.05236
G1 X87.379 Y90.672 E.03358
G3 X88.253 Y91.136 I-.068 J1.183 E.0328
G1 X89.127 Y92.17 E.04354
G2 X90.874 Y92.822 I1.746 J-2.013 E.06126
G2 X91.747 Y92.359 I-.068 J-1.183 E.0328
G1 X92.621 Y91.324 E.04354
G3 X93.645 Y90.783 I1.579 J1.752 E.03762
G1 X93.645 Y87.381 E.10942
G1 X92.621 Y87.178 E.03357
G2 X91.747 Y87.641 I.068 J1.183 E.0328
G1 X90.874 Y88.676 E.04354
G3 X89.127 Y89.328 I-1.746 J-2.013 E.06126
G3 X88.253 Y88.864 I.068 J-1.183 E.0328
G1 X87.379 Y87.83 E.04354
G2 X86.355 Y87.289 I-1.579 J1.752 E.03763
M73 P85 R2
G1 X86.355 Y86.355 E.03004
G1 X87.049 Y86.355 E.02232
; CHANGE_LAYER
; Z_HEIGHT: 8.4
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F5895.652
M204 S5000
G1 X86.355 Y86.355 E-.26379
G1 X86.355 Y87.289 E-.35497
G1 X86.703 Y87.42 E-.14124
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 42/50
; update layer progress
M73 L42
M991 S0 P41 ;notify layer change

; OBJECT_ID: 91
M204 S8000
G17
G3 Z8.6 I-.815 J.904 P1  F42000
G1 X93.991 Y93.991 Z8.6
G1 Z8.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.44999
G1 F1200
M204 S3000
G1 X86.009 Y93.991 E.25666
G1 X86.009 Y86.009 E.25666
G1 X93.991 Y86.009 E.25666
G1 X93.991 Y90 E.12833
G1 X93.991 Y93.931 E.1264
M204 S8000
G1 X94.398 Y94.398 F42000
G1 F1200
M204 S3000
G1 X85.602 Y94.398 E.28284
G1 X85.602 Y85.602 E.28284
G1 X94.398 Y85.602 E.28284
G1 X94.398 Y90 E.14142
G1 X94.398 Y94.338 E.13949
M204 S8000
G1 X94.79 Y94.79 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F1200
M204 S4000
G1 X85.21 Y94.79 E.28535
G1 X85.21 Y85.21 E.28535
G1 X94.79 Y85.21 E.28535
G1 X94.79 Y90 E.14267
G1 X94.79 Y94.73 E.14089
; WIPE_START
G1 F3600
M204 S5000
G1 X92.79 Y94.743 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S8000
G17
G3 Z8.8 I1.217 J0 P1  F42000
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z8.8
G1 X0 Y90 F18000 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
M1002 judge_flag g39_3rd_layer_detect_flag
M622 J1
    ; enable nozzle clog detect at 3rd layer
    


    M622.1 S1
    M1002 judge_flag g39_detection_flag
    M622 J1
      
        M622.1 S0
        M1002 judge_flag g39_mass_exceed_flag
        M622 J1
        
            G392 S0
            M400
            G90
            M83
            M204 S5000
            G0 Z8.8 F4000
            G39.3 S1
            G0 Z8.8 F4000
            G392 S0
          
        M623
    
    M623
M623
; SKIPPABLE_END




G1 X86.355 Y92.524 F42000
G1 Z8.4
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1200
M204 S5500
G1 X86.355 Y90.896 E.05236
G3 X87.816 Y91.023 I.596 J1.609 E.04872
G3 X89.127 Y92.258 I-7.755 J9.536 E.05797
G2 X91.31 Y92.472 I1.268 J-1.7 E.07416
G2 X92.621 Y91.236 I-7.756 J-9.537 E.05797
G3 X93.645 Y90.83 I1.42 J2.089 E.03571
G1 X93.645 Y87.402 E.11025
G2 X92.184 Y87.529 I-.596 J1.609 E.04872
G2 X90.874 Y88.764 I7.755 J9.536 E.05797
G3 X88.69 Y88.977 I-1.268 J-1.7 E.07416
G3 X87.379 Y87.742 I7.755 J-9.536 E.05797
G2 X86.355 Y87.336 I-1.42 J2.089 E.03571
G1 X86.355 Y86.355 E.03154
G1 X87.003 Y86.355 E.02082
; CHANGE_LAYER
; Z_HEIGHT: 8.6
; LAYER_HEIGHT: 0.200001
; WIPE_START
G1 F5895.652
M204 S5000
G1 X86.355 Y86.355 E-.24603
G1 X86.355 Y87.336 E-.37273
G1 X86.714 Y87.432 E-.14124
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 43/50
; update layer progress
M73 L43
M991 S0 P42 ;notify layer change

; OBJECT_ID: 91
M204 S8000
G17
G3 Z8.8 I-.815 J.904 P1  F42000
G1 X93.991 Y93.991 Z8.8
G1 Z8.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.44999
M73 P86 R2
G1 F1200
M204 S3000
G1 X86.009 Y93.991 E.25666
G1 X86.009 Y86.009 E.25666
G1 X93.991 Y86.009 E.25666
M73 P86 R1
G1 X93.991 Y90 E.12833
G1 X93.991 Y93.931 E.1264
M204 S8000
G1 X94.398 Y94.398 F42000
G1 F1200
M204 S3000
G1 X85.602 Y94.398 E.28284
G1 X85.602 Y85.602 E.28284
G1 X94.398 Y85.602 E.28284
G1 X94.398 Y90 E.14142
G1 X94.398 Y94.338 E.13949
M204 S8000
G1 X94.79 Y94.79 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F1200
M204 S4000
G1 X85.21 Y94.79 E.28535
G1 X85.21 Y85.21 E.28535
G1 X94.79 Y85.21 E.28535
G1 X94.79 Y90 E.14267
G1 X94.79 Y94.73 E.14089
; WIPE_START
G1 F3600
M204 S5000
G1 X92.79 Y94.743 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S8000
G17
G3 Z9 I1.217 J0 P1  F42000
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z9
G1 X0 Y90 F18000 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
M1002 judge_flag g39_3rd_layer_detect_flag
M622 J1
    ; enable nozzle clog detect at 3rd layer
    


    M622.1 S1
    M1002 judge_flag g39_detection_flag
    M622 J1
      
        M622.1 S0
        M1002 judge_flag g39_mass_exceed_flag
        M622 J1
        
            G392 S0
            M400
            G90
            M83
            M204 S5000
            G0 Z9 F4000
            G39.3 S1
            G0 Z9 F4000
            G392 S0
          
        M623
    
    M623
M623
; SKIPPABLE_END




G1 X86.355 Y92.526 F42000
G1 Z8.6
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1200
M204 S5500
G1 X86.355 Y90.898 E.05236
G3 X87.379 Y90.98 I.338 J2.21 E.03334
G3 X88.69 Y92.039 I-2.354 J4.253 E.05444
G2 X91.747 Y91.884 I1.456 J-1.52 E.11023
G3 X93.645 Y90.871 I2.013 J1.489 E.07149
G1 X93.645 Y87.404 E.11151
G2 X92.621 Y87.486 I-.338 J2.21 E.03334
G2 X91.31 Y88.545 I2.353 J4.253 E.05444
G3 X88.253 Y88.389 I-1.456 J-1.52 E.11023
G2 X86.355 Y87.377 I-2.013 J1.489 E.07149
G1 X86.355 Y86.355 E.03287
G1 X86.961 Y86.355 E.01949
; CHANGE_LAYER
; Z_HEIGHT: 8.8
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F5895.652
M204 S5000
G1 X86.355 Y86.355 E-.23035
G1 X86.355 Y87.377 E-.38841
G1 X86.723 Y87.428 E-.14124
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 44/50
; update layer progress
M73 L44
M991 S0 P43 ;notify layer change

; OBJECT_ID: 91
M204 S8000
G17
G3 Z9 I-.816 J.903 P1  F42000
G1 X93.991 Y93.991 Z9
G1 Z8.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.44999
G1 F1200
M204 S3000
G1 X86.009 Y93.991 E.25666
G1 X86.009 Y86.009 E.25666
G1 X93.991 Y86.009 E.25666
G1 X93.991 Y90 E.12833
G1 X93.991 Y93.931 E.1264
M204 S8000
G1 X94.398 Y94.398 F42000
G1 F1200
M204 S3000
G1 X85.602 Y94.398 E.28284
G1 X85.602 Y85.602 E.28284
G1 X94.398 Y85.602 E.28284
M73 P87 R1
G1 X94.398 Y90 E.14142
G1 X94.398 Y94.338 E.13949
M204 S8000
G1 X94.79 Y94.79 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F1200
M204 S4000
G1 X85.21 Y94.79 E.28535
G1 X85.21 Y85.21 E.28535
G1 X94.79 Y85.21 E.28535
G1 X94.79 Y90 E.14267
G1 X94.79 Y94.73 E.14089
; WIPE_START
G1 F3600
M204 S5000
G1 X92.79 Y94.743 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S8000
G17
G3 Z9.2 I1.217 J0 P1  F42000
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z9.2
G1 X0 Y90 F18000 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
M1002 judge_flag g39_3rd_layer_detect_flag
M622 J1
    ; enable nozzle clog detect at 3rd layer
    


    M622.1 S1
    M1002 judge_flag g39_detection_flag
    M622 J1
      
        M622.1 S0
        M1002 judge_flag g39_mass_exceed_flag
        M622 J1
        
            G392 S0
            M400
            G90
            M83
            M204 S5000
            G0 Z9.2 F4000
            G39.3 S1
            G0 Z9.2 F4000
            G392 S0
          
        M623
    
    M623
M623
; SKIPPABLE_END




G1 X93.645 Y92.522 F42000
G1 Z8.8
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1200
M204 S5500
G1 X93.645 Y90.894 E.05236
G2 X91.747 Y91.683 I-.228 J2.13 E.06892
G3 X88.253 Y91.812 I-1.797 J-1.293 E.1296
G2 X86.355 Y90.882 I-1.881 J1.436 E.07045
G1 X86.355 Y87.4 E.11196
G3 X88.253 Y88.188 I.228 J2.13 E.06892
G2 X91.747 Y88.318 I1.797 J-1.293 E.1296
G3 X93.645 Y87.387 I1.881 J1.436 E.07045
G1 X93.645 Y86.355 E.03319
G1 X93.049 Y86.355 E.01917
; CHANGE_LAYER
; Z_HEIGHT: 9
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F5895.652
M204 S5000
G1 X93.645 Y86.355 E-.22651
G1 X93.645 Y87.387 E-.39225
G1 X93.275 Y87.421 E-.14124
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 45/50
; update layer progress
M73 L45
M991 S0 P44 ;notify layer change

; OBJECT_ID: 91
M204 S8000
G17
G3 Z9.2 I-1.21 J.132 P1  F42000
G1 X93.991 Y93.991 Z9.2
G1 Z9
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.44999
G1 F1200
M204 S3000
G1 X86.009 Y93.991 E.25666
G1 X86.009 Y86.009 E.25666
G1 X93.991 Y86.009 E.25666
G1 X93.991 Y90 E.12833
G1 X93.991 Y93.931 E.1264
M204 S8000
G1 X94.398 Y94.398 F42000
G1 F1200
M204 S3000
G1 X85.602 Y94.398 E.28284
G1 X85.602 Y85.602 E.28284
G1 X94.398 Y85.602 E.28284
G1 X94.398 Y90 E.14142
G1 X94.398 Y94.338 E.13949
M204 S8000
G1 X94.79 Y94.79 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F1200
M204 S4000
G1 X85.21 Y94.79 E.28535
G1 X85.21 Y85.21 E.28535
G1 X94.79 Y85.21 E.28535
M73 P88 R1
G1 X94.79 Y90 E.14267
G1 X94.79 Y94.73 E.14089
; WIPE_START
G1 F3600
M204 S5000
G1 X92.79 Y94.743 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S8000
G17
G3 Z9.4 I1.217 J0 P1  F42000
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z9.4
G1 X0 Y90 F18000 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
M1002 judge_flag g39_3rd_layer_detect_flag
M622 J1
    ; enable nozzle clog detect at 3rd layer
    


    M622.1 S1
    M1002 judge_flag g39_detection_flag
    M622 J1
      
        M622.1 S0
        M1002 judge_flag g39_mass_exceed_flag
        M622 J1
        
            G392 S0
            M400
            G90
            M83
            M204 S5000
            G0 Z9.4 F4000
            G39.3 S1
            G0 Z9.4 F4000
            G392 S0
          
        M623
    
    M623
M623
; SKIPPABLE_END




G1 X86.762 Y92.556 F42000
G1 Z9
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1200
M204 S5500
G1 X86.762 Y90.928 E.05236
G3 X88.253 Y92.019 I-1.274 J3.302 E.06011
G2 X89.563 Y92.667 I1.462 J-1.308 E.04817
G2 X91.747 Y91.475 I-.083 J-2.748 E.08303
G3 X93.238 Y90.84 I1.363 J1.132 E.05411
G1 X93.238 Y87.433 E.10953
G2 X91.747 Y88.525 I1.274 J3.302 E.06011
G3 X90.437 Y89.173 I-1.462 J-1.308 E.04817
G3 X88.253 Y87.981 I.083 J-2.748 E.08303
G2 X86.762 Y87.345 I-1.363 J1.132 E.05411
G1 X86.762 Y86.762 E.01875
G1 X87.808 Y86.762 E.03361
M204 S8000
G1 X93.441 Y86.386 F42000
; Slow Down Start
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.403885
G1 F2400;_EXTRUDE_SET_SPEED
M204 S5000
G1 X93.513 Y86.401 E.00209
; Slow Down End
; Slow Down Start
; LINE_WIDTH: 0.423672
;_EXTRUDE_SET_SPEED
G1 X93.585 Y86.415 E.0022
G1 X93.614 Y86.559 E.0044
; Slow Down End
; Slow Down Start
; LINE_WIDTH: 0.40387
;_EXTRUDE_SET_SPEED
G1 X93.614 Y90 E.09812
; Slow Down End
; Slow Down Start
; LINE_WIDTH: 0.431242
;_EXTRUDE_SET_SPEED
G1 X93.614 Y93.441 E.10556
G1 X93.585 Y93.585 E.00449
G1 X93.441 Y93.614 E.00449
; Slow Down End
; Slow Down Start
; LINE_WIDTH: 0.40388
;_EXTRUDE_SET_SPEED
G1 X90 Y93.614 E.09812
; Slow Down End
; Slow Down Start
; LINE_WIDTH: 0.431233
;_EXTRUDE_SET_SPEED
G1 X86.559 Y93.614 E.10556
G1 X86.415 Y93.585 E.00449
G1 X86.386 Y93.441 E.00449
; Slow Down End
; Slow Down Start
; LINE_WIDTH: 0.40388
;_EXTRUDE_SET_SPEED
G1 X86.386 Y90 E.09812
; Slow Down End
; Slow Down Start
; LINE_WIDTH: 0.431233
;_EXTRUDE_SET_SPEED
G1 X86.386 Y86.559 E.10556
G1 X86.415 Y86.415 E.00449
G1 X86.559 Y86.386 E.00449
; Slow Down End
; Slow Down Start
; LINE_WIDTH: 0.38904
;_EXTRUDE_SET_SPEED
G1 X93.381 Y86.386 E.18653
; Slow Down End
; CHANGE_LAYER
; Z_HEIGHT: 9.2
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F2400
G1 X91.381 Y86.386 E-.76
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 46/50
; update layer progress
M73 L46
M991 S0 P45 ;notify layer change

; OBJECT_ID: 91
M204 S8000
G17
G3 Z9.4 I-1.151 J.395 P1  F42000
G1 X93.991 Y93.991 Z9.4
G1 Z9.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.44999
G1 F1200
M204 S3000
G1 X86.009 Y93.991 E.25666
G1 X86.009 Y86.009 E.25666
G1 X93.991 Y86.009 E.25666
G1 X93.991 Y90 E.12833
M73 P89 R1
G1 X93.991 Y93.931 E.1264
M204 S8000
G1 X94.398 Y94.398 F42000
G1 F1200
M204 S3000
G1 X85.602 Y94.398 E.28284
G1 X85.602 Y85.602 E.28284
G1 X94.398 Y85.602 E.28284
G1 X94.398 Y90 E.14142
G1 X94.398 Y94.338 E.13949
M204 S8000
G1 X94.79 Y94.79 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F1200
M204 S4000
G1 X85.21 Y94.79 E.28535
G1 X85.21 Y85.21 E.28535
G1 X94.79 Y85.21 E.28535
G1 X94.79 Y90 E.14267
G1 X94.79 Y94.73 E.14089
; WIPE_START
G1 F3600
M204 S5000
G1 X92.79 Y94.743 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S8000
G17
G3 Z9.6 I1.217 J0 P1  F42000
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z9.6
G1 X0 Y90 F18000 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
M1002 judge_flag g39_3rd_layer_detect_flag
M622 J1
    ; enable nozzle clog detect at 3rd layer
    


    M622.1 S1
    M1002 judge_flag g39_detection_flag
    M622 J1
      
        M622.1 S0
        M1002 judge_flag g39_mass_exceed_flag
        M622 J1
        
            G392 S0
            M400
            G90
            M83
            M204 S5000
            G0 Z9.6 F4000
            G39.3 S1
            G0 Z9.6 F4000
            G392 S0
          
        M623
    
    M623
M623
; SKIPPABLE_END




G1 X92.834 Y93.826 F42000
G1 Z9.2
G1 E.8 F1800
; FEATURE: Bridge
; LINE_WIDTH: 0.40225
; LAYER_HEIGHT: 0.4
G1 F2400
M204 S5000
G1 X93.623 Y93.147 E.05226
G1 X93.623 Y92.551 E.02994
G1 X92.376 Y93.623 E.08258
G1 X91.682 Y93.623 E.03482
G1 X93.623 Y91.954 E.1285
G1 X93.623 Y91.358 E.02994
G1 X90.988 Y93.623 E.17442
G1 X90.295 Y93.623 E.03482
G1 X93.623 Y90.761 E.22034
G1 X93.623 Y90.165 E.02994
G1 X89.601 Y93.623 E.26626
G1 X88.907 Y93.623 E.03482
G1 X93.623 Y89.569 E.31217
G1 X93.623 Y88.972 E.02994
G1 X88.214 Y93.623 E.35809
G1 X87.52 Y93.623 E.03482
G1 X93.623 Y88.376 E.40401
G1 X93.623 Y87.779 E.02994
G1 X86.826 Y93.623 E.44993
G1 X86.377 Y93.623 E.02257
G1 X86.377 Y93.414 E.01053
G1 X93.623 Y87.183 E.47969
G1 X93.623 Y86.586 E.02994
G1 X86.377 Y92.817 E.47969
G1 X86.377 Y92.221 E.02994
G1 X93.174 Y86.377 E.44993
M73 P90 R1
G1 X92.48 Y86.377 E.03482
G1 X86.377 Y91.624 E.40401
G1 X86.377 Y91.028 E.02994
G1 X91.786 Y86.377 E.3581
G1 X91.093 Y86.377 E.03482
G1 X86.377 Y90.431 E.31218
G1 X86.377 Y89.835 E.02994
G1 X90.399 Y86.377 E.26626
G1 X89.705 Y86.377 E.03482
G1 X86.377 Y89.239 E.22034
G1 X86.377 Y88.642 E.02994
G1 X89.012 Y86.377 E.17442
G1 X88.318 Y86.377 E.03482
G1 X86.377 Y88.046 E.12851
G1 X86.377 Y87.449 E.02994
G1 X87.624 Y86.377 E.08259
G1 X86.931 Y86.377 E.03482
G1 X86.174 Y87.027 E.05007
; CHANGE_LAYER
; Z_HEIGHT: 9.4
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F2400
G1 X86.931 Y86.377 E-.37909
G1 X87.624 Y86.377 E-.2636
G1 X87.39 Y86.578 E-.11731
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 47/50
; update layer progress
M73 L47
M991 S0 P46 ;notify layer change

M106 S226.95
; OBJECT_ID: 91
M204 S8000
G17
G3 Z9.6 I-.909 J.809 P1  F42000
G1 X93.991 Y93.991 Z9.6
G1 Z9.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.44999
G1 F1342
M204 S3000
G1 X86.009 Y93.991 E.25666
G1 X86.009 Y86.009 E.25666
G1 X93.991 Y86.009 E.25666
G1 X93.991 Y90 E.12833
G1 X93.991 Y93.931 E.1264
M204 S8000
G1 X94.398 Y94.398 F42000
G1 F1342
M204 S3000
G1 X85.602 Y94.398 E.28284
G1 X85.602 Y85.602 E.28284
G1 X94.398 Y85.602 E.28284
G1 X94.398 Y90 E.14142
G1 X94.398 Y94.338 E.13949
M204 S8000
G1 X94.79 Y94.79 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F1342
M204 S4000
G1 X85.21 Y94.79 E.28535
G1 X85.21 Y85.21 E.28535
G1 X94.79 Y85.21 E.28535
G1 X94.79 Y90 E.14267
G1 X94.79 Y94.73 E.14089
; WIPE_START
G1 F3600
M204 S5000
G1 X92.79 Y94.743 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S8000
G17
G3 Z9.8 I1.217 J0 P1  F42000
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z9.8
G1 X0 Y90 F18000 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
M1002 judge_flag g39_3rd_layer_detect_flag
M622 J1
    ; enable nozzle clog detect at 3rd layer
    


    M622.1 S1
    M1002 judge_flag g39_detection_flag
    M622 J1
      
        M622.1 S0
        M1002 judge_flag g39_mass_exceed_flag
        M622 J1
        
            G392 S0
            M400
            G90
            M83
            M204 S5000
            G0 Z9.8 F4000
            G39.3 S1
            G0 Z9.8 F4000
            G392 S0
          
        M623
    
    M623
M623
; SKIPPABLE_END




G1 X87.019 Y93.828 F42000
G1 Z9.4
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.46157
G1 F1342
M204 S5000
G1 X86.355 Y93.164 E.03106
G1 X86.355 Y92.572 E.01958
G1 X87.428 Y93.645 E.05018
G1 X88.02 Y93.645 E.01958
G1 X86.355 Y91.98 E.07787
G1 X86.355 Y91.388 E.01958
G1 X88.612 Y93.645 E.10556
G1 X89.204 Y93.645 E.01958
G1 X86.355 Y90.796 E.13325
G1 X86.355 Y90.204 E.01958
G1 X89.796 Y93.645 E.16094
G1 X90.388 Y93.645 E.01958
M73 P91 R1
G1 X86.355 Y89.612 E.18863
G1 X86.355 Y89.019 E.01958
G1 X90.981 Y93.645 E.21632
G1 X91.573 Y93.645 E.01958
G1 X86.355 Y88.427 E.24401
G1 X86.355 Y87.835 E.01958
G1 X92.165 Y93.645 E.2717
G1 X92.757 Y93.645 E.01958
G1 X86.355 Y87.243 E.29939
G1 X86.355 Y86.651 E.01958
G1 X93.349 Y93.645 E.32708
G1 X93.645 Y93.645 E.00979
G1 X93.645 Y93.349 E.00979
G1 X86.651 Y86.355 E.32709
G1 X87.243 Y86.355 E.01958
G1 X93.645 Y92.757 E.2994
G1 X93.645 Y92.165 E.01958
G1 X87.835 Y86.355 E.27171
G1 X88.427 Y86.355 E.01958
G1 X93.645 Y91.573 E.24402
G1 X93.645 Y90.981 E.01958
G1 X89.019 Y86.355 E.21633
G1 X89.611 Y86.355 E.01958
G1 X93.645 Y90.389 E.18864
G1 X93.645 Y89.797 E.01958
G1 X90.203 Y86.355 E.16095
G1 X90.796 Y86.355 E.01958
G1 X93.645 Y89.204 E.13326
G1 X93.645 Y88.612 E.01958
G1 X91.388 Y86.355 E.10557
G1 X91.98 Y86.355 E.01958
G1 X93.645 Y88.02 E.07788
G1 X93.645 Y87.428 E.01958
G1 X92.572 Y86.355 E.05019
G1 X93.164 Y86.355 E.01958
G1 X93.828 Y87.019 E.03107
; CHANGE_LAYER
; Z_HEIGHT: 9.6
; LAYER_HEIGHT: 0.200001
; WIPE_START
G1 F5732.712
G1 X93.164 Y86.355 E-.35698
G1 X92.572 Y86.355 E-.22498
G1 X92.903 Y86.686 E-.17804
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 48/50
; update layer progress
M73 L48
M991 S0 P47 ;notify layer change

; OBJECT_ID: 91
M204 S8000
G17
G3 Z9.8 I-1.204 J.179 P1  F42000
G1 X93.991 Y93.991 Z9.8
G1 Z9.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.44999
G1 F1339
M204 S3000
G1 X86.009 Y93.991 E.25666
G1 X86.009 Y86.009 E.25666
G1 X93.991 Y86.009 E.25666
G1 X93.991 Y90 E.12833
G1 X93.991 Y93.931 E.1264
M204 S8000
G1 X94.398 Y94.398 F42000
G1 F1339
M204 S3000
G1 X85.602 Y94.398 E.28284
G1 X85.602 Y85.602 E.28284
G1 X94.398 Y85.602 E.28284
G1 X94.398 Y90 E.14142
G1 X94.398 Y94.338 E.13949
M204 S8000
G1 X94.79 Y94.79 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F1339
M204 S4000
G1 X85.21 Y94.79 E.28535
G1 X85.21 Y85.21 E.28535
G1 X94.79 Y85.21 E.28535
G1 X94.79 Y90 E.14267
G1 X94.79 Y94.73 E.14089
; WIPE_START
G1 F3600
M204 S5000
G1 X92.79 Y94.743 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S8000
G17
G3 Z10 I1.217 J0 P1  F42000
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z10
G1 X0 Y90 F18000 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
M1002 judge_flag g39_3rd_layer_detect_flag
M622 J1
    ; enable nozzle clog detect at 3rd layer
    


    M622.1 S1
    M1002 judge_flag g39_detection_flag
    M622 J1
      
        M622.1 S0
        M1002 judge_flag g39_mass_exceed_flag
        M622 J1
        
            G392 S0
            M400
            G90
            M83
            M204 S5000
            G0 Z10 F4000
            G39.3 S1
            G0 Z10 F4000
            G392 S0
          
        M623
    
    M623
M623
; SKIPPABLE_END




G1 X92.981 Y93.828 F42000
G1 Z9.6
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.46157
G1 F1339
M204 S5000
G1 X93.645 Y93.164 E.03107
G1 X93.645 Y92.572 E.01958
M73 P92 R1
G1 X92.572 Y93.645 E.05019
G1 X91.98 Y93.645 E.01958
G1 X93.645 Y91.98 E.07788
G1 X93.645 Y91.388 E.01958
G1 X91.388 Y93.645 E.10557
G1 X90.796 Y93.645 E.01958
G1 X93.645 Y90.796 E.13326
G1 X93.645 Y90.203 E.01958
G1 X90.203 Y93.645 E.16095
G1 X89.611 Y93.645 E.01958
G1 X93.645 Y89.611 E.18864
G1 X93.645 Y89.019 E.01958
G1 X89.019 Y93.645 E.21633
G1 X88.427 Y93.645 E.01958
G1 X93.645 Y88.427 E.24402
G1 X93.645 Y87.835 E.01958
G1 X87.835 Y93.645 E.27171
G1 X87.243 Y93.645 E.01958
G1 X93.645 Y87.243 E.2994
G1 X93.645 Y86.651 E.01958
G1 X86.651 Y93.645 E.32709
G1 X86.355 Y93.645 E.00979
G1 X86.355 Y93.349 E.00979
G1 X93.349 Y86.355 E.32708
G1 X92.757 Y86.355 E.01958
G1 X86.355 Y92.757 E.29939
G1 X86.355 Y92.165 E.01958
G1 X92.165 Y86.355 E.2717
G1 X91.573 Y86.355 E.01958
G1 X86.355 Y91.573 E.24401
G1 X86.355 Y90.981 E.01958
G1 X90.981 Y86.355 E.21632
G1 X90.388 Y86.355 E.01958
G1 X86.355 Y90.388 E.18863
G1 X86.355 Y89.796 E.01958
G1 X89.796 Y86.355 E.16094
G1 X89.204 Y86.355 E.01958
G1 X86.355 Y89.204 E.13325
G1 X86.355 Y88.612 E.01958
G1 X88.612 Y86.355 E.10556
G1 X88.02 Y86.355 E.01958
G1 X86.355 Y88.02 E.07787
G1 X86.355 Y87.428 E.01958
G1 X87.428 Y86.355 E.05018
G1 X86.836 Y86.355 E.01958
G1 X86.172 Y87.019 E.03106
; CHANGE_LAYER
; Z_HEIGHT: 9.8
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F5732.712
G1 X86.836 Y86.355 E-.35693
G1 X87.428 Y86.355 E-.22498
G1 X87.097 Y86.687 E-.17809
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 49/50
; update layer progress
M73 L49
M991 S0 P48 ;notify layer change

; OBJECT_ID: 91
M204 S8000
G17
G3 Z10 I-.885 J.835 P1  F42000
G1 X93.991 Y93.991 Z10
G1 Z9.8
M73 P93 R1
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.44999
G1 F1338
M204 S3000
G1 X86.009 Y93.991 E.25666
M73 P93 R0
G1 X86.009 Y86.009 E.25666
G1 X93.991 Y86.009 E.25666
G1 X93.991 Y90 E.12833
G1 X93.991 Y93.931 E.1264
M204 S8000
G1 X94.398 Y94.398 F42000
G1 F1338
M204 S3000
G1 X85.602 Y94.398 E.28284
G1 X85.602 Y85.602 E.28284
G1 X94.398 Y85.602 E.28284
G1 X94.398 Y90 E.14142
G1 X94.398 Y94.338 E.13949
M204 S8000
G1 X94.79 Y94.79 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F1338
M204 S4000
G1 X85.21 Y94.79 E.28535
G1 X85.21 Y85.21 E.28535
G1 X94.79 Y85.21 E.28535
G1 X94.79 Y90 E.14267
G1 X94.79 Y94.73 E.14089
; WIPE_START
G1 F3600
M204 S5000
G1 X92.79 Y94.743 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S8000
G17
G3 Z10.2 I1.217 J0 P1  F42000
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z10.2
G1 X0 Y90 F18000 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
M1002 judge_flag g39_3rd_layer_detect_flag
M622 J1
    ; enable nozzle clog detect at 3rd layer
    


    M622.1 S1
    M1002 judge_flag g39_detection_flag
    M622 J1
      
        M622.1 S0
        M1002 judge_flag g39_mass_exceed_flag
        M622 J1
        
            G392 S0
            M400
            G90
            M83
            M204 S5000
            G0 Z10.2 F4000
            G39.3 S1
            G0 Z10.2 F4000
            G392 S0
          
        M623
    
    M623
M623
; SKIPPABLE_END




G1 X87.019 Y93.828 F42000
G1 Z9.8
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.46157
G1 F1338
M204 S5000
G1 X86.355 Y93.164 E.03106
G1 X86.355 Y92.572 E.01958
G1 X87.428 Y93.645 E.05018
G1 X88.02 Y93.645 E.01958
G1 X86.355 Y91.98 E.07787
G1 X86.355 Y91.388 E.01958
G1 X88.612 Y93.645 E.10556
G1 X89.204 Y93.645 E.01958
G1 X86.355 Y90.796 E.13325
G1 X86.355 Y90.204 E.01958
G1 X89.796 Y93.645 E.16094
G1 X90.388 Y93.645 E.01958
G1 X86.355 Y89.612 E.18863
G1 X86.355 Y89.019 E.01958
G1 X90.981 Y93.645 E.21632
G1 X91.573 Y93.645 E.01958
G1 X86.355 Y88.427 E.24401
G1 X86.355 Y87.835 E.01958
G1 X92.165 Y93.645 E.2717
G1 X92.757 Y93.645 E.01958
G1 X86.355 Y87.243 E.29939
G1 X86.355 Y86.651 E.01958
G1 X93.349 Y93.645 E.32708
G1 X93.645 Y93.645 E.00979
G1 X93.645 Y93.349 E.00979
G1 X86.651 Y86.355 E.32709
G1 X87.243 Y86.355 E.01958
M73 P94 R0
G1 X93.645 Y92.757 E.2994
G1 X93.645 Y92.165 E.01958
G1 X87.835 Y86.355 E.27171
G1 X88.427 Y86.355 E.01958
G1 X93.645 Y91.573 E.24402
G1 X93.645 Y90.981 E.01958
G1 X89.019 Y86.355 E.21633
G1 X89.611 Y86.355 E.01958
G1 X93.645 Y90.389 E.18864
G1 X93.645 Y89.797 E.01958
G1 X90.203 Y86.355 E.16095
G1 X90.796 Y86.355 E.01958
G1 X93.645 Y89.204 E.13326
G1 X93.645 Y88.612 E.01958
G1 X91.388 Y86.355 E.10557
G1 X91.98 Y86.355 E.01958
G1 X93.645 Y88.02 E.07788
G1 X93.645 Y87.428 E.01958
G1 X92.572 Y86.355 E.05019
G1 X93.164 Y86.355 E.01958
G1 X93.828 Y87.019 E.03107
; CHANGE_LAYER
; Z_HEIGHT: 10
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F5732.712
G1 X93.164 Y86.355 E-.35698
G1 X92.572 Y86.355 E-.22498
G1 X92.903 Y86.686 E-.17804
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 50/50
; update layer progress
M73 L50
M991 S0 P49 ;notify layer change

; OBJECT_ID: 91
M204 S8000
G17
G3 Z10.2 I-1.185 J.276 P1  F42000
G1 X94.79 Y94.79 Z10.2
G1 Z10
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F1583
M204 S4000
G1 X85.21 Y94.79 E.28535
G1 X85.21 Y85.21 E.28535
G1 X94.79 Y85.21 E.28535
G1 X94.79 Y90 E.14267
G1 X94.79 Y94.73 E.14089
; WIPE_START
G1 F3600
M204 S5000
G1 X92.79 Y94.743 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S8000
G17
G3 Z10.4 I1.217 J0 P1  F42000
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z10.4
G1 X0 Y90 F18000 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
M1002 judge_flag g39_3rd_layer_detect_flag
M622 J1
    ; enable nozzle clog detect at 3rd layer
    


    M622.1 S1
    M1002 judge_flag g39_detection_flag
    M622 J1
      
        M622.1 S0
        M1002 judge_flag g39_mass_exceed_flag
        M622 J1
        
            G392 S0
            M400
            G90
            M83
            M204 S5000
            G0 Z10.4 F4000
            G39.3 S1
            G0 Z10.4 F4000
            G392 S0
          
        M623
    
    M623
M623
; SKIPPABLE_END




G1 X94.583 Y94.216 F42000
G1 Z10
G1 E.8 F1800
; FEATURE: Top surface
; LINE_WIDTH: 0.42
G1 F1583
M204 S2000
G1 X94.216 Y94.583 E.01544
G1 X93.683 Y94.583
G1 X94.583 Y93.683 E.0379
G1 X94.583 Y93.15
G1 X93.15 Y94.583 E.06037
G1 X92.616 Y94.583
G1 X94.583 Y92.616 E.08283
G1 X94.583 Y92.083
G1 X92.083 Y94.583 E.1053
G1 X91.55 Y94.583
G1 X94.583 Y91.55 E.12776
G1 X94.583 Y91.017
G1 X91.017 Y94.583 E.15022
G1 X90.483 Y94.583
G1 X94.583 Y90.483 E.17268
G1 X94.583 Y89.95
G1 X89.95 Y94.583 E.19515
G1 X89.417 Y94.583
G1 X94.583 Y89.417 E.21761
G1 X94.583 Y88.883
M73 P95 R0
G1 X88.883 Y94.583 E.24007
G1 X88.35 Y94.583
G1 X94.583 Y88.35 E.26254
G1 X94.583 Y87.817
G1 X87.817 Y94.583 E.285
G1 X87.284 Y94.583
G1 X94.583 Y87.284 E.30746
G1 X94.583 Y86.75
G1 X86.75 Y94.583 E.32993
G1 X86.217 Y94.583
G1 X94.583 Y86.217 E.35239
G1 X94.583 Y85.684
G1 X85.684 Y94.583 E.37485
G1 X85.417 Y94.316
G1 X94.316 Y85.417 E.37485
G1 X93.783 Y85.417
G1 X85.417 Y93.783 E.35239
G1 X85.417 Y93.249
G1 X93.249 Y85.417 E.32992
G1 X92.716 Y85.417
G1 X85.417 Y92.716 E.30746
G1 X85.417 Y92.183
G1 X92.183 Y85.417 E.285
G1 X91.65 Y85.417
G1 X85.417 Y91.65 E.26253
G1 X85.417 Y91.116
G1 X91.116 Y85.417 E.24007
G1 X90.583 Y85.417
G1 X85.417 Y90.583 E.21761
G1 X85.417 Y90.05
G1 X90.05 Y85.417 E.19514
G1 X89.517 Y85.417
G1 X85.417 Y89.517 E.17268
G1 X85.417 Y88.983
G1 X88.983 Y85.417 E.15022
G1 X88.45 Y85.417
G1 X85.417 Y88.45 E.12775
G1 X85.417 Y87.917
G1 X87.917 Y85.417 E.10529
G1 X87.384 Y85.417
G1 X85.417 Y87.384 E.08283
G1 X85.417 Y86.85
G1 X86.85 Y85.417 E.06036
G1 X86.317 Y85.417
G1 X85.417 Y86.317 E.0379
G1 X85.417 Y85.784
G1 X85.784 Y85.417 E.01544
; close powerlost recovery
M1003 S0
; WIPE_START
G1 F1800
M204 S5000
G1 X85.417 Y85.784 E-.19693
G1 X85.417 Y86.317 E-.20264
G1 X86.088 Y85.646 E-.36043
; WIPE_END
G1 E-.04 F1800
M106 S0
M106 P2 S0
M981 S0 P20000 ; close spaghetti detector
; FEATURE: Custom
; MACHINE_END_GCODE_START
; filament end gcode 

;===== date: 20231229 =====================
;turn off nozzle clog detect
G392 S0

M400 ; wait for buffer to clear
G92 E0 ; zero the extruder
G1 E-0.8 F1800 ; retract
G1 Z10.5 F900 ; lower z a little
M73 P96 R0
G1 X0 Y90 F18000 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos

M1002 judge_flag timelapse_record_flag
M622 J1
M400 P100
M971 S11 C11 O0
M400 P100
M971 S11 C11 O0
M400 P100
M971 S11 C11 O0
M400 P100
M971 S11 C11 O0
M400 P100
M971 S11 C11 O0
M400 P100
M971 S11 C11 O0
M400 P100
M971 S11 C11 O0
M400 P100
M971 S11 C11 O0
M400 P100
M971 S11 C11 O0
M400 P100
M971 S11 C11 O0
M400 P100
M971 S11 C11 O0
M400 P100
M971 S11 C11 O0
M400 P100
M971 S11 C11 O0
M400 P100
M971 S11 C11 O0
M400 P100
M971 S11 C11 O0
M400 P100
M971 S11 C11 O0
M400 P100
M971 S11 C11 O0
M400 P100
M971 S11 C11 O0
M400 P100
M971 S11 C11 O0
M400 P100
M971 S11 C11 O0
M400 P100
M971 S11 C11 O0
M400 P100
M971 S11 C11 O0
M400 P100
M971 S11 C11 O0
M400 P100
M971 S11 C11 O0
M400 P100
M971 S11 C11 O0
M400 P100
M971 S11 C11 O0
M400 P100
M971 S11 C11 O0
M400 P100
M971 S11 C11 O0
M400 P100
M971 S11 C11 O0
M400 P100
M971 S11 C11 O0
M991 S0 P-1 ;end timelapse at safe pos
M623


M140 S0 ; turn off bed
M106 S0 ; turn off fan
M106 P2 S0 ; turn off remote part cooling fan
M106 P3 S0 ; turn off chamber cooling fan

;G1 X27 F15000 ; wipe

; pull back filament to AMS
M620 S255
G1 X181 F12000
T255
G1 X0 F18000
G1 X-13.0 F3000
G1 X0 F18000 ; wipe
M621 S255

M104 S0 ; turn off hotend

M400 ; wait all motion done
M17 S
M17 Z0.4 ; lower z motor current to reduce impact if there is something in the bottom

    G1 Z110 F600
    G1 Z108

M400 P100
M17 R ; restore z current

G90
G1 X-13 Y180 F3600

G91
G1 Z-1 F600
G90
M83

M220 S100  ; Reset feedrate magnitude
M201.2 K1.0 ; Reset acc magnitude
M73.2   R1.0 ;Reset left time magnitude
M1002 set_gcode_claim_speed_level : 0

;=====printer finish  sound=========
M17
M400 S1
M1006 S1
M1006 A0 B20 L100 C37 D20 M100 E42 F20 N100
M1006 A0 B10 L100 C44 D10 M100 E44 F10 N100
M1006 A0 B10 L100 C46 D10 M100 E46 F10 N100
M1006 A44 B20 L100 C39 D20 M100 E48 F20 N100
M1006 A0 B10 L100 C44 D10 M100 E44 F10 N100
M1006 A0 B10 L100 C0 D10 M100 E0 F10 N100
M1006 A0 B10 L100 C39 D10 M100 E39 F10 N100
M1006 A0 B10 L100 C0 D10 M100 E0 F10 N100
M1006 A0 B10 L100 C44 D10 M100 E44 F10 N100
M1006 A0 B10 L100 C0 D10 M100 E0 F10 N100
M1006 A0 B10 L100 C39 D10 M100 E39 F10 N100
M1006 A0 B10 L100 C0 D10 M100 E0 F10 N100
M1006 A44 B10 L100 C0 D10 M100 E48 F10 N100
M1006 A0 B10 L100 C0 D10 M100 E0 F10 N100
M1006 A44 B20 L100 C41 D20 M100 E49 F20 N100
M1006 A0 B20 L100 C0 D20 M100 E0 F20 N100
M1006 A0 B20 L100 C37 D20 M100 E37 F20 N100
M1006 W
;=====printer finish  sound=========
M400 S1
M18 X Y Z
M73 P100 R0
; EXECUTABLE_BLOCK_END

