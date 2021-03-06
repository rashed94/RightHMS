using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;

namespace HMS.Model.Core
{
    [Table("Contact")]
    public partial class Contact : EntityBase
    {
        public Contact()
        {
            this.ServiceProviders = new List<ServiceProvider>();
        }
    
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public string PhoneNumber { get; set; }
        public bool? Gender { get; set; }
        public string Street { get; set; }
        public string City { get; set; }
        public string Zip { get; set; }
        public string Country { get; set; }
        public string Email { get; set; }
        public string Fax { get; set; }
        public string WebSite { get; set; }
        public string Photo { get; set; }
        public bool? IsCompany { get; set; }

        public virtual ICollection<ServiceProvider> ServiceProviders { get; set; }

        protected override void RegisterValidationMethods()
        {

        }

        protected override void ResetProperties()
        {

        }
    }
}
