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
using HMS.View.Mappers;

namespace HMS.Controllers
{
    public class ItemController : BaseController
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

        public JsonResult GetReagents(long InvestigationId)
        {

            List<InvestigationReagent> onlyReagentList = new List<InvestigationReagent>();
           

            using (Repository<InvestigationReagent> repository = new Repository<InvestigationReagent>())
            {

                Expression<Func<InvestigationReagent, bool>> lambda;

                lambda = (x => x.Active == true && x.InvestigationId == InvestigationId);

                List<InvestigationReagent>  ReagentList = repository.GetByQuery(lambda).ToList();

                ReagentList.ForEach(r =>
                {
                    InvestigationReagent Reagent = ModelMapper.MapToClient(r);
                    onlyReagentList.Add(Reagent);
                });
                
                
            }

            return Json(onlyReagentList, JsonRequestBehavior.AllowGet);

        }


        public JsonResult DeletReagent(InvestigationReagent reagent)
        {

            InvestigationReagent onlyReagent = new InvestigationReagent();



            


            using (Repository<InvestigationReagent> repository = new Repository<InvestigationReagent>())
            {
                repository.DeleteByID(reagent.Id, GetLoggedinUserInfo().UserId);

            }
            return Json(GetReagents(reagent.InvestigationId), JsonRequestBehavior.AllowGet);

        }

