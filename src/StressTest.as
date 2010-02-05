package
{
	import flash.display.Sprite;
	import com.mintdigital.hemlock.clients.XMPPClient;
	import org.jivesoftware.xiff.im.Roster;
	
	public class StressTest extends Sprite
	{
		public function StressTest()
		{
			var container:StressTestContainer = new StressTestContainer("stress4");
			XMPPClient(container.client).connection;
			addChild(container);
		}
	}
}