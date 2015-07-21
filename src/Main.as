package
{
	import flash.display.Sprite;
	import flash.events.Event;
	import zhmq.component.UIRoot;
	import zhmq.game.TGameView;
	
	/**
	 * ...
	 * @author zhmq
	 */
	public class Main extends Sprite 
	{
		
		public function Main() 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			
			var Root:UIRoot = new UIRoot(stage);
			var Game:TGameView = new TGameView(Root);
		}
		
	}
	
}