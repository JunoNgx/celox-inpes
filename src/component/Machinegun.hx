package component;

import luxe.Component;
import luxe.options.ComponentOptions;

import luxe.Vector;

import entity.Shot;

import states.Play;
import C;

class Machinegun extends Component {

	var fireCooldown: Float = C.player_fireCooldown;
	var leftShot: Bool = true;

	override function update(dt: Float) {
		if (fireCooldown > 0) {
			fireCooldown -= dt;
		} else {
			fire();
			fireCooldown = C.player_fireCooldown;
		}
	} // update

	function fire() {
		if (leftShot) {
			// var shot = new Shot(pos.x - 10, pos.y - 5);
			var shot = Play.pool_shot.get();
			shot.reinit(pos.x - 10, pos.y - 5);
			leftShot = false;
		} else {
			// var shot = new Shot(pos.x + 10, pos.y - 5);
			var shot = Play.pool_shot.get();
			shot.reinit(pos.x + 10, pos.y - 5);
			leftShot = true;
		}
	} // fire

}