; HEADER_BLOCK_START
; BambuStudio 02.01.01.52
; model printing time: 3m 25s; total estimated time: 9m 50s
; total layer number: 30
; total filament length [mm] : 107.31
; total filament volume [cm^3] : 258.12
; total filament weight [g] : 0.33
; filament_density: 1.27
; filament_diameter: 1.75
; max_z_height: 6.00
; filament: 1
; HEADER_BLOCK_END

; CONFIG_BLOCK_START
; accel_to_decel_enable = 0
; accel_to_decel_factor = 50%
; activate_air_filtration = 0
; additional_cooling_fan_speed = 0
; apply_scarf_seam_on_circles = 1
; auxiliary_fan = 0
; bed_custom_model = C:/Program Files/Bambu Studio/resources/profiles/BBL/bbl-3dp-A1M.stl
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
; different_settings_to_system = bridge_speed;default_acceleration;detect_thin_wall;enable_prime_tower;enable_support;gap_infill_speed;initial_layer_acceleration;initial_layer_speed;inner_wall_acceleration;inner_wall_speed;internal_solid_infill_line_width;internal_solid_infill_speed;outer_wall_acceleration;overhang_1_4_speed;overhang_2_4_speed;overhang_4_4_speed;overhang_totally_speed;prime_tower_infill_gap;prime_tower_rib_wall;skeleton_infill_density;skin_infill_density;sparse_infill_acceleration;sparse_infill_density;sparse_infill_pattern;sparse_infill_speed;support_line_width;support_speed;top_shell_layers;top_surface_speed;travel_acceleration;wall_generator;wall_loops;filament_start_gcode;bed_custom_model;machine_start_gcode
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
; machine_start_gcode = ;===== machine: A1 mini =========================\n;===== date: 20240620 =====================\n\n;===== start to heat heatbead&hotend==========\nM1002 gcode_claim_action : 2\nM1002 set_filament_type:{filament_type[initial_no_support_extruder]}\nM104 S170\nM140 S[bed_temperature_initial_layer_single]\nG392 S0 ;turn off clog detect\nM9833.2\n;=====start printer sound ===================\nM17\nM400 S1\nM1006 S1\nM1006 A0 B0 L100 C37 D10 M100 E37 F10 N100\nM1006 A0 B0 L100 C41 D10 M100 E41 F10 N100\nM1006 A0 B0 L100 C44 D10 M100 E44 F10 N100\nM1006 A0 B10 L100 C0 D10 M100 E0 F10 N100\nM1006 A43 B10 L100 C39 D10 M100 E46 F10 N100\nM1006 A0 B0 L100 C0 D10 M100 E0 F10 N100\nM1006 A0 B0 L100 C39 D10 M100 E43 F10 N100\nM1006 A0 B0 L100 C0 D10 M100 E0 F10 N100\nM1006 A0 B0 L100 C41 D10 M100 E41 F10 N100\nM1006 A0 B0 L100 C44 D10 M100 E44 F10 N100\nM1006 A0 B0 L100 C49 D10 M100 E49 F10 N100\nM1006 A0 B0 L100 C0 D10 M100 E0 F10 N100\nM1006 A44 B10 L100 C39 D10 M100 E48 F10 N100\nM1006 A0 B0 L100 C0 D10 M100 E0 F10 N100\nM1006 A0 B0 L100 C39 D10 M100 E44 F10 N100\nM1006 A0 B0 L100 C0 D10 M100 E0 F10 N100\nM1006 A43 B10 L100 C39 D10 M100 E46 F10 N100\nM1006 W\nM18\n;=====avoid end stop =================\nG91\nG380 S2 Z30 F1200\nG380 S3 Z-20 F1200\nG1 Z5 F1200\nG90\n\n;===== reset machine status =================\nM204 S6000\n\nM630 S0 P0\nG91\nM17 Z0.3 ; lower the z-motor current\n\nG90\nM17 X0.7 Y0.9 Z0.5 ; reset motor current to default\nM960 S5 P1 ; turn on logo lamp\nG90\nM83\nM220 S100 ;Reset Feedrate\nM221 S100 ;Reset Flowrate\nM73.2   R1.0 ;Reset left time magnitude\n;====== cog noise reduction=================\nM982.2 S1 ; turn on cog noise reduction\n\n;===== prepare print temperature and material ==========\nM400\nM18\nM109 S100 H170\nM104 S170\nM400\nM17\nM400\nG28 X\n\nM211 X0 Y0 Z0 ;turn off soft endstop ; turn off soft endstop to prevent protential logic problem\n\nM975 S1 ; turn on\n\nG1 X0.0 F30000\nG1 X-13.5 F3000\n\nM620 M ;enable remap\nM620 S[initial_no_support_extruder]A   ; switch material if AMS exist\n    G392 S0 ;turn on clog detect\n    M1002 gcode_claim_action : 4\n    M400\n    M1002 set_filament_type:UNKNOWN\n    M109 S[nozzle_temperature_initial_layer]\n    M104 S250\n    M400\n    T[initial_no_support_extruder]\n    G1 X-13.5 F3000\n    M400\n    M620.1 E F{filament_max_volumetric_speed[initial_no_support_extruder]/2.4053*60} T{nozzle_temperature_range_high[initial_no_support_extruder]}\n    M109 S250 ;set nozzle to common flush temp\n    M106 P1 S0\n    G92 E0\n    G1 E50 F200\n    M400\n    M1002 set_filament_type:{filament_type[initial_no_support_extruder]}\n    M104 S{nozzle_temperature_range_high[initial_no_support_extruder]}\n    G92 E0\n    G1 E50 F{filament_max_volumetric_speed[initial_no_support_extruder]/2.4053*60}\n    M400\n    M106 P1 S178\n    G92 E0\n    G1 E5 F{filament_max_volumetric_speed[initial_no_support_extruder]/2.4053*60}\n    M109 S{nozzle_temperature_initial_layer[initial_no_support_extruder]-20} ; drop nozzle temp, make filament shink a bit\n    M104 S{nozzle_temperature_initial_layer[initial_no_support_extruder]-40}\n    G92 E0\n    G1 E-0.5 F300\n\n    G1 X0 F30000\n    G1 X-13.5 F3000\n    G1 X0 F30000 ;wipe and shake\n    G1 X-13.5 F3000\n    G1 X0 F12000 ;wipe and shake\n    G1 X0 F30000\n    G1 X-13.5 F3000\n    M109 S{nozzle_temperature_initial_layer[initial_no_support_extruder]-40}\n    G392 S0 ;turn off clog detect\nM621 S[initial_no_support_extruder]A\n\nM400\nM106 P1 S0\n;===== prepare print temperature and material end =====\n\n\n;===== mech mode fast check============================\nM1002 gcode_claim_action : 3\nG0 X25 Y175 F20000 ; find a soft place to home\n;M104 S0\nG28 Z P0 T300; home z with low precision,permit 300deg temperature\nG29.2 S0 ; turn off ABL\nM104 S170\n\n; build plate detect\nM1002 judge_flag build_plate_detect_flag\nM622 S1\n  G39.4\n  M400\nM623\n\nG1 Z5 F3000\n; G1 X90 Y-1 F30000\n; M400 P200\n; M970.3 Q1 A7 K0 O2\n; M974 Q1 S2 P0\n\n; G1 X90 Y0 Z5 F30000\n; M400 P200\n; M970 Q0 A10 B50 C90 H15 K0 M20 O3\n; M974 Q0 S2 P0\n\n; M975 S1\n; G1 F30000\nG1 X-1 Y10\nG28 X ; re-home XY\n\n;===== wipe nozzle ===============================\nM1002 gcode_claim_action : 14\nM975 S1\n\nM104 S170 ; set temp down to heatbed acceptable\nM106 S255 ; turn on fan (G28 has turn off fan)\nM211 S; push soft endstop status\nM211 X0 Y0 Z0 ;turn off Z axis endstop\n\nM83\nG1 E-1 F500\nG90\nM83\n\nM109 S170\nM104 S140\nG0 X90 Y-4 F30000\nG380 S3 Z-5 F1200\nG1 Z2 F1200\nG1 X91 F10000\nG380 S3 Z-5 F1200\nG1 Z2 F1200\nG1 X92 F10000\nG380 S3 Z-5 F1200\nG1 Z2 F1200\nG1 X93 F10000\nG380 S3 Z-5 F1200\nG1 Z2 F1200\nG1 X94 F10000\nG380 S3 Z-5 F1200\nG1 Z2 F1200\nG1 X95 F10000\nG380 S3 Z-5 F1200\nG1 Z2 F1200\nG1 X96 F10000\nG380 S3 Z-5 F1200\nG1 Z2 F1200\nG1 X97 F10000\nG380 S3 Z-5 F1200\nG1 Z2 F1200\nG1 X98 F10000\nG380 S3 Z-5 F1200\nG1 Z2 F1200\nG1 X99 F10000\nG380 S3 Z-5 F1200\nG1 Z2 F1200\nG1 X99 F10000\nG380 S3 Z-5 F1200\nG1 Z2 F1200\nG1 X99 F10000\nG380 S3 Z-5 F1200\nG1 Z2 F1200\nG1 X99 F10000\nG380 S3 Z-5 F1200\nG1 Z2 F1200\nG1 X99 F10000\nG380 S3 Z-5 F1200\n\nG1 Z5 F30000\n;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;\nG1 X25 Y175 F30000.1 ;Brush material\nG1 Z0.2 F30000.1\nG1 Y185\nG91\nG1 X-30 F30000\nG1 Y-2\nG1 X27\nG1 Y1.5\nG1 X-28\nG1 Y-2\nG1 X30\nG1 Y1.5\nG1 X-30\nG90\nM83\n\nG1 Z5 F3000\nG0 X50 Y175 F20000 ; find a soft place to home\nG28 Z P0 T300; home z with low precision, permit 300deg temperature\nG29.2 S0 ; turn off ABL\n\nG0 X85 Y185 F10000 ;move to exposed steel surface and stop the nozzle\nG0 Z-1.01 F10000\nG91\n\nG2 I1 J0 X2 Y0 F2000.1\nG2 I-0.75 J0 X-1.5\nG2 I1 J0 X2\nG2 I-0.75 J0 X-1.5\nG2 I1 J0 X2\nG2 I-0.75 J0 X-1.5\nG2 I1 J0 X2\nG2 I-0.75 J0 X-1.5\nG2 I1 J0 X2\nG2 I-0.75 J0 X-1.5\nG2 I1 J0 X2\nG2 I-0.75 J0 X-1.5\nG2 I1 J0 X2\nG2 I-0.75 J0 X-1.5\nG2 I1 J0 X2\nG2 I-0.75 J0 X-1.5\nG2 I1 J0 X2\nG2 I-0.75 J0 X-1.5\nG2 I1 J0 X2\nG2 I-0.75 J0 X-1.5\n\nG90\nG1 Z5 F30000\nG1 X25 Y175 F30000.1 ;Brush material\nG1 Z0.2 F30000.1\nG1 Y185\nG91\nG1 X-30 F30000\nG1 Y-2\nG1 X27\nG1 Y1.5\nG1 X-28\nG1 Y-2\nG1 X30\nG1 Y1.5\nG1 X-30\nG90\nM83\n\nG1 Z5\nG0 X55 Y175 F20000 ; find a soft place to home\nG28 Z P0 T300; home z with low precision, permit 300deg temperature\nG29.2 S0 ; turn off ABL\n\nG1 Z10\nG1 X85 Y185\nG1 Z-1.01\nG1 X95\nG1 X90\n\nM211 R; pop softend status\n\nM106 S0 ; turn off fan , too noisy\n;===== wipe nozzle end ================================\n\n\n;===== wait heatbed  ====================\nM1002 gcode_claim_action : 2\nM104 S0\nM190 S[bed_temperature_initial_layer_single];set bed temp\nM109 S140\n\nG1 Z5 F3000\nG29.2 S1\nG1 X10 Y10 F20000\n\n;===== bed leveling ==================================\n;M1002 set_flag g29_before_print_flag=1\nM1002 judge_flag g29_before_print_flag\nM622 J1\n    M1002 gcode_claim_action : 1\n    G29 A1 X{first_layer_print_min[0]} Y{first_layer_print_min[1]} I{first_layer_print_size[0]} J{first_layer_print_size[1]}\n    M400\n    M500 ; save cali data\nM623\n;===== bed leveling end ================================\n\n;===== home after wipe mouth============================\nM1002 judge_flag g29_before_print_flag\nM622 J0\n\n    M1002 gcode_claim_action : 13\n    G28 T145\n\nM623\n\n;===== home after wipe mouth end =======================\n\nM975 S1 ; turn on vibration supression\n;===== nozzle load line ===============================\nM975 S1\nG90\nM83\nT1000\n\nG1 X-13.5 Y0 Z10 F10000\nG1 E1.2 F500\nM400\nM1002 set_filament_type:UNKNOWN\nM109 S{nozzle_temperature[initial_extruder]}\nM400\n\nM412 S1 ;    ===turn on  filament runout detection===\nM400 P10\n\nG392 S0 ;turn on clog detect\n\nM620.3 W1; === turn on filament tangle detection===\nM400 S2\n\nM1002 set_filament_type:{filament_type[initial_no_support_extruder]}\n;M1002 set_flag extrude_cali_flag=1\nM1002 judge_flag extrude_cali_flag\nM622 J1\n    M1002 gcode_claim_action : 8\n    \n    M400\n    M900 K0.0 L1000.0 M1.0\n    G90\n    M83\n    G0 X68 Y-4 F30000\n    G0 Z0.3 F18000 ;Move to start position\n    M400\n    G0 X88 E10  F{outer_wall_volumetric_speed/(24/20)    * 60}\n    G0 X93 E.3742  F{outer_wall_volumetric_speed/(0.3*0.5)/4     * 60}\n    G0 X98 E.3742  F{outer_wall_volumetric_speed/(0.3*0.5)     * 60}\n    G0 X103 E.3742  F{outer_wall_volumetric_speed/(0.3*0.5)/4     * 60}\n    G0 X108 E.3742  F{outer_wall_volumetric_speed/(0.3*0.5)     * 60}\n    G0 X113 E.3742  F{outer_wall_volumetric_speed/(0.3*0.5)/4     * 60}\n    G0 Y0 Z0 F20000\n    M400\n    \n    G1 X-13.5 Y0 Z10 F10000\n    M400\n    \n    G1 E10 F{outer_wall_volumetric_speed/2.4*60}\n    M983 F{outer_wall_volumetric_speed/2.4} A0.3 H[nozzle_diameter]; cali dynamic extrusion compensation\n    M106 P1 S178\n    M400 S7\n    G1 X0 F18000\n    G1 X-13.5 F3000\n    G1 X0 F18000 ;wipe and shake\n    G1 X-13.5 F3000\n    G1 X0 F12000 ;wipe and shake\n    G1 X-13.5 F3000\n    M400\n    M106 P1 S0\n\n    M1002 judge_last_extrude_cali_success\n    M622 J0\n        M983 F{outer_wall_volumetric_speed/2.4} A0.3 H[nozzle_diameter]; cali dynamic extrusion compensation\n        M106 P1 S178\n        M400 S7\n        G1 X0 F18000\n        G1 X-13.5 F3000\n        G1 X0 F18000 ;wipe and shake\n        G1 X-13.5 F3000\n        G1 X0 F12000 ;wipe and shake\n        M400\n        M106 P1 S0\n    M623\n    \n    G1 X-13.5 F3000\n    M400\n    M984 A0.1 E1 S1 F{outer_wall_volumetric_speed/2.4} H[nozzle_diameter]\n    M106 P1 S178\n    M400 S7\n    G1 X0 F18000\n    G1 X-13.5 F3000\n    G1 X0 F18000 ;wipe and shake\n    G1 X-13.5 F3000\n    G1 X0 F12000 ;wipe and shake\n    G1 X-13.5 F3000\n    M400\n    M106 P1 S0\n\nM623 ; end of "draw extrinsic para cali paint"\n\n;===== extrude cali test ===============================\nM104 S{nozzle_temperature_initial_layer[initial_extruder]}\nG90\nM83\nG0 X68 Y-2.5 F30000\nG0 Z0.3 F18000 ;Move to start position\nG0 X88 E10  F{outer_wall_volumetric_speed/(24/20)    * 60}\nG0 X93 E.3742  F{outer_wall_volumetric_speed/(0.3*0.5)/4     * 60}\nG0 X98 E.3742  F{outer_wall_volumetric_speed/(0.3*0.5)     * 60}\nG0 X103 E.3742  F{outer_wall_volumetric_speed/(0.3*0.5)/4     * 60}\nG0 X108 E.3742  F{outer_wall_volumetric_speed/(0.3*0.5)     * 60}\nG0 X113 E.3742  F{outer_wall_volumetric_speed/(0.3*0.5)/4     * 60}\nG0 X115 Z0 F20000\nG0 Z5\nM400\n\n;========turn off light and wait extrude temperature =============\nM1002 gcode_claim_action : 0\n\nM400 ; wait all motion done before implement the emprical L parameters\n\n;===== for Textured PEI Plate , lower the nozzle as the nozzle was touching topmost of the texture when homing ==\n;curr_bed_type={curr_bed_type}\n{if curr_bed_type=="Textured PEI Plate"}\nG29.1 Z{-0.02} ; for Textured PEI Plate\n{endif}\n\nM960 S1 P0 ; turn off laser\nM960 S2 P0 ; turn off laser\nM106 S0 ; turn off fan\nM106 P2 S0 ; turn off big fan\nM106 P3 S0 ; turn off chamber fan\n\nM975 S1 ; turn on mech mode supression\nG90\nM83\nT1000\n\nM211 X0 Y0 Z0 ;turn off soft endstop\nM1007 S1\n\n; ---- Block A (X only, F fixed) ----\nG91\nM400\nM73 P1   ; A1\nG1 X0.01 F600\nM400\nM73 P2   ; A2\nG1 X-0.01 F600\nM400\nM73 P3   ; A3\nG1 X0.03 F600\nM400\n\n; ---- Block B (X only, distance fixed 0.04) ----\nG91\nM400\nM73 P11 ; B1\nG1 X0.04 F300\nM400\nM73 P12 ; B2\nG1 X0.04 F600\nM400\nM73 P13 ; B3\nG1 X0.04 F1200\nM400\nM73 P14 ; B4\nG1 X0.04 F2400\nM400\n\n; ---- Block C (isolate axes) ----\nG91\n; X-only\nM400\nM73 P15 ; C1\nG1 X0.04 F1200\nM400\n; Y-only\nM73 P16 ; C2\nG1 Y0.04 F1200\nM400\n; X+Y together (vector move)\nM73 P17 ; C3\nG1 X0.04 Y0.04 F1200\nM400\n; Tiny E jog without motion (if safe)\nM73 P18 ; C4\nG1 E0.2 F600\nM400\n\nM73 P4   ; A4\nG1 X-0.03 F600\nM400\n\n; Add powers-of-two style to expose bit fields\nM73 P5   ; A5\nG1 X0.02 F600     ; 2×\nM400\nM73 P6   ; A6\nG1 X0.04 F600     ; 4×\nM400\nM73 P7   ; A7\nG1 X0.08 F600     ; 8×\nM400\nM73 P8   ; A8\nG1 X-0.02 F600\nM400\nM73 P9   ; A9\nG1 X-0.04 F600\nM400\nM73 P10  ; A10\nG1 X-0.08 F600\nM400\n\n\n; ---- Block D (repeat same line) ----\nG91\nM400\nM73 P19 ; D1\nG1 X0.02 F1200\nG1 X0.02 F1200\nG1 X0.02 F1200\nG1 X0.02 F1200\nG1 X0.02 F1200\nM400\n
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
; printer_settings_id = A1 mini 0.4mm novibe RE
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
M73 P0 R9
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
M73 P5 R9
    G1 E50 F200
    M400
    M1002 set_filament_type:PETG
    M104 S270
    G92 E0
    G1 E50 F199.559
    M400
    M106 P1 S178
    G92 E0
