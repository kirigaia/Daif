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



class Design_17_17_NPCWanderAI extends ActorScript
{          	
	
public var _MinimumWaitingPeriod:Float;

public var _MaximumWaitingPeriod:Float;

public var _MinimumMovePeriod:Float;

public var _MaximumMovePeriod:Float;

public var _Upmove:String;

public var _Upidle:String;

public var _Downmove:String;

public var _Downidle:String;

public var _Leftmove:String;

public var _Leftidle:String;

public var _Rightmove:String;

public var _Rightidle:String;

public var _MinimumSpeed:Float;

public var _MaximumSpeed:Float;

public var __Direction:Float;

public var _Speed:Float;

public var _UseAnimations:Bool;
    
/* ========================= Custom Block ========================= */


/* Params are: */
public function _customBlock_Set_Direction_of_movement():Void
{
var __Self:Actor = actor;
        __Direction = asNumber((randomFloat() * 100));
propertyChanged("__Direction", __Direction);
        if((__Direction < 13))
{
            __Direction = asNumber(0);
propertyChanged("__Direction", __Direction);
}

        else if((__Direction < (13 * 2)))
{
            __Direction = asNumber(45);
propertyChanged("__Direction", __Direction);
}

        else if((__Direction < (13 * 3)))
{
            __Direction = asNumber(90);
propertyChanged("__Direction", __Direction);
}

        else if((__Direction < (13 * 4)))
{
            __Direction = asNumber(135);
propertyChanged("__Direction", __Direction);
}

        else if((__Direction < (13 * 5)))
{
            __Direction = asNumber(180);
propertyChanged("__Direction", __Direction);
}

        else if((__Direction < (13 * 6)))
{
            __Direction = asNumber(-135);
propertyChanged("__Direction", __Direction);
}

        else if((__Direction < (13 * 7)))
{
            __Direction = asNumber(-90);
propertyChanged("__Direction", __Direction);
}

        else
{
            __Direction = asNumber(-45);
propertyChanged("__Direction", __Direction);
}

}
    
/* ========================= Custom Block ========================= */


/* Params are: */
public function _customBlock_Movement_Speed():Void
{
var __Self:Actor = actor;
        if((_MaximumSpeed > _MinimumSpeed))
{
            _Speed = asNumber(randomInt(Math.floor(_MinimumSpeed), Math.floor(_MaximumSpeed)));
propertyChanged("_Speed", _Speed);
}

        else
{
            _Speed = asNumber(randomInt(Math.floor(_MaximumSpeed), Math.floor(_MinimumSpeed)));
propertyChanged("_Speed", _Speed);
}

}
    
/* ========================= Custom Block ========================= */


/* Params are: */
public function _customBlock_Move_For_Time():Float
{
var __Self:Actor = actor;
        if((_MaximumMovePeriod > _MinimumMovePeriod))
{
            return randomInt(Math.floor(_MinimumMovePeriod), Math.floor(_MaximumMovePeriod));
}

        else
{
            return randomInt(Math.floor(_MinimumMovePeriod), Math.floor(_MaximumMovePeriod));
}

}
    
/* ========================= Custom Block ========================= */


/* Params are: */
public function _customBlock_Move_After_Time():Float
{
var __Self:Actor = actor;
        if((_MaximumWaitingPeriod > _MinimumWaitingPeriod))
{
            return randomInt(Math.floor(_MinimumWaitingPeriod), Math.floor(_MaximumWaitingPeriod));
}

        else
{
            return randomInt(Math.floor(_MaximumWaitingPeriod), Math.floor(_MinimumWaitingPeriod));
}

}
    
/* ========================= Custom Block ========================= */


/* Params are: __toMove */
public function _customBlock_Move_Now(__toMove:Bool):Void
{
var __Self:Actor = actor;
        if(__toMove)
{
            if(_UseAnimations)
{
                if((Math.abs(__Direction) < 90))
{
                    actor.setAnimation("" + _Rightmove);
}

                else if((Math.abs(__Direction) == 90))
{
                    if((__Direction < 0))
{
                        actor.setAnimation("" + _Upmove);
}

                    else
{
                        actor.setAnimation("" + _Downmove);
}

}

                else if((Math.abs(__Direction) > 90))
{
                    actor.setAnimation("" + _Leftmove);
}

}

            actor.setVelocity(__Direction, _Speed);
}

        else
{
            if(_UseAnimations)
{
                if((Math.abs(__Direction) < 90))
{
                    actor.setAnimation("" + _Rightidle);
}

                else if((Math.abs(__Direction) == 90))
{
                    if((__Direction < 0))
{
                        actor.setAnimation("" + _Upidle);
}

                    else
{
                        actor.setAnimation("" + _Downidle);
}

}

                else if((Math.abs(__Direction) > 90))
{
                    actor.setAnimation("" + _Leftidle);
}

}

            actor.setVelocity(__Direction, 0);
}

}
    
/* ========================= Custom Block ========================= */


/* Params are: */
public function _customBlock_Movement_Block():Void
{
var __Self:Actor = actor;
        actor.say("NPC Wander AI", "_customBlock_Set_Direction_of_movement");
        actor.say("NPC Wander AI", "_customBlock_Movement_Speed");
        actor.say("NPC Wander AI", "_customBlock_Move_Now", [true]);
        runLater(1000 * cast((actor.say("NPC Wander AI", "_customBlock_Move_For_Time")), Float), function(timeTask:TimedTask):Void {
                    actor.say("NPC Wander AI", "_customBlock_Move_Now", [false]);
                    runLater(1000 * cast((actor.say("NPC Wander AI", "_customBlock_Move_After_Time")), Float), function(timeTask:TimedTask):Void {
                                actor.say("NPC Wander AI", "_customBlock_Movement_Block");
}, actor);
}, actor);
}

 
 	public function new(dummy:Int, actor:Actor, engine:Engine)
	{
		super(actor, engine);	
		nameMap.set("Actor", "actor");
nameMap.set("Minimum Waiting Period", "_MinimumWaitingPeriod");
_MinimumWaitingPeriod = 1.0;
nameMap.set("Maximum Waiting Period", "_MaximumWaitingPeriod");
_MaximumWaitingPeriod = 4.0;
nameMap.set("Minimum Move Period", "_MinimumMovePeriod");
_MinimumMovePeriod = 1.0;
nameMap.set("Maximum Move Period", "_MaximumMovePeriod");
_MaximumMovePeriod = 4.0;
nameMap.set("Up (move)", "_Upmove");
nameMap.set("Up (idle)", "_Upidle");
nameMap.set("Down (move)", "_Downmove");
nameMap.set("Down (idle)", "_Downidle");
nameMap.set("Left (move)", "_Leftmove");
nameMap.set("Left (idle)", "_Leftidle");
nameMap.set("Right (move)", "_Rightmove");
nameMap.set("Right (idle)", "_Rightidle");
nameMap.set("Minimum Speed", "_MinimumSpeed");
_MinimumSpeed = 5.0;
nameMap.set("Maximum Speed", "_MaximumSpeed");
_MaximumSpeed = 10.0;
nameMap.set("_Direction", "__Direction");
__Direction = 0.0;
nameMap.set("_Speed", "_Speed");
_Speed = 0.0;
nameMap.set("Use Animations?", "_UseAnimations");
_UseAnimations = false;

	}
	
	override public function init()
	{
		    
/* ======================== When Creating ========================= */
        runLater(1000 * cast((actor.say("NPC Wander AI", "_customBlock_Move_After_Time")), Float), function(timeTask:TimedTask):Void {
                    actor.say("NPC Wander AI", "_customBlock_Movement_Block");
}, actor);

	}	      	
	
	override public function forwardMessage(msg:String)
	{
		
	}
}