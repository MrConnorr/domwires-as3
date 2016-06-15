/**
 * Created by Anton Nefjodov on 13.06.2016.
 */
package com.crazyfm.core.factory
{
	import com.crazyfm.core.common.IDisposable;

	/**
	 * <p>Universal object factory.</p>
	 * <p>Features:</p>
	 * <ul>
	 * <li>New instances creation</li>
	 * <li>Pools creation</li>
	 * <li>Map interface (or any other class type) to class</li>
	 * <li>Map interface (or any other class type) to instance</li>
	 * <li>Inject dependencies to created objects</li>
	 * <li>Manage singletons</li>
	 * </ul>
	 * @example
	 * <listing version="3.0">
	 *     var factory:AppFactory = new AppFactory();
	 *
	 *     //maps IMyObject interface to MyObject class
	 *     factory.map(IMyObject, MyObject);
	 *
	 *     //returns new instance of MyObject
	 *     var obj:IMyObject = factory.getInstance(IMyObject) as IMyObject;
	 * </listing>
	 * @example
	 * <listing version="3.0">
	 *     var factory:AppFactory = new AppFactory();
	 *
	 *     //maps IMyObject interface to MyObject class
	 *     factory.map(IMyObject, MyObject);
	 *
	 *     //returns singleton instance of MyObject. Creates if needed
	 *     var obj:IMyObject = factory.getSingleton(IMyObject) as IMyObject;
	 * </listing>
	 * @example
	 * <listing version="3.0">
	 *     var factory:AppFactory = new AppFactory();
	 *
	 *     //maps IMyObject interface to MyObject class
	 *     factory.map(IMyObject, MyObject);
	 *
	 *     //returns new instance of MyObject and passes new Camera() as constructor argument
	 *     var obj:IMyObject = factory.getInstance(IMyObject, new Camera()) as IMyObject;
	 *     ...
	 *     public class MyObject implements IMyObject
	 *     {
	 *     		public function MyObject(camera:Camera)
	 *     		{
	 *   		}
	 *     }
	 * </listing>
	 * @example
	 * <listing version="3.0">
	 *     use namespace ns_app_factory;
	 *
	 *     var factory:AppFactory = new AppFactory();
	 *
	 * 	   //registers pool with maximum 2 elements
	 *     factory.registerPool(IMyObject, 2);
	 *
	 *     //maps IMyObject interface to MyObject class
	 *     factory.map(IMyObject, MyObject);
	 *
	 *     //Creates (if still not created) and returns instance of MyObject from pool
	 *     var obj:IMyObject = factory.getInstance(IMyObject) as IMyObject;
	 * </listing>
	 * @example
	 * <listing version="3.0">
	 *     var factory:AppFactory = new AppFactory();
	 *
	 *     //maps IMyObject interface to MyObject class
	 *     factory.map(IMyObject, MyObject);
	 *
	 *     //maps ICamera interface to Camera class
	 *     factory.map(ICamera, Camera);
	 *
	 *     //returns new instance of MyObject and passes new Camera() as constructor argument
	 *     var obj:IMyObject = factory.getInstance(IMyObject) as IMyObject;
	 *     ...
	 *     public class MyObject implements IMyObject
	 *     {
	 *     		[Autowired]
	 *     		public var camera:ICamera; //object will be automatically injected
	 *
	 *     		public function MyObject()
	 *     		{
	 *   		}
	 *
	 *			[PostConstruct]
	 *			public function init():void
	 *			{
	 *				//will be called automatically after dependencies are injected (e.q. camera in this case)
	 *			}
	 *     }
	 * </listing>
	 * @example
	 * <listing version="3.0">
	 *     use namespace ns_app_factory;
	 *
	 *     var factory:AppFactory = new AppFactory();
	 *
	 * 	   //registers pool with maximum 2 elements
	 *     factory.registerPool(IMyObject, 2);
	 *
	 *     //maps IMyObject interface to MyObject class
	 *     factory.map(IMyObject, MyObject);
	 *
	 *     //Creates (if still not created) and returns instance of MyObject from pool
	 *     var obj:IMyObject = factory.getInstance(IMyObject) as IMyObject;
	 *     //Injects dependencies to object and calls method (if any), that is marked with [PostConstruct] metatag
	 *     factory.injectDependencies(IMyObject, obj);
	 * </listing>
	 */
	public interface IAppFactory extends IDisposable
	{
		/**
		 * Maps one class (or interface) type to another.
		 * @param type Type, that has to be mapped to another type
		 * @param to Type or instance, that type type should be mapped to
		 * @return
		 */
		function map(type:Class, to:*):IAppFactory;

		/**
		 * Returns true, if <code>IAppFactory</code> has mapping for current type.
		 * @param type Class or interface type
		 * @return
		 */
		function hasMappingForType(type:Class):Boolean;

		/**
		 * Unmaps current type.
		 * @param type
		 * @see #map()
		 */
		function unmap(type:Class):IAppFactory;

		/**
		 * Returns either new instance of class or instance from pool.
		 * In case of new instance, constructorArgs can be passed and dependencies will be automatically injected (if
		 * <code>autoInjectDependencies</code> is set to true). if object is taken from pool or <code>autoInjectDependencies</code> is
		 * false, then dependencies can be injected using
		 * <code>injectDependencies</code>
		 * @param type Type of instance to return
		 * @param constructorArgs constructor arguments
		 * @return
		 * @see #injectDependencies()
		 */
		function getInstance(type:Class, constructorArgs:Array = null):*;

		/**
		 * Registers pool for instances of provided type.
		 * @param type Type of object to register pool for
		 * @param capacity Maximum objects of current type in pool
		 * @return
		 */
		function registerPool(type:Class, capacity:uint = 5):IAppFactory;

		/**
		 * Unregisters and disposes pool for provided type.
		 * @param type Type of object to register pool for
		 * @return
		 */
		function unregisterPool(type:Class):IAppFactory;

		/**
		 * Returns true, if <code>IAppFactory</code> has registered pool for provided type.
		 * @param type
		 * @return
		 */
		function hasPoolForType(type:Class):Boolean;

		/**
		 * Returns (creates in needed) singleton of provided type.
		 * @param type
		 * @return
		 */
		function getSingleton(type:Class):*;

		/**
		 * Removes singleton of provided type.
		 * @param type
		 * @return
		 */
		function removeSingleton(type:Class):IAppFactory;

		/**
		 * Clears all pools of current <code>IAppFactory</code>.
		 * @return
		 */
		function clearPools():IAppFactory;

		/**
		 * Clears of mappings of current <code>IAppFactory</code>.
		 * @return
		 */
		function clearMappings():IAppFactory;

		/**
		 * Clears of pools and mappings of current <code>IAppFactory</code>.
		 * @return
		 */
		function clear():IAppFactory;

		/**
		 * Inject dependencies to properties marked with [Autowired] to provided object and calls [PostConstruct] method if has any.
		 * @param type Type of provided object
		 * @param object Object to inject dependencies to
		 * @return
		 */
		function injectDependencies(type:Class, object:*):*;

		/**
		 * Automatically injects dependencies to newly created objects, using <code>getInstance</code> method.
		 */
		function set autoInjectDependencies(value:Boolean):void;

		/**
		 * Prints out extra information to logs.
		 * Useful for debugging, but leaks performance.
		 */
		function set verbose(value:Boolean):void;
	}
}
