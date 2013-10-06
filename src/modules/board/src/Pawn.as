package 
{
	import flash.display.MovieClip;
	/**
	 * ...
	 * @author Luca Graziani
	 */
	public class Pawn 
	{
		public static const WHITE:String = "white";
		public static const BLACK:String = "black"; 
		
		private var _color:String;
		private var _display:MovieClip;
		
		public var chain:Chain;
		private var _position:Position;
		
		public function Pawn(color:String) 
		{
			this._color = color;
			if (color == WHITE) {
				_display = new WhitePawn();
			}else {
				_display = new BlackPawn();
			}
		}
		
		public function get color():String 
		{
			return _color;
		}
		
		public function destroy():void {
			_color = null;
			_display = null;
			chain = null;
			position = null;
		}
		
		
		
		public function switchColor():void {
			if (this._color == BLACK) {
				this._color = WHITE;
			}else {
				this._color = BLACK;
			}
		}
		
		/**
		 * returns the movieclip for the pawn
		 */
		public function get display():MovieClip 
		{
			return _display;
		}
		
		public function get position():Position 
		{
			return _position;
		}
		
		public function set position(value:Position):void 
		{
			_position = value;
			if (_position != null) {
				_display.x = _position.button.x;
				_display.y = _position.button.y;
			}
			
		}
		
		
		
	}

}