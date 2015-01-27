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



class Design_10_10_2WayVerticalMovement extends ActorScript
{          	
	
public var _UpControl:String;

public var _DownControl:String;

public var _MoveY:Float;

public var _UseControls:Bool;

public var _PreventHorizontalMovement:Bool;

public var _StartX:Float;

public var _UpAnimationIdle:String;

public var _UpAnimation:String;

public var _DownAnimationIdle:String;

public var _Speed:Float;

public var _DownAnimation:String;

public var _UseAnimations:Bool;

public var _StopTurning:Bool;
    
/* ========================= Custom Event ========================= */
public function _customEvent_MoveUp():Void
{
        _MoveY = asNumber(-1);
propertyChanged("_MoveY", _MoveY);
}

    
/* ========================= Custom Event ========================= */
public function _customEvent_MoveDown():Void
{
        _MoveY = asNumber(1);
propertyChanged("_MoveY", _MoveY);
}


 
 	public function new(dummy:Int, actor:Actor, engine:Engine)
	{
		super(actor, engine);	
		nameMap.set("Actor", "actor");
nameMap.set("Up Control", "_UpControl");
nameMap.set("Down Control", "_DownControl");
nameMap.set("Move Y", "_MoveY");
_MoveY = 0.0;
nameMap.set("Use Controls", "_UseControls");
_UseControls = true;
nameMap.set("Prevent Horizontal Movement", "_PreventHorizontalMovement");
_PreventHorizontalMovement = false;
nameMap.set("Start X", "_StartX");
_StartX = 0.0;
nameMap.set("Up Animation (Idle)", "_UpAnimationIdle");
nameMap.set("Up Animation", "_UpAnimation");
nameMap.set("Down Animation (Idle)", "_DownAnimationIdle");
nameMap.set("Speed", "_Speed");
_Speed = 30.0;
nameMap.set("Down Animation", "_DownAnimation");
nameMap.set("Use Animations", "_UseAnimations");
_UseAnimations = true;
nameMap.set("Stop Turning", "_StopTurning");
_StopTurning = true;

	}
	
	override public function init()
	{
		    
/* ======================== When Creating ========================= */
        _StartX = asNumber(actor.getX());
propertyChanged("_StartX", _StartX);
    
/* ======================== When Updating ========================= */
addWhenUpdatedListener(null, function(elapsedTime:Float, list:Array<Dynamic>):Void
{
if(wrapper.enabled)
{
        if(_UseControls)
{
            _MoveY = asNumber((asNumber(isKeyDown(_DownControl)) - asNumber(isKeyDown(_UpControl))));
propertyChanged("_MoveY", _MoveY);
}

        actor.setYVelocity((_MoveY * _Speed));
        if(_PreventHorizontalMovement)
{
            actor.setX(_StartX);
            actor.setXVelocity(0);
}

        if((_StopTurning && !(_MoveY == 0)))
{
            actor.setAngularVelocity(Utils.RAD * (0));
}

        _MoveY = asNumber(0);
propertyChanged("_MoveY", _MoveY);
        if(_UseAnimations)
{
            if((actor.getYVelocity() == 0))
{
                if((actor.getAnimation() == _UpAnimation))
{
                    actor.setAnimation("" + _UpAnimationIdle);
}

                else if((actor.getAnimation() == _DownAnimation))
{
                    actor.setAnimation("" + _DownAnimationIdle);
}

}

            else if((actor.getYVelocity() < 0))
{
                actor.setAnimation("" + _UpAnimation);
}

            else if((actor.getYVelocity() > 0))
{
                actor.setAnimation("" + _DownAnimation);
}

}

}
});

	}	      	
	
	override public function forwardMessage(msg:String)
	{
		
	}
}