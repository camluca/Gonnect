package 
{
	import flash.display.MovieClip;
	/**
	 * ...
	 * 
	 * top left corner is x=0, y=0
	 * @author Luca Graziani
	 */
	public class BoardModule  extends MovieClip
	{
		
		
		public var freePositions:Vector.<Position>;
		
		private var _whiteChains:Vector.<Chain>;
		private var _blackChains:Vector.<Chain>;
		
		private var _rows:Vector.<Vector.<Pawn>>;
		
		private var _display:BoardDisplay;
		
		public function BoardModule(rows:int=13,columns:int=13) 
		{
			
			
			
			
			
			_whiteChains = new Vector.<Chain>();
			_blackChains = new Vector.<Chain>();
		    freePositions = new Vector.<Position>()
			_rows = new Vector.<Vector.<Pawn>>();
			_rows.length = rows;
			_rows.fixed = true;
			// creating columns
			
			for (var i:int = 0; i < _rows.length; i++) {
				_rows[i] = new Vector.<Pawn>();
				_rows[i].length = columns;
				_rows[i].fixed = true;
			}
			_display = new BoardDisplay(this);
			addChild(_display);
			
		}
		
		private var color:String = "black";
		
		public function onMove(position:Position):void
		{
			if (color == "black") {
				color = "white"
			}else {
				color = "black"
			}
			var tmpPawn:Pawn = new Pawn(color);
			insert(tmpPawn, position);
		}
		
		/**
		 * returns the number of rows in the board
		 */
		public function get rows():int {
			return _rows.length;
		}
		
		/**
		 * returns the number of columns in the board
		 */
		public function get columns():int {
			return _rows[0].length;
		}
		
		public function getNorthPawn(pos:Position):Pawn {
			trace("getNorthPawn");
			trace("pos.x =  " + pos.x);
			trace("pos.y =  " + pos.y);
			trace("_rows[pos.x] =  " + _rows[pos.x]);
			var tmpRow:Vector.<Pawn> = _rows[pos.x];
			if (tmpRow) {
				trace("tmpRow[pos.y-1] =  " + tmpRow[pos.y-1]);
				return tmpRow[pos.y-1];
			}
			return null;
		}
		
		public function getSouthPawn(pos:Position):Pawn {
			trace("getSouthPawn");
			trace("pos.x =  " + pos.x);
			trace("pos.y =  " + pos.y);
			trace("_rows[pos.x] =  " + _rows[pos.x]);
			var tmpRow:Vector.<Pawn> = _rows[pos.x];
			if (tmpRow) {
				trace("tmpRow[pos.y+1] =  " + tmpRow[pos.y+1]);
				return tmpRow[pos.y+1];
			}
			return null;
		}
		
		public function getWestPawn(pos:Position):Pawn {
			trace("getWestPawn");
			trace("pos.x =  " + pos.x);
			trace("pos.y =  " + pos.y);
			trace("_rows[pos.x-1] =  " + _rows[pos.x-1]);
			var tmpRow:Vector.<Pawn> = _rows[pos.x-1];
			if (tmpRow) {
				trace("tmpRow[pos.y] =  " + tmpRow[pos.y]);
				return tmpRow[pos.y];
			}
			return null;
		}
		
		public function getEastPawn(pos:Position):Pawn {
			trace("getEastPawn");
			trace("pos.x =  " + pos.x);
			trace("pos.y =  " + pos.y);
			trace("_rows[pos.x+1] =  " + _rows[pos.x+1]);
			var tmpRow:Vector.<Pawn> = _rows[pos.x+1];
			if (tmpRow) {
				trace("tmpRow[pos.y] =  " + tmpRow[pos.y]);
				return tmpRow[pos.y];
			}
			return null;
		}
		

		

		/**
		 * check for the NO SUICIDE rule
		 * evetually capture chains
		 * insert pawn
		 * @param	pawn
		 * @param	pos
		 * @return true if the pawn can be insert, false otherwise
		 */
		public function insert(pawn:Pawn, pos:Position):void {
			// will store chains that can merge with the current pawn
			var oldChains:Vector.<Chain> = new Vector.<Chain>();
			
			// create a new chain yo merge with cloned chain to check 
			// for NO SUICIDE move
			var newChain:Chain = new Chain();
			pawn.chain = newChain;
			newChain.add(pawn);
			
			var northPawn:Pawn;
			var southPawn:Pawn;
			var westPawn:Pawn;
			var eastPawn:Pawn;
			
			if (!pos.isOnNorthBorder) {
				northPawn = getNorthPawn(pos);
				if (northPawn != null && northPawn.color == pawn.color) {
					oldChains.push(northPawn.chain);
					newChain.merge(northPawn.chain.clone());
				}
			}
			
			if (!pos.isOnSouthBorder) {
				southPawn = getSouthPawn(pos);
				if (southPawn != null && southPawn.color == pawn.color) {
					oldChains.push(southPawn.chain);
					newChain.merge(southPawn.chain.clone());
				}
			}
			
			if (!pos.isOnWestBorder) {
				westPawn = getWestPawn(pos);
				if (westPawn != null && westPawn.color == pawn.color) {
					oldChains.push(westPawn.chain);
					newChain.merge(westPawn.chain.clone());
				}
			}
			
			if (!pos.isOnEastBorder) {
				eastPawn = getEastPawn(pos);
				if (eastPawn != null && eastPawn.color == pawn.color) {
					oldChains.push(eastPawn.chain);
					newChain.merge(eastPawn.chain.clone());
				}
			}
			
			// check for captures
			var otherColorChains:Vector.<Chain>;
			var sameColorChains:Vector.<Chain>;
			
			var chain:Chain;
			
			if (pawn.color == Pawn.BLACK) {
				sameColorChains = _blackChains;
				otherColorChains = _whiteChains;
			}else {
				sameColorChains = _whiteChains;
				otherColorChains = _blackChains;
			}
			
			pawn.position = pos;
			_rows[pos.x][pos.y] = pawn;
			
			// can only capture opposite color chains
			for each (chain in otherColorChains) {
				if (chain != null && !chain.isFree) {
					trace("chain was captured");
					// chain was captured
					while (chain.source.length > 0) {
						removePawn(chain.source.pop());
					}
					otherColorChains.splice(otherColorChains.indexOf(chain), 1);
					chain.destroy();
					//ODO Dispatch event chain destroy
				}
			}
			
			//pawn.position = pos;
			//_rows[pos.x][pos.y] = pawn;

			if (!newChain.isFree) {
				// move not permitted, suicide!!!
				trace("move not permitted, suicide!!!");
				removePawn(pawn);
				//TODO dispatch event NO SUICIDE
			}else {
				// move allowed
				// chreating the pawn chain and start merging with the attached ones
				pawn.chain = new Chain();
				sameColorChains.push(pawn.chain);
				pawn.chain.add(pawn);
				for each (chain in oldChains) {
					pawn.chain.merge(chain);
					sameColorChains.splice(sameColorChains.indexOf(chain), 1);
				}
			
				//_rows[pos.x][pos.y] = pawn;
				pos.pawn = pawn;
				//TODO display new pawn
				_display.showPawn(pawn);
				
			}
			
		
			//destroy the temporary chain
			newChain.destroy();
			
		}
		
		private function removePawn(pawn:Pawn):void {
			_rows[pawn.position.x][pawn.position.y] = null;
			_display.enablePosition(pawn.position);
			pawn.position.setFree();
			_display.hidePawn(pawn);
			pawn.destroy();
		}
		
		/**
		 * perfor the second move switch option
		 * @param	pawn
		 */
		public function switchPawn(pawn:Pawn):void {
			if (pawn.color == Pawn.BLACK) {
				_whiteChains.push(_blackChains.pop());
				
			}else {
				_blackChains.push(_whiteChains.pop());
			}
			pawn.switchColor();
			//TODO display the new color
			
			
		}
		
		public function getPawn(pos:Position):Pawn {
			
			var pawn:Pawn = _rows[pos.x][pos.y];
			return pawn;
		}
		
		public function clearPosition(pos:Position):Pawn {
			
			var pawn:Pawn = getPawn(pos);;
			_rows[pos.x][pos.y] = null;
			return pawn;
		}
		
		public function clear():void {
			
			_whiteChains = null;
			_blackChains = null;
		    freePositions = null;
			for (var i:int = 0; i < _rows.length; i++) {
				_rows[i] = null;
			}
			_rows = null;
		}
		
		
		
	}
	
}