M73 P51 R4
    G1 E5 F199.559
    M109 S235 ; drop nozzle temp, make filament shink a bit
    M104 S215
    G92 E0
M73 P54 R4
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
M73 P55 R4
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
M73 P56 R4
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
    G29 A1 X87 Y87 I6 J6
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
        G1 X-13.5 F3000
        G1 X0 F18000 ;wipe and shake
        G1 X-13.5 F3000
        G1 X0 F12000 ;wipe and shake
        M400
        M106 P1 S0
    M623
    
M73 P58 R4
    G1 X-13.5 F3000
    M400
    M984 A0.1 E1 S1 F1.8854 H0.4
    M106 P1 S178
    M400 S7
    G1 X0 F18000
M73 P59 R4
    G1 X-13.5 F3000
M73 P59 R3
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

; ---- Block A (X only, F fixed) ----
G91
M400
M73 P1   ; A1
G1 X0.01 F600
M400
M73 P2   ; A2
G1 X-0.01 F600
M400
M73 P3   ; A3
G1 X0.03 F600
M400

; ---- Block B (X only, distance fixed 0.04) ----
G91
M400
M73 P11 ; B1
M73 P60 R3
G1 X0.04 F300
M400
M73 P12 ; B2
M73 P61 R3
G1 X0.04 F600
M400
M73 P13 ; B3
G1 X0.04 F1200
M400
M73 P14 ; B4
M73 P62 R3
G1 X0.04 F2400
M400

; ---- Block C (isolate axes) ----
G91
; X-only
M400
M73 P15 ; C1
G1 X0.04 F1200
M400
; Y-only
M73 P16 ; C2
G1 Y0.04 F1200
M400
; X+Y together (vector move)
M73 P17 ; C3
G1 X0.04 Y0.04 F1200
M400
; Tiny E jog without motion (if safe)
M73 P18 ; C4
M73 P63 R3
G1 E0.2 F600
M400

M73 P4   ; A4
G1 X-0.03 F600
M400

; Add powers-of-two style to expose bit fields
M73 P5   ; A5
G1 X0.02 F600     ; 2×
M400
M73 P6   ; A6
G1 X0.04 F600     ; 4×
M400
M73 P7   ; A7
G1 X0.08 F600     ; 8×
M400
M73 P8   ; A8
G1 X-0.02 F600
M400
M73 P9   ; A9
G1 X-0.04 F600
M400
M73 P10  ; A10
G1 X-0.08 F600
M400


; ---- Block D (repeat same line) ----
G91
M400
M73 P19 ; D1
G1 X0.02 F1200
G1 X0.02 F1200
G1 X0.02 F1200
G1 X0.02 F1200
G1 X0.02 F1200
M400
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
G1 E-.8 F1800
; layer num/total_layer_count: 1/30
; update layer progress
M73 L1
M991 S0 P0 ;notify layer change

M106 S0
M106 P2 S0
; OBJECT_ID: 85
M73 P64 R3
G1 X91.836 Y91.836 F42000
M204 S6000
G1 Z.4
G1 Z.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.49999
G1 F1200
M204 S300
G1 X88.164 Y91.836 E.13257
G1 X88.164 Y88.164 E.13257
M73 P65 R3
G1 X91.836 Y88.164 E.13257
G1 X91.836 Y90 E.06628
G1 X91.836 Y91.776 E.06412
M204 S6000
G1 X92.293 Y92.293 F42000
G1 F1200
M204 S300
G1 X87.707 Y92.293 E.16557
G1 X87.707 Y87.707 E.16557
G1 X92.293 Y87.707 E.16557
G1 X92.293 Y90 E.08279
G1 X92.293 Y92.233 E.08062
M204 S6000
G1 X92.75 Y92.75 F42000
; FEATURE: Outer wall
G1 F1200
M204 S300
G1 X87.25 Y92.75 E.19858
G1 X87.25 Y87.25 E.19858
G1 X92.75 Y87.25 E.19858
G1 X92.75 Y90 E.09929
G1 X92.75 Y92.69 E.09712
; WIPE_START
G1 F1800
G1 X90.75 Y92.712 E-.76
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




G1 X90.693 Y88.347 F42000
G1 Z.2
G1 E.8 F1800
; FEATURE: Bottom surface
; LINE_WIDTH: 0.51693
G1 F1200
M204 S300
G1 X91.447 Y89.101 E.03994
G1 X91.447 Y89.772 E.0251
G1 X90.228 Y88.553 E.06454
G1 X89.558 Y88.553 E.0251
G1 X91.447 Y90.442 E.10004
G1 X91.447 Y91.112 E.0251
G1 X88.888 Y88.553 E.13554
G1 X88.553 Y88.553 E.01255
G1 X88.553 Y88.888 E.01255
G1 X91.112 Y91.447 E.13553
G1 X90.442 Y91.447 E.0251
G1 X88.553 Y89.558 E.10004
G1 X88.553 Y90.229 E.0251
G1 X89.771 Y91.447 E.06454
G1 X89.101 Y91.447 E.0251
G1 X88.347 Y90.693 E.03993
; CHANGE_LAYER
; Z_HEIGHT: 0.4
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F5063.184
G1 X89.101 Y91.447 E-.40529
G1 X89.771 Y91.447 E-.25473
G1 X89.585 Y91.261 E-.09998
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 2/30
; update layer progress
M73 L2
M991 S0 P1 ;notify layer change

; open powerlost recovery
M1003 S1
; OBJECT_ID: 85
M204 S8000
G17
G3 Z.6 I-.353 J1.165 P1  F42000
G1 X91.991 Y91.991 Z.6
G1 Z.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.44999
G1 F1200
M204 S3000
G1 X88.009 Y91.991 E.12804
G1 X88.009 Y88.009 E.12804
G1 X91.991 Y88.009 E.12804
G1 X91.991 Y90 E.06402
G1 X91.991 Y91.931 E.06209
M204 S8000
G1 X92.398 Y92.398 F42000
G1 F1200
M204 S3000
G1 X87.602 Y92.398 E.15421
G1 X87.602 Y87.602 E.15421
G1 X92.398 Y87.602 E.15421
G1 X92.398 Y90 E.07711
G1 X92.398 Y92.338 E.07518
M204 S8000
M73 P66 R3
G1 X92.79 Y92.79 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F1200
M204 S4000
G1 X87.21 Y92.79 E.16621
G1 X87.21 Y87.21 E.16621
G1 X92.79 Y87.21 E.16621
G1 X92.79 Y90 E.0831
G1 X92.79 Y92.73 E.08132
; WIPE_START
G1 F3600
M204 S5000
G1 X90.79 Y92.752 E-.76
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




G1 X90.02 Y89.966 F42000
G1 Z.4
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.36104
G1 F1200
M204 S5000
G1 X89.96 Y90 E.00173
G1 X90.002 Y90.024 E.00122
M204 S8000
G1 X90.363 Y90 F42000
; LINE_WIDTH: 0.44999
G1 F1200
M204 S5000
G1 X90.363 Y89.637 E.01166
G1 X89.637 Y89.637 E.02332
G1 X89.637 Y90.363 E.02332
G1 X90.363 Y90.363 E.02332
G1 X90.363 Y90.06 E.00973
M204 S8000
G1 X90.77 Y90 F42000
G1 F1200
M204 S5000
G1 X90.77 Y89.23 E.02475
G1 X89.23 Y89.23 E.0495
G1 X89.23 Y90.77 E.0495
G1 X90.77 Y90.77 E.0495
G1 X90.77 Y90.06 E.02282
M204 S8000
G1 X91.177 Y90 F42000
G1 F1200
M204 S5000
G1 X91.177 Y88.823 E.03784
G1 X88.823 Y88.823 E.07568
G1 X88.823 Y91.177 E.07568
G1 X91.177 Y91.177 E.07568
G1 X91.177 Y90.06 E.03591
M204 S8000
G1 X91.584 Y90 F42000
G1 F1200
M204 S5000
G1 X91.584 Y88.416 E.05093
G1 X88.416 Y88.416 E.10186
G1 X88.416 Y91.584 E.10186
G1 X91.584 Y91.584 E.10186
G1 X91.584 Y90.06 E.049
; CHANGE_LAYER
; Z_HEIGHT: 0.6
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F5895.792
G1 X91.584 Y91.584 E-.57905
G1 X91.108 Y91.584 E-.18095
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 3/30
; update layer progress
M73 L3
M991 S0 P2 ;notify layer change

