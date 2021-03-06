﻿'use strict';


HmsApp.controller("BedSetupController", function ($scope, $routeParams, $window, $filter, $modal, $route, BedSetupService, PatientService, IniService) {
    $scope.LabReportFormats = {};
    
    $scope.SingleBedItem = {
        id: 0,
        Name: "",
        GenericName: "",
        Code: "",
        ItemTypeId: '',
        MedicalTypeId: '',
        ItemCategoryId: '',
        MeasurementUnitId:'',
        SalePrice: "",
        BuyPrice: 0.00,
        ServiceProviderId: "",
        ReferralAllowed: 0,
        Description:"",
        DefaultReferrarFee: "",
        LabReportGroupId: "",


    };
    $scope.saveSuccess = 0;
    $scope.addPatientSuccess = 0;
    $scope.ItemCategories = {};
    $scope.LabTestGroups = {};
    $scope.MeasureMentUnits = {};
    $scope.medicalTypeID='';
    $scope.LabItemEdit = false;

    $scope.isSamePatient = 0;
    $scope.IsPatientNull = false;
    $scope.IsPatientExist = false;
    $scope.filterCondition=
    {
        ItemCategoryId: "0",
        CategoryId:"0"
    }

 
    function init()
    {

    $scope.$on('patientchange', function (event, args) {
        // console.log("patient changes");
        $scope.IsPatientNull = false;
        if ($routeParams.tab == "addlabtest") {

        }

        if ($routeParams.tab == "bedlist") {


            $scope.loadItemCategories();

        }


        if ($routeParams.tab == "summary") {
            $scope.IsPatientExist = false;
            $scope.checkBedOccupancy($scope.Patient.Id);

            //if ($scope.Patient) {
            //    if ($scope.Patient.Id != null) {
            //        if (!$scope.LabTestStatus) $scope.LabTestStatus = 0;

            //        $scope.GetInvoicesByMedicalType($scope.Patient.Id, $scope.LabTestStatus, $scope.medicalTypeID);
            //    }
            //}

        }
    });



    $scope.loaditembyCategory = function () {

        BedSetupService.GetItemsByMedicalType($scope.medicalTypeID, $scope.filterCondition.CategoryId)
    .success(function (pt) {
        $scope.items = pt;
        // preparelabtestDataModel();
        //$scope.loadBedOccupancyByItemId(itemID);
        console.log(pt);
    })
    .error(function (error) {
        $scope.status = 'Unable to load bed item data: ' + error.message;
        console.log($scope.status);
    });


    }
    $scope.loadItems = function () {



        $scope.GetItemsByMedicalType($scope.medicalTypeID);



    }

    $scope.GetItemsByMedicalType = function (medicalType) {
        BedSetupService.GetItemsByMedicalType($scope.medicalTypeID, $scope.filterCondition.CategoryId)
            .success(function (pt) {
                $scope.items = pt;
                // preparelabtestDataModel();
                //$scope.loadBedOccupancyByItemId(itemID);

                console.log(pt);
            })
            .error(function (error) {
                $scope.status = 'Unable to load bed item data: ' + error.message;
                console.log($scope.status);
            });
    }



    $scope.loadItemCategories = function () {
        BedSetupService.loadItemCategories($scope.medicalTypeID)
            .success(function (pt) {
                //$scope.ItemCategories = pt;
                $scope.ItemCategories = pt;
                //$scope.filterCondition.ItemCategoryId = $scope.ItemCategories[1].Id;

                if (!$routeParams.id && $scope.ItemCategories.length > 0) {
                    $scope.filterCondition.ItemCategoryId = $scope.ItemCategories[0].Id.toString();
                }

                console.log(pt);
            })
            .error(function (error) {
                $scope.status = 'Unable to load Bed categories: ' + error.message;
                console.log($scope.status);
            });
    }



    $scope.loadItembyId = function (itemid) {

        BedSetupService.loadItembyId(itemid)
            .success(function (pt) {
                $scope.SingleBedItem = pt;
                $scope.LoadFilterCondition();



                console.log(pt);
            })
            .error(function (error) {
                $scope.status = 'Unable to load single bed item ' + error.message;
                console.log($scope.status);
            });
    }

    $scope.loadMeasureMentUnits = function () {
        BedSetupService.loadMeasureMentUnits()
            .success(function (pt) {
                $scope.MeasureMentUnits = pt;
                if (!$routeParams.id) {
                    if ($scope.MeasureMentUnits.length > 0)
                    $scope.filterCondition.MeasurementUnitId = $scope.MeasureMentUnits[0].Id.toString();
                }

                console.log(pt);
            })
            .error(function (error) {
                $scope.status = 'Unable to load Measurement Units for Bed data: ' + error.message;
                console.log($scope.status);
            });
    }


    $scope.resetpopupFiled = function () {

        $scope.categoryName = "";
        $scope.reportGroupName = "";
        $scope.measurementUnitName = "";
    }

    /******************************* save portion ***********************************************/

    // $scope.filterCondition = {};


    $scope.LoadFilterCondition = function () {
       // $scope.filterCondition.MeasurementUnitId = $scope.SingleBedItem.MeasurementUnitId.toString();
        $scope.filterCondition.ItemCategoryId = $scope.SingleBedItem.ItemCategoryId.toString();
        if ($scope.SingleBedItem.LabReportGroupId != null) {
            $scope.filterCondition.LabReportGroupId = $scope.SingleBedItem.LabReportGroupId.toString()
        };
    }

    $scope.saveMeasurementUnit = function () {
        BedSetupService.CreateMeasurementUnit($scope.measurementUnitName)
        .success(function (data) {

            $scope.loadMeasureMentUnits();
            $scope.resetpopupFiled();

            $('#popupMeasurementUnit').css("visibility", "hidden");
            $('#popupMeasurementUnit').css("opacity", 0);

        })
        .error(function (error) {
            $scope.status = 'Unable to save Measurement Unit: ' + error.message;

        });

    }

    $scope.ReloadPage = function () {
        if (!$routeParams.id) {
            // location.reload();
            $route.reload();
        }
    }

    $scope.saveItem = function () {

       // $scope.SingleBedItem.MeasurementUnitId = 62;
        $scope.SingleBedItem.ItemCategoryId = $scope.filterCondition.ItemCategoryId;
        $scope.SingleBedItem.LabReportGroupId = null;
        $scope.SingleBedItem.MeasurementUnitId = null;


        BedSetupService.SaveItem($scope.SingleBedItem)
        .success(function (data) {

            $scope.loadItembyId(data);
            $scope.saveSuccess = 1;
            console.log("Save successfull");

        })
        .error(function (error) {
            $scope.status = 'Unable to save category data: ' + error.message;

        });
    }



    /*----------------------------- save end ----------------------------------------------------*/


    /*---------------------------------------- delete ------------------------------------------------*/


    // code added by zaber
    $scope.deleteBed = function (item) {


        if (item.BedOccupancies[0].Occupied != 0) {
            $window.alert('Cant Delete Item because already assigned to Patient');
        }
        else {
            BedSetupService.deleteBed(item.Id)
           .success(function (data) {

               $scope.GetItemsByMedicalType($scope.medicalTypeID);
               $scope.status = 'Delete Successful';


           })
           .error(function (error) {
               $scope.status = 'Unable to delete bed : ' + error.message;
               console.log($scope.status);
           });
        }

    }
    $scope.validateInput = {
        submit: function (form) {
            if (form.$valid) {
                $scope.valid = true;
            }
        }
    }

    $scope.checkBedOccupancy = function (Id) {
        BedSetupService.loadBedOccupancyByPatientId(Id)
                .success(function (data) {
                    console.log(data);
                    if (data.length > 0) {
                        $scope.IsPatientExist = true;
                    }
                })
                .error(function (error) {
                    $scope.status = 'Unable to check bed occupancy: ' + error.message;
                    console.log($scope.status);
                });
    }

    // end by zaber
    /*----------------------------------------delete end -----------------------------------------------*/

    //------------------------------- Modal open portion -------------------------------------------------------------



    //----------------------------------------------------------------------------------------------------




    if ($routeParams.tab == "addbed") {

        //  $scope.ItemCategories =  $scop
        // $scope.LabTestGroups = 
        // $scope.MeasureMentUnits = 

        /* $scope.loadLabTestGroups();
        $scope.loadMeasureMentUnits();*/


        if ($routeParams.id) {
            $scope.loadItembyId($routeParams.id);
        }
        $scope.loadItemCategories();
        $scope.loadMeasureMentUnits();

    }
    if ($routeParams.tab == "summary") {
        if ($scope.Patient) {
            $scope.checkBedOccupancy($scope.Patient.Id);
        }
        $scope.loadItemCategories();
        $scope.loaditembyCategory();
    }
    if ($routeParams.tab == "bedlist") {
        $scope.loadItemCategories();
        $scope.loadItems()




    }

    var tabClass = ".summary";
    if ($routeParams.tab != null) {
        tabClass = "." + $routeParams.tab;
    }
    $('.tabs li').removeClass('active');
    $(tabClass).addClass('active');
    $(tabClass).removeClass('hide');

    $scope.cancel = function () {
        $window.location.href = '#/bedsetup/summary';
    }



    $scope.addPatient = function (bedItem) {
        //$scope.IsPatientExist = false;

        if ($scope.Patient.AdmissionId == null) {
            alert("Patient Is not Admited to hospital");
            return;
        }

        if ($scope.IsPatientExist == false) {
            $scope.PatientServiceItem = [];
            $scope.isSamePatient = 0;

            //Filter the Bed Item from Items model array

            //$scope.bedItem = $filter('filter')($scope.items, Id);

            $scope.serviceItem = {};

            if (!$scope.Patient) {

                $window.alert("Please Enter a Patient Name");
                $scope.IsPatientNull = true;

            }



            //angular.forEach($scope.items, function (obj) {

            //    if (obj.BedOccupancies[0].PatientId == $scope.Patient.Id) {

            //        $scope.IsPatientExist = true;
            //    }


            //});

            if (!$scope.IsPatientNull) {
                //}
                //else
                //{
                //    BedSetupService.loadBedOccupancyByPatientId($scope.Patient.Id)
                //.success(function (data) {

                //    $scope.newbedItem = data;
                //    console.log(data);
                //    //$scope.isSamePatient = 1;

                //})
                //    .error(function (error) {
                //        $scope.status = 'Unable to get Bed Occupancy data: ' + error.message;
                //        console.log($scope.status);
                //    });

                //angular.forEach($scope.newbedItem, function (value, index) {
                //    alert(value.PatientId);
                //})

                if ($scope.IsPatientExist) {
                    $window.alert("This Patient has already been bedded");
                }
                else {
                    $scope.serviceItem.PatientID = $scope.Patient.Id;
                    $scope.serviceItem.ItemId = bedItem.Id;
                    $scope.serviceItem.InvoiceID = null;
                    $scope.serviceItem.PatientAdmissionId = $scope.Patient.AdmissionId;
                    $scope.serviceItem.ServiceListPrice = bedItem.SalePrice;
                    $scope.serviceItem.ServiceActualPrice = bedItem.SalePrice;
                    $scope.serviceItem.ServiceQuantity = 1;
                    $scope.serviceItem.ServiceDate = $filter('date')(new Date(), 'MM/dd/yy hh:mm:ss');
                    $scope.serviceItem.ServiceProviderId = bedItem.ServiceProviderId;


                    if (bedItem.MedicalTypeId == $scope.medicalTypeIDLab) {
                        $scope.serviceItem.LabStatusId = 1;
                        $scope.serviceItem.ReferralFeePaid = 0;
                    }
                    else {
                        $scope.serviceItem.LabStatusId = null;
                        $scope.serviceItem.ReferralFeePaid = null;
                    }
                    $scope.serviceItem.UserId = '';
                    $scope.serviceItem.Discount = '';
                    $scope.serviceItem.Refund = '';
                    $scope.serviceItem.Billed = '';
                    $scope.serviceItem.ReferralFee = bedItem.ReferralFee;
                    $scope.serviceItem.DeliveryDate = bedItem.Date;
                    $scope.serviceItem.DeliveryTime = bedItem.ReportDeliveryTime;

                    $scope.PatientServiceItem.push($scope.serviceItem);


                    BedSetupService.SavePatientServiceItem($scope.PatientServiceItem)
                    .success(function (data) {

                        console.log(data);
                        $scope.IsPatientExist = true;
                        // $scope.UpdateTopLink('billing');
                        //$window.location.href = '#/billing';
                        $scope.addPatientSuccess = 1;
                        $scope.serviceItemEmpty();
                        //$scope.loadItems();
                        $scope.occupyBed(bedItem);



                    })
                    .error(function (error) {
                        $scope.status = 'Unable to save PatientServiceItem data: ' + error.message;
                        console.log($scope.status);
                    });




                }
            }
        } else {
            $window.alert("Patient Already exist");
        }
    }



    $scope.occupyBed = function (bedItem) {
        $scope.BedOccupancy = {};
        $scope.BedOccupancyCollection = [];

        $scope.BedOccupancy.ItemID = bedItem.Id;
        $scope.BedOccupancy.AdmissioinId = $scope.Patient.AdmissionId;
        $scope.BedOccupancy.PatientId = $scope.Patient.Id;
        $scope.BedOccupancy.PatientName = $scope.Patient.Name;
        $scope.BedOccupancy.Occupied = 1;
        $scope.BedOccupancy.Active = 1;


        $scope.BedOccupancyCollection.push($scope.BedOccupancy);

        BedSetupService.SaveBedOccupancy($scope.BedOccupancyCollection)
            .success(function (data) {

                console.log(data);
                $scope.serviceItemEmpty();
                $scope.loaditembyCategory();

            })
            .error(function (error) {
                $scope.status = 'Unable to save Bed Occupancy: ' + error.message;
                console.log($scope.status);
            });

    }

    //$scope.loadBedOccupancyByItemId(itemID)
    //{
    //    BedSetupService.loadBedOccupancyByItemId(itemID)
    //        .success(function (data) {

    //            console.log(data);                

    //        })
    //        .error(function (error) {
    //            $scope.status = 'Unable to load Bed Occupancy data: ' + error.message;
    //            console.log($scope.status);
    //        });
    //}

    $scope.emptyBed = function (bedItem) {


        $scope.bedOccupancyItem = {};

        $scope.bedOccupancyItem.Id = bedItem.BedOccupancies[0].Id;
        $scope.bedOccupancyItem.ItemID = bedItem.BedOccupancies[0].ItemID;
        $scope.bedOccupancyItem.AdmissioinId = $scope.Patient.AdmissionId;
        $scope.bedOccupancyItem.Occupied = 0;
        $scope.bedOccupancyItem.PatientId = bedItem.BedOccupancies[0].PatientId;
        $scope.bedOccupancyItem.PatientName = bedItem.BedOccupancies[0].PatientName;
        $scope.bedOccupancyItem.Active = 0;

        BedSetupService.emptyBed($scope.bedOccupancyItem)
            .success(function (data) {

                console.log(data);
                //$scope.serviceItemEmpty();
                $scope.GetItemsByMedicalType($scope.medicalTypeID);

                if (bedItem.BedOccupancies[0].PatientId == $scope.Patient.Id) {
                    $scope.IsPatientExist = false;
                }




            })
            .error(function (error) {
                $scope.status = 'Unable to Empty Bed Allocation: ' + error.message;
                console.log($scope.status);
            });
    }




    $scope.saveCategory = function () {
        BedSetupService.CreateCategory($scope.categoryName, $scope.medicalTypeID)
        .success(function (data) {

            $scope.loadItemCategories();
            $scope.resetpopupFiled();

            $('#popupCategory').css("visibility", "hidden");
            $('#popupCategory').css("opacity", 0);

        })
        .error(function (error) {
            $scope.status = 'Unable to save category data: ' + error.message;

        });

    }
  
}


    /*------------------------- configuration begin -------------------------*/

        $scope.GetConfiguration = function () {

            IniService.GetConfiguration()
                .success(function (data) {

                    $scope.Configuration = data;


                    $scope.medicalTypeID = $scope.Configuration.Configuration.MedicalTypeBed.toString();
                    $scope.SingleBedItem.MedicalTypeId = $scope.Configuration.Configuration.MedicalTypeBed;
                    $scope.NonRegisterPatientId = $scope.Configuration.Configuration.NonRegisterPatientId;
                    $scope.ServiceProviderType = $scope.Configuration.Configuration.DoctorTypeId;
                    $scope.SingleBedItem.ItemTypeId = $scope.Configuration.Configuration.ServiceItem;
                    $scope.medicalTypeIDLab = $scope.Configuration.Configuration.MedicalTypeLabTest.toString();
                    $scope.Currency = $scope.Configuration.Configuration.Currency;

                    init();

                }).error(function (error) {

                    $scope.status = 'Unable to Discharge Admission: ' + error.message;
                    console.log($scope.status);

                });

        }

        $scope.GetConfiguration();

    /*------------------------- configuration end -------------------------*/


});