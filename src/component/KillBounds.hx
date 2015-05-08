package component;

import luxe.Component;
import luxe.options.ComponentOptions;

import C;

typedef KillBoundsOptions = {
	> ComponentOptions,

	@:optional var top: Int;
	@:optional var bottom: Int;
	@:optional var left: Int;
	@:optional var right: Int;
}

class KillBounds extends Component {

	var top: Int;
	var bottom: Int;
	var left: Int;
	var right: Int;

	public function new(_options:KillBoundsOptions) {
		super(_options);

		this.top 		= ( _options.top != null ) 		? _options.top 		: 0 - C.killbounds_vertical;
		this.bottom 	= ( _options.bottom != null ) 	? _options.bottom 	: Main.h + C.killbounds_vertical;
		this.left 		= ( _options.left != null ) 	? _options.left 	: 0 - C.killbounds_horizontal ;
		this.right 		= ( _options.right != null ) 	? _options.right 	: Main.w + C.killbounds_horizontal;
	}

	override function update(dt: Float) {

		if(entity.pos.x > this.right
		|| entity.pos.x < this.left
		|| entity.pos.y > this.bottom
		|| entity.pos.y < this.top ) {
			entity.active = false;

		}
	}

}