using System.ComponentModel.DataAnnotations.Schema;

namespace HMS.Model.Core
{
    [Table("Item_ItemGroup")]
    public partial class Item_ItemGroup : EntityBase
    {
        public long ItemID { get; set; }
        public long ItemGroupID { get; set; }
        [ForeignKey("ItemID")]
        public virtual Item Item { get; set; }
        [ForeignKey("ItemGroupID")]
        public virtual ItemGroup ItemGroup { get; set; }

        protected override void RegisterValidationMethods()
        {

        }

        protected override void ResetProperties()
        {

        }
    }
}
