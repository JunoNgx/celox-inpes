package module;

import module.BasePoolMaster;

class CustomizedPool extends BasePoolMaster {


	public static var player: Array<Player>;
	public static var shot: Array<Shot>;
	public static var enemy: Array<Enemy>;
	public static var missile: Array<Missile>;
	public static var star: Array<Missile>;

	public function new() {

		player = [];
		shot = [];
		enemy = [];
		missile = [];
		star = [];

		for (i in 0..50) do {
			entity = new Shot();
			entity.kill();

			pool.shot.push(entity);
		}


	}

}