package states;

import luxe.States;
import luxe.Text;
import luxe.Vector;
import luxe.Color;
import luxe.Input;

class Title extends State {

	var titleText: Text;
	var subText: Text;
	var bottomText: Text;
	var toprightText: Text;

	public function new() {
		super({name: 'title'});
	}

	override public function onenter<T>(_:T) {
		// super

		titleText = new Text({
			text: 'Celox Inpes',
			pos: new Vector ( Luxe.screen.w * 0.5, Luxe.screen.h * 0.3),
			point_size: 60,
			// font: font,
			align: center,
		});

		subText = new Text({
			// text: 'Celox Inpes',
			pos: new Vector ( Luxe.screen.w * 0.5, Luxe.screen.h * 0.5),
			point_size: 30,
			// font: font,
			align: center,
		});

#if mobile
		subText.text = ' click to start';
#else
		subText.text = ' touch to start';
#end

		bottomText = new Text({
			text: 'created by Juno Nguyen \n 2015 Aureoline Tetrahedron',
			pos: new Vector ( Luxe.screen.w * 0.5, Luxe.screen.h * 0.9),
			point_size: 20,
			// font: font,
			align: center,
		});

		toprightText = new Text({
			text: '@JunoNgx',
			pos: new Vector ( Luxe.screen.w, 0),
			point_size: 15,
			// font: font,
			align: right,
			align_vertical: top,
		});
	}

	override public function onleave<T>(_:T) {
		titleText.destroy();
		subText.destroy();
		bottomText.destroy();
		toprightText.destroy();
	}

	override public function onmouseup(e: MouseEvent) {
		Main.state.set('play');
	}

	override function onkeyup( e:KeyEvent ) {
		if(e.keycode == Key.escape) {
			Luxe.shutdown();
		}
	}
}
