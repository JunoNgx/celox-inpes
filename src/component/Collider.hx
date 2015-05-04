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

	override public function onadded() {
		// if (against == 'enemy') trace(entity.name);
	}

	override public function update(dt: Float) {

		if (entity.active && against.length > 0) {
			
			var targets = new Array<Entity>();
			Luxe.scene.get_named_like(against, targets);

			for (target in targets) {
				if (target.active
				&&  target.has('collider')){

					var target_collider = target.get('collider');
					
					if (Collision.shapeWithShape(shape, target_collider.shape) != null) {
						// trace(entity.name + ' hit ' + target.name);
						target.events.fire('hit');
						entity.events.fire('hit');
					}

					if (target.name.substr(0,5) == 'enemy') {
						Play.score ++;
					};

				}
			}
		}
		
	}
}