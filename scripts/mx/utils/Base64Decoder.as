package mx.utils
{
   import flash.utils.ByteArray;
   import mx.resources.IResourceManager;
   import mx.resources.ResourceManager;
   
   public class Base64Decoder
   {
      
      private static const ESCAPE_CHAR_CODE:Number = 61;
      
      private static const inverse:Array = [64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,62,64,64,64,63,52,53,54,55,56,57,58,59,60,61,64,64,64,64,64,64,64,0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,64,64,64,64,64,64,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64];
       
      
      private var filled:int = 0;
      
      private var data:ByteArray;
      
      private var count:int = 0;
      
      private var work:Array;
      
      private var resourceManager:IResourceManager;
      
      public function Base64Decoder()
      {
         work = [0,0,0,0];
         resourceManager = ResourceManager.getInstance();
         super();
         data = new ByteArray();
      }
      
      private static function copyByteArray(param1:ByteArray, param2:ByteArray, param3:uint = 0) : void
      {
         var _loc4_:int = param1.position;
         param1.position = 0;
         param2.position = 0;
         var _loc5_:uint = 0;
         while(param1.bytesAvailable > 0 && _loc5_ < param3)
         {
            param2.writeByte(param1.readByte());
            _loc5_++;
         }
         param1.position = _loc4_;
         param2.position = 0;
      }
      
      public function flush() : ByteArray
      {
         var _loc1_:String = null;
         if(count > 0)
         {
            _loc1_ = resourceManager.getString("utils","partialBlockDropped",[count]);
            throw new Error(_loc1_);
         }
         return drain();
      }
      
      public function reset() : void
      {
         data = new ByteArray();
         count = 0;
         filled = 0;
      }
      
      public function decode(param1:String) : void
      {
         var _loc3_:Number = NaN;
         var _loc2_:uint = 0;
         while(_loc2_ < param1.length)
         {
            _loc3_ = param1.charCodeAt(_loc2_);
            if(_loc3_ == ESCAPE_CHAR_CODE)
            {
               work[count++] = -1;
               addr63:
               if(count == 4)
               {
                  count = 0;
                  data.writeByte(work[0] << 2 | (work[1] & 255) >> 4);
                  filled++;
                  if(work[2] == -1)
                  {
                     break;
                  }
                  data.writeByte(work[1] << 4 | (work[2] & 255) >> 2);
                  filled++;
                  if(work[3] == -1)
                  {
                     break;
                  }
                  data.writeByte(work[2] << 6 | work[3]);
                  filled++;
               }
            }
            else if(inverse[_loc3_] != 64)
            {
               work[count++] = inverse[_loc3_];
               §§goto(addr63);
            }
            _loc2_++;
         }
      }
      
      public function toByteArray() : ByteArray
      {
         var _loc1_:ByteArray = flush();
         reset();
         return _loc1_;
      }
      
      public function drain() : ByteArray
      {
         var _loc1_:ByteArray = new ByteArray();
         copyByteArray(data,_loc1_,filled);
         filled = 0;
         return _loc1_;
      }
   }
}
