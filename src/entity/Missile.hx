package entity;

import luxe.Vector;
import luxe.Color;
import luxe.collision.shapes.Polygon;

import entity.BaseEntity;
import component.Velocity;
import component.Collider;

import C;

class Missile extends BaseEntity {
	
	var killsbound: Int = C.missile_killbounds;
	var radius: Int = C.missile_radius;

	override public function new() {
		super({
			name: 'missile',
			name_unique: true,
			size: new Vector(3, 3),
			color: new Color().rgb(0x3FB8CD),
		});

		velocity = new Velocity({name: 'velocity'});
		this.add(velocity);

		collider = new Collider({
			name: 'collider',
			against: 'player',
			shape: Polygon.create(pos.x, pos.y, 3, radius),
		});
		this.add(collider);

		this.velocity.y = 1000;
	}

	override public function update(dt : Float) {

		rotation_z += C.missile_rotateSpd * dt;

		alignShape();
		//killbounds
		if (pos.x > Luxe.screen.w + C.missile_killbounds
		|| pos.y > Luxe.screen.h + C.missile_killbounds
		|| pos.x < - C.missile_killbounds
		|| pos.y < C.spawn_area2) {
			kill();
		}

		if (isAlive()) onrender();
	}

	public function onrender() {
		Luxe.draw.ngon({
			immediate: true,
			r: this.radius,
			sides: 3,
			x: this.pos.x,
			y: this.pos.y,
			// Note the negated value in rotation_z
			angle: -this.rotation_z,
			color: new Color().rgb(0x3FB8CD),
		});
	}

}