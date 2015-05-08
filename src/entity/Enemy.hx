package entity;

import luxe.Entity;
import luxe.Vector;
import luxe.Color;
import luxe.collision.shapes.Polygon;

import component.Velocity;
import component.KillBounds;
import component.Collider;
import component.Seeker;

import states.Play;
import C;

class Enemy extends Entity {

	public var collider: Collider;
	public var velocity: Velocity;
	public var seeker: Seeker;

	var rotateSpd:Float;

	override public function new() {
		super({
			name: 'enemy',
			name_unique: true,
			// visible: false,
			// size: new Vector( C.enemy_size, C.enemy_size ),
			// color: new Color().rgb(0xFD971F),
			// pos: new Vector(Luxe.utils.random.float(0, Main.w),
			// 	Luxe.utils.random.float(C.spawn_area1, C.spawn_area2)),
			// texture: Luxe.resources.texture('assets/enemy.png'),
		});

		velocity = new Velocity ({
			name: 'velocity',
		});
		this.add(velocity);

		collider = new Collider({
			name: 'collider',
			against: 'player',
			// shape: Polygon.rectangle(pos.x, pos.y, C.enemy_size, C.enemy_size, true),
			shape: Polygon.create(pos.x, pos.y, 6, C.enemy_radius)
		});
		this.add(collider);

		seeker = new Seeker();
		this.add(seeker);

		this.add( new KillBounds({
			name: 'killBounds',
			top: -500, // dirty hack!!
		}));

		this.events.listen('hit', function(e){
			this.active = false;
			Luxe.events.fire('explosion', {x: this.pos.x, y: this.pos.y});

			Play.score += 50;
		});
	}

	public function reinit() {
		pos = new Vector(Luxe.utils.random.float(0, Main.w),
				Luxe.utils.random.float(C.spawn_area1, C.spawn_area2));
		rotateSpd = Luxe.utils.random.float(-C.enemy_rotateSpd_var, C.enemy_rotateSpd_var);
		velocity.set(0,
			C.enemy_speed + Luxe.utils.random.float(-C.enemy_speed_var, C.enemy_speed_var));

		seeker.reload();
		active = true;
	}

	// public function newSpeed(){
	// 	this.rotateSpd = Luxe.utils.random.float(-C.enemy_rotateSpd_var, C.enemy_rotateSpd_var);
	// }

	override function update(dt: Float) {
		this.collider.shape.rotation += rotateSpd * dt;

		if (this.active) {
			Luxe.draw.ngon({
				immediate: true,
				r: C.enemy_gunRadius,
				sides: 6,
				x: this.pos.x + C.enemy_radius * Math.cos(Math.PI /180 * this.collider.shape.rotation),
				y: this.pos.y + C.enemy_radius * Math.sin(Math.PI /180 * this.collider.shape.rotation),
				angle: -this.collider.shape.rotation,
				color: new Color().rgb(0xECECEC),
			});

			Luxe.draw.ngon({
				immediate: true,
				r: C.enemy_gunRadius,
				sides: 6,
				x: this.pos.x - C.enemy_radius * Math.cos(Math.PI /180 * this.collider.shape.rotation),
				y: this.pos.y - C.enemy_radius * Math.sin(Math.PI /180 * this.collider.shape.rotation),
				angle: -this.collider.shape.rotation,
				color: new Color().rgb(0xECECEC),
			});

			Luxe.draw.ngon({
				immediate: true,
				r: C.enemy_radius,
				sides: 6,
				x: this.pos.x,
				y: this.pos.y,
				angle: -this.collider.shape.rotation,
				solid: true,
				color: new Color().rgb(0xAE81ff),
				depth: -0.1,
			});
		}
	}
}