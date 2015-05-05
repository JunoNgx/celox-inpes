package component;

import luxe.Entity;
import luxe.collision.Collision;

import luxe.Component;
import luxe.options.ComponentOptions;
import luxe.collision.shapes.Polygon;

import states.Play;

typedef ColliderOptions = {
	> ComponentOptions,

	@:optional var against: String;
	var shape: Polygon;
}

class Collider extends Component {

	public var against: String;
	public var shape: Polygon;
	
	override public function new(_options: ColliderOptions) {

		super(_options);

		against = (_options.against != null) ? _options.against : '';
		shape = _options.shape;
	}

	override public function update(dt: Float) {
		this.shape.x = entity.pos.x;
		this.shape.y = entity.pos.y;
	}
}