; OBJECT_ID: 85
M204 S8000
G17
G3 Z.8 I-.509 J1.105 P1  F42000
G1 X91.991 Y91.991 Z.8
G1 Z.6
G1 E.8 F1800
; FEATURE: Inner wall
G1 F1200
M204 S3000
G1 X88.009 Y91.991 E.12804
G1 X88.009 Y88.009 E.12804
G1 X91.991 Y88.009 E.12804
G1 X91.991 Y90 E.06402
G1 X91.991 Y91.931 E.06209
M204 S8000
G1 X92.398 Y92.398 F42000
G1 F1200
M204 S3000
M73 P67 R3
G1 X87.602 Y92.398 E.15421
G1 X87.602 Y87.602 E.15421
G1 X92.398 Y87.602 E.15421
G1 X92.398 Y90 E.07711
G1 X92.398 Y92.338 E.07518
M204 S8000
G1 X92.79 Y92.79 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F1200
M204 S4000
G1 X87.21 Y92.79 E.16621
G1 X87.21 Y87.21 E.16621
G1 X92.79 Y87.21 E.16621
G1 X92.79 Y90 E.0831
G1 X92.79 Y92.73 E.08132
; WIPE_START
G1 F3600
M204 S5000
G1 X90.79 Y92.752 E-.76
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




G1 X90.02 Y89.966 F42000
G1 Z.6
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.36104
G1 F1200
M204 S5000
G1 X89.96 Y90 E.00173
G1 X90.002 Y90.024 E.00122
M204 S8000
G1 X90.363 Y90 F42000
; LINE_WIDTH: 0.44999
G1 F1200
M204 S5000
G1 X90.363 Y89.637 E.01166
G1 X89.637 Y89.637 E.02332
G1 X89.637 Y90.363 E.02332
G1 X90.363 Y90.363 E.02332
G1 X90.363 Y90.06 E.00973
M204 S8000
G1 X90.77 Y90 F42000
G1 F1200
M204 S5000
G1 X90.77 Y89.23 E.02475
G1 X89.23 Y89.23 E.0495
G1 X89.23 Y90.77 E.0495
G1 X90.77 Y90.77 E.0495
G1 X90.77 Y90.06 E.02282
M204 S8000
G1 X91.177 Y90 F42000
G1 F1200
M204 S5000
G1 X91.177 Y88.823 E.03784
G1 X88.823 Y88.823 E.07568
G1 X88.823 Y91.177 E.07568
G1 X91.177 Y91.177 E.07568
G1 X91.177 Y90.06 E.03591
M204 S8000
G1 X91.584 Y90 F42000
G1 F1200
M204 S5000
G1 X91.584 Y88.416 E.05093
G1 X88.416 Y88.416 E.10186
G1 X88.416 Y91.584 E.10186
G1 X91.584 Y91.584 E.10186
M73 P68 R3
G1 X91.584 Y90.06 E.049
; CHANGE_LAYER
; Z_HEIGHT: 0.8
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F5895.792
G1 X91.584 Y91.584 E-.57905
G1 X91.108 Y91.584 E-.18095
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 4/30
; update layer progress
M73 L4
M991 S0 P3 ;notify layer change

M106 S229.5
; OBJECT_ID: 85
M204 S8000
G17
G3 Z1 I-.509 J1.105 P1  F42000
G1 X91.991 Y91.991 Z1
G1 Z.8
G1 E.8 F1800
; FEATURE: Inner wall
G1 F1200
M204 S3000
G1 X88.009 Y91.991 E.12804
G1 X88.009 Y88.009 E.12804
G1 X91.991 Y88.009 E.12804
G1 X91.991 Y90 E.06402
G1 X91.991 Y91.931 E.06209
M204 S8000
G1 X92.398 Y92.398 F42000
G1 F1200
M204 S3000
G1 X87.602 Y92.398 E.15421
G1 X87.602 Y87.602 E.15421
G1 X92.398 Y87.602 E.15421
G1 X92.398 Y90 E.07711
G1 X92.398 Y92.338 E.07518
M204 S8000
G1 X92.79 Y92.79 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F1200
M204 S4000
G1 X87.21 Y92.79 E.16621
G1 X87.21 Y87.21 E.16621
G1 X92.79 Y87.21 E.16621
G1 X92.79 Y90 E.0831
G1 X92.79 Y92.73 E.08132
; WIPE_START
G1 F3600
M204 S5000
G1 X90.79 Y92.752 E-.76
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




G1 X90.02 Y89.966 F42000
G1 Z.8
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.36104
G1 F1200
M204 S5000
G1 X89.96 Y90 E.00173
G1 X90.002 Y90.024 E.00122
M204 S8000
G1 X90.363 Y90 F42000
; LINE_WIDTH: 0.44999
G1 F1200
M204 S5000
G1 X90.363 Y89.637 E.01166
G1 X89.637 Y89.637 E.02332
G1 X89.637 Y90.363 E.02332
G1 X90.363 Y90.363 E.02332
G1 X90.363 Y90.06 E.00973
M204 S8000
G1 X90.77 Y90 F42000
G1 F1200
M204 S5000
G1 X90.77 Y89.23 E.02475
G1 X89.23 Y89.23 E.0495
G1 X89.23 Y90.77 E.0495
G1 X90.77 Y90.77 E.0495
G1 X90.77 Y90.06 E.02282
M204 S8000
G1 X91.177 Y90 F42000
G1 F1200
M204 S5000
G1 X91.177 Y88.823 E.03784
G1 X88.823 Y88.823 E.07568
G1 X88.823 Y91.177 E.07568
G1 X91.177 Y91.177 E.07568
G1 X91.177 Y90.06 E.03591
M204 S8000
G1 X91.584 Y90 F42000
G1 F1200
M204 S5000
G1 X91.584 Y88.416 E.05093
G1 X88.416 Y88.416 E.10186
G1 X88.416 Y91.584 E.10186
M73 P69 R3
G1 X91.584 Y91.584 E.10186
G1 X91.584 Y90.06 E.049
; CHANGE_LAYER
; Z_HEIGHT: 1
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F5895.792
G1 X91.584 Y91.584 E-.57905
G1 X91.108 Y91.584 E-.18095
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 5/30
; update layer progress
M73 L5
M991 S0 P4 ;notify layer change

; OBJECT_ID: 85
M204 S8000
G17
G3 Z1.2 I-.509 J1.105 P1  F42000
G1 X91.991 Y91.991 Z1.2
G1 Z1
G1 E.8 F1800
; FEATURE: Inner wall
G1 F1200
M204 S3000
G1 X88.009 Y91.991 E.12804
G1 X88.009 Y88.009 E.12804
G1 X91.991 Y88.009 E.12804
G1 X91.991 Y90 E.06402
G1 X91.991 Y91.931 E.06209
M204 S8000
G1 X92.398 Y92.398 F42000
G1 F1200
M204 S3000
G1 X87.602 Y92.398 E.15421
G1 X87.602 Y87.602 E.15421
G1 X92.398 Y87.602 E.15421
G1 X92.398 Y90 E.07711
G1 X92.398 Y92.338 E.07518
M204 S8000
G1 X92.79 Y92.79 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F1200
M204 S4000
G1 X87.21 Y92.79 E.16621
G1 X87.21 Y87.21 E.16621
G1 X92.79 Y87.21 E.16621
G1 X92.79 Y90 E.0831
G1 X92.79 Y92.73 E.08132
; WIPE_START
G1 F3600
M204 S5000
G1 X90.79 Y92.752 E-.76
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




G1 X90.02 Y89.966 F42000
G1 Z1
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.36104
G1 F1200
M204 S5000
G1 X89.96 Y90 E.00173
G1 X90.002 Y90.024 E.00122
M204 S8000
G1 X90.363 Y90 F42000
; LINE_WIDTH: 0.44999
G1 F1200
M204 S5000
G1 X90.363 Y89.637 E.01166
G1 X89.637 Y89.637 E.02332
G1 X89.637 Y90.363 E.02332
G1 X90.363 Y90.363 E.02332
M73 P69 R2
G1 X90.363 Y90.06 E.00973
M204 S8000
G1 X90.77 Y90 F42000
G1 F1200
M204 S5000
G1 X90.77 Y89.23 E.02475
G1 X89.23 Y89.23 E.0495
G1 X89.23 Y90.77 E.0495
G1 X90.77 Y90.77 E.0495
G1 X90.77 Y90.06 E.02282
M204 S8000
G1 X91.177 Y90 F42000
G1 F1200
M204 S5000
G1 X91.177 Y88.823 E.03784
G1 X88.823 Y88.823 E.07568
G1 X88.823 Y91.177 E.07568
G1 X91.177 Y91.177 E.07568
G1 X91.177 Y90.06 E.03591
M204 S8000
G1 X91.584 Y90 F42000
G1 F1200
M204 S5000
G1 X91.584 Y88.416 E.05093
G1 X88.416 Y88.416 E.10186
G1 X88.416 Y91.584 E.10186
G1 X91.584 Y91.584 E.10186
G1 X91.584 Y90.06 E.049
; CHANGE_LAYER
; Z_HEIGHT: 1.2
; LAYER_HEIGHT: 0.2
; WIPE_START
M73 P70 R2
G1 F5895.792
G1 X91.584 Y91.584 E-.57905
G1 X91.108 Y91.584 E-.18095
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 6/30
; update layer progress
M73 L6
M991 S0 P5 ;notify layer change

; OBJECT_ID: 85
M204 S8000
G17
G3 Z1.4 I-.509 J1.105 P1  F42000
G1 X91.991 Y91.991 Z1.4
G1 Z1.2
G1 E.8 F1800
; FEATURE: Inner wall
G1 F1200
M204 S3000
G1 X88.009 Y91.991 E.12804
G1 X88.009 Y88.009 E.12804
G1 X91.991 Y88.009 E.12804
G1 X91.991 Y90 E.06402
G1 X91.991 Y91.931 E.06209
M204 S8000
G1 X92.398 Y92.398 F42000
G1 F1200
M204 S3000
G1 X87.602 Y92.398 E.15421
G1 X87.602 Y87.602 E.15421
G1 X92.398 Y87.602 E.15421
G1 X92.398 Y90 E.07711
G1 X92.398 Y92.338 E.07518
M204 S8000
G1 X92.79 Y92.79 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F1200
M204 S4000
G1 X87.21 Y92.79 E.16621
G1 X87.21 Y87.21 E.16621
G1 X92.79 Y87.21 E.16621
G1 X92.79 Y90 E.0831
G1 X92.79 Y92.73 E.08132
; WIPE_START
G1 F3600
M204 S5000
G1 X90.79 Y92.752 E-.76
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




G1 X90.02 Y89.966 F42000
G1 Z1.2
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.36104
G1 F1200
M204 S5000
G1 X89.96 Y90 E.00173
G1 X90.002 Y90.024 E.00122
M204 S8000
G1 X90.363 Y90 F42000
; LINE_WIDTH: 0.44999
G1 F1200
M204 S5000
G1 X90.363 Y89.637 E.01166
G1 X89.637 Y89.637 E.02332
G1 X89.637 Y90.363 E.02332
G1 X90.363 Y90.363 E.02332
G1 X90.363 Y90.06 E.00973
M204 S8000
G1 X90.77 Y90 F42000
G1 F1200
M204 S5000
G1 X90.77 Y89.23 E.02475
G1 X89.23 Y89.23 E.0495
G1 X89.23 Y90.77 E.0495
G1 X90.77 Y90.77 E.0495
G1 X90.77 Y90.06 E.02282
M204 S8000
G1 X91.177 Y90 F42000
G1 F1200
M204 S5000
G1 X91.177 Y88.823 E.03784
G1 X88.823 Y88.823 E.07568
G1 X88.823 Y91.177 E.07568
G1 X91.177 Y91.177 E.07568
G1 X91.177 Y90.06 E.03591
M204 S8000
G1 X91.584 Y90 F42000
G1 F1200
M204 S5000
M73 P71 R2
G1 X91.584 Y88.416 E.05093
G1 X88.416 Y88.416 E.10186
G1 X88.416 Y91.584 E.10186
G1 X91.584 Y91.584 E.10186
G1 X91.584 Y90.06 E.049
; CHANGE_LAYER
; Z_HEIGHT: 1.4
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F5895.792
G1 X91.584 Y91.584 E-.57905
G1 X91.108 Y91.584 E-.18095
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 7/30
; update layer progress
M73 L7
M991 S0 P6 ;notify layer change

; OBJECT_ID: 85
M204 S8000
G17
G3 Z1.6 I-.509 J1.105 P1  F42000
G1 X91.991 Y91.991 Z1.6
G1 Z1.4
G1 E.8 F1800
; FEATURE: Inner wall
G1 F1200
M204 S3000
G1 X88.009 Y91.991 E.12804
G1 X88.009 Y88.009 E.12804
G1 X91.991 Y88.009 E.12804
G1 X91.991 Y90 E.06402
G1 X91.991 Y91.931 E.06209
M204 S8000
G1 X92.398 Y92.398 F42000
G1 F1200
M204 S3000
G1 X87.602 Y92.398 E.15421
G1 X87.602 Y87.602 E.15421
G1 X92.398 Y87.602 E.15421
G1 X92.398 Y90 E.07711
G1 X92.398 Y92.338 E.07518
M204 S8000
G1 X92.79 Y92.79 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F1200
M204 S4000
G1 X87.21 Y92.79 E.16621
G1 X87.21 Y87.21 E.16621
G1 X92.79 Y87.21 E.16621
G1 X92.79 Y90 E.0831
G1 X92.79 Y92.73 E.08132
; WIPE_START
G1 F3600
M204 S5000
G1 X90.79 Y92.752 E-.76
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




