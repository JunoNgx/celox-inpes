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

	public function new() {
		super({
			name: 'player',
			pos: new Vector(Luxe.screen.w * 2, Luxe.screen.h * 0.75),
			visible: true,
			// size: new Vector(30, 30),
			texture: Luxe.resources.texture('assets/player.png')
		});

		collider = new Collider({
			name: 'collider',
			shape: Polygon.rectangle(pos.x, pos.y, 20, 20, true),
		});
		this.add(collider);

		this.add( new KeepBounds( {name:'keepBounds'}));

		this.add( new Machinegun( {name: 'machinegun'}));

	} // new


	override public function onmousemove(e: MouseEvent) {
		this.pos = Luxe.camera.screen_point_to_world(e.pos);
	} // on mouse move

	override public function ontouchmove(e: TouchEvent) {
		this.pos.x = e.x * Main.w;
		this.pos.y = e.y * Main.h;
	} // on touch move
}