using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;

namespace HMS.Model.Core
{
    [Table("ServiceProvider")]
    public partial class ServiceProvider : EntityBase
    {
        public ServiceProvider()
        {
            this.Items = new List<Item>();
            this.PatientAdmissions = new List<PatientAdmission>();
        }
    
        public long ContactId { get; set; }
        public long ServiceProviderTypeId { get; set; }
        public long DepartmentId { get; set; }
        public string Speciality { get; set; }
        public string Code { get; set; }
        public bool? AssignedToAllUsers { get; set; }
        public bool? IsReferer { get; set; }
    
        public virtual Contact Contact { get; set; }
        public virtual Department Department { get; set; }
        public virtual ICollection<Item> Items { get; set; }
        public virtual ICollection<PatientAdmission> PatientAdmissions { get; set; }
        public virtual ServiceProviderType ServiceProviderType { get; set; }

        protected override void RegisterValidationMethods()
        {

        }

        protected override void ResetProperties()
        {

        }
    }
}