G1 X90.02 Y89.966 F42000
G1 Z1.4
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.36104
G1 F1200
M204 S5000
G1 X89.96 Y90 E.00173
G1 X90.002 Y90.024 E.00122
M204 S8000
G1 X90.363 Y90 F42000
; LINE_WIDTH: 0.44999
G1 F1200
M204 S5000
G1 X90.363 Y89.637 E.01166
G1 X89.637 Y89.637 E.02332
G1 X89.637 Y90.363 E.02332
G1 X90.363 Y90.363 E.02332
G1 X90.363 Y90.06 E.00973
M204 S8000
G1 X90.77 Y90 F42000
G1 F1200
M204 S5000
G1 X90.77 Y89.23 E.02475
G1 X89.23 Y89.23 E.0495
G1 X89.23 Y90.77 E.0495
G1 X90.77 Y90.77 E.0495
G1 X90.77 Y90.06 E.02282
M204 S8000
G1 X91.177 Y90 F42000
G1 F1200
M204 S5000
G1 X91.177 Y88.823 E.03784
G1 X88.823 Y88.823 E.07568
G1 X88.823 Y91.177 E.07568
G1 X91.177 Y91.177 E.07568
G1 X91.177 Y90.06 E.03591
M204 S8000
G1 X91.584 Y90 F42000
G1 F1200
M204 S5000
G1 X91.584 Y88.416 E.05093
M73 P72 R2
G1 X88.416 Y88.416 E.10186
G1 X88.416 Y91.584 E.10186
G1 X91.584 Y91.584 E.10186
G1 X91.584 Y90.06 E.049
; CHANGE_LAYER
; Z_HEIGHT: 1.6
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F5895.792
G1 X91.584 Y91.584 E-.57905
G1 X91.108 Y91.584 E-.18095
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 8/30
; update layer progress
M73 L8
M991 S0 P7 ;notify layer change

; OBJECT_ID: 85
M204 S8000
G17
G3 Z1.8 I-.509 J1.105 P1  F42000
G1 X91.991 Y91.991 Z1.8
G1 Z1.6
G1 E.8 F1800
; FEATURE: Inner wall
G1 F1200
M204 S3000
G1 X88.009 Y91.991 E.12804
G1 X88.009 Y88.009 E.12804
G1 X91.991 Y88.009 E.12804
G1 X91.991 Y90 E.06402
G1 X91.991 Y91.931 E.06209
M204 S8000
G1 X92.398 Y92.398 F42000
G1 F1200
M204 S3000
G1 X87.602 Y92.398 E.15421
G1 X87.602 Y87.602 E.15421
G1 X92.398 Y87.602 E.15421
G1 X92.398 Y90 E.07711
G1 X92.398 Y92.338 E.07518
M204 S8000
G1 X92.79 Y92.79 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F1200
M204 S4000
G1 X87.21 Y92.79 E.16621
G1 X87.21 Y87.21 E.16621
G1 X92.79 Y87.21 E.16621
G1 X92.79 Y90 E.0831
G1 X92.79 Y92.73 E.08132
; WIPE_START
G1 F3600
M204 S5000
G1 X90.79 Y92.752 E-.76
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




G1 X90.02 Y89.966 F42000
G1 Z1.6
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.36104
G1 F1200
M204 S5000
G1 X89.96 Y90 E.00173
G1 X90.002 Y90.024 E.00122
M204 S8000
G1 X90.363 Y90 F42000
; LINE_WIDTH: 0.44999
G1 F1200
M204 S5000
G1 X90.363 Y89.637 E.01166
G1 X89.637 Y89.637 E.02332
G1 X89.637 Y90.363 E.02332
G1 X90.363 Y90.363 E.02332
G1 X90.363 Y90.06 E.00973
M204 S8000
G1 X90.77 Y90 F42000
G1 F1200
M204 S5000
G1 X90.77 Y89.23 E.02475
G1 X89.23 Y89.23 E.0495
G1 X89.23 Y90.77 E.0495
G1 X90.77 Y90.77 E.0495
G1 X90.77 Y90.06 E.02282
M204 S8000
G1 X91.177 Y90 F42000
G1 F1200
M204 S5000
G1 X91.177 Y88.823 E.03784
G1 X88.823 Y88.823 E.07568
G1 X88.823 Y91.177 E.07568
G1 X91.177 Y91.177 E.07568
G1 X91.177 Y90.06 E.03591
M204 S8000
G1 X91.584 Y90 F42000
G1 F1200
M204 S5000
G1 X91.584 Y88.416 E.05093
G1 X88.416 Y88.416 E.10186
M73 P73 R2
G1 X88.416 Y91.584 E.10186
G1 X91.584 Y91.584 E.10186
G1 X91.584 Y90.06 E.049
; CHANGE_LAYER
; Z_HEIGHT: 1.8
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F5895.792
G1 X91.584 Y91.584 E-.57905
G1 X91.108 Y91.584 E-.18095
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 9/30
; update layer progress
M73 L9
M991 S0 P8 ;notify layer change

; OBJECT_ID: 85
M204 S8000
G17
G3 Z2 I-.509 J1.105 P1  F42000
G1 X91.991 Y91.991 Z2
G1 Z1.8
G1 E.8 F1800
; FEATURE: Inner wall
G1 F1200
M204 S3000
G1 X88.009 Y91.991 E.12804
G1 X88.009 Y88.009 E.12804
G1 X91.991 Y88.009 E.12804
G1 X91.991 Y90 E.06402
G1 X91.991 Y91.931 E.06209
M204 S8000
G1 X92.398 Y92.398 F42000
G1 F1200
M204 S3000
G1 X87.602 Y92.398 E.15421
G1 X87.602 Y87.602 E.15421
G1 X92.398 Y87.602 E.15421
G1 X92.398 Y90 E.07711
G1 X92.398 Y92.338 E.07518
M204 S8000
G1 X92.79 Y92.79 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F1200
M204 S4000
G1 X87.21 Y92.79 E.16621
G1 X87.21 Y87.21 E.16621
G1 X92.79 Y87.21 E.16621
G1 X92.79 Y90 E.0831
G1 X92.79 Y92.73 E.08132
; WIPE_START
G1 F3600
M204 S5000
G1 X90.79 Y92.752 E-.76
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




G1 X90.02 Y89.966 F42000
G1 Z1.8
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.36104
G1 F1200
M204 S5000
G1 X89.96 Y90 E.00173
G1 X90.002 Y90.024 E.00122
M204 S8000
G1 X90.363 Y90 F42000
; LINE_WIDTH: 0.44999
G1 F1200
M204 S5000
G1 X90.363 Y89.637 E.01166
G1 X89.637 Y89.637 E.02332
G1 X89.637 Y90.363 E.02332
G1 X90.363 Y90.363 E.02332
G1 X90.363 Y90.06 E.00973
M204 S8000
G1 X90.77 Y90 F42000
G1 F1200
M204 S5000
G1 X90.77 Y89.23 E.02475
G1 X89.23 Y89.23 E.0495
G1 X89.23 Y90.77 E.0495
G1 X90.77 Y90.77 E.0495
G1 X90.77 Y90.06 E.02282
M204 S8000
G1 X91.177 Y90 F42000
G1 F1200
M204 S5000
G1 X91.177 Y88.823 E.03784
G1 X88.823 Y88.823 E.07568
G1 X88.823 Y91.177 E.07568
G1 X91.177 Y91.177 E.07568
G1 X91.177 Y90.06 E.03591
M204 S8000
G1 X91.584 Y90 F42000
G1 F1200
M204 S5000
G1 X91.584 Y88.416 E.05093
G1 X88.416 Y88.416 E.10186
G1 X88.416 Y91.584 E.10186
M73 P74 R2
G1 X91.584 Y91.584 E.10186
G1 X91.584 Y90.06 E.049
; CHANGE_LAYER
; Z_HEIGHT: 2
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F5895.792
G1 X91.584 Y91.584 E-.57905
G1 X91.108 Y91.584 E-.18095
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 10/30
; update layer progress
M73 L10
M991 S0 P9 ;notify layer change

; OBJECT_ID: 85
M204 S8000
G17
G3 Z2.2 I-.509 J1.105 P1  F42000
G1 X91.991 Y91.991 Z2.2
G1 Z2
G1 E.8 F1800
; FEATURE: Inner wall
G1 F1200
M204 S3000
G1 X88.009 Y91.991 E.12804
G1 X88.009 Y88.009 E.12804
G1 X91.991 Y88.009 E.12804
G1 X91.991 Y90 E.06402
G1 X91.991 Y91.931 E.06209
M204 S8000
G1 X92.398 Y92.398 F42000
G1 F1200
M204 S3000
G1 X87.602 Y92.398 E.15421
G1 X87.602 Y87.602 E.15421
G1 X92.398 Y87.602 E.15421
G1 X92.398 Y90 E.07711
G1 X92.398 Y92.338 E.07518
M204 S8000
G1 X92.79 Y92.79 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F1200
M204 S4000
G1 X87.21 Y92.79 E.16621
G1 X87.21 Y87.21 E.16621
G1 X92.79 Y87.21 E.16621
G1 X92.79 Y90 E.0831
G1 X92.79 Y92.73 E.08132
; WIPE_START
G1 F3600
M204 S5000
G1 X90.79 Y92.752 E-.76
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




G1 X90.02 Y89.966 F42000
G1 Z2
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.36104
G1 F1200
M204 S5000
G1 X89.96 Y90 E.00173
G1 X90.002 Y90.024 E.00122
M204 S8000
G1 X90.363 Y90 F42000
; LINE_WIDTH: 0.44999
G1 F1200
M204 S5000
G1 X90.363 Y89.637 E.01166
G1 X89.637 Y89.637 E.02332
G1 X89.637 Y90.363 E.02332
G1 X90.363 Y90.363 E.02332
G1 X90.363 Y90.06 E.00973
M204 S8000
G1 X90.77 Y90 F42000
G1 F1200
M204 S5000
G1 X90.77 Y89.23 E.02475
G1 X89.23 Y89.23 E.0495
G1 X89.23 Y90.77 E.0495
G1 X90.77 Y90.77 E.0495
G1 X90.77 Y90.06 E.02282
M204 S8000
G1 X91.177 Y90 F42000
G1 F1200
M204 S5000
G1 X91.177 Y88.823 E.03784
G1 X88.823 Y88.823 E.07568
G1 X88.823 Y91.177 E.07568
G1 X91.177 Y91.177 E.07568
G1 X91.177 Y90.06 E.03591
M204 S8000
G1 X91.584 Y90 F42000
G1 F1200
M204 S5000
G1 X91.584 Y88.416 E.05093
M73 P75 R2
G1 X88.416 Y88.416 E.10186
G1 X88.416 Y91.584 E.10186
G1 X91.584 Y91.584 E.10186
G1 X91.584 Y90.06 E.049
; CHANGE_LAYER
; Z_HEIGHT: 2.2
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F5895.792
G1 X91.584 Y91.584 E-.57905
G1 X91.108 Y91.584 E-.18095
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 11/30
; update layer progress
M73 L11
M991 S0 P10 ;notify layer change

; OBJECT_ID: 85
M204 S8000
G17
G3 Z2.4 I-.509 J1.105 P1  F42000
G1 X91.991 Y91.991 Z2.4
G1 Z2.2
G1 E.8 F1800
; FEATURE: Inner wall
G1 F1200
M204 S3000
G1 X88.009 Y91.991 E.12804
G1 X88.009 Y88.009 E.12804
G1 X91.991 Y88.009 E.12804
G1 X91.991 Y90 E.06402
G1 X91.991 Y91.931 E.06209
M204 S8000
G1 X92.398 Y92.398 F42000
G1 F1200
M204 S3000
G1 X87.602 Y92.398 E.15421
G1 X87.602 Y87.602 E.15421
G1 X92.398 Y87.602 E.15421
G1 X92.398 Y90 E.07711
G1 X92.398 Y92.338 E.07518
M204 S8000
G1 X92.79 Y92.79 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F1200
M204 S4000
G1 X87.21 Y92.79 E.16621
G1 X87.21 Y87.21 E.16621
G1 X92.79 Y87.21 E.16621
G1 X92.79 Y90 E.0831
G1 X92.79 Y92.73 E.08132
; WIPE_START
G1 F3600
M204 S5000
G1 X90.79 Y92.752 E-.76
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




G1 X90.02 Y89.966 F42000
G1 Z2.2
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.36104
G1 F1200
M204 S5000
G1 X89.96 Y90 E.00173
G1 X90.002 Y90.024 E.00122
M204 S8000
G1 X90.363 Y90 F42000
; LINE_WIDTH: 0.44999
G1 F1200
M204 S5000
G1 X90.363 Y89.637 E.01166
G1 X89.637 Y89.637 E.02332
G1 X89.637 Y90.363 E.02332
G1 X90.363 Y90.363 E.02332
G1 X90.363 Y90.06 E.00973
M204 S8000
G1 X90.77 Y90 F42000
G1 F1200
M204 S5000
G1 X90.77 Y89.23 E.02475
G1 X89.23 Y89.23 E.0495
G1 X89.23 Y90.77 E.0495
G1 X90.77 Y90.77 E.0495
G1 X90.77 Y90.06 E.02282
M204 S8000
G1 X91.177 Y90 F42000
G1 F1200
M204 S5000
G1 X91.177 Y88.823 E.03784
G1 X88.823 Y88.823 E.07568
G1 X88.823 Y91.177 E.07568
G1 X91.177 Y91.177 E.07568
G1 X91.177 Y90.06 E.03591
M204 S8000
G1 X91.584 Y90 F42000
G1 F1200
M204 S5000
G1 X91.584 Y88.416 E.05093
M73 P76 R2
G1 X88.416 Y88.416 E.10186
G1 X88.416 Y91.584 E.10186
G1 X91.584 Y91.584 E.10186
G1 X91.584 Y90.06 E.049
; CHANGE_LAYER
; Z_HEIGHT: 2.4
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F5895.792
G1 X91.584 Y91.584 E-.57905
G1 X91.108 Y91.584 E-.18095
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 12/30
; update layer progress
M73 L12
M991 S0 P11 ;notify layer change

; OBJECT_ID: 85
M204 S8000
G17
G3 Z2.6 I-.509 J1.105 P1  F42000
G1 X91.991 Y91.991 Z2.6
G1 Z2.4
G1 E.8 F1800
; FEATURE: Inner wall
G1 F1200
M204 S3000
G1 X88.009 Y91.991 E.12804
G1 X88.009 Y88.009 E.12804
G1 X91.991 Y88.009 E.12804
G1 X91.991 Y90 E.06402
G1 X91.991 Y91.931 E.06209
M204 S8000
G1 X92.398 Y92.398 F42000
G1 F1200
M204 S3000
G1 X87.602 Y92.398 E.15421
G1 X87.602 Y87.602 E.15421
G1 X92.398 Y87.602 E.15421
G1 X92.398 Y90 E.07711
G1 X92.398 Y92.338 E.07518
M204 S8000
G1 X92.79 Y92.79 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F1200
M204 S4000
G1 X87.21 Y92.79 E.16621
G1 X87.21 Y87.21 E.16621
G1 X92.79 Y87.21 E.16621
G1 X92.79 Y90 E.0831
G1 X92.79 Y92.73 E.08132
; WIPE_START
G1 F3600
M204 S5000
G1 X90.79 Y92.752 E-.76
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




