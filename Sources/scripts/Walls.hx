package scripts;

import kha.Color;
import kha.System;

import rice2d.Scene;
import rice2d.data.ObjectData;

class Walls extends rice2d.Script{

    var wallTop:ObjectData;
    var wallBottom:ObjectData;
    var wallRight:ObjectData;
    var wallLeft:ObjectData;

    public function new() {
        super();

        notifyOnAdd(()->{
            // Get objects from scene and its properties
            wallTop = Scene.getObject("wallTop").props;
            wallTop.width = System.windowWidth();

            wallBottom = Scene.getObject("wallBottom").props;
            wallBottom.width = System.windowWidth();
            wallBottom.y = System.windowHeight()-wallTop.height;

            wallRight = Scene.getObject("wallRight").props;
            wallRight.x = System.windowWidth()-wallRight.width;
            wallRight.height = System.windowHeight();

            wallLeft = Scene.getObject("wallLeft").props;
            wallLeft.height = System.windowHeight();

        });

        notifyOnRender(function (canvas){
            var g = canvas.g2;
            var col = g.color;
            // Draw simple shape for walls.
            g.color = Color.fromBytes(255, 70, 70);// Set color to red.
            //Draw filled rectangle.
            g.fillRect(wallRight.x, wallRight.y, wallRight.width, wallRight.height);
            g.fillRect(wallLeft.x, wallLeft.y, wallLeft.width, wallLeft.height);
            g.color = Color.White;
            g.fillRect(wallTop.x, wallTop.y, wallTop.width, wallTop.height);
            g.fillRect(wallBottom.x, wallBottom.y, wallBottom.width, wallBottom.height);
            g.color = col;
        });

    }
}