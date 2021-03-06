﻿using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;

namespace HMS.Model.Core
{
    [Table("Referral")]
    public partial class Referral : EntityBase
    {
        public long ItemId { get; set; }
        public long ServiceProviderId { get; set; }
        public decimal ReferralFee { get; set; }

         [ForeignKey("ItemId")]
        public virtual Item Item { get; set; }
        [ForeignKey("ServiceProviderId")]
        public virtual ServiceProvider ServiceProvider { get; set; }

        protected override void RegisterValidationMethods()
        {

        }

        protected override void ResetProperties()
        {

        }
    }
}
