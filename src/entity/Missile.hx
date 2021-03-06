package entity;

import luxe.Entity;
import luxe.Vector;
import luxe.Color;
import luxe.collision.shapes.Polygon;

import component.Velocity;
import component.Collider;
import component.KillBounds;

import C;

class Missile extends Entity {
	
	public var collider: Collider;
	public var velocity: Velocity;

	override public function new() {
		super({
			name: 'missile',
			name_unique: true,
		});

		velocity = new Velocity({
			name: 'velocity',
		});
		this.add(velocity);

		collider = new Collider({
			name: 'collider',
			against: 'player',
			shape: Polygon.create(pos.x, pos.y, 3, C.missile_radius),
		});
		this.add(collider);

		this.add( new KillBounds( {name: 'killBounds'}));

		this.events.listen('hit', function(e){
			this.active = false;
		});
	}

	public function reinit() {
		this.active = true;
	}

	override public function update(dt: Float) {

		this.collider.shape.rotation += C.missile_rotateSpd * dt;

		if (this.active) {
			Luxe.draw.ngon({
					immediate: true,
					r: C.missile_radius,
					sides: 3,
					x: this.pos.x,
					y: this.pos.y,
					// Note the negated value in rotation_z
					angle: -this.collider.shape.rotation,
					color: new Color().rgb(0x777777),
				});
		
				Luxe.draw.ngon({
					immediate: true,
					r: C.missile_radius/3,
					sides: 3,
					x: this.pos.x,
					y: this.pos.y,
					angle: this.collider.shape.rotation,
					solid: true,
					color: new Color().rgb(0xFFF381),
				});
		}
	}
}