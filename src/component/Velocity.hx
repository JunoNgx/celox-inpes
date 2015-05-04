package component;

import luxe.Component;
import luxe.options.ComponentOptions;

typedef VelocityOptions = {
    > ComponentOptions,

    @:optional var vx: Float;
    @:optional var vy: Float;
}

class Velocity extends Component {
	
	public var x: Float;
	public var y: Float;

	public override function new(_options:VelocityOptions) {
		super(_options);

		this.x = (_options.vx != null) ? _options.vx : 0;
		this.y = (_options.vy != null) ? _options.vy : 0;
	}
	
	override function update(dt: Float) {
		pos.x += this.x * dt;
		pos.y += this.y * dt;
	}
	
}

