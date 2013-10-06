package 
{
	import com.greensock.easing.Strong;
	import com.greensock.TweenNano;
	import flash.display.MovieClip;
	import flash.display.SimpleButton; 
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.utils.Dictionary;
	/**
	 * ...
	 * @author Luca Graziani
	 */
	public class BoardDisplay extends MovieClip
	{
		// INTERNAL PROPERTIES --------------------------------------------------------------------
		protected var _controller:BoardModule;
		private var _content:BoardUI;
		private var _light:Point;
		private var _buttonToPositionMap:Dictionary;
		// contains all the pawn on the screen
		private var _visiblePawn:Dictionary;
		
		public function BoardDisplay(controller:BoardModule) 
		{
			this._controller = controller;
			_visiblePawn = new Dictionary();
			//this._light  = new Point(stage.stageWidth * .5, 0);
			this._initializeUI();
		}
		
		private function _initializeUI():void 
		{
			_content = new BoardUI();
			_createPositions();
			addChild(_content);
		}
		
		private function _createPositions():void {
			_buttonToPositionMap = new Dictionary();
			for (var i:int = 0; i < _controller.rows; i++) {
				for (var j:int = 0; j < _controller.columns; j++) {
					var position:Position = new Position(i, j, _controller);
					_buttonToPositionMap[position.button] = position;
					 _controller.freePositions.push(position);	
					 _content.addChild(position.button);
					 enablePosition(position);
				}
			}
		
		}
		
		public function enablePosition(position:Position):void {
			 position.button.addEventListener(MouseEvent.CLICK, _buttonClickHandler);
			 position.button.addEventListener(MouseEvent.ROLL_OVER, _buttonRolloverHandler);
		}
		
		public function disablePosition(position:Position):void {
			 position.button.addEventListener(MouseEvent.CLICK, _buttonClickHandler);
			 position.button.addEventListener(MouseEvent.ROLL_OVER, _buttonRolloverHandler);
		}
		
		public function showPawn(pawn:Pawn):void {
			_content.addChild(pawn.display);
			_visiblePawn[pawn] = pawn.display;
		}
		
		public function hidePawn(pawn:Pawn):void {
			if (_visiblePawn[pawn] != null) {
				_visiblePawn[pawn] = null;
				_content.removeChild(pawn.display);
			}	
		}
		
		
		private function _buttonClickHandler(e:MouseEvent):void
		{
			var position:Position = _buttonToPositionMap[e.target];
			if (position == null) {
				trace("where the hell is this position??");
				return;
			}
			
			if (!position.isFree) {
				// do some shit we cant put pawn here
				return;
			}
			
			disablePosition(position);
			this._controller.onMove(position);
			
		}
		
		private function _buttonRolloverHandler(e:MouseEvent):void
		{
			var position:Position = _buttonToPositionMap[e.target];
			if (position == null) {
				trace("where the hell is this position??");
				return;
			}
			/*
			TweenNano.killTweensOf(pendingPawn);
			TweenNano.to(pendingPawn,.25,{x:e.target.x, y:e.target.y, ease:Strong.easeOut});
			pendingPawn.rotation = (180 * Math.atan2(light.y - pendingPawn.y, light.x - pendingPawn.x))/Math.PI + 90;	
			*/
		}
		
		protected function _localize():void {
			
			
			
		}
		
	}

}