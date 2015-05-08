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

import luxe.structural.Pool;

import entity.Player;
import entity.Shot;
import entity.Enemy;
import entity.Missile;
import entity.Star;
import entity.Explosion;

class Play extends State {

	static var shapeDrawer: ShapeDrawerLuxe;

	var scoreText: Text;
	public static var score: Int;
	var loseStatus: Bool;

	public static var pool_shot: Pool<Shot>;
	public static var pool_enemy: Pool<Enemy>;
	public static var pool_missile: Pool<Missile>;
	public static var pool_exp: Pool<Explosion>;

	var p: Player;

	var debug: Text;

	override public function new() {
		super({ name: "play" });
		shapeDrawer = new ShapeDrawerLuxe();
	}

	override public function onenter<T> (_:T) {

		// UI
		score = 0;
		scoreText = new Text({
			text: Std.string(score),
			// point_size: 32,
			pos: new Vector(Main.w * 0.5, Main.h * 0.1),
			align: center,
			align_vertical: center,
			font: Main.dFont,
		});

		// Adding the background stars
		for (i in 0...C.star_amt) {
			var star = new Star();
		}
		poolInit();
		p = new Player();

		// mechanic
		loseStatus = false;
		Luxe.events.listen('die!', function(e){
			showResult();
			loseStatus = true;
			p.active = false;
			Luxe.audio.stop('music');
		});

		Luxe.events.listen('explosion', function(options: PositionOptions){
			explodeAt(options.x, options.y);
		});

		Luxe.audio.loop('music');
		Luxe.timer.schedule(1, SpawnOneWaveOfEnemies);

		debug = new Text({});
// #end
	}

	override public function update(dt: Float) {
		// collisionSweep();

		if (!loseStatus) scoreText.text = Std.string(score);

		// Annouce player's position to enemies
		Luxe.events.fire('player position', {x: p.pos.x, y: p.pos.y});

		#if debug
			// debug.text = p.pos.x
			// + '\n' + p.pos.y
			// + '\n' + Luxe.screen.w
			// + '\n' + Luxe.screen.h;

			debug.text = Std.string(pool_enemy.length);
		#end
	}

	override public function onrender() {

#if debug
		shapeDrawer.drawShape(p.collider.shape);

		var shotGr = [];
		Luxe.scene.get_named_like('shot', shotGr);
		var enemyGr = [];
		Luxe.scene.get_named_like('enemy', enemyGr);
		var missileGr = [];
		Luxe.scene.get_named_like('missile', missileGr);

		for (entity in shotGr) {
			var collider = entity.get('collider');
			shapeDrawer.drawShape(collider.shape);
		}

		for (entity in enemyGr) {
			var collider = entity.get('collider');
			shapeDrawer.drawShape(collider.shape);
		}

		for (entity in missileGr) {
			var collider = entity.get('collider');
			shapeDrawer.drawShape(collider.shape);
		}
#end
	} // onrender

	override public function onleave<T> (_:T) {
		Luxe.timer.reset();
		Luxe.scene.empty();
		Luxe.events.clear();

		pool_shot = null;
		pool_enemy = null;
		pool_missile = null;
		pool_exp = null;
	} // onleave

	override public function onmouseup(e: MouseEvent) {
		if (loseStatus) {
			Main.state.set('title');
		}
	} // onmouseup

	override function onkeyup( e:KeyEvent ) {
		//escape from the game at any time, mostly for debugging purpose
		if(e.keycode == Key.escape) {
			Luxe.shutdown();
		} else if (e.keycode == Key.space) {

		}
	} // onkeyup for debugging

// -----====== End of standard callbacks =======--------------


// -----====== Mechanic =======--------

	function showResult() {
		scoreText.point_size = 40;
		scoreText.pos.y = Main.h * 0.3;
		scoreText.text = 'Your score \n' + Std.string(score);

		trace('showed result');
	}

	// function collisionSweep() {

