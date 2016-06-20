﻿using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using HMS.DAL;
using HMS.Model.Core;
using HMS.DAL.Repository;
using System.Security.Claims;
using System.Linq.Expressions;
using System.Data.Entity;

namespace HMS.Controllers
{
    public class ItemController : Controller
    {
        //private IRepository<Patient> _Repository;

        public ItemController()
        {
            // _Repository = new Repository<Patient>(new Context());
        }

        public JsonResult LoadLabReport(long labReportId)
        {
            LabReportFormat labReport = null;

            using (Repository<LabReportFormat> repository = new Repository<LabReportFormat>())
            {
                labReport = repository.GetById(labReportId);

            }
            return Json(labReport, JsonRequestBehavior.AllowGet);
        }

        public JsonResult LoadLabReportbyId(long itemID)
        {
            List<LabReportFormat> labReports = null;
            List<LabReportFormat> onlylabReports = new List<LabReportFormat>();

                using (Repository<LabReportFormat> repository = new Repository<LabReportFormat>())
                {

                    Expression<Func<LabReportFormat, bool>> lambda;

                    lambda = (x => x.Active == true && x.ItemId == itemID);

                     labReports = repository.GetByQuery(lambda).ToList();

                     labReports.ForEach(c => onlylabReports.Add(new LabReportFormat
                     {
                         Id=c.Id,
                         Name = c.Name,
                         RichContent = c.RichContent,
                         ItemId=c.ItemId

                     }));

                  

                    if (onlylabReports == null)
                    {
                    return Json(HttpNotFound(), JsonRequestBehavior.AllowGet);
                    }

                    return Json(onlylabReports, JsonRequestBehavior.AllowGet);
                }
        }

        public JsonResult getDoctorWithReferrel(long itemid)
        {
            List<Referral> referrals = null;
            List<Referral> onlyReferrals = new List<Referral>();





            using (ReferralRepository repository = new ReferralRepository())
            {
                referrals = repository.GetReferrers(itemid).ToList();





                foreach (Referral item in referrals)
                {
                    Referral referral = new Referral();
                    ServiceProvider serviceProvider = new ServiceProvider();
                    Contact contact = new Contact();
                    serviceProvider.Contact = contact;
                    referral.ServiceProvider = serviceProvider;

                    referral.Id = item.Id;
                    referral.ItemId = item.ItemId;
                    referral.ReferralFee = item.ReferralFee;
                    referral.ServiceProviderId = item.ServiceProviderId;
                    referral.ServiceProvider.Contact.FirstName = item.ServiceProvider.Contact.FirstName;
                    referral.ServiceProvider.Contact.LastName = item.ServiceProvider.Contact.LastName;
                    referral.ServiceProvider.Speciality = item.ServiceProvider.Speciality;
                    onlyReferrals.Add(referral);

                }
                return Json(onlyReferrals, JsonRequestBehavior.AllowGet);
            }



        }

        public JsonResult loadLabTestGroups()
        {
            List<LabReportGroup> onlyLabTestGroup = new List<LabReportGroup>();
            List<LabReportGroup> labTestGroup;

            using (LabReportGroupRepository repository = new LabReportGroupRepository())
            {

                Expression<Func<LabReportGroup, bool>> lambda;

                lambda = (x => x.Active == true);

                labTestGroup = repository.GetByQuery(lambda).ToList();

                foreach (LabReportGroup item in labTestGroup)
                {
                    LabReportGroup itemlabgroup = new LabReportGroup();


                    itemlabgroup.Id = item.Id;
                    itemlabgroup.Name = item.Name;

                    onlyLabTestGroup.Add(itemlabgroup);

                }

                if (onlyLabTestGroup == null)
                {
                    return Json(HttpNotFound(), JsonRequestBehavior.AllowGet);
                }




                return Json(onlyLabTestGroup, JsonRequestBehavior.AllowGet);
            }
        }

        public JsonResult deleteCommission(long referralId)
        {

            using (ReferralRepository repository = new ReferralRepository())
            {
                repository.DeleteByID(referralId);
                repository.Commit();
                return Json("referall delete successfull");
            }

        }
        // Code added by zaber
        public JsonResult deleteLabTest(long labitemId)
        {

            using (ItemRepository repository = new ItemRepository())
            {
                repository.DeleteByID(labitemId);
                repository.Commit();
                return Json("Labitem delete successfull");
            }

        }
        
        //end by zaber
        public JsonResult saveDoctorsCommission(Referral referral)
        {
            using (ReferralRepository repository = new ReferralRepository())
            {
                repository.Insert(referral);
                repository.Commit();
                return Json("referall save successfull");
            }

        }