G1 X90.02 Y89.966 F42000
G1 Z2.4
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.36104
G1 F1200
M204 S5000
G1 X89.96 Y90 E.00173
G1 X90.002 Y90.024 E.00122
M204 S8000
G1 X90.363 Y90 F42000
; LINE_WIDTH: 0.44999
G1 F1200
M204 S5000
G1 X90.363 Y89.637 E.01166
G1 X89.637 Y89.637 E.02332
G1 X89.637 Y90.363 E.02332
G1 X90.363 Y90.363 E.02332
G1 X90.363 Y90.06 E.00973
M204 S8000
G1 X90.77 Y90 F42000
G1 F1200
M204 S5000
G1 X90.77 Y89.23 E.02475
G1 X89.23 Y89.23 E.0495
G1 X89.23 Y90.77 E.0495
G1 X90.77 Y90.77 E.0495
G1 X90.77 Y90.06 E.02282
M204 S8000
G1 X91.177 Y90 F42000
G1 F1200
M204 S5000
G1 X91.177 Y88.823 E.03784
G1 X88.823 Y88.823 E.07568
G1 X88.823 Y91.177 E.07568
G1 X91.177 Y91.177 E.07568
G1 X91.177 Y90.06 E.03591
M204 S8000
G1 X91.584 Y90 F42000
G1 F1200
M204 S5000
G1 X91.584 Y88.416 E.05093
G1 X88.416 Y88.416 E.10186
M73 P77 R2
G1 X88.416 Y91.584 E.10186
G1 X91.584 Y91.584 E.10186
G1 X91.584 Y90.06 E.049
; CHANGE_LAYER
; Z_HEIGHT: 2.6
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F5895.792
G1 X91.584 Y91.584 E-.57905
G1 X91.108 Y91.584 E-.18095
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 13/30
; update layer progress
M73 L13
M991 S0 P12 ;notify layer change

; OBJECT_ID: 85
M204 S8000
G17
G3 Z2.8 I-.509 J1.105 P1  F42000
G1 X91.991 Y91.991 Z2.8
G1 Z2.6
G1 E.8 F1800
; FEATURE: Inner wall
G1 F1200
M204 S3000
G1 X88.009 Y91.991 E.12804
G1 X88.009 Y88.009 E.12804
G1 X91.991 Y88.009 E.12804
G1 X91.991 Y90 E.06402
G1 X91.991 Y91.931 E.06209
M204 S8000
G1 X92.398 Y92.398 F42000
G1 F1200
M204 S3000
G1 X87.602 Y92.398 E.15421
G1 X87.602 Y87.602 E.15421
G1 X92.398 Y87.602 E.15421
G1 X92.398 Y90 E.07711
G1 X92.398 Y92.338 E.07518
M204 S8000
G1 X92.79 Y92.79 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F1200
M204 S4000
G1 X87.21 Y92.79 E.16621
G1 X87.21 Y87.21 E.16621
G1 X92.79 Y87.21 E.16621
G1 X92.79 Y90 E.0831
G1 X92.79 Y92.73 E.08132
; WIPE_START
G1 F3600
M204 S5000
G1 X90.79 Y92.752 E-.76
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




G1 X90.02 Y89.966 F42000
G1 Z2.6
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.36104
G1 F1200
M204 S5000
G1 X89.96 Y90 E.00173
G1 X90.002 Y90.024 E.00122
M204 S8000
G1 X90.363 Y90 F42000
; LINE_WIDTH: 0.44999
G1 F1200
M204 S5000
G1 X90.363 Y89.637 E.01166
G1 X89.637 Y89.637 E.02332
G1 X89.637 Y90.363 E.02332
G1 X90.363 Y90.363 E.02332
G1 X90.363 Y90.06 E.00973
M204 S8000
G1 X90.77 Y90 F42000
G1 F1200
M204 S5000
G1 X90.77 Y89.23 E.02475
G1 X89.23 Y89.23 E.0495
G1 X89.23 Y90.77 E.0495
G1 X90.77 Y90.77 E.0495
G1 X90.77 Y90.06 E.02282
M204 S8000
G1 X91.177 Y90 F42000
G1 F1200
M204 S5000
G1 X91.177 Y88.823 E.03784
G1 X88.823 Y88.823 E.07568
G1 X88.823 Y91.177 E.07568
G1 X91.177 Y91.177 E.07568
G1 X91.177 Y90.06 E.03591
M204 S8000
G1 X91.584 Y90 F42000
G1 F1200
M204 S5000
M73 P78 R2
G1 X91.584 Y88.416 E.05093
G1 X88.416 Y88.416 E.10186
G1 X88.416 Y91.584 E.10186
G1 X91.584 Y91.584 E.10186
G1 X91.584 Y90.06 E.049
; CHANGE_LAYER
; Z_HEIGHT: 2.8
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F5895.792
G1 X91.584 Y91.584 E-.57905
G1 X91.108 Y91.584 E-.18095
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 14/30
; update layer progress
M73 L14
M991 S0 P13 ;notify layer change

; OBJECT_ID: 85
M204 S8000
G17
G3 Z3 I-.509 J1.105 P1  F42000
G1 X91.991 Y91.991 Z3
G1 Z2.8
G1 E.8 F1800
; FEATURE: Inner wall
G1 F1200
M204 S3000
G1 X88.009 Y91.991 E.12804
G1 X88.009 Y88.009 E.12804
G1 X91.991 Y88.009 E.12804
G1 X91.991 Y90 E.06402
G1 X91.991 Y91.931 E.06209
M204 S8000
G1 X92.398 Y92.398 F42000
G1 F1200
M204 S3000
G1 X87.602 Y92.398 E.15421
G1 X87.602 Y87.602 E.15421
G1 X92.398 Y87.602 E.15421
G1 X92.398 Y90 E.07711
G1 X92.398 Y92.338 E.07518
M204 S8000
G1 X92.79 Y92.79 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F1200
M204 S4000
G1 X87.21 Y92.79 E.16621
G1 X87.21 Y87.21 E.16621
G1 X92.79 Y87.21 E.16621
G1 X92.79 Y90 E.0831
G1 X92.79 Y92.73 E.08132
; WIPE_START
G1 F3600
M204 S5000
G1 X90.79 Y92.752 E-.76
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




G1 X90.02 Y89.966 F42000
G1 Z2.8
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.36104
G1 F1200
M204 S5000
G1 X89.96 Y90 E.00173
G1 X90.002 Y90.024 E.00122
M204 S8000
G1 X90.363 Y90 F42000
; LINE_WIDTH: 0.44999
G1 F1200
M204 S5000
G1 X90.363 Y89.637 E.01166
G1 X89.637 Y89.637 E.02332
G1 X89.637 Y90.363 E.02332
G1 X90.363 Y90.363 E.02332
G1 X90.363 Y90.06 E.00973
M204 S8000
G1 X90.77 Y90 F42000
G1 F1200
M204 S5000
G1 X90.77 Y89.23 E.02475
G1 X89.23 Y89.23 E.0495
G1 X89.23 Y90.77 E.0495
G1 X90.77 Y90.77 E.0495
G1 X90.77 Y90.06 E.02282
M204 S8000
G1 X91.177 Y90 F42000
G1 F1200
M204 S5000
G1 X91.177 Y88.823 E.03784
G1 X88.823 Y88.823 E.07568
G1 X88.823 Y91.177 E.07568
G1 X91.177 Y91.177 E.07568
G1 X91.177 Y90.06 E.03591
M204 S8000
G1 X91.584 Y90 F42000
G1 F1200
M204 S5000
M73 P79 R2
G1 X91.584 Y88.416 E.05093
G1 X88.416 Y88.416 E.10186
G1 X88.416 Y91.584 E.10186
G1 X91.584 Y91.584 E.10186
G1 X91.584 Y90.06 E.049
; CHANGE_LAYER
; Z_HEIGHT: 3
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F5895.792
G1 X91.584 Y91.584 E-.57905
G1 X91.108 Y91.584 E-.18095
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 15/30
; update layer progress
M73 L15
M991 S0 P14 ;notify layer change

; OBJECT_ID: 85
M204 S8000
G17
G3 Z3.2 I-.509 J1.105 P1  F42000
G1 X91.991 Y91.991 Z3.2
G1 Z3
G1 E.8 F1800
; FEATURE: Inner wall
G1 F1200
M204 S3000
G1 X88.009 Y91.991 E.12804
G1 X88.009 Y88.009 E.12804
G1 X91.991 Y88.009 E.12804
G1 X91.991 Y90 E.06402
G1 X91.991 Y91.931 E.06209
M204 S8000
G1 X92.398 Y92.398 F42000
G1 F1200
M204 S3000
G1 X87.602 Y92.398 E.15421
G1 X87.602 Y87.602 E.15421
G1 X92.398 Y87.602 E.15421
G1 X92.398 Y90 E.07711
G1 X92.398 Y92.338 E.07518
M204 S8000
G1 X92.79 Y92.79 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F1200
M204 S4000
G1 X87.21 Y92.79 E.16621
G1 X87.21 Y87.21 E.16621
G1 X92.79 Y87.21 E.16621
G1 X92.79 Y90 E.0831
G1 X92.79 Y92.73 E.08132
; WIPE_START
G1 F3600
M204 S5000
G1 X90.79 Y92.752 E-.76
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




G1 X90.02 Y89.966 F42000
G1 Z3
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.36104
G1 F1200
M204 S5000
G1 X89.96 Y90 E.00173
M73 P79 R1
G1 X90.002 Y90.024 E.00122
M204 S8000
G1 X90.363 Y90 F42000
; LINE_WIDTH: 0.44999
G1 F1200
M204 S5000
G1 X90.363 Y89.637 E.01166
G1 X89.637 Y89.637 E.02332
G1 X89.637 Y90.363 E.02332
G1 X90.363 Y90.363 E.02332
G1 X90.363 Y90.06 E.00973
M204 S8000
G1 X90.77 Y90 F42000
G1 F1200
M204 S5000
G1 X90.77 Y89.23 E.02475
G1 X89.23 Y89.23 E.0495
G1 X89.23 Y90.77 E.0495
G1 X90.77 Y90.77 E.0495
G1 X90.77 Y90.06 E.02282
M204 S8000
G1 X91.177 Y90 F42000
G1 F1200
M204 S5000
G1 X91.177 Y88.823 E.03784
G1 X88.823 Y88.823 E.07568
G1 X88.823 Y91.177 E.07568
G1 X91.177 Y91.177 E.07568
G1 X91.177 Y90.06 E.03591
M204 S8000
G1 X91.584 Y90 F42000
G1 F1200
M204 S5000
G1 X91.584 Y88.416 E.05093
M73 P80 R1
G1 X88.416 Y88.416 E.10186
G1 X88.416 Y91.584 E.10186
G1 X91.584 Y91.584 E.10186
G1 X91.584 Y90.06 E.049
; CHANGE_LAYER
; Z_HEIGHT: 3.2
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F5895.792
G1 X91.584 Y91.584 E-.57905
G1 X91.108 Y91.584 E-.18095
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 16/30
; update layer progress
M73 L16
M991 S0 P15 ;notify layer change

; OBJECT_ID: 85
M204 S8000
G17
G3 Z3.4 I-.509 J1.105 P1  F42000
G1 X91.991 Y91.991 Z3.4
G1 Z3.2
G1 E.8 F1800
; FEATURE: Inner wall
G1 F1200
M204 S3000
G1 X88.009 Y91.991 E.12804
G1 X88.009 Y88.009 E.12804
G1 X91.991 Y88.009 E.12804
G1 X91.991 Y90 E.06402
G1 X91.991 Y91.931 E.06209
M204 S8000
G1 X92.398 Y92.398 F42000
G1 F1200
M204 S3000
G1 X87.602 Y92.398 E.15421
G1 X87.602 Y87.602 E.15421
G1 X92.398 Y87.602 E.15421
G1 X92.398 Y90 E.07711
G1 X92.398 Y92.338 E.07518
M204 S8000
G1 X92.79 Y92.79 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F1200
M204 S4000
G1 X87.21 Y92.79 E.16621
G1 X87.21 Y87.21 E.16621
G1 X92.79 Y87.21 E.16621
G1 X92.79 Y90 E.0831
G1 X92.79 Y92.73 E.08132
; WIPE_START
G1 F3600
M204 S5000
G1 X90.79 Y92.752 E-.76
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




G1 X90.02 Y89.966 F42000
G1 Z3.2
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.36104
G1 F1200
M204 S5000
G1 X89.96 Y90 E.00173
G1 X90.002 Y90.024 E.00122
M204 S8000
G1 X90.363 Y90 F42000
; LINE_WIDTH: 0.44999
G1 F1200
M204 S5000
G1 X90.363 Y89.637 E.01166
G1 X89.637 Y89.637 E.02332
G1 X89.637 Y90.363 E.02332
G1 X90.363 Y90.363 E.02332
G1 X90.363 Y90.06 E.00973
M204 S8000
G1 X90.77 Y90 F42000
G1 F1200
M204 S5000
G1 X90.77 Y89.23 E.02475
G1 X89.23 Y89.23 E.0495
G1 X89.23 Y90.77 E.0495
G1 X90.77 Y90.77 E.0495
G1 X90.77 Y90.06 E.02282
M204 S8000
G1 X91.177 Y90 F42000
G1 F1200
M204 S5000
M73 P81 R1
G1 X91.177 Y88.823 E.03784
G1 X88.823 Y88.823 E.07568
G1 X88.823 Y91.177 E.07568
G1 X91.177 Y91.177 E.07568
G1 X91.177 Y90.06 E.03591
M204 S8000
G1 X91.584 Y90 F42000
G1 F1200
M204 S5000
G1 X91.584 Y88.416 E.05093
G1 X88.416 Y88.416 E.10186
G1 X88.416 Y91.584 E.10186
G1 X91.584 Y91.584 E.10186
G1 X91.584 Y90.06 E.049
; CHANGE_LAYER
; Z_HEIGHT: 3.4
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F5895.792
G1 X91.584 Y91.584 E-.57905
G1 X91.108 Y91.584 E-.18095
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 17/30
; update layer progress
M73 L17
M991 S0 P16 ;notify layer change

