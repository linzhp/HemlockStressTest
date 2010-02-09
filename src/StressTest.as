package
{
	import flash.display.Sprite;
	import com.mintdigital.hemlock.clients.XMPPClient;
	
	public class StressTest extends Sprite
	{
		public function StressTest()
		{
			var container:StressTestContainer = new StressTestContainer("kevin");
			container.friends = ["tracy","clive", "stress"]; 
			addChild(container);
		}
	}
}