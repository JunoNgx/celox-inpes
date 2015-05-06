package entity;

import luxe.Sprite;
import luxe.Vector;
import luxe.Color;
import luxe.collision.shapes.Polygon;

import component.Velocity;
import component.Collider;
import component.KillBounds;

import C;

class Missile extends Sprite {
	
	public var collider: Collider;
	public var velocity: Velocity;

	override public function new(veloX: Float, VeloY: Float) {
		super({
			name: 'missile',
			name_unique: true,
			// size: new Vector(C.missile_radius * 2, C.missile_radius * 2),
			color: new Color().rgb(0x3FB8CD),
			texture: Luxe.resources.texture('assets/missile.png'),
		});

		velocity = new Velocity({
			name: 'velocity',
			vx: veloX,
			vy: VeloY,
		});
		this.add(velocity);

		collider = new Collider({
			name: 'collider',
			shape: Polygon.rectangle(pos.x, pos.y, C.missile_radius * 2, C.missile_radius * 2, true),
		});
		this.add(collider);

		this.add( new KillBounds( {name: 'killBounds'}));
	}

}