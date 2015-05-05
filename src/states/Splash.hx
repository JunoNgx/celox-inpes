package states;
import luxe.Color;
import luxe.Vector;
import luxe.Sprite;
import luxe.Input;
import luxe.States;
import phoenix.Texture;

class Splash extends State {

	var logo: Sprite;

	var delayStartTime: Float = 1;
	var fadeTime: Float = 1;
	var stayTime: Float = 2;
	var delaySwitchTime: Float = 1;

	// Set the next state in name (string) here
	var destinationState: String = 'play';

	public function new() {
		super( { name: "splash" } );
	}

	override function onenter<T> (_:T) {
		// Create the logo sprite
		logo = new Sprite ({
			// Change path to the texture of your logo/splash screen here
			texture: Luxe.resources.texture('assets/logo_box.png'),
			pos: new Vector(Luxe.screen.mid.x, Luxe.screen.mid.y),
			color: new Color(1, 1, 1, 0)
		});

		// Schedule fading in with a slight delay (looks better)
		Luxe.timer.schedule(delayStartTime, fadeIn);
	}

	function fadeIn() {
		logo.color.tween(fadeTime, { a: 1 } );
		Luxe.timer.schedule(fadeTime + stayTime, fadeOut);
	}

	function fadeOut() {
		logo.color.tween(fadeTime, { a: 0 } );
		Luxe.timer.schedule(fadeTime + delaySwitchTime, switchState);
	}

	// Switch to the designated state, set above
	function switchState() {
		Main.state.set(destinationState);
	}

	// Optionally skip splash screen by pressing keyboard or mouse or touch
	override function onmouseup(e: MouseEvent) {
		switchState();
	}

	override function onkeyup(e: KeyEvent) {
		switchState();
	}

	//override function update(dt: Float) {
		//
	//}
	//
	override function onleave<T> (_:T) {
		Luxe.timer.reset();
		logo.destroy();
	}


}
