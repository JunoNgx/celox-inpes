package module;

import entity.Player;
import entity.Shot;
import entity.Enemy;
import entity.Missile;


class BasePoolMaster {

	public static var player: Array<Player>;
	public static var shot: Array<Shot>;
	public static var enemy: Array<Enemy>;
	public static var missile: Array<Missile>;
	public static var star: Array<Missile>;

	public function new() {



	}

	public function init() {

	}

	// public function fill(amount: Int, pool: Array, entity: Dynamic) {
	// 	for (i in 0..amount) do {
	// 		entity = new Entity();
	// 		Entity.kill();

	// 		pool.push(entity);
	// 	}
	// }

	public function spawn(X, Y) {

	}

	public function getFirstDead() {

	}

}