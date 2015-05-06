package;

/**
 * ...
 * @author Juno Nguyen
 */

 // List of optimizable gameplay constants
class C {

	public static var player_fireCooldown: Float = 0.07;
	// public static var player_radius: Int = 28;
	// public static var player_gunRadius: Int = 10;

	public static var shot_w: Int = 8;
	public static var shot_h: Int = 8;
	public static var shot_speed: Int = 800;

	public static var enemy_size:Int = 24;
	public static var enemy_speed:Int = 500;
	public static var enemy_speed_var:Int = 300;
	// public static var enemy_radius:Int = 20;
	// public static var enemy_gunRadius:Int = 7;
	public static var enemy_rotateSpd_var:Float = 200;

	public static var missile_speed:Int = 200;
	public static var missile_radius:Int = 15;
	// public static var missile_killbounds:Int = 100;
	// public static var missile_radius:Int = 15;
	// public static var missile_rotateSpd:Int = 120;

	public static var seeker_firingDelay_min:Float = 0.1;
	public static var seeker_firingDelay_max:Float = 1.2;

	public static var star_w: Int = 9;
	public static var star_h: Int = 5;
	public static var star_var_min: Float = 1;
	public static var star_var_max: Float = 2;
	public static var star_speed: Float = 100;
	public static var star_amt: Int = 20;

	public static var exp_amt_min: Int = 3;
	public static var exp_amt_max: Int = 7;
	public static var exp_pos_var: Int = 20;
	public static var exp_size: Int = 32;
	public static var exp_size_var: Int = 20;
	public static var exp_lifetime_min: Float = 0.05;
	public static var exp_lifetime_max: Float = 0.2;

	// public static var exp_time: Float = 0.05;

	public static var spawn_time1:Float = 2;
	public static var spawn_time2:Float = 3;
	public static var spawn_area1:Float = -300;
	public static var spawn_area2:Float = -20;

	// public static var pool_max_shot: Int = 24;
	// public static var pool_max_enemy: Int = 7;
	// public static var pool_max_missile: Int = 20;

	public static var wave_amt: Int = 7;
	public static var wave_amt_var: Int = 4;

	public static var killbounds_horizontal: Int = 50;
	public static var killbounds_vertical: Int = 50;
	
}