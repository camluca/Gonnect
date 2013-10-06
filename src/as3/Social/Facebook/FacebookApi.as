package as3.Social.Facebook 
{
	import com.facebook.graph.Facebook;
	/**
	 * ...
	 * @author Luca Graziani
	 */
	public class FacebookApi 
	{
		private static const APP_ID:String;
		
		protected var _session		:Object;
		
		public function FacebookApi() 
		{
			Facebook.init(APP_ID, _onInit);
		}
		
		protected function _onInit(success:Object, fail:Object):void
		{
			_session = success;
		}
		
	}

}