        public JsonResult DeleteReportFormat(long labReportId)
        {
            using (Repository<LabReportFormat> repository = new Repository<LabReportFormat>())
            {
                repository.DeleteByID(labReportId);           
                repository.Commit();
                return Json("delete succussfull");
            }
        }

        public JsonResult SaveLabReportTemplate(LabReportFormat labReportFormat)
        {

            using (Repository<LabReportFormat> repository = new Repository<LabReportFormat>())
            {
                if (labReportFormat.Id > 0)
                {
                    repository.Update(labReportFormat);
                }
                else
                {
                    repository.Insert(labReportFormat);
                }
                repository.Commit();
                return Json("lab Report Format save successfull");
            }
        }

        public JsonResult SaveItem(Item item)
        {
            Item LabTestItem = new Item();
            using (ItemRepository repository = new ItemRepository())
            {
                if (item.Id > 0)
                {
                   LabTestItem= repository.Update(item);
                    repository.Commit();
                }
                else
                {
                    LabTestItem=repository.Insert(item);
                    repository.Commit();
                }

            }

            return Json(LabTestItem.Id);
        }
        public JsonResult CreateCategory(string categoryName, long medicalTypeId)
        {
            ItemCategory category = new ItemCategory();
            ItemCategory outPutCategory = new ItemCategory();
            category.Name = categoryName;
            category.MedicalTypeId = medicalTypeId;

            using (ItemCategoryRepository repository = new ItemCategoryRepository())
            {

                repository.Insert(category);
                repository.Commit();
                // CreatePatientService(invoice.Id, patientServices);
            }

            return Json("Category Insert successfull");

        }

        public JsonResult CreateReportGroup(string reportGroupName)
        {
            LabReportGroup LabReportGroup = new LabReportGroup();

            LabReportGroup.Name = reportGroupName;


            using (Repository<LabReportGroup> repository = new Repository<LabReportGroup>())
            {

                repository.Insert(LabReportGroup);
                repository.Commit();
                // CreatePatientService(invoice.Id, patientServices);
            }

            return Json("Report Group Insert successfull");

        }


        public JsonResult CreateMeasurementUnit(string measurementUnitName)
        {
            MeasurementUnit MeasurementUnit = new MeasurementUnit();

            MeasurementUnit.Name = measurementUnitName;


            using (Repository<MeasurementUnit> repository = new Repository<MeasurementUnit>())
            {

                repository.Insert(MeasurementUnit);
                repository.Commit();
                // CreatePatientService(invoice.Id, patientServices);
            }

            return Json("MeasurementUnit Insert successfull");

        }




        public JsonResult loadMeasureMentUnits()
        {
            List<MeasurementUnit> onlyMeasurementUnits = new List<MeasurementUnit>();
            List<MeasurementUnit> measurementUnits;

            using (MeasurementUnitRepository repository = new MeasurementUnitRepository())
            {

                Expression<Func<MeasurementUnit, bool>> lambda;

                lambda = (x => x.Active == true);

                measurementUnits = repository.GetByQuery(lambda).ToList();

                foreach (MeasurementUnit item in measurementUnits)
                {
                    MeasurementUnit itemMUnit = new MeasurementUnit();


                    itemMUnit.Id = item.Id;
                    itemMUnit.Name = item.Name;

                    onlyMeasurementUnits.Add(itemMUnit);

                }

                if (onlyMeasurementUnits == null)
                {
                    return Json(HttpNotFound(), JsonRequestBehavior.AllowGet);
                }




                return Json(onlyMeasurementUnits, JsonRequestBehavior.AllowGet);
            }
        }



        public JsonResult loadLabTestCategories(long  medicalTypeID)
        {
            List<ItemCategory> onlyItemCategories = new List<ItemCategory>();
            List<ItemCategory> ItemCategories;

            using (ItemCategoryRepository repository = new ItemCategoryRepository())
            {
               
                 Expression<Func<ItemCategory, bool>> lambda;

                 lambda = (x => x.Active == true && x.MedicalTypeId == medicalTypeID);

                ItemCategories= repository.GetByQuery(lambda).ToList();

                foreach (ItemCategory catogry in ItemCategories)
                {
                    ItemCategory itemCategory = new ItemCategory();


                    itemCategory.Id = catogry.Id;
                    itemCategory.Name = catogry.Name;

                    onlyItemCategories.Add(itemCategory);
                  
                }

                if (onlyItemCategories == null)
                {
                    return Json(HttpNotFound(), JsonRequestBehavior.AllowGet);
                }




                return Json(onlyItemCategories, JsonRequestBehavior.AllowGet);
            }
        }

