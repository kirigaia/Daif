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



class Design_0_0_StomponEnemies extends ActorScript
{          	
	
public var _StompableGroup:Group;

public var _JumpKey:String;

 
 	public function new(dummy:Int, actor:Actor, engine:Engine)
	{
		super(actor, engine);	
		nameMap.set("Actor", "actor");
nameMap.set("Stompable Group", "_StompableGroup");
nameMap.set("Jump Key", "_JumpKey");

	}
	
	override public function init()
	{
		    
/* ======================== When Creating ========================= */

    
/* ======================== Something Else ======================== */
addCollisionListener(actor, function(event:Collision, list:Array<Dynamic>):Void
{
if(wrapper.enabled)
{
        if(event.thisCollidedWithActor)
{
            if(event.thisFromBottom)
{
                if((internalGetGroup(event.otherActor, event.otherShape) == _StompableGroup))
{
                    if(!(asBoolean(actor.getLastCollidedActor().getActorValue("_BeingStomped"))))
{
                        actor.getLastCollidedActor().say("Stompable", "_customEvent_" + "stomped");
                        if(isKeyDown(_JumpKey))
{
                            actor.setYVelocity(-(asNumber(actor.getLastCollidedActor().getValue("Stompable", "_PushPlayerJumpForce"))));
}

                        else
{
                            actor.setYVelocity(-(asNumber(actor.getLastCollidedActor().getValue("Stompable", "_PushPlayerForce"))));
}

}

}

}

}

}
});

	}	      	
	
	override public function forwardMessage(msg:String)
	{
		
	}
}