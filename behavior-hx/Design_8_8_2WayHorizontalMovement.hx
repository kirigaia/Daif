package scripts;

import com.stencyl.graphics.G;
import com.stencyl.graphics.BitmapWrapper;

import com.stencyl.behavior.Script;
import com.stencyl.behavior.ActorScript;
import com.stencyl.behavior.SceneScript;
import com.stencyl.behavior.TimedTask;

import com.stencyl.models.Actor;
import com.stencyl.models.GameModel;
import com.stencyl.models.actor.Animation;
import com.stencyl.models.actor.ActorType;
import com.stencyl.models.actor.Collision;
import com.stencyl.models.actor.Group;
import com.stencyl.models.Scene;
import com.stencyl.models.Sound;
import com.stencyl.models.Region;
import com.stencyl.models.Font;

import com.stencyl.Engine;
import com.stencyl.Input;
import com.stencyl.Key;
import com.stencyl.utils.Utils;

import nme.ui.Mouse;
import nme.display.Graphics;
import nme.display.BlendMode;
import nme.display.BitmapData;
import nme.display.Bitmap;
import nme.events.Event;
import nme.events.KeyboardEvent;
import nme.events.TouchEvent;
import nme.net.URLLoader;

import box2D.common.math.B2Vec2;
import box2D.dynamics.B2Body;
import box2D.dynamics.B2Fixture;
import box2D.dynamics.joints.B2Joint;

import motion.Actuate;
import motion.easing.Back;
import motion.easing.Cubic;
import motion.easing.Elastic;
import motion.easing.Expo;
import motion.easing.Linear;
import motion.easing.Quad;
import motion.easing.Quart;
import motion.easing.Quint;
import motion.easing.Sine;

import com.stencyl.graphics.shaders.BasicShader;
import com.stencyl.graphics.shaders.GrayscaleShader;
import com.stencyl.graphics.shaders.SepiaShader;
import com.stencyl.graphics.shaders.InvertShader;
import com.stencyl.graphics.shaders.GrainShader;
import com.stencyl.graphics.shaders.ExternalShader;
import com.stencyl.graphics.shaders.InlineShader;
import com.stencyl.graphics.shaders.BlurShader;
import com.stencyl.graphics.shaders.SharpenShader;
import com.stencyl.graphics.shaders.ScanlineShader;
import com.stencyl.graphics.shaders.CSBShader;
import com.stencyl.graphics.shaders.HueShader;
import com.stencyl.graphics.shaders.TintShader;
import com.stencyl.graphics.shaders.BloomShader;



class Design_8_8_2WayHorizontalMovement extends ActorScript
{          	
	
public var _LeftControl:String;

public var _RightControl:String;

public var _MoveX:Float;

public var _UseControls:Bool;

public var _PreventVerticalMovement:Bool;

public var _StartY:Float;

public var _LeftAnimationIdle:String;

public var _LeftAnimation:String;

public var _RightAnimationIdle:String;

public var _Speed:Float;

public var _RightAnimation:String;

public var _UseAnimations:Bool;

public var _StopTurning:Bool;
    
/* ========================= Custom Event ========================= */
public function _customEvent_MoveLeft():Void
{
        _MoveX = asNumber(-1);
propertyChanged("_MoveX", _MoveX);
}

    
/* ========================= Custom Event ========================= */
public function _customEvent_MoveRight():Void
{
        _MoveX = asNumber(1);
propertyChanged("_MoveX", _MoveX);
}


 
 	public function new(dummy:Int, actor:Actor, engine:Engine)
	{
		super(actor, engine);	
		nameMap.set("Actor", "actor");
nameMap.set("Left Control", "_LeftControl");
nameMap.set("Right Control", "_RightControl");
nameMap.set("Move X", "_MoveX");
_MoveX = 0.0;
nameMap.set("Use Controls", "_UseControls");
_UseControls = true;
nameMap.set("Prevent Vertical Movement", "_PreventVerticalMovement");
_PreventVerticalMovement = false;
nameMap.set("Start Y", "_StartY");
_StartY = 0.0;
nameMap.set("Left Animation (Idle)", "_LeftAnimationIdle");
nameMap.set("Left Animation", "_LeftAnimation");
nameMap.set("Right Animation (Idle)", "_RightAnimationIdle");
nameMap.set("Speed", "_Speed");
_Speed = 30.0;
nameMap.set("Right Animation", "_RightAnimation");
nameMap.set("Use Animations", "_UseAnimations");
_UseAnimations = true;
nameMap.set("Stop Turning", "_StopTurning");
_StopTurning = true;

	}
	
	override public function init()
	{
		    
/* ======================== When Creating ========================= */
        _StartY = asNumber(actor.getY());
propertyChanged("_StartY", _StartY);
    
/* ======================== When Updating ========================= */
addWhenUpdatedListener(null, function(elapsedTime:Float, list:Array<Dynamic>):Void
{
if(wrapper.enabled)
{
        if(_UseControls)
{
            _MoveX = asNumber((asNumber(isKeyDown(_RightControl)) - asNumber(isKeyDown(_LeftControl))));
propertyChanged("_MoveX", _MoveX);
}

        actor.setXVelocity((_MoveX * _Speed));
        if(_PreventVerticalMovement)
{
            actor.setY(_StartY);
            actor.setYVelocity(0);
}

        if((_StopTurning && !(_MoveX == 0)))
{
            actor.setAngularVelocity(Utils.RAD * (0));
}

        _MoveX = asNumber(0);
propertyChanged("_MoveX", _MoveX);
        if(_UseAnimations)
{
            if((actor.getXVelocity() == 0))
{
                if((actor.getAnimation() == _LeftAnimation))
{
                    actor.setAnimation("" + _LeftAnimationIdle);
}

                else if((actor.getAnimation() == _RightAnimation))
{
                    actor.setAnimation("" + _RightAnimationIdle);
}

}

            else if((actor.getXVelocity() < 0))
{
                actor.setAnimation("" + _LeftAnimation);
}

            else if((actor.getXVelocity() > 0))
{
                actor.setAnimation("" + _RightAnimation);
}

}

}
});

	}	      	
	
	override public function forwardMessage(msg:String)
	{
		
	}
}