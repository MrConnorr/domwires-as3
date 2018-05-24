/**
 * Created by CrazyFlasher on 1.12.2016.
 */
package com.domwires.example.simplemvc.commands
{
	import com.domwires.core.mvc.command.AbstractCommand;
	import com.domwires.example.simplemvc.model.IAppModel;
	import com.domwires.example.simplemvc.utils.RandomStringUtil;

	public class GenerateStreetCommand extends AbstractCommand
	{
		[Autowired]
		public var model:IAppModel;

		override public function execute():void
		{
			super.execute();

			model.setStreet(RandomStringUtil.randomString);
		}
	}
}
