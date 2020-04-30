package scripts;

import haxe.Timer;

import kha.System;
import kha.math.Random;
import kha.math.Vector2;
using kha.graphics2.GraphicsExtension;

import rice2d.Scene;
import rice2d.data.ObjectData;

class BallController extends rice2d.Script{

    var paddle1:ObjectData;
    var paddle2:ObjectData;

    var wallTop:ObjectData;
    var wallBottom:ObjectData;
    var wallLeft:ObjectData;
    var wallRight:ObjectData;

    var dirx:Float = 0.0;
    var diry:Float = 0.0;

    public static var pause = false;

    public function new() {
        super();

        notifyOnAdd(() -> {
            paddle1 = Scene.getObject("player1").props;
            paddle2 = Scene.getObject("player2").props;
            wallTop = Scene.getObject("wallTop").props;
            wallBottom = Scene.getObject("wallBottom").props;
            wallLeft = Scene.getObject("wallLeft").props;
            wallRight = Scene.getObject("wallRight").props;
            object.transform.setCenter(System.windowWidth()/2, System.windowHeight()/2);
            var rand = getRandomPoint();
            var dir = new Vector2(rand.x, rand.y).normalized();
            dirx = dir.x;
            diry = dir.y;
        });
        
        notifyOnInit(()->{
            pause = true;
            Timer.delay(()->{pause = false;}, 2000);
        });

        notifyOnUpdate(() -> {
            if(pause) return null;
            if(checkCollision(paddle1)){
                //                               mafs
                var vec = new Vector2(1, Math.atan2(diry, dirx)).normalized();
                dirx = vec.x;
                diry = vec.y;
            }else if(checkCollision(paddle2)){
                //                               mafs
                var vec = new Vector2(-1, Math.atan2(diry, dirx)).normalized();
                dirx = vec.x;
                diry = vec.y;
            }else if(checkCollision(wallTop)){
                //                               mafs
                var vec = new Vector2(Math.atan2(dirx, diry), 1).normalized();
                dirx = vec.x;
                diry = vec.y;
            }else if(checkCollision(wallBottom)){
                //                               mafs
                var vec = new Vector2(Math.atan2(dirx, diry), -1).normalized();
                dirx = vec.x;
                diry = vec.y;
            }else if(checkCollision(wallLeft)){
                Scoreborad.p2Score += 10;
                object.transform.setCenter(System.windowWidth()/2, System.windowHeight()/2);

                var rand = getRandomPoint();
                var dir = new Vector2(rand.x, rand.y).normalized();
                dirx = dir.x;
                diry = dir.y;

                pause = true;
                Timer.delay(()->{pause = false;}, 2000);
            }else if(checkCollision(wallRight)){
                Scoreborad.p1Score += 10;
                object.transform.setCenter(System.windowWidth()/2, System.windowHeight()/2);

                var rand = getRandomPoint();
                var dir = new Vector2(rand.x, rand.y).normalized();
                dirx = dir.x;
                diry = dir.y;

                pause = true;
                Timer.delay(()->{pause = false;}, 2000);
            }

            object.props.x += dirx * 6;
            object.props.y += diry * 6;
        });

        notifyOnRender(function (canvas){
            var g = canvas.g2;
            var c = object.transform.getCenter();
            g.fillCircle(c.x, c.y, object.props.width);
        });

    }

    function getRandomPoint() {
        // Get random points between -1 and 1.
        Random.init(3243242*Std.int(Math.random()*342));
        var randx = Random.getFloatIn(-1, 1);
        var randy = Random.getFloatIn(-1, 1);
        return {x: randx, y: randy}
    }

    function checkCollision(rect:ObjectData) {
        // Simple rect-circle collision detection
        // http://jeffreythompson.org/collision-detection/circle-rect.php

        var c = object.transform.getCenter();
        // temporary variables to set edges for testing
        var testX = c.x;
        var testY = c.y;
        var rx = rect.x;
        var ry = rect.y;
        var rw = rect.width;
        var rh = rect.height;
        
        // which edge is closest?
        if (c.x < rx)         testX = rx;      // test left edge
        else if (c.x > rx + rw) testX = rx+rw;   // right edge
        if (c.y < ry)         testY = ry;      // top edge
        else if (c.y > ry + rh) testY = ry+rh;   // bottom edge
        
        // get distance from closest edges
        var distX = c.x-testX;
        var distY = c.y-testY;
        var distance = Math.sqrt( (distX*distX) + (distY*distY) );
        
        // if the distance is less than the radius, collision!
        if (distance <= object.props.width) {
            return true;
        }
        return false;
    }
}