; OBJECT_ID: 85
M204 S8000
G17
G3 Z3.6 I-.509 J1.105 P1  F42000
G1 X91.991 Y91.991 Z3.6
G1 Z3.4
G1 E.8 F1800
; FEATURE: Inner wall
G1 F1200
M204 S3000
G1 X88.009 Y91.991 E.12804
G1 X88.009 Y88.009 E.12804
G1 X91.991 Y88.009 E.12804
G1 X91.991 Y90 E.06402
G1 X91.991 Y91.931 E.06209
M204 S8000
G1 X92.398 Y92.398 F42000
G1 F1200
M204 S3000
G1 X87.602 Y92.398 E.15421
G1 X87.602 Y87.602 E.15421
G1 X92.398 Y87.602 E.15421
G1 X92.398 Y90 E.07711
G1 X92.398 Y92.338 E.07518
M204 S8000
G1 X92.79 Y92.79 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F1200
M204 S4000
G1 X87.21 Y92.79 E.16621
G1 X87.21 Y87.21 E.16621
G1 X92.79 Y87.21 E.16621
G1 X92.79 Y90 E.0831
G1 X92.79 Y92.73 E.08132
; WIPE_START
G1 F3600
M204 S5000
G1 X90.79 Y92.752 E-.76
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




G1 X90.02 Y89.966 F42000
G1 Z3.4
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.36104
G1 F1200
M204 S5000
G1 X89.96 Y90 E.00173
G1 X90.002 Y90.024 E.00122
M204 S8000
G1 X90.363 Y90 F42000
; LINE_WIDTH: 0.44999
G1 F1200
M204 S5000
G1 X90.363 Y89.637 E.01166
G1 X89.637 Y89.637 E.02332
G1 X89.637 Y90.363 E.02332
G1 X90.363 Y90.363 E.02332
G1 X90.363 Y90.06 E.00973
M204 S8000
G1 X90.77 Y90 F42000
G1 F1200
M204 S5000
G1 X90.77 Y89.23 E.02475
G1 X89.23 Y89.23 E.0495
G1 X89.23 Y90.77 E.0495
G1 X90.77 Y90.77 E.0495
G1 X90.77 Y90.06 E.02282
M204 S8000
G1 X91.177 Y90 F42000
G1 F1200
M204 S5000
M73 P82 R1
G1 X91.177 Y88.823 E.03784
G1 X88.823 Y88.823 E.07568
G1 X88.823 Y91.177 E.07568
G1 X91.177 Y91.177 E.07568
G1 X91.177 Y90.06 E.03591
M204 S8000
G1 X91.584 Y90 F42000
G1 F1200
M204 S5000
G1 X91.584 Y88.416 E.05093
G1 X88.416 Y88.416 E.10186
G1 X88.416 Y91.584 E.10186
G1 X91.584 Y91.584 E.10186
G1 X91.584 Y90.06 E.049
; CHANGE_LAYER
; Z_HEIGHT: 3.6
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F5895.792
G1 X91.584 Y91.584 E-.57905
G1 X91.108 Y91.584 E-.18095
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 18/30
; update layer progress
M73 L18
M991 S0 P17 ;notify layer change

; OBJECT_ID: 85
M204 S8000
G17
G3 Z3.8 I-.509 J1.105 P1  F42000
G1 X91.991 Y91.991 Z3.8
G1 Z3.6
G1 E.8 F1800
; FEATURE: Inner wall
G1 F1200
M204 S3000
G1 X88.009 Y91.991 E.12804
G1 X88.009 Y88.009 E.12804
G1 X91.991 Y88.009 E.12804
G1 X91.991 Y90 E.06402
G1 X91.991 Y91.931 E.06209
M204 S8000
G1 X92.398 Y92.398 F42000
G1 F1200
M204 S3000
G1 X87.602 Y92.398 E.15421
G1 X87.602 Y87.602 E.15421
G1 X92.398 Y87.602 E.15421
G1 X92.398 Y90 E.07711
G1 X92.398 Y92.338 E.07518
M204 S8000
G1 X92.79 Y92.79 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F1200
M204 S4000
G1 X87.21 Y92.79 E.16621
G1 X87.21 Y87.21 E.16621
G1 X92.79 Y87.21 E.16621
G1 X92.79 Y90 E.0831
G1 X92.79 Y92.73 E.08132
; WIPE_START
G1 F3600
M204 S5000
G1 X90.79 Y92.752 E-.76
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




G1 X90.02 Y89.966 F42000
G1 Z3.6
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.36104
G1 F1200
M204 S5000
G1 X89.96 Y90 E.00173
G1 X90.002 Y90.024 E.00122
M204 S8000
G1 X90.363 Y90 F42000
; LINE_WIDTH: 0.44999
G1 F1200
M204 S5000
G1 X90.363 Y89.637 E.01166
G1 X89.637 Y89.637 E.02332
G1 X89.637 Y90.363 E.02332
G1 X90.363 Y90.363 E.02332
G1 X90.363 Y90.06 E.00973
M204 S8000
G1 X90.77 Y90 F42000
G1 F1200
M204 S5000
G1 X90.77 Y89.23 E.02475
G1 X89.23 Y89.23 E.0495
G1 X89.23 Y90.77 E.0495
G1 X90.77 Y90.77 E.0495
M73 P83 R1
G1 X90.77 Y90.06 E.02282
M204 S8000
G1 X91.177 Y90 F42000
G1 F1200
M204 S5000
G1 X91.177 Y88.823 E.03784
G1 X88.823 Y88.823 E.07568
G1 X88.823 Y91.177 E.07568
G1 X91.177 Y91.177 E.07568
G1 X91.177 Y90.06 E.03591
M204 S8000
G1 X91.584 Y90 F42000
G1 F1200
M204 S5000
G1 X91.584 Y88.416 E.05093
G1 X88.416 Y88.416 E.10186
G1 X88.416 Y91.584 E.10186
G1 X91.584 Y91.584 E.10186
G1 X91.584 Y90.06 E.049
; CHANGE_LAYER
; Z_HEIGHT: 3.8
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F5895.792
G1 X91.584 Y91.584 E-.57905
G1 X91.108 Y91.584 E-.18095
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 19/30
; update layer progress
M73 L19
M991 S0 P18 ;notify layer change

; OBJECT_ID: 85
M204 S8000
G17
G3 Z4 I-.509 J1.105 P1  F42000
G1 X91.991 Y91.991 Z4
G1 Z3.8
G1 E.8 F1800
; FEATURE: Inner wall
G1 F1200
M204 S3000
G1 X88.009 Y91.991 E.12804
G1 X88.009 Y88.009 E.12804
G1 X91.991 Y88.009 E.12804
G1 X91.991 Y90 E.06402
G1 X91.991 Y91.931 E.06209
M204 S8000
G1 X92.398 Y92.398 F42000
G1 F1200
M204 S3000
G1 X87.602 Y92.398 E.15421
G1 X87.602 Y87.602 E.15421
G1 X92.398 Y87.602 E.15421
G1 X92.398 Y90 E.07711
G1 X92.398 Y92.338 E.07518
M204 S8000
G1 X92.79 Y92.79 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F1200
M204 S4000
G1 X87.21 Y92.79 E.16621
G1 X87.21 Y87.21 E.16621
G1 X92.79 Y87.21 E.16621
G1 X92.79 Y90 E.0831
G1 X92.79 Y92.73 E.08132
; WIPE_START
G1 F3600
M204 S5000
G1 X90.79 Y92.752 E-.76
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




G1 X90.02 Y89.966 F42000
G1 Z3.8
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.36104
G1 F1200
M204 S5000
G1 X89.96 Y90 E.00173
G1 X90.002 Y90.024 E.00122
M204 S8000
G1 X90.363 Y90 F42000
; LINE_WIDTH: 0.44999
G1 F1200
M204 S5000
G1 X90.363 Y89.637 E.01166
G1 X89.637 Y89.637 E.02332
G1 X89.637 Y90.363 E.02332
G1 X90.363 Y90.363 E.02332
G1 X90.363 Y90.06 E.00973
M204 S8000
G1 X90.77 Y90 F42000
G1 F1200
M204 S5000
G1 X90.77 Y89.23 E.02475
G1 X89.23 Y89.23 E.0495
G1 X89.23 Y90.77 E.0495
M73 P84 R1
G1 X90.77 Y90.77 E.0495
G1 X90.77 Y90.06 E.02282
M204 S8000
G1 X91.177 Y90 F42000
G1 F1200
M204 S5000
G1 X91.177 Y88.823 E.03784
G1 X88.823 Y88.823 E.07568
G1 X88.823 Y91.177 E.07568
G1 X91.177 Y91.177 E.07568
G1 X91.177 Y90.06 E.03591
M204 S8000
G1 X91.584 Y90 F42000
G1 F1200
M204 S5000
G1 X91.584 Y88.416 E.05093
G1 X88.416 Y88.416 E.10186
G1 X88.416 Y91.584 E.10186
G1 X91.584 Y91.584 E.10186
G1 X91.584 Y90.06 E.049
; CHANGE_LAYER
; Z_HEIGHT: 4
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F5895.792
G1 X91.584 Y91.584 E-.57905
G1 X91.108 Y91.584 E-.18095
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 20/30
; update layer progress
M73 L20
M991 S0 P19 ;notify layer change

; OBJECT_ID: 85
M204 S8000
G17
G3 Z4.2 I-.509 J1.105 P1  F42000
G1 X91.991 Y91.991 Z4.2
G1 Z4
G1 E.8 F1800
; FEATURE: Inner wall
G1 F1200
M204 S3000
G1 X88.009 Y91.991 E.12804
G1 X88.009 Y88.009 E.12804
G1 X91.991 Y88.009 E.12804
G1 X91.991 Y90 E.06402
G1 X91.991 Y91.931 E.06209
M204 S8000
G1 X92.398 Y92.398 F42000
G1 F1200
M204 S3000
G1 X87.602 Y92.398 E.15421
G1 X87.602 Y87.602 E.15421
G1 X92.398 Y87.602 E.15421
G1 X92.398 Y90 E.07711
G1 X92.398 Y92.338 E.07518
M204 S8000
G1 X92.79 Y92.79 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F1200
M204 S4000
G1 X87.21 Y92.79 E.16621
G1 X87.21 Y87.21 E.16621
G1 X92.79 Y87.21 E.16621
G1 X92.79 Y90 E.0831
G1 X92.79 Y92.73 E.08132
; WIPE_START
G1 F3600
M204 S5000
G1 X90.79 Y92.752 E-.76
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




G1 X90.02 Y89.966 F42000
G1 Z4
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.36104
G1 F1200
M204 S5000
G1 X89.96 Y90 E.00173
G1 X90.002 Y90.024 E.00122
M204 S8000
G1 X90.363 Y90 F42000
; LINE_WIDTH: 0.44999
G1 F1200
M204 S5000
G1 X90.363 Y89.637 E.01166
G1 X89.637 Y89.637 E.02332
G1 X89.637 Y90.363 E.02332
G1 X90.363 Y90.363 E.02332
G1 X90.363 Y90.06 E.00973
M204 S8000
G1 X90.77 Y90 F42000
M73 P85 R1
G1 F1200
M204 S5000
G1 X90.77 Y89.23 E.02475
G1 X89.23 Y89.23 E.0495
G1 X89.23 Y90.77 E.0495
G1 X90.77 Y90.77 E.0495
G1 X90.77 Y90.06 E.02282
M204 S8000
G1 X91.177 Y90 F42000
G1 F1200
M204 S5000
G1 X91.177 Y88.823 E.03784
G1 X88.823 Y88.823 E.07568
G1 X88.823 Y91.177 E.07568
G1 X91.177 Y91.177 E.07568
G1 X91.177 Y90.06 E.03591
M204 S8000
G1 X91.584 Y90 F42000
G1 F1200
M204 S5000
G1 X91.584 Y88.416 E.05093
G1 X88.416 Y88.416 E.10186
G1 X88.416 Y91.584 E.10186
G1 X91.584 Y91.584 E.10186
G1 X91.584 Y90.06 E.049
; CHANGE_LAYER
; Z_HEIGHT: 4.2
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F5895.792
G1 X91.584 Y91.584 E-.57905
G1 X91.108 Y91.584 E-.18095
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 21/30
; update layer progress
M73 L21
M991 S0 P20 ;notify layer change

; OBJECT_ID: 85
M204 S8000
G17
G3 Z4.4 I-.509 J1.105 P1  F42000
G1 X91.991 Y91.991 Z4.4
G1 Z4.2
G1 E.8 F1800
; FEATURE: Inner wall
G1 F1200
M204 S3000
G1 X88.009 Y91.991 E.12804
G1 X88.009 Y88.009 E.12804
G1 X91.991 Y88.009 E.12804
G1 X91.991 Y90 E.06402
G1 X91.991 Y91.931 E.06209
M204 S8000
G1 X92.398 Y92.398 F42000
G1 F1200
M204 S3000
G1 X87.602 Y92.398 E.15421
G1 X87.602 Y87.602 E.15421
G1 X92.398 Y87.602 E.15421
G1 X92.398 Y90 E.07711
G1 X92.398 Y92.338 E.07518
M204 S8000
G1 X92.79 Y92.79 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F1200
M204 S4000
G1 X87.21 Y92.79 E.16621
G1 X87.21 Y87.21 E.16621
G1 X92.79 Y87.21 E.16621
G1 X92.79 Y90 E.0831
G1 X92.79 Y92.73 E.08132
; WIPE_START
G1 F3600
M204 S5000
G1 X90.79 Y92.752 E-.76
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




