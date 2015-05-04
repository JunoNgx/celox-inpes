package states;
import luxe.Sprite;
import luxe.Input;
import luxe.States;
import luxe.Color;
import luxe.Vector;
import luxe.Camera;
import luxe.Text;
import luxe.collision.ShapeDrawerLuxe;
import luxe.collision.Collision;

import luxe.Entity;

import luxe.structural.Pool;

import entity.Player;
import entity.Shot;
import entity.Enemy;
import entity.Missile;

class Play extends State {

	static var shapeDrawer: ShapeDrawerLuxe;

	var scoreText: Text;
	public static var score: Int;
	var loseStatus: Bool;

	var p: Player;
	public static var pool_shot: Pool<Shot>;
	public static var pool_enemy: Pool<Enemy>;
	public static var pool_missile: Pool<Missile>;

	var debug: Text;

	public function new() {
		super( { name: "play" } );
		shapeDrawer = new ShapeDrawerLuxe();
	}

	override public function onenter<T> (_:T) {

		// UI
		scoreText = new Text({
			// immediate: true,
			// visible: true,
			text: Std.string(score),
			point_size: 24,
			pos: new Vector(Luxe.screen.w * 0.5, Luxe.screen.h * 0.1),
			align: center,
			align_vertical: center
		});
		score = 0;

		// entities
		poolSetup();
		p = new Player();

		enemyRespawn();

		// mechanic
		loseStatus = false;
		Luxe.events.listen('die!', function(e){
			showResult();
			loseStatus = true;
		});

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

		if (!loseStatus) scoreText.text = Std.string(score);

		// if (p.has('collider') && p.active) trace('player has collider');

		// Annouce player's position to enemies
		Luxe.events.fire('player position', {x: p.pos.x, y: p.pos.y});


		#if debug
			// var targets = new Array<Entity>();
			// targets = Luxe.scene.get_named_like('player', targets);

			debug.text = Std.string(Luxe.scene.length)
			+ '\n' ;
		#end
	}

	override public function onrender() {
#if debug
		shapeDrawer.drawShape(p.collider.shape);

		for (i in 0...pool_enemy.length) {
			var entity = pool_enemy.get();
			shapeDrawer.drawShape(entity.collider.shape);
		}

		for (i in 0...pool_shot.length) {
			var entity = pool_shot.get();
			shapeDrawer.drawShape(entity.collider.shape);
		}		

		for (i in 0...pool_missile.length) {
			var entity = pool_missile.get();
			shapeDrawer.drawShape(entity.collider.shape);
		}
#end
	} // onrender

	override public function onleave<T> (_:T) {
		p.destroy();
		scoreText.destroy();

		pool_shot = null;
		pool_enemy = null;
		pool_missile = null;

		debug.destroy();

		Luxe.timer.reset();
		
		// Rough and lazy but effect, huh?
		Luxe.scene.empty();
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
			// p.events.fire('hit');

			for (i in 0...pool_enemy.length) {
				var enemy = pool_enemy.get();
				enemy.seeker.fire();
			}
		}
	} // onkeyup

// ----------======= End of standard callbacks =======-------------------


// -----====== Mechanic =======--------------

	function showResult():Void {
		scoreText.point_size = 40;
		scoreText.pos.y = Luxe.screen.h * 0.3;
		scoreText.text = 'Your score \n' + Std.string(score);
	}

	function enemyRespawn():Void {

		for (i in 0...pool_enemy.length) {
			var enemy = pool_enemy.get();
			enemy.newRotateSpd();
			enemy.pos = new Vector(
				Luxe.utils.random.float(0, Luxe.screen.w),
				Luxe.utils.random.float(C.spawn_area1, C.spawn_area2)
			);
			enemy.revive();
			enemy.seeker.reload();
		}

		Luxe.timer.schedule(
			Luxe.utils.random.float(C.spawn_time1, C.spawn_time2),
			enemyRespawn);

		trace('respawned');

	}

// ------========= Pool management ======= ---------------


	function poolSetup(){

		pool_shot = new Pool<Shot>(C.pool_max_shot,
			function(index, total):Shot {
				var entity = new Shot(); 
				// shot.init();
				entity.kill();
				return entity;
			},
			true);

		pool_enemy = new Pool<Enemy>(C.pool_max_enemy,
			function(index, total):Enemy {
				var entity = new Enemy();
				// enemy.init();
				entity.kill();
				return entity;
			},
			true);

		pool_missile = new Pool<Missile>(C.pool_max_missile,
			function(index, total):Missile {
				var entity = new Missile();
				entity.kill();
				return entity;
			},
			true);
	}

	// function poolInit() {

	// 	for (i in 0...50) {
	// 		var entity = new Shot();
	// 		entity.kill();
	// 		pool[1].push(entity);
	// 	}
	// 	trace('shots created');

	// 	var p = new Player();
	// 	pool[0].push(p);
	// 	trace('player created');
	// }

	// public function getFirstDead(pool: Array<Dynamic>) {
	// 	for (entity in pool) {
	// 		if (!entity.active) {
	// 			if (!entity.visible) {
	// 				return entity;
	// 			}
	// 		}
	// 	}
	// 	return null;
	// }

	// public function spawnSingle(pool: Array<Dynamic>, X: Float, Y:Float) {
	// 	var entity = getFirstDead(pool);
	// 	entity.pos.x = X;
	// 	entity.pos.y = Y;
	// 	entity.revive();
	// }

}
