package entity;

import luxe.Sprite;
import luxe.Vector;
import luxe.Color;
import luxe.collision.shapes.Polygon;

import component.Velocity;
import component.KillBounds;
import component.Collider;
import component.Seeker;

import states.Play;
import C;

class Enemy extends Sprite {

	public var collider: Collider;
	public var velocity: Velocity;
	public var seeker: Seeker;

	var rotateSpd:Float;

	override public function new() {
		super({
			name: 'enemy',
			name_unique: true,
			size: new Vector( C.enemy_size, C.enemy_size ),
			color: new Color().rgb(0xFD971F),
			pos: new Vector(Luxe.utils.random.float(0, Main.w),
				Luxe.utils.random.float(C.spawn_area1, C.spawn_area2)),
		});

		velocity = new Velocity ({
			name: 'velocity',
			vy: C.enemy_speed + Luxe.utils.random.float(-C.enemy_speed_var, C.enemy_speed_var),
		});
		this.add(velocity);

		collider = new Collider({
			name: 'collider',
			shape: Polygon.rectangle(pos.x, pos.y, C.shot_w, C.shot_h, true),
		});
		this.add(collider);

		seeker = new Seeker();
		this.add(seeker);

		this.add( new KillBounds({
			name: 'killBounds',
			top: -500, // dirty hack!!
		}));

		rotateSpd = Luxe.utils.random.float(-C.enemy_rotateSpd_var, C.enemy_rotateSpd_var);
		seeker.reload();
	}

	public function newSpeed(){
		this.rotation_z += rotateSpd * Luxe.dt;
	}

	// override function destroy(){
	// 	super.destroy();
	// }

	// public function destroy(){

	// }

}