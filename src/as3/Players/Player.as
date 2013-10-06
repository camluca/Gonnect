package as3.Players 
{
	/**
	 * ...
	 * @author Luca Graziani
	 */
	public class Player 
	{
		private static const 
		
		protected var _name:String;
		/** number of moves already done */
		private var _moves:int;
		/** number of moves left */
		private var _movesLeft:int;
		/** color assigned to this player */
		private const _color:String;
		
		public function Player(name:String) 
		{
			this._name = name;
		}
		
		public function get moves():int 
		{
			return _moves;
		}
		
		public function get movesLeft():int 
		{
			return _movesLeft;
		}
		
	}

}