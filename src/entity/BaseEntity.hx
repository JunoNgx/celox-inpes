package entity;

import luxe.Sprite;
import luxe.collision.shapes.Polygon;
import luxe.options.SpriteOptions;

import component.Velocity;
import component.Collider;

import C;

class BaseEntity extends Sprite {

	public var velocity: Velocity;
	public var collider: Collider;

	override public function new(options:SpriteOptions) {
		super(options);

		this.events.listen('hit', function(e){
			this.hit();
		});
	}

	public function alignShape() {
		this.collider.shape.x = pos.x;
		this.collider.shape.y = pos.y;

		this.collider.shape.rotation = rotation_z;
	}

	public function hit() {
		kill();
	}

	public function kill() {
		this.active = false;
		// this.visible = false;
	}

	public function revive() {
		this.active = true;
		// this.visible = true;
	}

	public function isAlive() {
		if (this.active
		// && this.visible
		)  {
			return true;
		} else return false;
	}
}