G1 X90.02 Y89.966 F42000
G1 Z4.2
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.36104
G1 F1200
M204 S5000
G1 X89.96 Y90 E.00173
G1 X90.002 Y90.024 E.00122
M204 S8000
G1 X90.363 Y90 F42000
; LINE_WIDTH: 0.44999
G1 F1200
M204 S5000
M73 P86 R1
G1 X90.363 Y89.637 E.01166
G1 X89.637 Y89.637 E.02332
G1 X89.637 Y90.363 E.02332
G1 X90.363 Y90.363 E.02332
G1 X90.363 Y90.06 E.00973
M204 S8000
G1 X90.77 Y90 F42000
G1 F1200
M204 S5000
G1 X90.77 Y89.23 E.02475
G1 X89.23 Y89.23 E.0495
G1 X89.23 Y90.77 E.0495
G1 X90.77 Y90.77 E.0495
G1 X90.77 Y90.06 E.02282
M204 S8000
G1 X91.177 Y90 F42000
G1 F1200
M204 S5000
G1 X91.177 Y88.823 E.03784
G1 X88.823 Y88.823 E.07568
G1 X88.823 Y91.177 E.07568
G1 X91.177 Y91.177 E.07568
G1 X91.177 Y90.06 E.03591
M204 S8000
G1 X91.584 Y90 F42000
G1 F1200
M204 S5000
G1 X91.584 Y88.416 E.05093
G1 X88.416 Y88.416 E.10186
G1 X88.416 Y91.584 E.10186
G1 X91.584 Y91.584 E.10186
G1 X91.584 Y90.06 E.049
; CHANGE_LAYER
; Z_HEIGHT: 4.4
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F5895.792
G1 X91.584 Y91.584 E-.57905
G1 X91.108 Y91.584 E-.18095
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 22/30
; update layer progress
M73 L22
M991 S0 P21 ;notify layer change

; OBJECT_ID: 85
M204 S8000
G17
G3 Z4.6 I-.509 J1.105 P1  F42000
G1 X91.991 Y91.991 Z4.6
G1 Z4.4
G1 E.8 F1800
; FEATURE: Inner wall
G1 F1200
M204 S3000
G1 X88.009 Y91.991 E.12804
G1 X88.009 Y88.009 E.12804
G1 X91.991 Y88.009 E.12804
G1 X91.991 Y90 E.06402
G1 X91.991 Y91.931 E.06209
M204 S8000
G1 X92.398 Y92.398 F42000
G1 F1200
M204 S3000
G1 X87.602 Y92.398 E.15421
G1 X87.602 Y87.602 E.15421
G1 X92.398 Y87.602 E.15421
G1 X92.398 Y90 E.07711
G1 X92.398 Y92.338 E.07518
M204 S8000
G1 X92.79 Y92.79 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F1200
M204 S4000
G1 X87.21 Y92.79 E.16621
G1 X87.21 Y87.21 E.16621
G1 X92.79 Y87.21 E.16621
G1 X92.79 Y90 E.0831
G1 X92.79 Y92.73 E.08132
; WIPE_START
G1 F3600
M204 S5000
G1 X90.79 Y92.752 E-.76
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




G1 X90.02 Y89.966 F42000
M73 P87 R1
G1 Z4.4
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.36104
G1 F1200
M204 S5000
G1 X89.96 Y90 E.00173
G1 X90.002 Y90.024 E.00122
M204 S8000
G1 X90.363 Y90 F42000
; LINE_WIDTH: 0.44999
G1 F1200
M204 S5000
G1 X90.363 Y89.637 E.01166
G1 X89.637 Y89.637 E.02332
G1 X89.637 Y90.363 E.02332
G1 X90.363 Y90.363 E.02332
G1 X90.363 Y90.06 E.00973
M204 S8000
G1 X90.77 Y90 F42000
G1 F1200
M204 S5000
G1 X90.77 Y89.23 E.02475
G1 X89.23 Y89.23 E.0495
G1 X89.23 Y90.77 E.0495
G1 X90.77 Y90.77 E.0495
G1 X90.77 Y90.06 E.02282
M204 S8000
G1 X91.177 Y90 F42000
G1 F1200
M204 S5000
G1 X91.177 Y88.823 E.03784
G1 X88.823 Y88.823 E.07568
G1 X88.823 Y91.177 E.07568
G1 X91.177 Y91.177 E.07568
G1 X91.177 Y90.06 E.03591
M204 S8000
G1 X91.584 Y90 F42000
G1 F1200
M204 S5000
G1 X91.584 Y88.416 E.05093
G1 X88.416 Y88.416 E.10186
G1 X88.416 Y91.584 E.10186
G1 X91.584 Y91.584 E.10186
G1 X91.584 Y90.06 E.049
; CHANGE_LAYER
; Z_HEIGHT: 4.6
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F5895.792
G1 X91.584 Y91.584 E-.57905
G1 X91.108 Y91.584 E-.18095
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 23/30
; update layer progress
M73 L23
M991 S0 P22 ;notify layer change

; OBJECT_ID: 85
M204 S8000
G17
G3 Z4.8 I-.509 J1.105 P1  F42000
G1 X91.991 Y91.991 Z4.8
G1 Z4.6
G1 E.8 F1800
; FEATURE: Inner wall
G1 F1200
M204 S3000
G1 X88.009 Y91.991 E.12804
G1 X88.009 Y88.009 E.12804
G1 X91.991 Y88.009 E.12804
G1 X91.991 Y90 E.06402
G1 X91.991 Y91.931 E.06209
M204 S8000
G1 X92.398 Y92.398 F42000
G1 F1200
M204 S3000
G1 X87.602 Y92.398 E.15421
G1 X87.602 Y87.602 E.15421
G1 X92.398 Y87.602 E.15421
G1 X92.398 Y90 E.07711
G1 X92.398 Y92.338 E.07518
M204 S8000
G1 X92.79 Y92.79 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F1200
M204 S4000
G1 X87.21 Y92.79 E.16621
G1 X87.21 Y87.21 E.16621
G1 X92.79 Y87.21 E.16621
G1 X92.79 Y90 E.0831
G1 X92.79 Y92.73 E.08132
; WIPE_START
G1 F3600
M204 S5000
G1 X90.79 Y92.752 E-.76
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




M73 P88 R1
G1 X90.02 Y89.966 F42000
G1 Z4.6
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.36104
G1 F1200
M204 S5000
G1 X89.96 Y90 E.00173
G1 X90.002 Y90.024 E.00122
M204 S8000
G1 X90.363 Y90 F42000
; LINE_WIDTH: 0.44999
G1 F1200
M204 S5000
G1 X90.363 Y89.637 E.01166
G1 X89.637 Y89.637 E.02332
G1 X89.637 Y90.363 E.02332
G1 X90.363 Y90.363 E.02332
G1 X90.363 Y90.06 E.00973
M204 S8000
G1 X90.77 Y90 F42000
G1 F1200
M204 S5000
G1 X90.77 Y89.23 E.02475
G1 X89.23 Y89.23 E.0495
G1 X89.23 Y90.77 E.0495
G1 X90.77 Y90.77 E.0495
G1 X90.77 Y90.06 E.02282
M204 S8000
G1 X91.177 Y90 F42000
G1 F1200
M204 S5000
G1 X91.177 Y88.823 E.03784
G1 X88.823 Y88.823 E.07568
G1 X88.823 Y91.177 E.07568
G1 X91.177 Y91.177 E.07568
G1 X91.177 Y90.06 E.03591
M204 S8000
G1 X91.584 Y90 F42000
G1 F1200
M204 S5000
G1 X91.584 Y88.416 E.05093
G1 X88.416 Y88.416 E.10186
G1 X88.416 Y91.584 E.10186
G1 X91.584 Y91.584 E.10186
G1 X91.584 Y90.06 E.049
; CHANGE_LAYER
; Z_HEIGHT: 4.8
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F5895.792
G1 X91.584 Y91.584 E-.57905
G1 X91.108 Y91.584 E-.18095
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 24/30
; update layer progress
M73 L24
M991 S0 P23 ;notify layer change

; OBJECT_ID: 85
M204 S8000
G17
G3 Z5 I-.509 J1.105 P1  F42000
G1 X91.991 Y91.991 Z5
G1 Z4.8
G1 E.8 F1800
; FEATURE: Inner wall
G1 F1200
M204 S3000
G1 X88.009 Y91.991 E.12804
G1 X88.009 Y88.009 E.12804
G1 X91.991 Y88.009 E.12804
G1 X91.991 Y90 E.06402
G1 X91.991 Y91.931 E.06209
M204 S8000
G1 X92.398 Y92.398 F42000
G1 F1200
M204 S3000
G1 X87.602 Y92.398 E.15421
G1 X87.602 Y87.602 E.15421
G1 X92.398 Y87.602 E.15421
G1 X92.398 Y90 E.07711
G1 X92.398 Y92.338 E.07518
M204 S8000
G1 X92.79 Y92.79 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F1200
M204 S4000
G1 X87.21 Y92.79 E.16621
G1 X87.21 Y87.21 E.16621
G1 X92.79 Y87.21 E.16621
G1 X92.79 Y90 E.0831
G1 X92.79 Y92.73 E.08132
; WIPE_START
G1 F3600
M204 S5000
G1 X90.79 Y92.752 E-.76
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




G1 X90.02 Y89.966 F42000
M73 P89 R1
G1 Z4.8
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.36104
G1 F1200
M204 S5000
G1 X89.96 Y90 E.00173
G1 X90.002 Y90.024 E.00122
M204 S8000
G1 X90.363 Y90 F42000
; LINE_WIDTH: 0.44999
G1 F1200
M204 S5000
G1 X90.363 Y89.637 E.01166
G1 X89.637 Y89.637 E.02332
G1 X89.637 Y90.363 E.02332
G1 X90.363 Y90.363 E.02332
G1 X90.363 Y90.06 E.00973
M204 S8000
G1 X90.77 Y90 F42000
G1 F1200
M204 S5000
G1 X90.77 Y89.23 E.02475
G1 X89.23 Y89.23 E.0495
G1 X89.23 Y90.77 E.0495
G1 X90.77 Y90.77 E.0495
G1 X90.77 Y90.06 E.02282
M204 S8000
G1 X91.177 Y90 F42000
G1 F1200
M204 S5000
G1 X91.177 Y88.823 E.03784
G1 X88.823 Y88.823 E.07568
G1 X88.823 Y91.177 E.07568
G1 X91.177 Y91.177 E.07568
G1 X91.177 Y90.06 E.03591
M204 S8000
G1 X91.584 Y90 F42000
G1 F1200
M204 S5000
G1 X91.584 Y88.416 E.05093
G1 X88.416 Y88.416 E.10186
G1 X88.416 Y91.584 E.10186
G1 X91.584 Y91.584 E.10186
G1 X91.584 Y90.06 E.049
; CHANGE_LAYER
; Z_HEIGHT: 5
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F5895.792
G1 X91.584 Y91.584 E-.57905
G1 X91.108 Y91.584 E-.18095
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 25/30
; update layer progress
M73 L25
M991 S0 P24 ;notify layer change

; OBJECT_ID: 85
M204 S8000
G17
G3 Z5.2 I-.509 J1.105 P1  F42000
G1 X91.991 Y91.991 Z5.2
G1 Z5
G1 E.8 F1800
; FEATURE: Inner wall
G1 F1200
M204 S3000
G1 X88.009 Y91.991 E.12804
G1 X88.009 Y88.009 E.12804
G1 X91.991 Y88.009 E.12804
G1 X91.991 Y90 E.06402
G1 X91.991 Y91.931 E.06209
M204 S8000
G1 X92.398 Y92.398 F42000
G1 F1200
M204 S3000
G1 X87.602 Y92.398 E.15421
G1 X87.602 Y87.602 E.15421
G1 X92.398 Y87.602 E.15421
G1 X92.398 Y90 E.07711
G1 X92.398 Y92.338 E.07518
M204 S8000
G1 X92.79 Y92.79 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F1200
M204 S4000
G1 X87.21 Y92.79 E.16621
G1 X87.21 Y87.21 E.16621
G1 X92.79 Y87.21 E.16621
G1 X92.79 Y90 E.0831
G1 X92.79 Y92.73 E.08132
; WIPE_START
G1 F3600
M204 S5000
G1 X90.79 Y92.752 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S8000
G17
M73 P89 R0
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




G1 X90.02 Y89.966 F42000
G1 Z5
M73 P90 R0
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.36104
G1 F1200
M204 S5000
G1 X89.96 Y90 E.00173
G1 X90.002 Y90.024 E.00122
M204 S8000
G1 X90.363 Y90 F42000
; LINE_WIDTH: 0.44999
G1 F1200
M204 S5000
G1 X90.363 Y89.637 E.01166
G1 X89.637 Y89.637 E.02332
G1 X89.637 Y90.363 E.02332
G1 X90.363 Y90.363 E.02332
G1 X90.363 Y90.06 E.00973
M204 S8000
G1 X90.77 Y90 F42000
G1 F1200
M204 S5000
G1 X90.77 Y89.23 E.02475
G1 X89.23 Y89.23 E.0495
G1 X89.23 Y90.77 E.0495
G1 X90.77 Y90.77 E.0495
G1 X90.77 Y90.06 E.02282
M204 S8000
G1 X91.177 Y90 F42000
G1 F1200
M204 S5000
G1 X91.177 Y88.823 E.03784
G1 X88.823 Y88.823 E.07568
G1 X88.823 Y91.177 E.07568
G1 X91.177 Y91.177 E.07568
G1 X91.177 Y90.06 E.03591
M204 S8000
G1 X91.584 Y90 F42000
G1 F1200
M204 S5000
G1 X91.584 Y88.416 E.05093
G1 X88.416 Y88.416 E.10186
G1 X88.416 Y91.584 E.10186
G1 X91.584 Y91.584 E.10186
G1 X91.584 Y90.06 E.049
; CHANGE_LAYER
; Z_HEIGHT: 5.2
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F5895.792
G1 X91.584 Y91.584 E-.57905
G1 X91.108 Y91.584 E-.18095
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 26/30
; update layer progress
M73 L26
M991 S0 P25 ;notify layer change

