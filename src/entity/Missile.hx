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

	override public function new(veloX: Float, VeloY: Float) {
		super({
			name: 'missile',
			name_unique: true,
			// size: new Vector(C.missile_radius * 2, C.missile_radius * 2),
			// color: new Color().rgb(0x3FB8CD),
			// texture: Luxe.resources.texture('assets/missile.png'),
		});

		velocity = new Velocity({
			name: 'velocity',
			vx: veloX,
			vy: VeloY,
		});
		this.add(velocity);

		collider = new Collider({
			name: 'collider',
			against: 'player',
			// shape: Polygon.rectangle(pos.x, pos.y, C.missile_radius * 2, C.missile_radius * 2, true),
			shape: Polygon.create(pos.x, pos.y, 3, C.missile_radius),
		});
		this.add(collider);

		this.add( new KillBounds( {name: 'killBounds'}));

		this.events.listen('hit', function(e){
			this.active = false;
		});
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
					color: new Color().rgb(0xFC951E),
				});
		
				Luxe.draw.ngon({
					immediate: true,
					r: C.missile_radius/3,
					sides: 3,
					x: this.pos.x,
					y: this.pos.y,
					angle: this.collider.shape.rotation,
					solid: true,
					color: new Color().rgb(0x66D9EF),
				});
		}
	}
}