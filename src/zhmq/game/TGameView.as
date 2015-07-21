package zhmq.game 
{
	import flash.events.KeyboardEvent;
	import flash.events.TextEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	import flash.ui.Keyboard;
	import zhmq.component.UIComponent;
	
	/**
	 * ...
	 * @author zhmq
	 * 2015/7/20 17:53
	 */
	public class TGameView extends UIComponent 
	{		
		//---- Constants -------------------------------------------------------
		/**文本框数量*/
		protected static const TXT_NUM:int = 4;
		/**数字1-9*/
		protected static const NUMBERS_NUM:int = 10;
		
		//---- Protected Fields ------------------------------------------------
		
		protected var FTxtVec:Vector.<TextField>;
		/**初始化数组*/
		protected var FNumberVec:Vector.<int>;
		protected var FGuessingVec:Vector.<int>;
		protected var FTxtFormat:TextFormat;
		protected var FTFDesc:TextField;
		
		//---- Property Fields -------------------------------------------------
		
		//---- Constructor -----------------------------------------------------
		
		public function TGameView(Parent:UIComponent) 
		{
			var Index:int;
			var Txt:TextField;
			
			super(Parent);
			
			FNumberVec = new Vector.<int>(NUMBERS_NUM);
			FGuessingVec = new Vector.<int>(TXT_NUM);
			
			FTFDesc = new TextField();	
			FTFDesc.width = 200;
			FTFDesc.height = 500;
			this.addChild(FTFDesc);
			//文本框初始化
			FTxtFormat = new TextFormat();
			FTxtFormat.align = TextFieldAutoSize.CENTER;
			FTxtFormat.size = 80;
			
			FTxtVec = new Vector.<TextField>(TXT_NUM);
			for (Index = 0; Index < TXT_NUM; Index++) 
			{
				Txt = new TextField();
				Txt.y = 200;
				Txt.x = 200 + 120 * Index;
				Txt.width = 100;
				Txt.defaultTextFormat = FTxtFormat;
				Txt.border = true;
				Txt.type = TextFieldType.INPUT;
				Txt.restrict = "0-9";
				Txt.maxChars = 1;
				Txt.alwaysShowSelection = true;
				Txt.addEventListener(TextEvent.TEXT_INPUT, OnTxtInput);
				Txt.addEventListener(KeyboardEvent.KEY_DOWN, OnKeyDown);
				FTxtVec[Index] = Txt;
				this.addChild(Txt);
			}
			FParent.UICore.focus = FTxtVec[0];
			FormatData();
		}
		
		//---- Protected Methods -----------------------------------------------
		
		//构造数字
		protected function FormatData():void
		{	
			var Index:int;
			var Random:int;
			
			FTFDesc.text = "\nR：重新开始"
					+ "\nP：显示答案"
					+ "\nEnter：显示答题结果"
					+ "\n请输入数字：";
			
			FNumberVec.length = 0;
			FGuessingVec.length = 0;
			for (Index = 0; Index < NUMBERS_NUM; Index++) 
			{
				FNumberVec.push(Index);
			}
			for (Index = 0; Index < TXT_NUM; Index++) 
			{
				FTxtVec[Index].text = "";
				Random = Math.random() * (NUMBERS_NUM - Index);
				FGuessingVec.push(FNumberVec[Random]);
				FNumberVec.splice(Random, 1);
				//FTFDesc.appendText(FGuessingVec[Index] + "");
			}
			FTFDesc.appendText("\n\n");
		}
		
		protected function CheckNumber():void
		{
			var Index:int;
			var NumStr:String;
			var TxtStr:String;
			var ANum:int;
			var BNum:int;
			
			NumStr = "";
			ANum = 0;
			BNum = 0;
			for (Index = 0; Index < TXT_NUM; Index++) 
			{
				if (FTxtVec[Index].text == "")
				{
					FTFDesc.appendText("请输入数字：\n\n");
					return;
				}
				TxtStr = FTxtVec[Index].text;
				NumStr += TxtStr;
				if (int(TxtStr) == FGuessingVec[Index])
				{
					ANum ++;
					continue;
				}
				if (FGuessingVec.indexOf(int(TxtStr)) != -1)
				{
					BNum ++;
				}
			}
			FTFDesc.appendText(NumStr + "\n");
			FTFDesc.appendText(ANum + "A" + BNum + "B\n\n");
		}
		
		protected function ShowAnswer():void
		{
			var Index:int;
			for (Index = 0; Index < TXT_NUM; Index++) 
			{
				FTFDesc.appendText(FGuessingVec[Index] + "");
			}
			FTFDesc.appendText("\n")
		}
		
		//---- Event Handling Methods ------------------------------------------
		
		private function OnKeyDown(E:KeyboardEvent):void 
		{
			if (E.keyCode == Keyboard.ENTER)
			{
				CheckNumber();
			}
			else if (E.keyCode == Keyboard.R)
			{
				ShowAnswer();
				FormatData();
			}
			else if (E.keyCode == Keyboard.P)
			{
				ShowAnswer();
			}
			
		}
		
		private function OnTxtInput(E:TextEvent):void 
		{
			var TxtIndex:int;
			var SimIndex:int;//相同数字的索引
			var Index:int;
			var Code:int;
			TxtIndex = FTxtVec.indexOf(E.target as TextField);
			
			Code = E.text.charCodeAt();
			
			if (Code < Keyboard.NUMBER_0) return;
			if (Code > Keyboard.NUMBER_9) return;
			
			for (Index = 0; Index < TXT_NUM; Index++) 
			{
				if (Index == TxtIndex) continue;
				if (E.text == FTxtVec[Index].text)
				{
					FParent.UICore.focus = FTxtVec[Index];
					FTxtVec[Index].text = "";
					return;
				}
			}
			
			if (TxtIndex + 1 < TXT_NUM)
			{
				FParent.UICore.focus = FTxtVec[TxtIndex + 1];
				FTxtVec[TxtIndex + 1].setSelection(0, 1);
			}
			else
			{
				FParent.UICore.focus = FTxtVec[0];
				FTxtVec[0].setSelection(0, 1);
			}
		}
		
		//---- Property Accessing Methods --------------------------------------
		
		//---- Public Methods ----------------------------------------------------
		
	}

}