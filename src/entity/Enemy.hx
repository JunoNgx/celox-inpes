package entity;

import luxe.Vector;
import luxe.Color;
import luxe.collision.shapes.Polygon;

import entity.BaseEntity;
import component.Velocity;
import component.Collider;
import component.Seeker;

import states.Play;
import C;

class Enemy extends BaseEntity {

	var radius:Int = C.enemy_radius;
	var rotateSpd:Float;
	public var seeker: Seeker;

	override public function new() {
		super({
			name: 'enemy',
			name_unique: true,
			visible: false,
			size: new Vector( 4, 4 ),
			color: new Color().rgb(0xFD971F),
		});

		collider = new Collider({
			name: 'collider',
			against: 'player',
			shape: Polygon.create(pos.x, pos.y, 6, radius)
		});
		this.add(collider);

		seeker = new Seeker();
		this.add(seeker);

		velocity = new Velocity({name:'velocity'});
		this.add(velocity);

		this.velocity.x = 0;
		this.velocity.y = C.enemy_speed;

		newSpeed();
	}

	public function newSpeed(){
		rotateSpd = Luxe.utils.random.float(-C.enemy_rotateSpd_var, C.enemy_rotateSpd_var);
		this.velocity.y = C.enemy_speed + Luxe.utils.random.float(-C.enemy_speed_var, C.enemy_speed_var);
	}

	override function update(dt: Float){
		rotation_z += rotateSpd * dt;

		alignShape();

		if (this.pos.y > Luxe.screen.w + 300) kill();

		if (isAlive()) onrender();
	}

	function onrender(){

		Luxe.draw.ngon({
			immediate: true,
			r: C.enemy_gunRadius,
			sides: 6,
			x: this.pos.x + this.radius * Math.cos(Math.PI /180 * this.rotation_z),
			y: this.pos.y + this.radius * Math.sin(Math.PI /180 * this.rotation_z),
			// Note the negated value in rotation_z
			angle: -this.rotation_z,
			color: new Color().rgb(0xFFFFFF),
		});

		Luxe.draw.ngon({
			immediate: true,
			r: C.enemy_gunRadius,
			sides: 6,
			x: this.pos.x - this.radius * Math.cos(Math.PI /180 * this.rotation_z),
			y: this.pos.y - this.radius * Math.sin(Math.PI /180 * this.rotation_z),
			angle: -this.rotation_z,
			color: new Color().rgb(0xFFFFFF),
		});

		Luxe.draw.ngon({
			immediate: true,
			r: this.radius,
			sides: 6,
			x: this.pos.x,
			y: this.pos.y,
			angle: -this.rotation_z,
			solid: true,
			color: new Color().rgb(0x3FB8CD),
			depth: -0.1,
		});
	}

	override public function hit() {
		super.hit();

		Luxe.events.fire('explosion', {
			x: this.pos.x,
			y: this.pos.y,
		});
	}

}