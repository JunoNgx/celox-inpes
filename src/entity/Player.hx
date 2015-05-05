package entity;

import luxe.Sprite;
import luxe.Vector;
import luxe.Color;
import luxe.Input;
import luxe.collision.shapes.Polygon;

import states.Play;

import component.KeepBounds;
import component.Collider;
import component.Machinegun;

import C;

class Player extends Sprite {

	public var collider: Collider;

	// public var radius: Int = C.player_radius;

	public function new() {
		super({
			name: 'player',
			// name_unique: true,
			pos: new Vector(Luxe.screen.w * 2, Luxe.screen.h * 0.75),
			visible: true,
			size: new Vector(30, 30),
		});

		collider = new Collider({
			name: 'collider',
			shape: Polygon.rectangle(pos.x, pos.y, 20, 20, true),
		});
		this.add(collider);

		this.add( new KeepBounds( {name:'keepBounds'}));

		this.add( new Machinegun( {name: 'machinegun'}));

	// 	// velocity = new Velocity({name: 'velocity'});
	// 	// this.add(velocity);

	// 	// collider = new Collider({
	// 	// 	name: 'collider',
	// 	// 	against: 'powerup',
	// 	// 	shape: Polygon.create(pos.x, pos.y, 3, radius),
	// 	// });
	// 	// this.add(collider);

	// 	// revive();

	} // new


	override public function onmousemove(e: MouseEvent) {
		this.pos = Luxe.camera.screen_point_to_world(e.pos);
	} // on mouse move

	override public function ontouchmove(e: TouchEvent) {
		this.pos.x = e.x * Main.w;
		this.pos.y = e.y * Main.h;
	} // on touch move

// 	public function onrender() {
// 		Luxe.draw.ngon({
// 			immediate: true,
// 			r: this.radius,
// 			sides: 3,
// 			x: this.pos.x,
// 			y: this.pos.y,
// 			// Note the negated value in rotation_z
// 			angle: -this.rotation_z,
// 			solid: true,
// 			color: new Color().rgb(0xF92672),
// 		});

// 		Luxe.draw.ngon({
// 			immediate: true,
// 			r: C.player_gunRadius,
// 			sides: 3,
// 			x: this.pos.x + 20,
// 			y: this.pos.y - 10,
// 			// Note the negated value in rotation_z
// 			angle: -180,
// 			solid: true,
// 			color: new Color().rgb(0xA6E22E),
// 		});

// 		Luxe.draw.ngon({
// 			immediate: true,
// 			r: C.player_gunRadius,
// 			sides: 3,
// 			x: this.pos.x - 20,
// 			y: this.pos.y - 10,
// 			// Note the negated value in rotation_z
// 			angle: -180,
// 			solid: true,
// 			color: new Color().rgb(0xA6E22E),
// 		});

// 		// Luxe.draw.rectangle({
// 		// 	immediate: true,
// 		// 	x: this.pos.x,
// 		// 	y: this.pos.y - 50,
// 		// 	w: 3,
// 		// 	h: 3,
// 		// 	scale: new Vector(200,200),
// 		// 	// Note the negated value in rotation_z
// 		// 	// angle: -this.rotation_z,
// 		// 	color: new Color(1, 1, 1, 1),
// 		// });
// 	}

// 	// override public function hit() {
// 	// 	super.hit();
// 	// 	Luxe.events.fire('die!');

// 	// 	Luxe.events.fire('explosion', {
// 	// 		x: this.pos.x,
// 	// 		y: this.pos.y,
// 	// 	});
// 	// }
}