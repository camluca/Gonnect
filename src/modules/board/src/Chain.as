package 
{
	/**
	 * ...
	 * @author Luca Graziani
	 */
	public class Chain 
	{
		private var _source:Vector.<Pawn>
		
		public function Chain(source:Vector.<Pawn> = null) 
		{
			if (source == null) {
				this._source  = new Vector.<Pawn>();
			}else {
				this._source = source;
			}
			
		}
		
		/**
		 * add a pawn to the chain
		 * points the pawn "chain" property to this
		 * @param	pawn
		 * @return
		 */
		public function add(pawn:Pawn):Chain {
			this._source.push(pawn);
			pawn.chain = this;
			return this;
		}
		
		/**
		 * remove a pawn from the chain
		 * destroy the pawn
		 * retunr the chain
		 * @param	pawn
		 * @return
		 */
		public function remove(pawn:Pawn):Chain {
			this._source.splice(this._source.indexOf(pawn), 1);
			return this;
		}
		
		/**
		 * merge the chain passed with this
		 * paints all the pawn "chain" property to this
		 * destroy the chain passed 
		 * return the merged chain
		 * @param	chain
		 * @return
		 */
		public function merge(chain:Chain):Chain {
			for each (var pawn:Pawn in chain) {
				pawn.chain = this;
			}
			this._source = this._source.concat(chain._source);
			chain.destroy();
			return this;
		}
		
		public function get source():Vector.<Pawn> 
		{
			return _source;
		}
		
		public function get color():String {
			return _source[0].color;
		}
		
		/**
		 * true if the chain has at least one pawn with "freedom"
		 * @return
		 */
		public function get isFree():Boolean {
			for each (var pawn:Pawn in _source) {
				trace("checking escape for pawn color = " + pawn.color + " x = " + pawn.position.x + " y = " + pawn.position.y);
				if (pawn.position.hasEscape()) {
					trace("pawn has escape");
					return true;
				}else {
					trace("pawn does not have escape");
				}
			}
			
			return false;
		}
		
		/**
		 * create a new clone chain and returns it
		 * @return
		 */
		public function clone():Chain {
			return new Chain(_source.concat());
		}
		
		public function destroy():void {
			for each (var pawn:Pawn in _source) {
				remove(pawn);
			}
			_source.fixed = false;
			_source.length = 0;
			_source = null;
		}
		
	}

}