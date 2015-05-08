package states;

import luxe.States;
import luxe.Text;
import luxe.Vector;
import luxe.Color;
import luxe.Input;
import luxe.Sprite;

class Title extends State {

	var titleText: Sprite;
	var subText: Text;
	var touchText: Text;
	var bottomText: Text;
	var toprightText: Text;

	public function new() {
		super({name: 'title'});
	}

	override public function onenter<T>(_:T) {

		titleText = new Sprite({
			// text: 'Celox Inpes',
			texture: Luxe.resources.texture('assets/cilogo.png'),
			pos: new Vector ( Main.w * 0.5, Main.h * 0.3),
			// point_size: 128,
			// align: center,
			// font: Main.dFont,
		});

		subText = new Text({
			text: 'Mobile Redux',
			pos: new Vector ( Main.w * 0.5, Main.h * 0.4),
			point_size: 32,
			align: center,
			font: Main.dFont,
		});

		touchText = new Text({
			pos: new Vector ( Main.w * 0.5, Main.h * 0.7),
			point_size: 32,
			align: center,
			font: Main.dFont,
		});

#if mobile
		touchText.text = ' touch to start';
#else
		touchText.text = ' start to start';
#end

		bottomText = new Text({
			text: 'created by Juno Nguyen \n 2015 Aureoline Tetrahedron',
			pos: new Vector ( Main.w * 0.5, Main.h * 0.9),
			point_size: 32,
			align: center,
			color: new Color(0.1, 0.1, 0.1, 0.1),
			font: Main.dFont,
		});

		toprightText = new Text({
			text: '@JunoNgx',
			pos: new Vector ( Main.w, 0),
			point_size: 32,
			align: right,
			align_vertical: top,
			font: Main.dFont,
		});
	}

	override public function onleave<T>(_:T) {
		titleText.destroy();
		subText.destroy();
		touchText.destroy();
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