        public JsonResult loadItembyId(long itemID)
        {
            Item LabTestItem = new Item();
            Item Item = new Item();
              using (ItemRepository repository = new ItemRepository())
              {


                  Item=repository.GetById(itemID);

                  LabTestItem.Id = Item.Id;
                  LabTestItem.Name = Item.Name;
                  LabTestItem.GenericName = Item.GenericName;
                  LabTestItem.Code = Item.Code;
                  LabTestItem.ItemTypeId = Item.ItemTypeId;
                  LabTestItem.MedicalTypeId = Item.MedicalTypeId;
                  LabTestItem.ItemCategoryId = Item.ItemCategoryId;
                  LabTestItem.MeasurementUnitId = Item.MeasurementUnitId;
                  LabTestItem.SalePrice = Item.SalePrice;
                  LabTestItem.BuyPrice = Item.BuyPrice;
                  LabTestItem.DefaultReferrarFee = Item.DefaultReferrarFee;
                  LabTestItem.ReferralAllowed = Item.ReferralAllowed;
                  LabTestItem.ServiceProviderId = Item.ServiceProviderId;
                  LabTestItem.LabReportGroupId = Item.LabReportGroupId;
                  //LabTestItem.ItemCategory.Name = Item.ItemCategory.Name;




                  if (LabTestItem == null)
                  {
                      return Json(HttpNotFound(), JsonRequestBehavior.AllowGet);
                  }




                  return Json(LabTestItem, JsonRequestBehavior.AllowGet);

              }
        }
        public JsonResult GetLabItemsByMedicalType(long medicalTypeID)
        {
            List<Item> onlyItemsforLabTest = new List<Item>();
            List<Item> itemsforLabTest;

            using (ItemRepository repository = new ItemRepository())
            {
                Expression<Func<Item, bool>> lambda;

                lambda = (x => x.MedicalTypeId == medicalTypeID && x.Active == true);

                itemsforLabTest = repository.GetByQuery(lambda).ToList();

                foreach (Item c in itemsforLabTest)
                {
                    Item LabTestItem = new Item();
                    ItemCategory LabTestItemCategory = new ItemCategory();
                    LabTestItem.ItemCategory = LabTestItemCategory;

                    LabTestItem.Id = c.Id;
                    LabTestItem.Name = c.Name;
                    LabTestItem.GenericName = c.GenericName;
                    LabTestItem.Code=c.Code;
                    LabTestItem.ItemTypeId=c.ItemTypeId;
                    LabTestItem.MedicalTypeId=c.MedicalTypeId;
                    LabTestItem.ItemCategoryId=c.ItemCategoryId;
                    LabTestItem.MeasurementUnitId = c.MeasurementUnitId;
                    LabTestItem.SalePrice = c.SalePrice;
                    LabTestItem.BuyPrice = c.BuyPrice;
                    LabTestItem.DefaultReferrarFee = c.DefaultReferrarFee;
                    LabTestItem.ReferralAllowed = c.ReferralAllowed;
                    LabTestItem.ServiceProviderId = c.ServiceProviderId;
                    LabTestItem.LabReportGroupId = c.LabReportGroupId;
                    LabTestItem.ItemCategory.Name = c.ItemCategory.Name;
                    onlyItemsforLabTest.Add(LabTestItem);
                }

                if (onlyItemsforLabTest == null)
                {
                    return Json(HttpNotFound(), JsonRequestBehavior.AllowGet);
                }




                return Json(onlyItemsforLabTest, JsonRequestBehavior.AllowGet);

            }

            
        }

