package objects 
{
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.utils.deg2rad;
	/**
	 * ...
	 * @author mimbele
	 */
	public class ParticleEffect extends Sprite
	{
		private var speedX:Number;
		private var speedY:Number;
		private var spin:Number;
		private var numOfParticles:Number;
		private var x:Number;
		private var y:Number;
		
		private var image:Image;
		private var particles:Vector.<Particle>
		
		public function ParticleEffect(x:Number, y:Number)
		{
			super();
			this.x = x;
			this.y = y;
			this.addEventListener(Event.ADDED_TO_STAGE, addToStageHandler);
		}
		
		private function addToStageHandler(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, addToStageHandler);
			
			particles = new Vector.<Particle>;
			numOfParticles = 7;
						
			createParticles();
			this.addEventListener(Event.ENTER_FRAME, enterFrameHandler);
		}
		
		private function enterFrameHandler(e:Event):void 
		{
			for (var i:uint =0; i< particles.length; i++){
				var thisParticle:Particle = particles[i];
				
				if(thisParticle){
					thisParticle.scaleX -= 0.03;
					thisParticle.scaleY = thisParticle.scaleX;
					
					thisParticle.y -= thisParticle.speedY;
					thisParticle.speedY -= thisParticle.speedY * 0.2;
					
					thisParticle.x += thisParticle.speedX;
					thisParticle.speedX = thisParticle.speedY;
					
					thisParticle.rotation += deg2rad(thisParticle.spin);
					thisParticle.spin *= 1.1;
					
					if(thisParticle.scaleY <= 0.02){
						particles.slice(i,1);
						this.removeChild(thisParticle);
						thisParticle = null;
					}
				}
				if (particles.length < 0){
					this.removeEventListener(Event.ENTER_FRAME, enterFrameHandler);
				}
			}
		}
		
		private function createParticles():void 
		{
			var count = numOfParticles;
			while (count > 0){
				count --;
				var newParticle:Particle = new Particle();
				this.addChild(newParticle);
				newParticle.x = x + Math.random() * 40;
				newParticle.y = y + Math.random() * 40;
				
				newParticle.speedX = Math.random() * 10 - 5;
				newParticle.speedY = Math.random() * 10 - 5;
				newParticle.spin = Math.random() * 15;
				
				newParticle.scaleX = newParticle.scaleY = Math.random() * 0.3 + 0.3;
				
				particles.push(newParticle);
			}
		}

	}

}