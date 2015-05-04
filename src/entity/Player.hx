package entity;

import luxe.Vector;
import luxe.Color;
import luxe.Input;
import luxe.collision.shapes.Polygon;

import entity.BaseEntity;
import component.Velocity;
import component.Collider;
import states.Play;

import C;
import entity.Shot;

class Player extends BaseEntity {

	var fireCooldown: Float = C.player_fireCooldown;
	var oddShot: Bool = false;

	public var radius: Int = C.player_radius;

	override public function new() {
		super({
			name: 'player',
			name_unique: true,
			pos: new Vector(Luxe.screen.w * 2, Luxe.screen.h * 0.75),
			size: new Vector(10, 10),
		});

		velocity = new Velocity({name: 'velocity'});
		this.add(velocity);

		collider = new Collider({
			name: 'collider',
			against: 'powerup',
			shape: Polygon.create(pos.x, pos.y, 3, radius),
		});
		this.add(collider);

		revive();

	} // new

	override function update(dt: Float) {
		alignShape();

		// rotation_z += 40 * dt;

		if (fireCooldown > 0) {
			fireCooldown -= dt;
		} else {
			fire();
			fireCooldown = C.player_fireCooldown;
		}

		if (isAlive()) onrender();
	} // update

	function fire() {
		if (oddShot) {
			// var shot = new Shot();
			// shot.pos = new Vector(pos.x - 10, pos.y - 5);

			var shot = Play.pool_shot.get();
			shot.revive();
			shot.pos = new Vector(pos.x - 10, pos.y - 5);

			oddShot = false;
		} else {
			var shot = Play.pool_shot.get();
			shot.revive();
			shot.pos = new Vector(pos.x + 10, pos.y - 5);

			oddShot = true;
		}
	} // fire

	override public function onmousemove(e: MouseEvent) {
		this.pos = Luxe.camera.screen_point_to_world(e.pos);
	} // on mouse move

	public function onrender() {
		Luxe.draw.ngon({
			immediate: true,
			r: this.radius,
			sides: 3,
			x: this.pos.x,
			y: this.pos.y,
			// Note the negated value in rotation_z
			angle: -this.rotation_z,
			color: new Color(1, 0.5, 0.7, 0.7),
		});
	}

	override public function kill() {
		super.kill();
		Luxe.events.fire('die!');
	}
}