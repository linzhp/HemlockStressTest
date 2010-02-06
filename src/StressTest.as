package
{
	import flash.display.Sprite;
	import com.mintdigital.hemlock.clients.XMPPClient;
	
	public class StressTest extends Sprite
	{
		public function StressTest()
		{
			var container:StressTestContainer = new StressTestContainer("stress");
			addChild(container);
		}
	}
}