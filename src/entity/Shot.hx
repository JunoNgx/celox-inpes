package entity;

import luxe.Entity;
import luxe.Vector;
import luxe.Color;
import luxe.collision.shapes.Polygon;

import component.Velocity;
import component.KillBounds;
import component.Collider;

import C;

class Shot extends Entity {

	public var velocity: Velocity;
	public var collider: Collider;
	
	override public function new (X: Float, Y: Float) {
		super({
			name: 'shot',
			name_unique: true,
			// size: new Vector( C.shot_w, C.shot_h),
			pos: new Vector(X, Y),
			// color: new Color(1, 0, 0, 1),
			// texture: Luxe.resources.texture('assets/shot.png'),
			});

		velocity = new Velocity ({
			name: 'velocity',
			vx: 0,
			vy: - C.shot_speed,
			});
		this.add(velocity);

		collider = new Collider({
			name: 'collider',
			shape: Polygon.rectangle(pos.x, pos.y, C.shot_w, C.shot_h, true),
		});
		this.add(collider);

		// this.velocity.set(0, - C.shot_speed);

		this.add( new KillBounds( {name: 'killBounds'}));
		// trace('shot created');
	}

	override public function update(dt: Float) {
		Luxe.draw.rectangle({
			immediate: true,
			x: this.pos.x - C.shot_w/2,
			y: this.pos.y - C.shot_h/2,
			w: C.shot_w,
			h: C.shot_h,
			color: new Color().rgb(0xA6E22E),
		});
	}

}