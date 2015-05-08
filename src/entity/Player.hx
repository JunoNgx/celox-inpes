package entity;

import luxe.Entity;
import luxe.Vector;
import luxe.Color;
import luxe.Input;
import luxe.collision.shapes.Polygon;

import states.Play;

import component.KeepBounds;
import component.Collider;
import component.Machinegun;

import C;

class Player extends Entity {

	public var collider: Collider;

	public function new() {
		super({
			name: 'player',
			name_unique: true,
			pos: new Vector(Main.w * 2, Main.h * 0.75),
			// visible: true,
			// size: new Vector(30, 30),
			// texture: Luxe.resources.texture('assets/player.png')
		});

		collider = new Collider({
			name: 'collider',
			// shape: Polygon.rectangle(pos.x, pos.y, 20, 20, true),
			shape: Polygon.create(pos.x, pos.y, 3, C.player_radius),
		});
		this.add(collider);
		this.collider.shape.rotation = -180;

		this.add( new KeepBounds( {name:'keepBounds'}));

		this.add( new Machinegun( {name: 'machinegun'}));

		this.events.listen('hit', function(e){
			this.active = false;
			Luxe.events.fire('explosion', {x: this.pos.x, y: this.pos.y});
			
			Luxe.events.fire('die!');
		});

	} // new


	override public function onmousemove(e: MouseEvent) {
		this.pos = Luxe.camera.screen_point_to_world(e.pos);
	} // on mouse move

	override public function ontouchmove(e: TouchEvent) {
		this.pos.x = e.x * Main.w;
		this.pos.y = e.y * Main.h;
	} // on touch move

	override function update(dt: Float) {

		if (this.active) {
			Luxe.draw.ngon({
				immediate: true,
				r: C.player_radius,
				sides: 3,
				x: this.pos.x,
				y: this.pos.y,
				angle: -180,
				solid: true,
				color: new Color().rgb(0xF92672),
			});

			Luxe.draw.ngon({
				immediate: true,
				r: C.player_wingRadius,
				sides: 3,
				x: this.pos.x + 18,
				y: this.pos.y + 10,
				// solid: true,
				color: new Color().rgb(0xA6E22E),
			});

			Luxe.draw.ngon({
				immediate: true,
				r: C.player_wingRadius,
				sides: 3,
				x: this.pos.x - 18,
				y: this.pos.y + 10,
				// solid: true,
				color: new Color().rgb(0xA6E22E),
			});

			Luxe.draw.ngon({
				immediate: true,
				r: C.player_gunRadius,
				sides: 4,
				x: this.pos.x - 10,
				y: this.pos.y - 14,
				angle: 45,
				solid: true,
				color: new Color().rgb(0xA6E22E),
			});

			Luxe.draw.ngon({
				immediate: true,
				r: C.player_gunRadius,
				sides: 4,
				x: this.pos.x + 10,
				y: this.pos.y - 14,
				angle: 45,
				solid: true,
				color: new Color().rgb(0xA6E22E),
			});
		}
	}
}