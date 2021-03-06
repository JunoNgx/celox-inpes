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
	
	override public function new () {
		super({
			name: 'shot',
			name_unique: true,
		});

		velocity = new Velocity ({
			name: 'velocity',
			vx: 0,
			vy: - C.shot_speed,
			});
		this.add(velocity);

		collider = new Collider({
			name: 'collider',
			against: 'enemy',
			shape: Polygon.rectangle(pos.x, pos.y, C.shot_w, C.shot_h, true),
		});
		this.add(collider);

		this.add( new KillBounds( {name: 'killBounds'}));
		// trace('shot created');

		this.events.listen('hit', function(e){
			this.active = false;
		});
	}

	public function reinit(X: Float, Y: Float) {
		this.pos = new Vector(X, Y);
		this.active = true;
	}

	override public function update(dt: Float) {

		if (this.active) {
			Luxe.draw.rectangle({
				immediate: true,
				x: this.pos.x - C.shot_w/2,
				y: this.pos.y - C.shot_h/2,
				w: C.shot_w,
				h: C.shot_h,
				color: new Color().rgb(0xA6E22E),
			});

			Luxe.draw.rectangle({
				immediate: true,
				x: this.pos.x - C.trail_w/2,
				y: this.pos.y,
				w: C.trail_w,
				h: C.trail_h,
				color: new Color().rgb(0x444444),
			});
		}
	}
	
}