        public JsonResult UpdateLabStatus(PatientService PatientServiceItem,bool InvoiceStatusUpdate,long InvoiceID)
        {
            using (PatientServiceRepository repository = new PatientServiceRepository())
            {
                PatientServiceItem.Item = null;
                PatientServiceItem.ServiceProvider = null;
               

                repository.Update(PatientServiceItem);
                repository.Commit();
            }
            if (InvoiceStatusUpdate)
            {
                using (PatientInvoiceRepository repository = new PatientInvoiceRepository())
                {
                   

                     string field = "LabStatusId";
                     PatientInvoice pinvoice = new PatientInvoice();
                     pinvoice.LabStatusId = 2;
                     pinvoice.Id = InvoiceID;
                    // repository.updateInvoiceStatus(pinvoice);
                     repository.UpdateByField(pinvoice, field);
                }
            }

            return Json("Status update successfull");
        }
        public JsonResult GetPatientInvoicebyMedicalType(long id, long statusid, long medicalTypeID)
        {

            List<PatientInvoice> onlypatientInvoices = new List<PatientInvoice>();
            List<PatientInvoice> patientInvoices;
            List<PatientService> PatientServices;

            using (PatientInvoiceRepository repository = new PatientInvoiceRepository())
            {

                patientInvoices = repository.GetPatientInvoicebyMedicalTypeOnlyLabItem(id, statusid, medicalTypeID).ToList();

               foreach (PatientInvoice pinvoice in patientInvoices)
               {
                   PatientInvoice onlyPatientInvoice = new PatientInvoice();
                   Patient patient = new Patient();
                   onlyPatientInvoice.Patient = patient;

                   onlyPatientInvoice.Id = pinvoice.Id;
                   onlyPatientInvoice.InvoiceDate = pinvoice.InvoiceDate;
                   onlyPatientInvoice.DueDate = pinvoice.DueDate;
                   onlyPatientInvoice.PatientID = pinvoice.PatientID;
                   onlyPatientInvoice.TotalAmount = pinvoice.TotalAmount;
                   onlyPatientInvoice.TotalDiscount = pinvoice.TotalDiscount;
                   onlyPatientInvoice.InvoiceStatusId = pinvoice.InvoiceStatusId;
                   onlyPatientInvoice.LabStatusId = pinvoice.LabStatusId;
                   onlyPatientInvoice.ItemDiscount = pinvoice.ItemDiscount;
                   onlyPatientInvoice.UserId = pinvoice.UserId;
                   onlyPatientInvoice.Patient.FirstName = pinvoice.Patient.FirstName;
                   onlyPatientInvoice.Patient.LastName = pinvoice.Patient.LastName;

                   foreach (InvoicePayment invoicepayment in pinvoice.InvoicePayments)
                   {
                       InvoicePayment invoicePayment = new InvoicePayment();

                       invoicePayment.Id = invoicepayment.Id;
                       invoicePayment.PatientInvoiceId = invoicepayment.PatientInvoiceId;
                       invoicePayment.Amount = invoicepayment.Amount;
                       invoicePayment.PaymentID = invoicepayment.PaymentID;
                       invoicePayment.UserId = invoicepayment.UserId;
                       onlyPatientInvoice.InvoicePayments.Add(invoicePayment);

                   }
                   using (PatientServiceRepository srepository = new PatientServiceRepository())
                   {
                       PatientServices = srepository.GetServiceItemsLabtestOnlyByPatientId(pinvoice.PatientID, pinvoice.Id).ToList();
                       foreach (PatientService c in PatientServices)
                       {
                           PatientService patientstitem = new PatientService();
                           Item item = new Item();
                           ServiceProvider serviceProdier = new ServiceProvider();
                           Contact contact = new Contact();
                           serviceProdier.Contact = contact;
                           patientstitem.Item = item;
                           patientstitem.ServiceProvider = serviceProdier;


                           patientstitem.Id = c.Id;
                           patientstitem.PatientID = c.PatientID;
                           patientstitem.ItemID = c.ItemID;
                           patientstitem.InvoiceID = c.InvoiceID;
                           patientstitem.ServiceListPrice = c.ServiceListPrice;
                           patientstitem.ServiceActualPrice = c.ServiceActualPrice;
                           patientstitem.ServiceQuantity = c.ServiceQuantity;
                           patientstitem.ServiceDate = c.ServiceDate;
                           patientstitem.UserId = c.UserId;
                           patientstitem.Discount = c.Discount;
                           patientstitem.Refund = c.Refund;
                           patientstitem.Billed = c.Billed;
                           patientstitem.ReferralFee = c.ReferralFee;
                           patientstitem.DeliveryDate = c.DeliveryDate;
                           patientstitem.DeliveryTime = c.DeliveryTime;

                           patientstitem.ServiceProviderId = c.ServiceProviderId;
                           patientstitem.ReferralFeePaid = c.ReferralFeePaid;
                           patientstitem.ReportFormatName = c.ReportFormatName;
                           patientstitem.LabStatusId = c.LabStatusId;

                           patientstitem.Item.Id = c.Item.Id;
                           patientstitem.Item.Name = c.Item.Name;
                           patientstitem.Item.GenericName = c.Item.GenericName;
                           patientstitem.Item.ReferralAllowed = c.Item.ReferralAllowed;

                           if (c.ServiceProvider != null)
                           {

                               patientstitem.ServiceProvider.Contact.FirstName = c.ServiceProvider.Contact.FirstName;
                               patientstitem.ServiceProvider.Contact.LastName = c.ServiceProvider.Contact.LastName;
                           }

             

                           onlyPatientInvoice.PatientServices.Add(patientstitem);

                       }
                   }
                   onlypatientInvoices.Add(onlyPatientInvoice);



               }

               if (onlypatientInvoices == null)
               {
                   return Json(HttpNotFound(), JsonRequestBehavior.AllowGet);
               }




               return Json(onlypatientInvoices, JsonRequestBehavior.AllowGet);
               

            }
           
        }
    }
}