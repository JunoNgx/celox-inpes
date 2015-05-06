package states;
import luxe.Sprite;
import luxe.Input;
import luxe.States;
import luxe.Color;
import luxe.Vector;
import luxe.Text;
import luxe.collision.ShapeDrawerLuxe;
import luxe.collision.Collision;
import luxe.Particles;

import luxe.Entity;

import entity.Player;
import entity.Shot;
import entity.Enemy;
import entity.Missile;
import entity.Star;
import entity.Explosion;

class Play extends State {

	static var shapeDrawer: ShapeDrawerLuxe;

	var scoreText: Text;
	public var score: Int;

	var loseStatus: Bool;

	var p: Player;

	// public static var shotGr: Pool<Shot>;
	// public static var enemyGr: Pool<Enemy>;
	// public static var missileGr: Pool<Missile>;

	// public static var expSys: ParticleSystem; // explosion system hah
	// var stars: ParticleSystem; // background

	var debug: Text;

	override public function new() {
		super({ name: "play" });
		shapeDrawer = new ShapeDrawerLuxe();
	}

	override public function onenter<T> (_:T) {

		// UI
		score = 0;
		scoreText = new Text({
			// immediate: true,
			// visible: true,
			text: Std.string(score),
			point_size: 24,
			pos: new Vector(Main.w * 0.5, Main.h * 0.1),
			align: center,
			align_vertical: center
		});

		// entities
		// poolSetup();
		// shotGr = [];
		// enemyGr = [];
		// missileGr = [];

		for (i in 0...C.star_amt) {
			var star = new Star();
		}

		p = new Player();

		// SpawnOneWaveOfEnemies();

		//audio
		// Luxe.audio.loop('music');

		// mechanic
		loseStatus = false;
		Luxe.events.listen('die!', function(e){
			showResult();
			loseStatus = true;
			// Luxe.audio.stop('music');
		});
		// Luxe.events.listen('explosion', function(options: ExpEventOptions){
		// 	explodeAt(new Vector(options.x, options.y));
		// 	Luxe.audio.play('bass');
		// });

		Luxe.timer.schedule(2, SpawnOneWaveOfEnemies);

		// expSys = new ParticleSystem({
		// 	name: 'part_exp',
		// 	pos: new Vector(Luxe.screen.w/2, Luxe.screen.h/2),
		// 	});
		// expSys.add_emitter({
		// 	name: 'part_exp1',
		// 	pos: new Vector(0, 0),
		// 	rotation: 45,
		// 	start_size: new Vector(50,50),
		// 	end_size: new Vector(50,50),
		// 	speed: 50,
		// 	speed_random: 20,
		// 	direction_random: 360,
		// 	life: 0.2, // lifetime of a particle
		// 	emit_time: 0.05, // Interval before a new particle is emitted
		// 	emit_count: 10, // Seems to be emitting in pulse and wave
		// });
		// expSys.stop();		

		//Background stars
		// stars = new ParticleSystem({
		// 	name: 'part_stars',
		// 	pos: new Vector(Luxe.screen.w/2, -120),
		// 	});
		// stars.add_emitter({
		// 	name: 'part_stars1',
		// 	pos: new Vector(Luxe.screen.w/2, 0),
		// 	pos_random: new Vector(Luxe.screen.w/2, 0),
		// 	start_color: new Color().rgb(0x444444),
		// 	end_color: new Color().rgb(0x444444),
		// 	speed: 600,
		// 	speed_random: 300,
		// 	direction: -90,
		// 	start_size: new Vector(40, 80),
		// 	end_size: new Vector(40, 80),
		// 	life: 10, // lifetime of a particle
		// 	emit_time: 0.05, // Interval before a new particle is emitted
		// 	// emit_count: 10, // Seems to be emitting in pulse and wave
		// 	depth: -2,
		// });
		// stars.start();

// #if debug
		// Luxe.scene.add(p);
		// p.init();

		// var progress_bars = new Pool<Dynamic>(10, 
		// 	function (index, total) {
		// 		var _s = Luxe.draw.ring({
		// 			x: Luxe.screen.mid.x, y: Luxe.screen.mid.y,
		// 			r:  40,
		// 			depth: 0.5,
		// 			color: new Color(0,0,0,0.0).rgb(0xf6007b)
		// 		});
		// 		return _s;
		// });

		// var b = progress_bars.get();
		// b.color.tween( 10, {a:1}, true);

		debug = new Text({});
// #end
	}

	override public function update(dt: Float) {

		collisionSweep();


		// if (!loseStatus) scoreText.text = Std.string(score);

		// Annouce player's position to enemies
		Luxe.events.fire('player position', {x: p.pos.x, y: p.pos.y});


		#if debug
			debug.text = p.pos.x
			+ '\n' + p.pos.y
			+ '\n' + Luxe.screen.w
			+ '\n' + Luxe.screen.h;
		#end
	}

	override public function onrender() {
		shapeDrawer.drawShape(p.collider.shape);

#if debug
		// shapeDrawer.drawShape(p.collider.shape);

		// for (i in 0...pool_enemy.length) {
		// 	var entity = pool_enemy.get();
		// 	shapeDrawer.drawShape(entity.collider.shape);
		// }

		// for (i in 0...pool_shot.length) {
		// 	var entity = pool_shot.get();
		// 	shapeDrawer.drawShape(entity.collider.shape);
		// }		

		// for (i in 0...pool_missile.length) {
		// 	var entity = pool_missile.get();
		// 	shapeDrawer.drawShape(entity.collider.shape);
		// }
#end
	} // onrender

