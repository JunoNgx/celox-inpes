package entity;

import luxe.Sprite;
import luxe.Vector;
import luxe.Color;
import luxe.collision.shapes.Polygon;

import component.Velocity;
import component.KillBounds;
import component.Collider;

import C;

class Shot extends Sprite {

	public var velocity: Velocity;
	public var collider: Collider;
	
	override public function new (X: Float, Y: Float) {
		super({
			name: 'shot',
			name_unique: true,
			// size: new Vector( C.shot_w, C.shot_h),
			pos: new Vector(X, Y),
			// color: new Color(1, 0, 0, 1),
			texture: Luxe.resources.texture('assets/shot.png'),
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

}