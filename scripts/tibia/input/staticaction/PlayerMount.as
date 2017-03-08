package tibia.input.staticaction
{
   import tibia.creatures.Player;
   import tibia.network.Communication;
   
   public class PlayerMount extends StaticAction
   {
       
      
      public function PlayerMount(param1:int, param2:String, param3:uint)
      {
         super(param1,param2,param3,false);
      }
      
      override public function perform(param1:Boolean = false) : void
      {
         var _loc2_:Communication = Tibia.s_GetCommunication();
         var _loc3_:Player = Tibia.s_GetPlayer();
         if(_loc2_ != null && _loc2_.isGameRunning && _loc3_ != null)
         {
            _loc2_.sendCMOUNT(_loc3_.mountOutfit == null);
         }
      }
   }
}
