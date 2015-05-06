package entity;

import luxe.Sprite;
import luxe.Color;
import luxe.Vector;

import luxe.tween.Actuate;
// import luxe.tween.easing.Linear;

import C;

class Explosion extends Sprite {

	public function new( X: Float, Y: Float) {
		super({
			name: 'explosion',
			name_unique: true,
			pos: new Vector(
				X + Luxe.utils.random.float(-C.exp_pos_var, C.exp_pos_var),
				Y + Luxe.utils.random.float(-C.exp_pos_var, C.exp_pos_var)
			),
			size: new Vector(
				C.exp_size + Luxe.utils.random.float(-C.exp_size_var, C.exp_size_var),
				C.exp_size + Luxe.utils.random.float(-C.exp_size_var, C.exp_size_var)
			),
			color: new Color().rgb(0xff403b),
			depth: 2,
		});

		explode();
	}

	public function explode() {
		var lifetime = Luxe.utils.random.float(C.exp_lifetime_min, C.exp_lifetime_max);

		Actuate.tween(this.color, lifetime, {a:0.4});
		Actuate.tween(this.transform.scale, lifetime, {x: 7, y: 7})
			.onComplete( function(){ destroy(); })
			.ease(luxe.tween.easing.Sine.easeIn);
	}
}