package;

import luxe.States;
import states.Play;
import states.Splash;
import states.Title;

import luxe.Camera;
import luxe.Vector;
import phoenix.Color;
import luxe.Screen.WindowEvent;

class Main extends luxe.Game {

	public static var w: Int = 480;
	public static var h: Int = 640;

	public static var winW: Int;
	public static var winH: Int;

	var initialState:String = 'play'; // First state to run, in string (luxe.States.State.name), refer to state's file

	public static var state: States;

	override function config(config:luxe.AppConfig) {

		// Preloading textures, optional
		config.preload.textures = [
			{id: 'assets/logo_box.png'}
		];

        #if web
        	config.window.fullscreen = true;
        #end

        return config;
	}

    override function onwindowsized( e:WindowEvent ) {
        Luxe.camera.viewport = new luxe.Rectangle( 0, 0, e.event.x, e.event.y);
    }

	override function ready() {

		// Set a consistent camera mode for the entire game
		Luxe.camera.size = new Vector(Main.w, Main.h);
		Luxe.camera.size_mode = SizeMode.fit;

		// Useful when you want your gameplay mechanic to
		// adapt to different screen size/ratio
		Main.winW = Luxe.snow.windowing.display_bounds(0).width;
		Main.winH = Luxe.snow.windowing.display_bounds(0).height;

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