        public JsonResult SaveReagentForInvestigation(InvestigationReagent Reagent)
        {

            InvestigationReagent onlyReagent = new InvestigationReagent();

            

            Reagent.UserId= GetLoggedinUserInfo().UserId;


            using (Repository<InvestigationReagent> repository = new Repository<InvestigationReagent>())
            {
                onlyReagent= repository.Insert(Reagent);
                
            }
            return Json(GetReagents(onlyReagent.InvestigationId), JsonRequestBehavior.AllowGet);

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
                    Id = c.Id,
                    Name = c.Name,
                    RichContent = c.RichContent,
                    ItemId = c.ItemId

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
                repository.DeleteByID(referralId, GetLoggedinUserInfo().UserId);
                repository.Commit();
                return Json("referall delete successfull");
            }

        }
        // Code added by zaber
        public JsonResult deleteBed(long beditem)
        {

            using (ItemRepository repository = new ItemRepository())
            {
                repository.DeleteByID(beditem, GetLoggedinUserInfo().UserId);
                repository.Commit();
                return Json("BedItem delete successfull");
            }

        }
       public JsonResult deleteItem(long ItemId)
        {

            using (ItemRepository repository = new ItemRepository())
            {
                repository.DeleteByID(ItemId, GetLoggedinUserInfo().UserId);
                repository.Commit();
                return Json("BedItem delete successfull");
            }

        }

       public JsonResult DeleteOtherService(Item item,InitialSetupItem iniItem)
       {

           using (ItemRepository repository = new ItemRepository())
           {
               repository.DeleteByID(item.Id, GetLoggedinUserInfo().UserId);
               repository.Commit();
               //return Json("BedItem delete successfull");
           }

         
            using (Repository<InitialSetupItem> repository = new Repository<InitialSetupItem>())
            {
                if (iniItem.Id > 0)
                {
                    repository.DeleteByID(iniItem.Id, GetLoggedinUserInfo().UserId);
                    repository.Commit();
                }
                  
            }
         return Json("Other services delete successfull");
         

       }
       public JsonResult deleteLabTest(long ItemId)
        {

            using (ItemRepository repository = new ItemRepository())
            {
                repository.DeleteByID(ItemId, GetLoggedinUserInfo().UserId);
                repository.Commit();
                return Json("BedItem delete successfull");
            }

        }

       public JsonResult UpdateLabItem(PatientInvoice pinvoice)
       {
           PatientInvoice onlyInvoice = new PatientInvoice();
           PatientInvoice patientInvoice = new PatientInvoice();
           List<PatientService> patientServiceItems = pinvoice.PatientServices.ToList();
         


           pinvoice.Refunds = null;
           pinvoice.PatientServices = null;
           pinvoice.Patient = null;
           pinvoice.InvoicePayments = null;
           pinvoice.InvoiceStatus = null;

           

           using (Repository<PatientInvoice> repository = new Repository<PatientInvoice>())
           {
               patientInvoice = repository.Update(pinvoice);
               patientInvoice.UserId = GetLoggedinUserInfo().UserId;
               repository.Commit();
           }

         
           foreach (PatientService sitem in patientServiceItems)
           {
               sitem.Item = null;
               sitem.Patient = null;
               sitem.PatientInvoice = null;
               sitem.ServiceProvider = null;

               using (PatientServiceRepository patientservicerepository = new PatientServiceRepository())
               {
                   sitem.UserId = GetLoggedinUserInfo().UserId;
                   patientservicerepository.Update(sitem);
                   patientservicerepository.Commit();
               }
           }


           return Json("Invoice update successfull", JsonRequestBehavior.AllowGet);
       }

        [HttpPost]
        //[ValidateAntiForgeryToken]
        public JsonResult CreatePatientService(IList<PatientService> patientServices)
        {

            //if (ModelState.IsValid)
            {
                using (PatientServiceRepository repository = new PatientServiceRepository())
                {
                    foreach (PatientService patientervice in patientServices)
                    {
                        repository.Insert(patientervice);

                    }
                    repository.Commit();
                    // patient = repository.GetByPhoneNumber(patient.PhoneNumber);
                }
            }
            return Json("200");
        }

        [HttpPost]
        public JsonResult CreateBedOccupancy(IList<BedOccupancy> BedOccupancy)
        {
            PatientAdmission pAdmission = new PatientAdmission();
            //if (ModelState.IsValid)
            {
                using (BedOccupancyRepository repository = new BedOccupancyRepository())
                {
                    foreach (BedOccupancy isBedOccupied in BedOccupancy)
                    {
                        pAdmission.BedId = isBedOccupied.ItemID;
                        pAdmission.Id = isBedOccupied.AdmissioinId;
                        pAdmission.UserId=GetLoggedinUserInfo().UserId;

                        isBedOccupied.UserId = GetLoggedinUserInfo().UserId;
                        repository.Insert(isBedOccupied);

                    }
                    repository.Commit();
                }
                using (Repository<PatientAdmission> repository = new Repository<PatientAdmission>())
                 {
                     repository.UpdateByField(pAdmission, "BedId");
                     repository.Commit();
                 }
            }
            return Json("200");
        }

        //public JsonResult loadBedOccupancyByItemId(long itemId)
        //{
        //    IList<BedOccupancy> BedOccupancy = null;

        //    using (BedOccupancyRepository repository = new BedOccupancyRepository())
        //    {
        //        BedOccupancy = repository.getBedOccupancyByItemId(itemId);

        //    }
        //    return Json(BedOccupancy, JsonRequestBehavior.AllowGet);
            
        //}

        public JsonResult emptyBed(BedOccupancy bedOccupancyItem)
        {
            using (BedOccupancyRepository repository = new BedOccupancyRepository())
            {

                bedOccupancyItem.Occupied = false;
                bedOccupancyItem.Active = false;
                bedOccupancyItem.UserId=GetLoggedinUserInfo().UserId;
                repository.Update(bedOccupancyItem);

                repository.Commit();                
            }            

            return Json("Item update successfull");
        }

        public JsonResult LoadBedOccupancybyId(long patientId)
        {
            List<BedOccupancy> bed = null;
            List<BedOccupancy> bedlist = new List<BedOccupancy>();

            using (Repository<BedOccupancy> repository = new Repository<BedOccupancy>())
            {

                Expression<Func<BedOccupancy, bool>> lambda;

                lambda = (x => x.Occupied == true && x.Active == true && x.PatientId == patientId);

                bed = repository.GetByQuery(lambda).ToList();

                bed.ForEach(c => bedlist.Add(new BedOccupancy
                {
                    ItemID = c.ItemID,
                    PatientName = c.PatientName,
                    PatientId = c.PatientId,
                    Occupied = c.Occupied

                }));

                if (bedlist == null)
                {
                    return Json(HttpNotFound(), JsonRequestBehavior.AllowGet);
                }

                return Json(bedlist, JsonRequestBehavior.AllowGet);
            }
        }
        
        //end by zaber
        public JsonResult saveDoctorsCommission(Referral referral)
        {
            using (ReferralRepository repository = new ReferralRepository())
            {
                referral.UserId = GetLoggedinUserInfo().UserId;
                repository.Insert(referral);
                repository.Commit();
                return Json("Referall saved successfully");
            }

        }

        public JsonResult DeleteReportFormat(long labReportId)
        {
            using (Repository<LabReportFormat> repository = new Repository<LabReportFormat>())
            {
                repository.DeleteByID(labReportId, GetLoggedinUserInfo().UserId);
                repository.Commit();
                return Json("Delete succussful");
            }
        }

        public JsonResult SaveLabReportTemplate(LabReportFormat labReportFormat)
        {
            using (Repository<LabReportFormat> repository = new Repository<LabReportFormat>())
            {
                labReportFormat.UserId = GetLoggedinUserInfo().UserId;
                if (labReportFormat.Id > 0)
                {
                    repository.Update(labReportFormat);
                }
                else
                {
                    repository.Insert(labReportFormat);
                }
                repository.Commit();
                return Json("Lab Report Format saved successfully");
            }
        }

        public JsonResult LoadTreatmentItems(long medicalTypeID)
        {
            List<Item> onlyItemsforTreatment = new List<Item>();
            List<Item> itemsforTreatment;

            using (ItemRepository repository = new ItemRepository())
            {
                Expression<Func<Item, bool>> lambda;

                lambda = (x => x.MedicalTypeId == medicalTypeID && x.Active == true);

                itemsforTreatment = repository.GetByQuery(lambda).ToList();

                foreach (Item c in itemsforTreatment)
                {
                    Item TeatmentItem = new Item();


                    TeatmentItem.Id = c.Id;
                    TeatmentItem.Name = c.Name;
                    TeatmentItem.GenericName = c.GenericName;
                    TeatmentItem.Code = c.Code;
                    TeatmentItem.ItemTypeId = c.ItemTypeId;
                    TeatmentItem.MedicalTypeId = c.MedicalTypeId;
                    TeatmentItem.ItemCategoryId = c.ItemCategoryId;
                    TeatmentItem.MeasurementUnitId = c.MeasurementUnitId;
                    TeatmentItem.SalePrice = c.SalePrice;
                    TeatmentItem.BuyPrice = c.BuyPrice;
                    TeatmentItem.DefaultReferrarFee = c.DefaultReferrarFee;
                    TeatmentItem.ReferralAllowed = c.ReferralAllowed;
                    TeatmentItem.Description = c.Description;
                    TeatmentItem.ServiceProviderId = c.ServiceProviderId;
                    TeatmentItem.LabReportGroupId = c.LabReportGroupId;
                    if (c.ItemCategoryId != null)
                    {
                        TeatmentItem.ItemCategory = new ItemCategory();
                        TeatmentItem.ItemCategory.Name = c.ItemCategory.Name;
                    }



                    onlyItemsforTreatment.Add(TeatmentItem);
                }

                if (onlyItemsforTreatment == null)
                {
                    return Json(HttpNotFound(), JsonRequestBehavior.AllowGet);
                }




                return Json(onlyItemsforTreatment, JsonRequestBehavior.AllowGet);

            }


        }

        public JsonResult GetOtherServices(long medicalTypeID)
        {
            List<Item> onlyItemsforOtherServices = new List<Item>();
            List<Item> itemsforOtherService;

            using (ItemRepository repository = new ItemRepository())
            {
                Expression<Func<Item, bool>> lambda;

                lambda = (x => x.MedicalTypeId == medicalTypeID && x.Active == true );

                itemsforOtherService = repository.GetByQuery(lambda).ToList();

                foreach (Item c in itemsforOtherService)
                {
                    Item OtherServiceItem = new Item();


                    OtherServiceItem.Id = c.Id;
                    OtherServiceItem.Name = c.Name;
                    OtherServiceItem.GenericName = c.GenericName;
                    OtherServiceItem.Code = c.Code;
                    OtherServiceItem.ItemTypeId = c.ItemTypeId;
                    OtherServiceItem.MedicalTypeId = c.MedicalTypeId;
                    OtherServiceItem.ItemCategoryId = c.ItemCategoryId;
                    OtherServiceItem.MeasurementUnitId = c.MeasurementUnitId;
                    OtherServiceItem.SalePrice = c.SalePrice;
                    OtherServiceItem.BuyPrice = c.BuyPrice;
                    OtherServiceItem.DefaultReferrarFee = c.DefaultReferrarFee;
                    OtherServiceItem.ReferralAllowed = c.ReferralAllowed;
                    OtherServiceItem.Description = c.Description;
                    OtherServiceItem.ServiceProviderId = c.ServiceProviderId;
                    OtherServiceItem.LabReportGroupId = c.LabReportGroupId;
                    if (c.ItemCategoryId != null)
                    {
                        OtherServiceItem.ItemCategory.Name = c.ItemCategory.Name;
                    }

                    OtherServiceItem.InitialSetupItems = new List<InitialSetupItem>();

                    foreach (InitialSetupItem item in c.InitialSetupItems)
                    {
                        if (item.Active)
                        {
                            InitialSetupItem iniItem = new InitialSetupItem();

                            iniItem.Id = item.Id;
                            iniItem.InitialSetupId = item.InitialSetupId;
                            iniItem.ItemId = item.ItemId;
                            iniItem.MedicalTypeId = item.MedicalTypeId;
                            OtherServiceItem.InitialSetupItems.Add(iniItem);
                        }
                    }


                    onlyItemsforOtherServices.Add(OtherServiceItem);
                }

                if (onlyItemsforOtherServices == null)
                {
                    return Json(HttpNotFound(), JsonRequestBehavior.AllowGet);
                }




                return Json(onlyItemsforOtherServices, JsonRequestBehavior.AllowGet);

            }


        }
        public InitialSetupItem getExistingItem(InitialSetupItem item)
        {
            using (Repository<InitialSetupItem> repository = new Repository<InitialSetupItem>())
            {
                Expression<Func<InitialSetupItem, bool>> lambda;

                lambda = (x => x.MedicalTypeId == item.MedicalTypeId && x.ItemId == item.ItemId && x.InitialSetupId==item.InitialSetupId);

                List<InitialSetupItem> iniItem = repository.GetByQueryWithInactive(lambda).ToList();

               if(iniItem.Count>0)
               {
                   return iniItem[0];
               }else
               {
                   return new InitialSetupItem();
               }
            }
        }

        public JsonResult SaveInititalSetupItem(InitialSetupItem item)
        {


           

            using (Repository<InitialSetupItem> repository = new Repository<InitialSetupItem>())
            {
  
                    item.UserId = GetLoggedinUserInfo().UserId;

                    if (item.Id == 0)
                    {
                        InitialSetupItem existingItem=getExistingItem(item);

                        if (existingItem.Id > 0)
                        {
                            existingItem.Active = true;
                            repository.Update(existingItem);
                            repository.Commit();
                        }
                        else
                        {
                            repository.Insert(item);
                            repository.Commit();
                        }
                    }else
                    {
                        repository.Delete(item, GetLoggedinUserInfo().UserId);
                        repository.Commit();
                    }
                
         
            }

            return Json("saved successfully");
        }
        public JsonResult SaveItem(Item item)
        {
            Item LabTestItem = new Item();

 
            
            using (ItemRepository repository = new ItemRepository())
            {
               
                item.UserId = GetLoggedinUserInfo().UserId;
                if (item.Id > 0)
                {
                    LabTestItem = repository.Update(item);
                    repository.Commit();
                }
                else
                {
                    LabTestItem = repository.Insert(item);
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
                category.UserId = GetLoggedinUserInfo().UserId;

                outPutCategory = repository.Insert(category);
                                repository.Commit();
                // CreatePatientService(invoice.Id, patientServices);
            }

            return Json(outPutCategory, JsonRequestBehavior.AllowGet);

        }

        public JsonResult CreateReportGroup(string reportGroupName)
        {
            LabReportGroup LabReportGroup = new LabReportGroup();

            LabReportGroup.Name = reportGroupName;

            using (Repository<LabReportGroup> repository = new Repository<LabReportGroup>())
            {
                LabReportGroup.UserId = GetLoggedinUserInfo().UserId;
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
                MeasurementUnit.UserId = GetLoggedinUserInfo().UserId;
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




        public JsonResult loadTestCategories(long medicalTypeID)
        {
            List<ItemCategory> onlyItemCategories = new List<ItemCategory>();
            List<ItemCategory> ItemCategories;

            using (ItemCategoryRepository repository = new ItemCategoryRepository())
            {

                Expression<Func<ItemCategory, bool>> lambda;
                Func<IQueryable<ItemCategory>, IOrderedQueryable<ItemCategory>> orderingFunc = query => query.OrderBy(m => m.Name);

                lambda = (x => x.Active == true && x.MedicalTypeId == medicalTypeID);

                ItemCategories = repository.GetByQuery(lambda, orderingFunc).ToList();

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


        public JsonResult loadLabTestCategories(long medicalTypeID)
        {
            List<ItemCategory> onlyItemCategories = new List<ItemCategory>();
            List<ItemCategory> ItemCategories;

            using (ItemCategoryRepository repository = new ItemCategoryRepository())
            {

                Expression<Func<ItemCategory, bool>> lambda;
                Func<IQueryable<ItemCategory>, IOrderedQueryable<ItemCategory>> orderingFunc = query => query.OrderBy(m => m.Name);


                lambda = (x => x.Active == true && x.MedicalTypeId == medicalTypeID);

                ItemCategories = repository.GetByQuery(lambda, orderingFunc).ToList();

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


                Item = repository.GetById(itemID);

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
                LabTestItem.Description = Item.Description;
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


        public JsonResult GetLabItemsByMedicalType(long medicalTypeID,long? categoryId=null)
        {
            List<Item> onlyItemsforLabTest = new List<Item>();
            List<Item> itemsforLabTest;

            using (ItemRepository repository = new ItemRepository())
            {
                Expression<Func<Item, bool>> lambda;
                Func<IQueryable<Item>, IOrderedQueryable<Item>> orderingFunc = query => query.OrderBy(m => m.ItemCategory.Name).ThenBy(m=>m.Name);
                
                lambda = (x => x.MedicalTypeId == medicalTypeID && x.Active == true && (categoryId==null ? x.ItemCategoryId==null|| x.ItemCategoryId>0: x.ItemCategoryId==categoryId));

                itemsforLabTest = repository.GetByQuery(lambda, orderingFunc).ToList();

                foreach (Item c in itemsforLabTest)
                {
                    Item LabTestItem = new Item();
                    ItemCategory LabTestItemCategory = new ItemCategory();
                    BedOccupancy bed = new BedOccupancy();
                    List<BedOccupancy> beds = new List<BedOccupancy>();

                    LabTestItem.ItemCategory = LabTestItemCategory;

                    if (c.BedOccupancies.Count > 0)
                    {
                        foreach (BedOccupancy itembed in c.BedOccupancies)
                        {
                            bed.Id = itembed.Id;
                            bed.ItemID = itembed.ItemID;
                            bed.PatientId = itembed.PatientId;
                            bed.PatientName = itembed.PatientName;
                            bed.Occupied = itembed.Occupied;
                            bed.Active = itembed.Active;
                            beds.Add(bed);
                        }


                    }
                    else
                    {
                        bed.Occupied = false;
                        beds.Add(bed);
                    }

                    LabTestItem.BedOccupancies = beds;


                    LabTestItem.Id = c.Id;
                    LabTestItem.Name = c.Name;
                    LabTestItem.GenericName = c.GenericName;
                    LabTestItem.Code = c.Code;
                    LabTestItem.ItemTypeId = c.ItemTypeId;
                    LabTestItem.MedicalTypeId = c.MedicalTypeId;
                    LabTestItem.ItemCategoryId = c.ItemCategoryId;
                    LabTestItem.MeasurementUnitId = c.MeasurementUnitId;
                    LabTestItem.SalePrice = c.SalePrice;
                    LabTestItem.BuyPrice = c.BuyPrice;
                    LabTestItem.DefaultReferrarFee = c.DefaultReferrarFee;
                    LabTestItem.ReferralAllowed = c.ReferralAllowed;
                    LabTestItem.Description = c.Description;
                    LabTestItem.ServiceProviderId = c.ServiceProviderId;
                    LabTestItem.LabReportGroupId = c.LabReportGroupId;
                    if (c.ItemCategoryId != null)
                    {
                        LabTestItem.ItemCategory.Name = c.ItemCategory.Name;
                    }
                    onlyItemsforLabTest.Add(LabTestItem);
                }

                if (onlyItemsforLabTest == null)
                {
                    return Json(HttpNotFound(), JsonRequestBehavior.AllowGet);
                }




                return Json(onlyItemsforLabTest, JsonRequestBehavior.AllowGet);

            }


        }

        public JsonResult GetLabItemsByMedicalTypeAndCategory(long medicalTypeID, long categoryId = 0)
        {
            List<Item> onlyItemsforLabTest = new List<Item>();
            List<Item> itemsforLabTest;

            using (ItemRepository repository = new ItemRepository())
            {
                Expression<Func<Item, bool>> lambda;

                Func<IQueryable<Item>, IOrderedQueryable<Item>> orderingFunc = query => query.OrderBy(m => m.ItemCategory.Name).ThenBy(m => m.Name);

                if (categoryId == 0 || categoryId==null)
                {
                    lambda = (x => x.MedicalTypeId == medicalTypeID && x.Active == true);
                }else
                {
                    lambda = (x => x.MedicalTypeId == medicalTypeID && x.Active == true && x.ItemCategoryId==categoryId);
                }

                itemsforLabTest = repository.GetByQuery(lambda, orderingFunc).ToList();

                foreach (Item c in itemsforLabTest)
                {
                    Item LabTestItem = new Item();
                    ItemCategory LabTestItemCategory = new ItemCategory();
                    BedOccupancy bed = new BedOccupancy();
                    List<BedOccupancy> beds =new List<BedOccupancy>();

                    LabTestItem.ItemCategory = LabTestItemCategory;

                    if (c.BedOccupancies.Count > 0)
                    {
                        foreach (BedOccupancy itembed in c.BedOccupancies)
                        {
                            bed.Id = itembed.Id;
                            bed.ItemID = itembed.ItemID;
                            bed.PatientId = itembed.PatientId;
                            bed.PatientName = itembed.PatientName;
                            bed.Occupied = itembed.Occupied;
                            bed.Active = itembed.Active;
                            beds.Add(bed);
                        }
                        
                       
                    }else
                    {
                        bed.Occupied = false;
                        beds.Add(bed);
                    }

                    LabTestItem.BedOccupancies = beds;
                

                    LabTestItem.Id = c.Id;
                    LabTestItem.Name = c.Name;
                    LabTestItem.GenericName = c.GenericName;
                    LabTestItem.Code = c.Code;
                    LabTestItem.ItemTypeId = c.ItemTypeId;
                    LabTestItem.MedicalTypeId = c.MedicalTypeId;
                    LabTestItem.ItemCategoryId = c.ItemCategoryId;
                    LabTestItem.MeasurementUnitId = c.MeasurementUnitId;
                    LabTestItem.SalePrice = c.SalePrice;
                    LabTestItem.BuyPrice = c.BuyPrice;
                    LabTestItem.DefaultReferrarFee = c.DefaultReferrarFee;
                    LabTestItem.ReferralAllowed = c.ReferralAllowed;
                    LabTestItem.Description = c.Description;
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

        public JsonResult UpdateLabStatus(PatientService patientServiceItem, bool InvoiceStatusUpdate, long InvoiceID)
        {
            patientServiceItem.UserId = GetLoggedinUserInfo().UserId;
            using (PatientServiceRepository repository = new PatientServiceRepository())
            {
                patientServiceItem.Item = null;
                patientServiceItem.ServiceProvider = null;
                repository.Update(patientServiceItem);
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
        public static bool IsDate(Object obj)
        {
            string strDate = obj.ToString();
            try
            {
                DateTime dt = DateTime.Parse(strDate);
                if ((dt.Month != System.DateTime.Now.Month) || (dt.Day < 1 && dt.Day > 31) || dt.Year != System.DateTime.Now.Year)
                    return false;
                else
                    return true;
            }
            catch
            {
                return false;
            }
        }


        public JsonResult cancelRefund(PatientService patientService)
        {
            using (PatientServiceRepository repository = new PatientServiceRepository())
            {
                patientService.Item.ItemCategory = null;
                patientService.RefundNote=null;
                repository.UpdateByField(patientService, "RefundNote");
               // repository.Update(patientService);
                repository.Commit();
            }

            return Json("Successfully cancel refund");
        }
        public JsonResult approveRefund(PatientService patientService)
        {

           // patientService.UserId = GetLoggedinUserInfo().UserId;

            Payment pPayment = new Payment();
            long invoiceId=0;
            long receiptId=0;

            if (patientService.InvoiceID != null)
            {
                 invoiceId = (long)patientService.InvoiceID;
            }
            else
            {
                 receiptId = (long)patientService.ReceiptId;
            }
        

            using (PatientServiceRepository repository = new PatientServiceRepository())
            {
                patientService.Item = null;
                patientService.Refund = true;
                repository.UpdateByField(patientService,"Refund");
                repository.Commit();
            }

            Refund refundItem = new Refund();

            refundItem.ApprovedUserID = GetLoggedinUserInfo().UserId;
            refundItem.UserId =(long) patientService.UserId;
            refundItem.Amount = patientService.ServiceListPrice;
            refundItem.InvoiceID =  patientService.InvoiceID;
            refundItem.ReceiptId = patientService.ReceiptId;
            refundItem.ItemId = patientService.ItemId;
            refundItem.PatientServiceId = patientService.Id;
            refundItem.PatientInvoice = null;

            

            using (Repository<Refund> repository = new Repository<Refund>())
            {

                repository.Insert(refundItem);
                repository.Commit();
            }



            if (patientService.InvoiceID != null)
            {
                using (PatientInvoiceRepository repository = new PatientInvoiceRepository())
                {
                    PatientInvoice pInvoice = repository.GetById(invoiceId);
                    pInvoice.IsRefunded = true;
                    pInvoice.UserId = GetLoggedinUserInfo().UserId;

                    pInvoice.TotalAmount = pInvoice.TotalAmount - patientService.ServiceListPrice;
                    repository.Update(pInvoice);
                    repository.Commit();

                }
            }else
            {
                if (patientService.ReceiptId != null)
                {
                    using (Repository<ReceiptPayment> repository = new Repository<ReceiptPayment>())
                    {
                        ReceiptPayment pReceipt = repository.GetById(receiptId);
                        pReceipt.IsRefunded = true;
                        pReceipt.UserId = GetLoggedinUserInfo().UserId;

                        pReceipt.TotalAmount = pReceipt.TotalAmount - patientService.ServiceListPrice;
                        repository.Update(pReceipt);
                        repository.Commit();

                    }
                }
            }

            using (Repository<Payment> repository = new Repository<Payment>())
            {


                pPayment.Amount = -(patientService.ServiceListPrice);
                if (patientService.InvoiceID != null)
                {
                    pPayment.PaymentTypeId = 101;
                }else
                {
                    pPayment.PaymentTypeId = 102;
                }
                pPayment.PatientID = patientService.PatientID;
                pPayment.UserId = (long)patientService.UserId;
                pPayment.Date = DateTime.Now;
                pPayment.DeductionAmount = 0;
                pPayment.PaymentMethodId = 1;
                pPayment = repository.Insert(pPayment);
                repository.Commit();
            }

            if (patientService.InvoiceID != null)
            {
                using (Repository<InvoicePayment> repository = new Repository<InvoicePayment>())
                {
                    InvoicePayment pInvoicePayment = new InvoicePayment();

                    pInvoicePayment.PatientInvoiceId = invoiceId;
                    pInvoicePayment.Amount = -(patientService.ServiceListPrice);
                    pInvoicePayment.PaymentID = pPayment.Id;
                    pInvoicePayment.UserId = (long)patientService.UserId;


                    repository.Insert(pInvoicePayment);
                    repository.Commit();


                }
            }



            return Json("Successfully approved refund");
        }

        public JsonResult GetRefundedItem()
        {
            List<PatientService> onlyPatientServices = new List<PatientService>();
            List<PatientService> PatientServices;
            Expression<Func<PatientService, bool>> lambda;

            using (PatientServiceRepository repository = new PatientServiceRepository())
            {


                lambda = (x => x.RefundNote!= null && x.Refund==null && x.Active == true);
                PatientServices= repository.GetByQuery(lambda).ToList();


                foreach (PatientService c in PatientServices)
                {
                    PatientService patientstitem = new PatientService();
                    Item item = new Item();
                    ItemCategory Category = new ItemCategory();
 
                    
                    patientstitem.Item = item;
                    patientstitem.Item.ItemCategory = Category;
                   


                    patientstitem.Id = c.Id;
                    patientstitem.PatientID = c.PatientID;
                    patientstitem.ItemId = c.ItemId;
                    patientstitem.InvoiceID = c.InvoiceID;
                    patientstitem.ReceiptId = c.ReceiptId;
                    patientstitem.PatientAdmissionId = c.PatientAdmissionId;
                    patientstitem.ServiceListPrice = c.ServiceListPrice;
                    patientstitem.ServiceActualPrice = c.ServiceActualPrice;
                    patientstitem.ServiceQuantity = c.ServiceQuantity;
                    patientstitem.ServiceDate = c.ServiceDate;
                    patientstitem.UserId = c.UserId;
                    patientstitem.Discount = c.Discount;
                    patientstitem.DiscountAfterInvoice = c.DiscountAfterInvoice;
                    patientstitem.Refund = c.Refund;
                    patientstitem.RefundNote = c.RefundNote;
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
                    if (c.Item.ItemCategory != null)
                    {
                        patientstitem.Item.ItemCategory.Name = c.Item.ItemCategory.Name;
                    }



                    onlyPatientServices.Add(patientstitem);
                }




                if (onlyPatientServices == null)
                {
                    return Json(HttpNotFound(), JsonRequestBehavior.AllowGet);
                }




                return Json(onlyPatientServices, JsonRequestBehavior.AllowGet);
            }

          
        }

        public JsonResult GetPatientInvoicebyMedicalType(long id, long statusid, long medicalTypeID, string DateStart, string DateEnd, long? invoiceId = null)
        {

            List<PatientInvoice> onlypatientInvoices = new List<PatientInvoice>();
            List<PatientInvoice> patientInvoices =new  List<PatientInvoice>();
            List<PatientService> PatientServices;
            DateTime invoiceDateStart = DateTime.Parse("1/1/1980");
            DateTime invoiceDateEnd = DateTime.Today;

            if (IsDate(DateEnd) && IsDate(DateStart))
            {

                invoiceDateStart = DateTime.Parse(DateStart);
                invoiceDateEnd = DateTime.Parse(DateEnd);
            } 

            using (PatientInvoiceRepository repository = new PatientInvoiceRepository())
            {
                patientInvoices = repository.GetPatientInvoicebyMedicalTypeOnlyLabItem(id, statusid, medicalTypeID, invoiceDateStart, invoiceDateEnd, invoiceId).ToList();
             

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
                    onlyPatientInvoice.IsRefunded = pinvoice.IsRefunded;
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
                            ItemCategory Category = new ItemCategory();
                            ServiceProvider serviceProdier = new ServiceProvider();
                            Contact contact = new Contact();
                            serviceProdier.Contact = contact;
                            patientstitem.Item = item;
                            patientstitem.Item.ItemCategory = Category;
                            patientstitem.ServiceProvider = serviceProdier;


                            patientstitem.Id = c.Id;
                            patientstitem.PatientID = c.PatientID;
                            patientstitem.ItemId = c.ItemId;
                            patientstitem.InvoiceID = c.InvoiceID;
                            patientstitem.ReceiptId = c.ReceiptId;
                            patientstitem.PatientAdmissionId = c.PatientAdmissionId;
                            patientstitem.ServiceListPrice = c.ServiceListPrice;
                            patientstitem.ServiceActualPrice = c.ServiceActualPrice;
                            patientstitem.ServiceQuantity = c.ServiceQuantity;
                            patientstitem.ServiceDate = c.ServiceDate;
                            patientstitem.UserId = c.UserId;
                            patientstitem.Discount = c.Discount;
                            patientstitem.DiscountAfterInvoice = c.DiscountAfterInvoice;
                            patientstitem.Refund = c.Refund;
                            patientstitem.RefundNote = c.RefundNote;
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
                            if (c.Item.ItemCategory != null)
                            {
                                patientstitem.Item.ItemCategory.Name = c.Item.ItemCategory.Name;

                            }

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