package 
{
	import flash.display.SimpleButton;
	/**
	 * ...
	 * @author Luca Graziani
	 */
	public class Position 
	{
		private static const BUTTON_SIZE:int = 40;
		
		private var _x:int;
		private var _y:int;
		private var _button:SimpleButton;
		private var _board:BoardModule;
		public var pawn:Pawn;
		
		public function Position(x:int,y:int,board:BoardModule) 
		{
			this._x = x;
			this._y = y;
			this._board = board;
			this._createButton();
		}
		
		public function get isFree():Boolean {
			return pawn == null;
		}
		
		public function setFree():void {
			pawn = null;
		}
		
		/**
		 * return true if the position has at least an escape.
		 * an escape is a adiacent position without a pawn
		 * @return
		 */
		public function hasEscape():Boolean {
			
			// has at last a empty position on the left
			return (x > 0 && _board.getWestPawn(this) == null) ||
			// has at last a empty position above
			(y > 0 && _board.getNorthPawn(this) == null) ||
			// has at last a empty position on the right
			(x < _board.columns - 1 && _board.getEastPawn(this) == null) ||
			// has at last a empty position below
		    (y < _board.rows - 1 && _board.getSouthPawn(this) == null);
			
		}
		
		/**
		 * Create the graphic button
		 */
		private function _createButton():void
		{
			
			// CORNERS
			if(x + y == 0){
				_button = new CornerButton();
			}else if(x+y==_board+_board.rows-2){
				_button = new CornerButton();
				_button.rotation = 180;
			}else if(x==0 && y==_board.rows-1){
				_button = new CornerButton();
				_button.rotation = -90;
			}else if(x==_board.columns-1 && y==0){
				_button = new CornerButton();
				_button.rotation = 90;
			}
			
			// EDGES
			else if(x==0){
				_button = new EdgeButton();
			}else if(x==_board.columns-1){
				_button = new EdgeButton();
				_button.rotation = 180;
			}else if(y==0){
				_button = new EdgeButton();
				_button.rotation = 90;
			}else if(y==_board.rows-1){
				_button = new EdgeButton();
				_button.rotation = -90;
			}
			
			// CENTER
			else{
				_button = new CenterButton();
			}
			
			_button.x = 20 + x * BUTTON_SIZE;
			_button.y = 20 + y * BUTTON_SIZE;
			
		}
		
		public function get isOnNorthBorder():Boolean {
			return y == 0;
		}
		
		public function get isOnSouthBorder():Boolean {
			return y == _board.rows-1;
		}
		
		public function get isOnWestBorder():Boolean {
			return x == 0;
		}
		
		public function get isOnEastBorder():Boolean {
			return x == _board.columns - 1;
		}
		
		public function get x():int 
		{
			return _x;
		}
		
		public function get y():int 
		{
			return _y;
		}
		
		public function get button():SimpleButton 
		{
			return _button;
		}
		
	}

}