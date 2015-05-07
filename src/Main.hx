package;

import luxe.States;
import states.Play;
import states.Splash;
import states.Title;

import luxe.Camera;
import luxe.Vector;
import phoenix.Color;
import luxe.Screen.WindowEvent;
import phoenix.Texture;
import phoenix.BitmapFont;

class Main extends luxe.Game {

	public static var w: Int = 480;
	public static var h: Int = 640;

	public static var winW: Int;
	public static var winH: Int;

	var initialState:String = 'title'; // First state to run, in string (luxe.States.State.name), refer to state's file

	public static var dFont: BitmapFont;

	public static var state: States;

	override function config(config:luxe.AppConfig) {

		// Preloading textures, optional
		// config.preload.textures = [
		// 	{id: 'assets/logo_box.png'},
		// 	{id: 'assets/player.png', filter_min:FilterType.nearest, filter_mag:FilterType.nearest},
		// 	{id: 'assets/shot.png', filter_min:FilterType.nearest, filter_mag:FilterType.nearest},
		// 	{id: 'assets/enemy.png', filter_min:FilterType.nearest, filter_mag:FilterType.nearest},
		// 	{id: 'assets/missile.png', filter_min:FilterType.nearest, filter_mag:FilterType.nearest},
		// 	{id: 'assets/explosion.png', filter_min:FilterType.nearest, filter_mag:FilterType.nearest}
		// ];

		config.preload.fonts.push({ id:'assets/Muzarela.fnt'});
		// config.preload.fonts.push({ id:'assets/Muzarela64.fnt'});

		config.preload.textures.push({ id:'assets/cilogo.png', filter_min:FilterType.nearest, filter_mag:FilterType.nearest });
		
		// config.preload.textures.push({ id:'assets/player.png', filter_min:FilterType.nearest, filter_mag:FilterType.nearest });
		// config.preload.textures.push({ id:'assets/shot.png', filter_min:FilterType.nearest, filter_mag:FilterType.nearest });
		// config.preload.textures.push({ id:'assets/enemy.png', filter_min:FilterType.nearest, filter_mag:FilterType.nearest });
		// config.preload.textures.push({ id:'assets/missile.png', filter_min:FilterType.nearest, filter_mag:FilterType.nearest });
		// config.preload.textures.push({ id:'assets/explosion.png', filter_min:FilterType.nearest, filter_mag:FilterType.nearest });

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

		// Background color
		// Luxe.renderer.clear_color = new Color().rgb(0xD7D7D7);
		dFont = Luxe.resources.font('assets/Muzarela.fnt');
		Luxe.audio.create('assets/DrumBass.ogg', 'bass');
		Luxe.audio.create('assets/DrumSeq.ogg', 'music');

		// Draw line on horizontal borders
		Luxe.draw.line({
			p0: new Vector(0, 0),
			p1: new Vector(0, Main.h),
			color: new Color(0.2, 0.2, 0.2, 1),
		});

		Luxe.draw.line({
			p0: new Vector(Main.w, 0),
			p1: new Vector(Main.w, Main.h),
			color: new Color(0.2, 0.2, 0.2, 1),
		});

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

	// override function onrender() {
	// 	// Luxe.draw.rectangle({
	// 	// 	x: 0, y: 0,
	// 	// 	w: Main.w,
	// 	// 	h: Main.h,
	// 	// 	color: new Color(0.2, 0.2, 0.2, 1),
	// 	// 	// solid: true,
	// 	// 	depth: -10,
	// 	// });
	// }

}
