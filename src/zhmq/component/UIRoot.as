package zhmq.component 
{
	import flash.display.Stage;
	/**
	 * ...
	 * @author zhmq
	 */
	public class UIRoot extends UIComponent 
	{
		protected var FUIStage:Stage;
		public function UIRoot(UIStage:Stage) 
		{
			super(null);
			UIStage.addChild(this);
			FUIStage = UIStage;
		}
		
		override public function get UICore():Stage
		{
			return FUIStage;
		}
		
	}

}