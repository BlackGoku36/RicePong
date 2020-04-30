package scripts;

import kha.System;

import rice2d.system.Input;

class PaddleController extends rice2d.Script{

    // Get keyborad input
    var kb = Input.getKeyboard();
    var speed = 4;

    public function new() {
        super();

        // Both player have same class, so it is differentiated with name
        // Preventing it from having two seperate class.
        notifyOnAdd(()->{
            if(object.props.name == "player2")
                object.props.x = System.windowWidth()-object.props.x-object.props.width;

        });

        notifyOnUpdate(function (){
            if(object.props.name == "player1"){
                checkBoundary();
                // Check key down
                if(kb.down(W)) object.props.y -= speed;
                if(kb.down(S)) object.props.y += speed;
            }else if(object.props.name == "player2"){
                checkBoundary();
                if(kb.down(Up)) object.props.y -= speed;
                if(kb.down(Down)) object.props.y += speed;
            }
        });

        notifyOnRender(function (canvas){
            var g = canvas.g2;
            if(object.props.name == "player1")
                g.fillRect(object.props.x, object.props.y, object.props.width, object.props.height);
            else if(object.props.name == "player2")
                g.fillRect(object.props.x, object.props.y, object.props.width, object.props.height);
        });

    }

    function checkBoundary() {
        // Prevent player from moving paddle out of screen.
        if(object.props.y + object.props.height >= System.windowHeight()) object.props.y = System.windowHeight() - object.props.height;
        if(object.props.y <= 0) object.props.y = 0;
    }
}