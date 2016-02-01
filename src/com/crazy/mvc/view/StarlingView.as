/**
 * Created by Anton Nefjodov on 30.01.2016.
 */
package com.crazy.mvc.view
{
	import com.crazy.mvc.event.SignalDispatcher;

	import starling.display.DisplayObjectContainer;

	/**
	 * Starling view object that can be connected to IContext for further model <-> view communication
	 */
	public class StarlingView extends SignalDispatcher implements IViewController
	{
		protected var _displayObjectContainer:DisplayObjectContainer;

		/**
		 * Constructs new view object, that is used to work with starling displayList objects
		 * @param displayObjectContainer
		 */
		public function StarlingView(displayObjectContainer:DisplayObjectContainer)
		{
			super();

			_displayObjectContainer = displayObjectContainer;
		}
	}
}
