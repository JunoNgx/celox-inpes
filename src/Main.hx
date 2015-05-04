package;

import luxe.States;
import states.Play;
import states.Splash;
import states.Title;

import phoenix.Color;
import luxe.Screen.WindowEvent;

class Main extends luxe.Game {

	var initialState:String = 'title'; // First state to run, in string (luxe.States.State.name), refer to state's file

	public static var state: States;

	override function config(config:luxe.AppConfig) {

		// Preloading textures, optional
		config.preload.textures = [
			{id: 'assets/logo_box.png'}
		];

        // #if web
        // config.window.fullscreen = false;
        // #end

        return config;
	}

	override function onwindowsized( e:WindowEvent ) {
        Luxe.camera.viewport = new luxe.Rectangle( 0, 0, e.event.x, e.event.y);
    }

	override function ready() {

		// Luxe.renderer.clear_color = new Color(0.23, 0.23, 0.23, 1) ;
		Luxe.audio.create('assets/DrumBass.ogg', 'bass');
		Luxe.audio.create('assets/DrumSeq.ogg', 'music');
		Luxe.screen.cursor.visible = false;

		// Create a state machine [...]
		state = new States( { name: "states" } );

		// Add states to the state machine
		state.add (new Play());
		state.add (new Splash());
		state.add (new Title());

		// Set the inital state upon running the game
		state.set(initialState);

	}

}
