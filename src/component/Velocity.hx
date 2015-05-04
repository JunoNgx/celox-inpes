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
	
	// override function onadded() {
	// 	// velocity.x == null will be freaking messy
	// 	this.x = 0;
	// 	this.y = 0;
	// }

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

