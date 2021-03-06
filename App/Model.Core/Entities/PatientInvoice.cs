using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;

namespace HMS.Model.Core
{
    [Table("PatientInvoice")]
    public partial class PatientInvoice : EntityBase
    {
        public PatientInvoice()
        {
            this.InvoicePayments = new List<InvoicePayment>();
            this.PatientServices = new List<PatientService>();
            this.Refunds = new List<Refund>();
        }

        [ForeignKey("Patient")]
        public long PatientID { get; set; }
        public System.DateTime InvoiceDate { get; set; }
        public System.DateTime DueDate { get; set; }
        [ForeignKey("InvoiceStatus")]
        public long InvoiceStatusId { get; set; }
         [ForeignKey("LabStatus")]
        public long? LabStatusId { get; set; }
        public decimal TotalAmount { get; set; }
        public decimal? TotalDiscount { get; set; }
        public decimal? ItemDiscount { get; set; }
        public bool IsRefunded { get; set; }
    
        public virtual ICollection<InvoicePayment> InvoicePayments { get; set; }
        
        public virtual Patient Patient { get; set; }
        
        public virtual LabStatus LabStatus { get; set; }
       
        public virtual InvoiceStatus InvoiceStatus { get; set; }

        public virtual ICollection<PatientService> PatientServices { get; set; }
        public virtual ICollection<Refund> Refunds { get; set; }

        protected override void RegisterValidationMethods()
        {

        }

        protected override void ResetProperties()
        {

        }
    }
}
