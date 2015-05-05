package component;

import luxe.Component;
import luxe.options.ComponentOptions;

typedef KeepBoundsOptions = {
	> ComponentOptions,

	@:optional var top: Int;
	@:optional var bottom: Int;
	@:optional var left: Int;
	@:optional var right: Int;
}

class KeepBounds extends Component {

	var top: Int;
	var bottom: Int;
	var left: Int;
	var right: Int;

	public function new(_options:KeepBoundsOptions) {
		super(_options);

		this.top 		= ( _options.top != null ) 		? _options.top 		: 0;
		this.bottom 	= ( _options.bottom != null ) 	? _options.bottom 	: Main.h;
		this.left 		= ( _options.left != null ) 	? _options.left 	: 0;
		this.right 		= ( _options.right != null ) 	? _options.right 	: Main.w;
	}

	override function update(dt: Float) {
		if (entity.pos.x > this.right) entity.pos.x = this.right;
		if (entity.pos.y > this.bottom) entity.pos.y = this.bottom;
		if (entity.pos.x < this.left) entity.pos.x = this.left;
		if (entity.pos.y < this.top) entity.pos.y = this.top;
	}

}