	override public function onleave<T> (_:T) {
		// p.destroy();
		// scoreText.destroy();

		// pool_shot = null;
		// pool_enemy = null;
		// pool_missile = null;

		// debug.destroy();

		Luxe.timer.reset();
		
		// Rough and lazy but effect, huh?
		Luxe.scene.empty();
	} // onleave

	override public function onmouseup(e: MouseEvent) {
		if (loseStatus) {
			Main.state.set('title');
		}
	} // onmouseup

	// override public function ontouchmove(e: TouchEvent) {
	// 	p.pos = Luxe.camera.screen_point_to_world(e.pos);
	// } // on touch move

	override function onkeyup( e:KeyEvent ) {
		//escape from the game at any time, mostly for debugging purpose
		if(e.keycode == Key.escape) {
			Luxe.shutdown();
		} else if (e.keycode == Key.space) {
			// p.events.fire('hit');

			// for (i in 0...pool_enemy.length) {
			// 	var enemy = pool_enemy.get();
			// 	enemy.seeker.fire();
			// }
			// var bullet = new Shot( Luxe.utils.random.float(0, 400), 600);

			var exp = new Explosion ( 200, 200);
		}
	} // onkeyup

// -----====== End of standard callbacks =======--------------


// -----====== Mechanic =======--------

	function showResult() {
		scoreText.point_size = 40;
		scoreText.pos.y = Main.h * 0.3;
		scoreText.text = 'Your score \n' + Std.string(score);

		trace('showed result');
	}

	function collisionSweep() {

		var shotGr = [];
		Luxe.scene.get_named_like('shot', shotGr);
		var enemyGr = [];
		Luxe.scene.get_named_like('enemy', enemyGr);
		var missileGr = [];
		Luxe.scene.get_named_like('missile', missileGr);

		// Luxe.scene.get_named_like() only returns an Array<luxe.Entity>
		// without extended properties and members
		// further fiddling and get() is required

		// shot vs enemy
		for (shot in shotGr) {
			for (enemy in enemyGr) {
				var sCol = shot.get('collider');
				var eCol = enemy.get('collider');
				if (Collision.shapeWithShape (sCol.shape, eCol.shape) != null) {
					shot.destroy();
					enemy.destroy();

					explodeAt(enemy.pos);

					score += 40;
					updateScore();
				}
			}
		}		

		// shot vs missile
		for (shot in shotGr) {
			for (missile in missileGr) {
				var sCol = shot.get('collider');
				var mCol = missile.get('collider');
				if (Collision.shapeWithShape (sCol.shape, mCol.shape) != null) {

					score += 1;
					updateScore();

				}
			}
		}

		// player vs enemy
		for (enemy in enemyGr) {
			var col = enemy.get('collider');
			if (Collision.shapeWithShape (p.collider.shape, col.shape) != null) {
				p.destroy();
				enemy.destroy();

				Luxe.events.fire('die!');
			}
		}

		// player vs missile
		for (missile in missileGr) {
			var col = missile.get('collider');
			if (Collision.shapeWithShape (p.collider.shape, col.shape) != null) {
				p.destroy();
				missile.destroy();

				Luxe.events.fire('die!');
			}
		}



		// for (enemy in enemyGroup) {
		// 	for (bullet in bulletGroup) {
		// 		if (Collision.shapeWithShape (enemy.shape, bullet.shape) != null) {
					
		// 			debugShapes.remove(enemy.shape);
		// 			debugShapes.remove(bullet.shape);

		// 			enemyGroup.remove(enemy);
		// 			enemy.destroy( );

		// 			bulletGroup.remove(bullet);
		// 			bullet.destroy( );
		// 		}
		// 	}
		// }
	}

	function SpawnOneWaveOfEnemies() {

		var actual_amount = Math.ceil(C.wave_amt + Luxe.utils.random.float(-C.wave_amt_var, C.wave_amt_var));

		for (i in 0...actual_amount) var enemy = new Enemy();


		Luxe.timer.schedule(
			Luxe.utils.random.float(C.spawn_time1, C.spawn_time2),
			SpawnOneWaveOfEnemies);

		trace('spawned');

	}

	function updateScore() {
		scoreText.text = Std.string(score);
	}

	function explodeAt(position: Vector) {
		// Play.expSys.pos = position;
		// Play.expSys.start(C.exp_time);

		var amt = Luxe.utils.random.int(C.exp_amt_min, C.exp_amt_max);

		for (i in 0...amt) {
			// Luxe.timer.schedule(0.005,
			// 	function() {
			// 		var exp = new Explosion ( position.x, position.y);
			// 	}
			// );
			var exp = new Explosion ( position.x, position.y);
		}
		// Luxe.camera.shake(20);
	}

// ------========= Pool management =========--------


// 	function poolSetup(){

// 		pool_shot = new Pool<Shot>(C.pool_max_shot,
// 			function(index, total):Shot {
// 				var entity = new Shot(); 
// 				// shot.init();
// 				entity.kill();
// 				return entity;
// 			},
// 			true);

// 		pool_enemy = new Pool<Enemy>(C.pool_max_enemy,
// 			function(index, total):Enemy {
// 				var entity = new Enemy();
// 				// enemy.init();
// 				entity.kill();
// 				return entity;
// 			},
// 			true);

// 		pool_missile = new Pool<Missile>(C.pool_max_missile,
// 			function(index, total):Missile {
// 				var entity = new Missile();
// 				entity.kill();
// 				return entity;
// 			},
// 			true);
// 	}

}

typedef ExpEventOptions = {
	var x: Float;
	var y: Float;
}