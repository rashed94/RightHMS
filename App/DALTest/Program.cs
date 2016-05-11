﻿using HMS.DAL;
using HMS.DAL.Repository;
using HMS.DAL.SessionFactory;
using HMS.DAL.SessionFactory.Impl;
using HMS.Model.Core;
using System;
using System.Collections.Generic;
using System.Linq;

class Program
{
    static void Main(string[] args)
    {
        var p = new Program();
        p.Run();
    }

    private Contact GetContactByPhone(string phone)
    {
        ContactRepository contactRepo = new ContactRepository();
        return contactRepo.GetByPhoneNumber(phone);
    }
    private Department GetDepartmentByName(string name)
    {
        IRepository<Department> departmentRepo = new Repository<Department>();
        return departmentRepo.GetFirst(d => d.Name == "ENT");
    }
    private ServiceProviderType GetServiceProviderTypeByName(string name)
    {
        IRepository<ServiceProviderType> serviceProviderTypeRepo = new Repository<ServiceProviderType>();
        return serviceProviderTypeRepo.GetFirst(d => d.Name == "Doctor");
    }

    private void Run()
    {
        log4net.ILog logger = log4net.LogManager.GetLogger("Logger");

        Contact contact;
        using (ContactRepository contactRepo = new ContactRepository())
        {
            contact = contactRepo.GetByPhoneNumber("01833353657");
        }

        Department department;
        using (IRepository<Department> departmentRepo = new Repository<Department>())
        {
            department = departmentRepo.GetFirst(d => d.Name == "ENT");
        }

        ServiceProviderType serviceProviderType;
        using (IRepository<ServiceProviderType> serviceProviderTypeRepo = new Repository<ServiceProviderType>())
        {
            serviceProviderType = serviceProviderTypeRepo.GetFirst(d => d.Name == "Doctor");
        }

        //ISessionFactory sessionFactory = SessionFactory.Instance;
        //sessionFactory.OpenSession();
        //using (Context context = new Context())
        //{
        //InitData();

        using (IRepository<ServiceProvider> serviceProviderRepo = new Repository<ServiceProvider>())
        {
            serviceProviderRepo.Insert(new ServiceProvider
            {
                Code = "SP1",
                Contact = contact,
                Department = department,
                ServiceProviderType = serviceProviderType,
                IsReferer = true,
                Speciality = "Paediatritian"
            });
        }
        //context.SaveChanges();
        //sessionFactory.Commit();

        logger.Debug("All data insertion completed.");
        //}
    }