	// 	var shotGr = [];
	// 	Luxe.scene.get_named_like('shot', shotGr);
	// 	var enemyGr = [];
	// 	Luxe.scene.get_named_like('enemy', enemyGr);
	// 	var missileGr = [];
	// 	Luxe.scene.get_named_like('missile', missileGr);

	// 	// Luxe.scene.get_named_like() only returns an Array<luxe.Entity>
	// 	// without extended properties and members
	// 	// further fiddling and get() is required

	// 	// shot vs enemy
	// 	for (shot in shotGr) {
	// 		for (enemy in enemyGr) {
	// 			var sCol = shot.get('collider');
	// 			var eCol = enemy.get('collider');
	// 			if (Collision.shapeWithShape (sCol.shape, eCol.shape) != null) {
	// 				explodeAt(enemy.pos);

	// 				shot.destroy();
	// 				enemy.destroy();

	// 				score += 40;
	// 				updateScore();
	// 			}
	// 		}
	// 	}		

	// 	// shot vs missile
	// 	for (shot in shotGr) {
	// 		for (missile in missileGr) {
	// 			var sCol = shot.get('collider');
	// 			var mCol = missile.get('collider');
	// 			if (Collision.shapeWithShape (sCol.shape, mCol.shape) != null) {

	// 				score += 1;
	// 				updateScore();

	// 			}
	// 		}
	// 	}

	// 	// player vs enemy
	// 	for (enemy in enemyGr) {
	// 		var col = enemy.get('collider');
	// 		if (Collision.shapeWithShape (p.collider.shape, col.shape) != null
	// 		&& p.active) {
	// 			explodeAt(enemy.pos);

	// 			p.destroy();
	// 			enemy.destroy();

	// 			Luxe.events.fire('die!');
	// 			explodeAt(enemy.pos);
	// 		}
	// 	}

	// 	// player vs missile
	// 	for (missile in missileGr) {
	// 		var col = missile.get('collider');
	// 		if (Collision.shapeWithShape (p.collider.shape, col.shape) != null
	// 		&& p.active) {
	// 			explodeAt(p.pos);

	// 			p.destroy();
	// 			missile.destroy();

	// 			Luxe.events.fire('die!');
	// 		}
	// 	}
	// }

	function poolInit() {
		pool_shot = new Pool<Shot>(C.pool_max_shot,
			function(index, total):Shot {
				var entity = new Shot(); 
				// shot.init();
				entity.active = false;
				return entity;
			},
			true);

		pool_enemy = new Pool<Enemy>(C.pool_max_enemy,
			function(index, total):Enemy {
				var entity = new Enemy();
				// enemy.init();
				entity.active = false;
				return entity;
			},
			true);

		pool_missile = new Pool<Missile>(C.pool_max_missile,
			function(index, total):Missile {
				var entity = new Missile();
				entity.active = false;
				return entity;
			},
			true);

		pool_exp = new Pool<Explosion>(C.pool_max_exp,
			function(index, total):Explosion {
				var entity = new Explosion();
				entity.active = false;
				return entity;
			},
			true);
	}

	function SpawnOneWaveOfEnemies() {
		var actual_amount = Math.ceil(C.wave_amt + Luxe.utils.random.float(-C.wave_amt_var, C.wave_amt_var));
		for (i in 0...actual_amount) {
			var enemy = pool_enemy.get();
			enemy.reinit();
		}
		Luxe.timer.schedule(
			Luxe.utils.random.float(C.spawn_time1, C.spawn_time2),
			SpawnOneWaveOfEnemies);
		trace('spawned');
	}

	function updateScore() {
		if (p.active) scoreText.text = Std.string(score);
	}

	function explodeAt(X: Float, Y: Float) {
		// Randomize
		var amt = Luxe.utils.random.int(C.exp_amt_min, C.exp_amt_max);

		for (i in 0...amt) {
			// var exp = new Explosion (X, Y);
			var exp = pool_exp.get();
			exp.reinit(X, Y);
		}
		// Luxe.camera.shake(20);
		Luxe.audio.play('bass');
	}

}

typedef PositionOptions = {
	var x: Float;
	var y: Float;
}