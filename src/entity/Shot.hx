package entity;

import luxe.Vector;
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
	}



}