    private void InitData()
    {
        Repository<Department> deptRepo = new Repository<Department>();
        Repository<ServiceProviderType> serviceProviderTypeRepo = new Repository<ServiceProviderType>();
        Repository<Item> itemRepo = new Repository<Item>();

        Repository<ItemCategory> itemCategoryRepo = new Repository<ItemCategory>();
        Repository<MedicalType> medicalTypeRepo = new Repository<MedicalType>();
        Repository<MeasurementUnit> measurementUnitRepo = new Repository<MeasurementUnit>();
        Repository<ItemType> itemTypeRepo = new Repository<ItemType>();

        Repository<PatientService> patientServiceRepo = new Repository<PatientService>();
        Repository<ServiceProvider> serviceProvidereRepo = new Repository<ServiceProvider>();
        Repository<Patient> patientRepo = new Repository<Patient>();
        Repository<Contact> contactRepo = new Repository<Contact>();

        deptRepo.DeleteAll();
        serviceProviderTypeRepo.DeleteAll();
        itemRepo.DeleteAll();
        itemCategoryRepo.DeleteAll();
        medicalTypeRepo.DeleteAll();
        measurementUnitRepo.DeleteAll();
        itemTypeRepo.DeleteAll();
        patientServiceRepo.DeleteAll();
        serviceProvidereRepo.DeleteAll();
        patientRepo.DeleteAll();
        contactRepo.DeleteAll();
        


        var entDepartment = new Department { Name = "ENT" };
        deptRepo.Insert(entDepartment);
        deptRepo.Insert(new Department { Name = "Dermatology" });
        deptRepo.Insert(new Department { Name = "Cosmetology" });
        deptRepo.Insert(new Department { Name = "Diabetology" });
        deptRepo.Insert(new Department { Name = "Gastroentrology" });
        deptRepo.Insert(new Department { Name = "Medicine" });
        deptRepo.Insert(new Department { Name = "Nephrology" });
        deptRepo.Insert(new Department { Name = "Neurology" });
        deptRepo.Insert(new Department { Name = "Nutririon & Dietetics" });
        deptRepo.Insert(new Department { Name = "Gynecology" });
        deptRepo.Insert(new Department { Name = "Oncology" });
        deptRepo.Insert(new Department { Name = "Paediatrics" });
        deptRepo.Insert(new Department { Name = "Urology" });

        var doctorServiceProvider = new ServiceProviderType { Name = "Doctor" };
        serviceProviderTypeRepo.Insert(doctorServiceProvider);
        serviceProviderTypeRepo.Insert(new ServiceProviderType { Name = "Surgeon" });
        serviceProviderTypeRepo.Insert(new ServiceProviderType { Name = "Anesthetist" });
        serviceProviderTypeRepo.Insert(new ServiceProviderType { Name = "Nurse" });

        var drugMedicalType = new MedicalType { Name = "Drug" };
        medicalTypeRepo.Insert(drugMedicalType);
        medicalTypeRepo.Insert(new MedicalType { Name = "Treatment" });
        medicalTypeRepo.Insert(new MedicalType { Name = "Laboratory Test" });
        medicalTypeRepo.Insert(new MedicalType { Name = "Surgery" });
        medicalTypeRepo.Insert(new MedicalType { Name = "Inpatient Accomodation" });

        var aiItemCategory = new ItemCategory { Name = "Anti-Inflammatory", MedicalType = drugMedicalType };
        itemCategoryRepo.Insert(aiItemCategory);
        itemCategoryRepo.Insert(new ItemCategory { Name = "Antihistamine", MedicalType = drugMedicalType });

        var boxMeasUnit = new MeasurementUnit { Name = "Box" };
        measurementUnitRepo.Insert(boxMeasUnit);
        measurementUnitRepo.Insert(new MeasurementUnit { Name = "File" });
        measurementUnitRepo.Insert(new MeasurementUnit { Name = "Inch" });
        measurementUnitRepo.Insert(new MeasurementUnit { Name = "Kg" });

        var inventoryItemType = new ItemType { Name = "Inventory" };
        itemTypeRepo.Insert(inventoryItemType);
        itemTypeRepo.Insert(new ItemType { Name = "Service" });

        itemRepo.Insert(new Item
        {
            Name = "Napa Extend",
            MedicalType = drugMedicalType,
            ItemType = inventoryItemType,
            BuyPrice = 10,
            SalePrice = 14.5M,
            Code = "P001",
            GenericName = "Paracetamol",
            ItemCategory = new ItemCategory { Name = "CAT-1", MedicalType = drugMedicalType },
            MeasurementUnit = boxMeasUnit
        });

        Contact muzahid = new Contact { FirstName = "Muzahidul", LastName = "Islam", PhoneNumber = "01833353657", Email = "mailmuzahid@gmail.com", City = "Dhaka" };
        Contact rashed = new Contact { FirstName = "Rashidul", LastName = "Alam", PhoneNumber = "017xxxxxxx", Email = "rashed94@gmail.com", City = "Dhaka" };
        Contact kashpia = new Contact { FirstName = "Kashpia", LastName = "Naharin", PhoneNumber = "0171xxxxxx", Email = "kashpia@gmail.com", City = "Feni" };
        contactRepo.Insert(muzahid);
        contactRepo.Insert(rashed);
        contactRepo.Insert(kashpia);

        //db.ServiceProviders.Add(new ServiceProvider
        //{
        //    Contact = muzahid,
        //    Department = entDepartment,
        //    AssignedToAllUsers = true,
        //    Code = "D001",
        //    IsReferer = false,
        //    Speciality = "Surgery",
        //    ServiceProviderType = doctorServiceProvider
        //});

        patientRepo.Insert(new Patient
        {
            FirstName = "Masum",
            LastName = "Ahammed",
            Gender = true,
            NationalId = "269321844923",
            PhoneNumber = "01713738465",
            Occupation = "Service",
            Email = "masum.ahammed@gmail.com",
            FatherName = "ABC Ahammed",
            DOB = new DateTime(1980, 6, 21),
            City = "Dhaka",
            Country = "Bangladesh",
            BloodGroup = "O+",
            Street = "Mohammadia Housing Society",
            Zip = "1207"
        });
    }
}