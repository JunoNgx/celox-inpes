package module;

import entity.Player;
import entity.Shot;
import entity.Enemy;
import entity.Missile;

class Pool {

	public static var player: Array<Player> = [];
	public static var shot: Array<Shot> = [];
	public static var enemy: Array<Enemy> = [];
	public static var missile: Array<Missile> = [];
	// public static var star: Array<Missile> = [];

	public function new() {
		// for (var i:Int = 0; i > 50; i++) {
		for (i in 0...50) {
			var entity = new Shot();
			entity.kill();

			shot.push(entity);
		}
		trace('shots created');

		var p = new Player();
		player.push(p);
		trace('player created');
	}

}