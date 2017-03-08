package
{
   import mx.core.IFlexModuleFactory;
   import mx.skins.halo.ListDropIndicator;
   import mx.styles.CSSStyleDeclaration;
   import mx.styles.StyleManager;
   
   public class _ListBaseStyle
   {
       
      
      public function _ListBaseStyle()
      {
         super();
      }
      
      public static function init(param1:IFlexModuleFactory) : void
      {
         var fbs:IFlexModuleFactory = param1;
         var style:CSSStyleDeclaration = StyleManager.getStyleDeclaration("ListBase");
         if(!style)
         {
            style = new CSSStyleDeclaration();
            StyleManager.setStyleDeclaration("ListBase",style,false);
         }
         if(style.defaultFactory == null)
         {
            style.defaultFactory = function():void
            {
               this.backgroundColor = 16777215;
               this.paddingBottom = 2;
               this.backgroundDisabledColor = 14540253;
               this.paddingRight = 0;
               this.dropIndicatorSkin = ListDropIndicator;
               this.paddingTop = 2;
               this.borderStyle = "solid";
               this.paddingLeft = 2;
            };
         }
      }
   }
}
