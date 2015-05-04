package entity;

import luxe.Vector;
import luxe.Color;
import luxe.collision.shapes.Polygon;

import entity.BaseEntity;
import component.Velocity;
import component.Collider;

import C;

class Shot extends BaseEntity {
	
	override public function new () {
		super({
			name: 'shot',
			name_unique: true,
			visible: false,
			size: new Vector( C.shot_w, C.shot_h),
			});

		collider = new Collider({
			name: 'collider',
			against: 'enemy',
			shape: Polygon.rectangle(pos.x, pos.y, C.shot_w, C.shot_h, true),
		});
		this.add(collider);

		velocity = new Velocity ({name: 'velocity'});
		this.add(velocity);

		this.velocity.x = 0;
		this.velocity.y = -C.shot_speed;
	}

	override public function update(dt: Float) {
		alignShape();

		if (this.pos.y < -20) kill();

		if (this.isAlive()) onrender();
	}

	public function onrender() {
		Luxe.draw.rectangle({
			immediate: true,
			x: this.pos.x,
			y: this.pos.y,
			w: C.shot_w,
			h: C.shot_h,
			// Note the negated value in rotation_z
			// angle: -this.rotation_z,
			color: new Color().rgb(0xAE81FF),
		});
	}



}