; OBJECT_ID: 85
M204 S8000
G17
G3 Z5.4 I-.509 J1.105 P1  F42000
G1 X91.991 Y91.991 Z5.4
G1 Z5.2
G1 E.8 F1800
; FEATURE: Inner wall
G1 F1200
M204 S3000
G1 X88.009 Y91.991 E.12804
G1 X88.009 Y88.009 E.12804
G1 X91.991 Y88.009 E.12804
G1 X91.991 Y90 E.06402
G1 X91.991 Y91.931 E.06209
M204 S8000
G1 X92.398 Y92.398 F42000
G1 F1200
M204 S3000
G1 X87.602 Y92.398 E.15421
G1 X87.602 Y87.602 E.15421
G1 X92.398 Y87.602 E.15421
G1 X92.398 Y90 E.07711
G1 X92.398 Y92.338 E.07518
M204 S8000
G1 X92.79 Y92.79 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F1200
M204 S4000
G1 X87.21 Y92.79 E.16621
G1 X87.21 Y87.21 E.16621
G1 X92.79 Y87.21 E.16621
G1 X92.79 Y90 E.0831
G1 X92.79 Y92.73 E.08132
; WIPE_START
G1 F3600
M204 S5000
G1 X90.79 Y92.752 E-.76
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
M73 P91 R0
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




G1 X90.02 Y89.966 F42000
G1 Z5.2
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.36104
G1 F1200
M204 S5000
G1 X89.96 Y90 E.00173
G1 X90.002 Y90.024 E.00122
M204 S8000
G1 X90.363 Y90 F42000
; LINE_WIDTH: 0.44999
G1 F1200
M204 S5000
G1 X90.363 Y89.637 E.01166
G1 X89.637 Y89.637 E.02332
G1 X89.637 Y90.363 E.02332
G1 X90.363 Y90.363 E.02332
G1 X90.363 Y90.06 E.00973
M204 S8000
G1 X90.77 Y90 F42000
G1 F1200
M204 S5000
G1 X90.77 Y89.23 E.02475
G1 X89.23 Y89.23 E.0495
G1 X89.23 Y90.77 E.0495
G1 X90.77 Y90.77 E.0495
G1 X90.77 Y90.06 E.02282
M204 S8000
G1 X91.177 Y90 F42000
G1 F1200
M204 S5000
G1 X91.177 Y88.823 E.03784
G1 X88.823 Y88.823 E.07568
G1 X88.823 Y91.177 E.07568
G1 X91.177 Y91.177 E.07568
G1 X91.177 Y90.06 E.03591
M204 S8000
G1 X91.584 Y90 F42000
G1 F1200
M204 S5000
G1 X91.584 Y88.416 E.05093
G1 X88.416 Y88.416 E.10186
G1 X88.416 Y91.584 E.10186
G1 X91.584 Y91.584 E.10186
G1 X91.584 Y90.06 E.049
; CHANGE_LAYER
; Z_HEIGHT: 5.4
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F5895.792
G1 X91.584 Y91.584 E-.57905
G1 X91.108 Y91.584 E-.18095
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 27/30
; update layer progress
M73 L27
M991 S0 P26 ;notify layer change

; OBJECT_ID: 85
M204 S8000
G17
G3 Z5.6 I-.509 J1.105 P1  F42000
G1 X91.991 Y91.991 Z5.6
G1 Z5.4
G1 E.8 F1800
; FEATURE: Inner wall
G1 F1200
M204 S3000
G1 X88.009 Y91.991 E.12804
G1 X88.009 Y88.009 E.12804
G1 X91.991 Y88.009 E.12804
G1 X91.991 Y90 E.06402
G1 X91.991 Y91.931 E.06209
M204 S8000
G1 X92.398 Y92.398 F42000
G1 F1200
M204 S3000
G1 X87.602 Y92.398 E.15421
G1 X87.602 Y87.602 E.15421
G1 X92.398 Y87.602 E.15421
G1 X92.398 Y90 E.07711
G1 X92.398 Y92.338 E.07518
M204 S8000
G1 X92.79 Y92.79 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F1200
M204 S4000
G1 X87.21 Y92.79 E.16621
G1 X87.21 Y87.21 E.16621
G1 X92.79 Y87.21 E.16621
G1 X92.79 Y90 E.0831
G1 X92.79 Y92.73 E.08132
; WIPE_START
G1 F3600
M204 S5000
G1 X90.79 Y92.752 E-.76
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
G1 X0 Y90 F18000 ; move to safe pos
M73 P92 R0
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




G1 X90.02 Y89.966 F42000
G1 Z5.4
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.36104
G1 F1200
M204 S5000
G1 X89.96 Y90 E.00173
G1 X90.002 Y90.024 E.00122
M204 S8000
G1 X90.363 Y90 F42000
; LINE_WIDTH: 0.44999
G1 F1200
M204 S5000
G1 X90.363 Y89.637 E.01166
G1 X89.637 Y89.637 E.02332
G1 X89.637 Y90.363 E.02332
G1 X90.363 Y90.363 E.02332
G1 X90.363 Y90.06 E.00973
M204 S8000
G1 X90.77 Y90 F42000
G1 F1200
M204 S5000
G1 X90.77 Y89.23 E.02475
G1 X89.23 Y89.23 E.0495
G1 X89.23 Y90.77 E.0495
G1 X90.77 Y90.77 E.0495
G1 X90.77 Y90.06 E.02282
M204 S8000
G1 X91.177 Y90 F42000
G1 F1200
M204 S5000
G1 X91.177 Y88.823 E.03784
G1 X88.823 Y88.823 E.07568
G1 X88.823 Y91.177 E.07568
G1 X91.177 Y91.177 E.07568
G1 X91.177 Y90.06 E.03591
M204 S8000
G1 X91.584 Y90 F42000
G1 F1200
M204 S5000
G1 X91.584 Y88.416 E.05093
G1 X88.416 Y88.416 E.10186
G1 X88.416 Y91.584 E.10186
G1 X91.584 Y91.584 E.10186
G1 X91.584 Y90.06 E.049
; CHANGE_LAYER
; Z_HEIGHT: 5.6
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F5895.792
G1 X91.584 Y91.584 E-.57905
G1 X91.108 Y91.584 E-.18095
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 28/30
; update layer progress
M73 L28
M991 S0 P27 ;notify layer change

; OBJECT_ID: 85
M204 S8000
G17
G3 Z5.8 I-.509 J1.105 P1  F42000
G1 X91.991 Y91.991 Z5.8
G1 Z5.6
G1 E.8 F1800
; FEATURE: Inner wall
G1 F1200
M204 S3000
G1 X88.009 Y91.991 E.12804
G1 X88.009 Y88.009 E.12804
G1 X91.991 Y88.009 E.12804
G1 X91.991 Y90 E.06402
G1 X91.991 Y91.931 E.06209
M204 S8000
G1 X92.398 Y92.398 F42000
G1 F1200
M204 S3000
G1 X87.602 Y92.398 E.15421
G1 X87.602 Y87.602 E.15421
G1 X92.398 Y87.602 E.15421
G1 X92.398 Y90 E.07711
G1 X92.398 Y92.338 E.07518
M204 S8000
G1 X92.79 Y92.79 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F1200
M204 S4000
G1 X87.21 Y92.79 E.16621
G1 X87.21 Y87.21 E.16621
G1 X92.79 Y87.21 E.16621
G1 X92.79 Y90 E.0831
G1 X92.79 Y92.73 E.08132
; WIPE_START
G1 F3600
M204 S5000
G1 X90.79 Y92.752 E-.76
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
M73 P93 R0
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




G1 X90.02 Y89.966 F42000
G1 Z5.6
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.36104
G1 F1200
M204 S5000
G1 X89.96 Y90 E.00173
G1 X90.002 Y90.024 E.00122
M204 S8000
G1 X90.363 Y90 F42000
; LINE_WIDTH: 0.44999
G1 F1200
M204 S5000
G1 X90.363 Y89.637 E.01166
G1 X89.637 Y89.637 E.02332
G1 X89.637 Y90.363 E.02332
G1 X90.363 Y90.363 E.02332
G1 X90.363 Y90.06 E.00973
M204 S8000
G1 X90.77 Y90 F42000
G1 F1200
M204 S5000
G1 X90.77 Y89.23 E.02475
G1 X89.23 Y89.23 E.0495
G1 X89.23 Y90.77 E.0495
G1 X90.77 Y90.77 E.0495
G1 X90.77 Y90.06 E.02282
M204 S8000
G1 X91.177 Y90 F42000
G1 F1200
M204 S5000
G1 X91.177 Y88.823 E.03784
G1 X88.823 Y88.823 E.07568
G1 X88.823 Y91.177 E.07568
G1 X91.177 Y91.177 E.07568
G1 X91.177 Y90.06 E.03591
M204 S8000
G1 X91.584 Y90 F42000
G1 F1200
M204 S5000
G1 X91.584 Y88.416 E.05093
G1 X88.416 Y88.416 E.10186
G1 X88.416 Y91.584 E.10186
G1 X91.584 Y91.584 E.10186
G1 X91.584 Y90.06 E.049
; CHANGE_LAYER
; Z_HEIGHT: 5.8
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F5895.792
G1 X91.584 Y91.584 E-.57905
G1 X91.108 Y91.584 E-.18095
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 29/30
; update layer progress
M73 L29
M991 S0 P28 ;notify layer change

; OBJECT_ID: 85
M204 S8000
G17
G3 Z6 I-.509 J1.105 P1  F42000
G1 X91.991 Y91.991 Z6
G1 Z5.8
G1 E.8 F1800
; FEATURE: Inner wall
G1 F1200
M204 S3000
G1 X88.009 Y91.991 E.12804
G1 X88.009 Y88.009 E.12804
G1 X91.991 Y88.009 E.12804
G1 X91.991 Y90 E.06402
G1 X91.991 Y91.931 E.06209
M204 S8000
G1 X92.398 Y92.398 F42000
G1 F1200
M204 S3000
G1 X87.602 Y92.398 E.15421
G1 X87.602 Y87.602 E.15421
G1 X92.398 Y87.602 E.15421
G1 X92.398 Y90 E.07711
G1 X92.398 Y92.338 E.07518
M204 S8000
G1 X92.79 Y92.79 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F1200
M204 S4000
G1 X87.21 Y92.79 E.16621
G1 X87.21 Y87.21 E.16621
G1 X92.79 Y87.21 E.16621
G1 X92.79 Y90 E.0831
G1 X92.79 Y92.73 E.08132
; WIPE_START
G1 F3600
M204 S5000
G1 X90.79 Y92.752 E-.76
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




M73 P94 R0
G1 X90.02 Y89.966 F42000
G1 Z5.8
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.36104
G1 F1200
M204 S5000
G1 X89.96 Y90 E.00173
G1 X90.002 Y90.024 E.00122
M204 S8000
G1 X90.363 Y90 F42000
; LINE_WIDTH: 0.44999
G1 F1200
M204 S5000
G1 X90.363 Y89.637 E.01166
G1 X89.637 Y89.637 E.02332
G1 X89.637 Y90.363 E.02332
G1 X90.363 Y90.363 E.02332
G1 X90.363 Y90.06 E.00973
M204 S8000
G1 X90.77 Y90 F42000
G1 F1200
M204 S5000
G1 X90.77 Y89.23 E.02475
G1 X89.23 Y89.23 E.0495
G1 X89.23 Y90.77 E.0495
G1 X90.77 Y90.77 E.0495
G1 X90.77 Y90.06 E.02282
M204 S8000
G1 X91.177 Y90 F42000
G1 F1200
M204 S5000
G1 X91.177 Y88.823 E.03784
G1 X88.823 Y88.823 E.07568
G1 X88.823 Y91.177 E.07568
G1 X91.177 Y91.177 E.07568
G1 X91.177 Y90.06 E.03591
M204 S8000
G1 X91.584 Y90 F42000
G1 F1200
M204 S5000
G1 X91.584 Y88.416 E.05093
G1 X88.416 Y88.416 E.10186
G1 X88.416 Y91.584 E.10186
G1 X91.584 Y91.584 E.10186
G1 X91.584 Y90.06 E.049
; CHANGE_LAYER
; Z_HEIGHT: 6
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F5895.792
G1 X91.584 Y91.584 E-.57905
G1 X91.108 Y91.584 E-.18095
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 30/30
; update layer progress
M73 L30
M991 S0 P29 ;notify layer change

; OBJECT_ID: 85
M204 S8000
G17
G3 Z6.2 I-.709 J.989 P1  F42000
G1 X92.79 Y92.79 Z6.2
G1 Z6
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F1200
M204 S4000
G1 X87.21 Y92.79 E.16621
G1 X87.21 Y87.21 E.16621
G1 X92.79 Y87.21 E.16621
G1 X92.79 Y90 E.0831
G1 X92.79 Y92.73 E.08132
; WIPE_START
G1 F3600
M204 S5000
G1 X90.79 Y92.752 E-.76
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




G1 X92.583 Y91.95 F42000
G1 Z6
G1 E.8 F1800
; FEATURE: Top surface
; LINE_WIDTH: 0.42
G1 F1200
M204 S2000
G1 X91.95 Y92.583 E.02665
G1 X91.417 Y92.583
G1 X92.583 Y91.417 E.04911
G1 X92.583 Y90.883
G1 X90.883 Y92.583 E.07158
G1 X90.35 Y92.583
G1 X92.583 Y90.35 E.09404
G1 X92.583 Y89.817
G1 X89.817 Y92.583 E.1165
M73 P95 R0
G1 X89.284 Y92.583
G1 X92.583 Y89.284 E.13897
G1 X92.583 Y88.75
G1 X88.75 Y92.583 E.16143
G1 X88.217 Y92.583
G1 X92.583 Y88.217 E.18389
G1 X92.583 Y87.684
G1 X87.684 Y92.583 E.20636
G1 X87.417 Y92.316
G1 X92.316 Y87.417 E.20635
G1 X91.783 Y87.417
G1 X87.417 Y91.783 E.18389
G1 X87.417 Y91.249
G1 X91.249 Y87.417 E.16142
G1 X90.716 Y87.417
G1 X87.417 Y90.716 E.13896
G1 X87.417 Y90.183
G1 X90.183 Y87.417 E.1165
G1 X89.65 Y87.417
G1 X87.417 Y89.65 E.09403
G1 X87.417 Y89.116
G1 X89.116 Y87.417 E.07157
G1 X88.583 Y87.417
G1 X87.417 Y88.583 E.04911
G1 X87.417 Y88.05
G1 X88.05 Y87.417 E.02664
; close powerlost recovery
M1003 S0
; WIPE_START
G1 F1800
M204 S5000
G1 X87.417 Y88.05 E-.33991
G1 X87.417 Y88.583 E-.20264
G1 X87.822 Y88.179 E-.21745
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
G1 Z6.5 F900 ; lower z a little
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

    G1 Z106 F600
    G1 Z104

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

