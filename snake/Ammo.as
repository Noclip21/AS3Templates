package 
{
	
	public class Ammo
	{

		static var _ammo = [
							['ammo1',	'ammo2'],	// bullet type
							[100, 		200], 		// total bullets
							[999, 		999]		// max bullets
						   ];
		
		
		
		static function ammo(type :String)
		{ return Utils.getID(type,_ammo[0]); }
		
		
		public static function getAmmo(type :String)
		{ return _ammo[1][ammo(type)]; } 
		
		public static function setAmmo(type :String, n :Number)
		{
			if(_ammo[1][ammo(type)] + n < 0)
			{
				_ammo[1][ammo(type)] = 0;
				return;
			}
			
			if(_ammo[1][ammo(type)] + n > _ammo[2][ammo(type)])
			{
				_ammo[1][ammo(type)] = _ammo[2][ammo(type)];
				return;
			}
			
			
			_ammo[1][ammo(type)] += n;
		} 
		
		
		public function Ammo()
		{
			// constructor code
		}

	}
	
}
