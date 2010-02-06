package
{
	import com.mintdigital.hemlock.HemlockEnvironment;
	import com.mintdigital.hemlock.Logger;
	import com.mintdigital.hemlock.containers.HemlockContainer;
	import com.mintdigital.hemlock.data.JID;
	import com.mintdigital.hemlock.events.AppEvent;
	import com.mintdigital.hemlock.skins.hemlockSoft.HemlockSoftSkin;
	import com.mintdigital.hemlock.widgets.debug.DebugWidget;
	
	import org.jivesoftware.xiff.im.Roster;

	public class StressTestContainer extends HemlockContainer
	{
		private var _username:String;
		private var _password:String;
		private var _session:JID;
		
		public function StressTestContainer(account:String = "stress")
		{
			_session = new JID(room);
			_username =  _password = account;
            HemlockEnvironment.SKIN = HemlockSoftSkin;
            
			signIn(_username,_password); 			
		}

		override protected function initialize():void{
			HemlockEnvironment.ENVIRONMENT  = HemlockEnvironment.ENVIRONMENT_DEVELOPMENT;
			HemlockEnvironment.SERVER       = 'ejb.playcrab.com';
			HemlockEnvironment._debug       = true; 			
		}

		override protected function initializeStage():void{
			super.initializeStage();
			addDebugWidget(); 
            if(widgets.debug){ moveChildToFront(widgets.debug); }
		}
		
		override public function registerListeners():void{
			super.registerListeners();
            registerListener(dispatcher, AppEvent.SESSION_CREATE_FAILURE, onSessionCreateFailure);
			registerListener(dispatcher, AppEvent.CONFIGURATION_START, onConfigurationStart);
			registerListener(dispatcher, AppEvent.ROOM_JOINED,onRoomJoined);
//			registerListener(dispatcher, AppEvent.ROSTER_LOADED,onRoomJoined);
		}
		
//		private function onRosterLoaded(event:AppEvent):void {
//			var roster:Roster = event.options as Roster;
//			Logger.("Roster: "+roster.toString());
//		}
		
		private function onRoomJoined(event:AppEvent):void{
			sendMessage(event.jid.bareJID, "All glory is fleeting");			
		}
		
		override protected function onSessionCreateSuccess(event:AppEvent):void {
			visit(_username);
		}
		
		public function visit(account:String):void{
			joinChatRoom(buildJID(account));			
		}
		
		public function leave(account:String):void{
			leaveChatRoom(buildJID(account));
		}
		
		private function buildJID(account:String):JID{
			return new JID(JID.TYPE_APP+"_"+account+"@"+domain);
		}

		private function onConfigurationStart(event:AppEvent):void{
			var jid:JID = event.from;
			if(jid.type == JID.TYPE_APP)
			{
				this.configureChatRoom(jid, {'muc#roomconfig_persistentroom' : [1],'muc#roomconfig_publicroom' : [0]});
			}
		}
		
        public function onSessionCreateFailure(ev:AppEvent):void {
        	signUp(_username,_password);
        }
		
		private function addDebugWidget():void{
            if(!HemlockEnvironment.debug){ return; }
            // TODO: Move to HemlockContainer
            // - HemlockContainer should automatically keep DebugWidget in
            //   front whenever another child is added
            
            // Prepare coordinates
            var coords:Object = {};
            coords.debug = {
                width:  310,
                height: stage.stageHeight
            };
            coords.debug.x = (stage.stageWidth - coords.debug.width);
            coords.debug.y = 0;
            
            // Show widget
            widgets.debug = new DebugWidget(this, coords.debug);
            addWidgets([ widgets.debug ]);
        }

	}
}