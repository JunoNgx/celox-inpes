package entity;


import luxe.Sprite;
import luxe.Vector;
import luxe.Color;

import component.Velocity;

import C;

class Star extends Sprite {

	public var velocity: Velocity;

	override public function new() {
		super({
			name: 'star',
			name_unique: true,
			pos: new Vector(Luxe.utils.random.float(0, Main.w), Luxe.utils.random.float(0, Main.h)),
			size: new Vector(C.star_w, C.star_h),
			color: new Color(0.1, 0.1, 0.1, 1),
			depth: -9,
		});

		velocity = new Velocity({name: 'velocity'});
		this.add(velocity);

		resetVariance();
	}

	public function resetVariance() {
		var variance = Luxe.utils.random.float(C.star_var_min, C.star_var_max);

		this.velocity.set(0, C.star_speed * variance);
		this.size = new Vector (
			C.star_w * Luxe.utils.random.float(C.star_var_min, C.star_var_max),
			C.star_h * Luxe.utils.random.float(C.star_var_min, C.star_var_max)
		);
	}

	public function returnToTop() {
		this.pos.y = -20;
	}

	override public function update(dt: Float) {
		if (pos.y > Main.h + 50) {
			returnToTop();
			resetVariance();
		}
	}

}