package scripts;

import haxe.Timer;

import kha.Font;
import kha.Color;
import kha.System;

import rice2d.ui.UI;
import rice2d.Assets;
import rice2d.ui.Style;

class Scoreborad extends rice2d.Script{

	var scoreboardUI: UI;
	var font:Font;
	public static var p1Score = 0;
	public static var p2Score = 0;
	public static var gameOver = false;

	public function new() {
		super();

		notifyOnAdd(()->{
			// Get font from assets.
			font = Assets.getAsset("font", Font);

			// Get default light theme and customize it.
			var style = Style.light;
			style.textColor = Color.White;
			style.textHoverColor = Color.White;
			style.textDownColor = Color.White;
			style.backgroundColor = 0;
			style.backgroundDownColor = 0;
			style.backgroundHoverColor = 0;

			// Create new UI for scoreboard
			scoreboardUI = new UI({
				name: "scoreboard",
				font: font,
				elements: [
					{
						name: "scores",
						style: style,
						text: '$p1Score : $p2Score', type: Text,
						x: Std.int((System.windowWidth()/2)-(font.width(50, '$p1Score : $p2Score')/2)),
						y: 50, width: 200, height: 50
					},
					{
						name: "stat",
						style: style,
						visible: false,
						text: 'Player1 Wins', type: Text,
						x: Std.int((System.windowWidth()/2)-(font.width(50, 'Player 1 Wins')/2)),
						y: 180,
						width: 200, height: 50
					},
					{
						name: "instruct",
						style: style,
						visible: false,
						text: 'Click to Retry', type: Text,
						x: Std.int((System.windowWidth()/2)-(font.width(50, 'Player 1 Wins')/2)),
						y: 290,
						width: 200, height: 50
					},
					{
						name: "bg", text:"", type: Rect,
						style: style,
						x: 0, y: 0,
						width: System.windowWidth(), height: System.windowHeight(),
						onClicked: resetGame
					},
				]
			});
		});

		notifyOnUpdate(()->{
			// Get element from UI and set it properties.
			scoreboardUI.getElement("scores").text = '$p1Score : $p2Score';
			scoreboardUI.getElement("scores").x = Std.int((System.windowWidth()/2)-(font.width(50, '$p1Score : $p2Score')/2));

			if(p1Score >= 50){
				gameOver = true;
				BallController.pause = true;
				scoreboardUI.getElement("stat").visible = true;
				scoreboardUI.getElement("instruct").visible = true;
				scoreboardUI.getElement("stat").text = "Player1 Wins!";
			}else if(p2Score >= 50){
				gameOver = true;
				BallController.pause = true;
				scoreboardUI.getElement("stat").visible = true;
				scoreboardUI.getElement("instruct").visible = true;
				scoreboardUI.getElement("stat").text = "Player2 Wins!";
			}
		});

	}

	function resetGame() {
		if(gameOver){
			p1Score = 0;
			p2Score = 0;
			scoreboardUI.getElement("stat").visible = false;
			scoreboardUI.getElement("instruct").visible = false;
			Timer.delay(()->{
				BallController.pause = false;
			}, 1000);
		}
	}
}
