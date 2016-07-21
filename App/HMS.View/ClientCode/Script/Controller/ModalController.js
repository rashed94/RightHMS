﻿'use strict';

HmsApp.controller("ModalController", function ($scope, $modalInstance, patient, PatientService) {

    $scope.Patient = patient;
    if (!$scope.Patient.Country) {
        $scope.Patient.Country = "BD";
    }
    $scope.ok = function (file) {
        $modalInstance.close({ Patient: $scope.Patient, File: file });
    };
    $scope.cancel = function () {
        $modalInstance.dismiss('cancel');
    };
});

HmsApp.controller("PharmacyStockModelController", function ($scope, $modalInstance) {


    $scope.ok = function (file) {
        $modalInstance.close();
    };
    $scope.cancel = function () {
        $modalInstance.dismiss('cancel');
    };
});



HmsApp.controller("PrintInvoiceModalController", function ($scope, $modalInstance, singleInvoice) {

    $scope.singleinvoice = singleInvoice;



    $scope.ok = function (file) {
        $modalInstance.close();
    };
    $scope.cancel = function () {
        $modalInstance.dismiss('cancel');
    };
});


HmsApp.controller("ServiceProviderModalController", function ($scope, $modalInstance, serviceProvider, ConfigurationService) {
    $scope.ServiceProvider = serviceProvider;
    if ($scope.ServiceProvider.Contact.Gender == null) {
        $scope.ServiceProvider.Contact.Gender = false;
        $scope.ServiceProvider.ServiceProviderTypeId = $scope.SelectedServiceProviderType.Id;
       
        $scope.ServiceProvider.ServiceProviderType = { Id: $scope.SelectedServiceProviderType.Id };
        $scope.ServiceProvider.DepartmentId = 205;
        $scope.ServiceProvider.Department = { Id: 205 }
    }

    $scope.ok = function (file) {
        $modalInstance.close({ ServiceProvider: $scope.ServiceProvider, File: file });
    };
    $scope.cancel = function () {
        $modalInstance.dismiss('cancel');
    };
});


HmsApp.controller("LabReportTemplateResultModalController", function ($scope, $http, $modalInstance, $filter, $window, isEdit, PatientServiceItem, LabTestItem, LabTestService) {

    $scope.InvoiceStatusUpdate = true;


    $scope.loadSavedData = function () {
        if (CKEDITOR.instances.editor1) {

            if (PatientServiceItem.ReportFormatName === null) {
                CKEDITOR.instances.editor1.setData("");


            } else {
                CKEDITOR.instances.editor1.setData(PatientServiceItem.ReportFormatName);
            }

        }
    }
    $scope.LoadData = function () {
        if ($scope.labreportTemplates != null) {
            $scope.labreportSingleTemplate = $scope.labreportTemplates[0];

            richTextData = $scope.labreportSingleTemplate.RichContent;
            CKEDITOR.instances.editor1.setData(richTextData);
        }
    }


    if (isEdit == "false") {
        LabTestService.LoadLabReportbyId(PatientServiceItem.Item.Id)
            .success(function (pt) {
                console.log(pt);
                $scope.labreportTemplates = pt;
                $scope.LoadData();

            })
            .error(function (error) {
                $scope.status = 'Unable to load  lab report  ' + error.message;
                console.log($scope.status);
            });

    }



    $scope.ok = function (richTextData) {

        PatientServiceItem.LabStatusId = "2";
        PatientServiceItem.ReportFormatName = richTextData;
        PatientServiceItem.Staus = "Completed";

        angular.forEach(LabTestItem.PatientServices, function (item) {

            if (PatientServiceItem.Id != item.Id) {
                if (item.LabStatusId == "1") {
                    $scope.InvoiceStatusUpdate = false;
                }
            }
        });

        if ($scope.InvoiceStatusUpdate) {
            LabTestItem.Staus = "Completed";
            LabTestItem.LabStatusId = "2";

        }

        LabTestService.UpdateLabStatus(PatientServiceItem, $scope.InvoiceStatusUpdate, PatientServiceItem.InvoiceID)
            .success(function (pt) {
                console.log(pt);
                $scope.labreportTemplates = pt;
                //$scope.LoadData();

            })
            .error(function (error) {
                $scope.status = 'Unable to load  lab report  ' + error.message;
                console.log($scope.status);
            });


        $modalInstance.dismiss('cancel');
    };


    $scope.cancel = function () {
        $modalInstance.dismiss('cancel');
    };



});

HmsApp.controller("LabReportTemplateModalController", function ($scope, $http, $modalInstance, $filter, $window, isEdit, labReportID, LabTestService) {

    $scope.templateData = {};


    $scope.LoadLabReport = function () {
        LabTestService.LoadLabReport(labReportID)
        .success(function (data) {

            console.log(data);
            //$modalInstance.dismiss('cancel');
            $scope.templateData = data;
            $scope.reportName = $scope.templateData.Name;
            richTextData = $scope.templateData.RichContent;
            CKEDITOR.instances.editor1.setData(richTextData);



        })
        .error(function (error) {
            $scope.status = 'Unable to load LabReportTemplate data: ' + error.message;
            console.log($scope.status);
        });

    }

    if (isEdit == 'true') {
        $scope.LoadLabReport();
    }

    $scope.ok = function (richTextData) {

        console.log(richTextData);


        $scope.templateData.Name = $scope.reportName;
        $scope.templateData.RichContent = richTextData;
        $scope.templateData.ItemId = $scope.SingleLabItem.Id;
        if (isEdit) {
            $scope.templateData.Id = labReportID;
        }

        LabTestService.SaveLabReportTemplate($scope.templateData)
            .success(function (data) {

                console.log(data);
                $modalInstance.dismiss('cancel');


            })
            .error(function (error) {
                $scope.status = 'Unable to save LabReportTemplate data: ' + error.message;
                console.log($scope.status);
            });



    };


    $scope.cancel = function () {
        $modalInstance.dismiss('cancel');
    };


});

HmsApp.controller("CommissionModalController", function ($scope, $http, $modalInstance, $filter, $window, LabTestService) {



    $scope.Referral = {};


    $scope.saveCommission = function () {
        LabTestService.saveDoctorsCommission($scope.Referral)
        .success(function (data) {

            console.log(data);
            $scope.getDoctorWithReferrel();


        })
        .error(function (error) {
            $scope.status = 'Unable to save PatientServiceItem data: ' + error.message;
            console.log($scope.status);
        });
    }


    $scope.getDoctorWithReferrel = function () {
        LabTestService.getDoctorWithReferrel($scope.SingleLabItem.Id)
         .success(function (data) {

             $scope.Referrals = data;
             console.log(data);



         })
            .error(function (error) {
                $scope.status = 'Unable to load reffer doctor for this item: ' + error.message;
                console.log($scope.status);
            });
    }



    $scope.ok = function () {


        $scope.Referral.itemId = $scope.SingleLabItem.Id;
        $scope.Referral.ServiceProviderId = $scope.Doctor.Id;
        $scope.Referral.ReferralFee = $scope.CommissionAmount;


        $scope.saveCommission();

        // $modalInstance.dismiss('cancel');

    };

    $scope.cancel = function () {
        $modalInstance.dismiss('cancel');
    };



    $scope.OnDocotorSelect = function ($item) {
        $scope.Doctor.Name = $item.Contact.FirstName + " " + $item.Contact.LastName;
        $scope.Doctor.Id = $item.Id;
    }

    $scope.GetDoctorPartialName = function (name) {


        //return $http.get('/patient/getserviceproviderpartialname?name=' + name + "&itemid=" + itemid).then(function (response) {
        //    var data = response.data;
        //    return response.data;
        //});

        /*----------------------------  TypeId 56 means doctor --------------------------------------------------*/

        return $http.get('/patient/getdoctorbyname?name=' + name + "&typeId=" + 56).then(function (response) {
            var data = response.data;
            return response.data;
        });


    }

    $scope.deleteCommission = function (referralId) {


        LabTestService.deleteCommission(referralId)
       .success(function (data) {

           $scope.getDoctorWithReferrel();



       })
       .error(function (error) {
           $scope.status = 'Unable to delete referral comission: ' + error.message;
           console.log($scope.status);
       });






    }


    $scope.getDoctorWithReferrel();
});

HmsApp.controller("InvoiceModalController", function ($scope, $modalInstance, $filter, $window, billingItems, singleInvoice, advancePayment, BillingService) {

    $scope.PatientServiceItem = [];
    $scope.InvoicePayments = [];
    $scope.TotalPaid = 0.00;
    $scope.ReconcileAmount = 0.00;
    $scope.PaymentMethod = "1";
    $scope.PaymentFlag = true;

    $scope.Invoice = {
        Id: null,
        InvoiceDate: $filter('date')(new Date(), 'MM/dd/yy'),
        DueDate: $filter('date')(new Date(), 'MM/dd/yy'),
        PatientID: $scope.Patient.Id,
        TotalAmount: 0.0,
        //PaidAmount: 0.0,
        //PaymentAmount: 0.0,
        //PaymentMethod: 'Cash',
        //CoPayerAmount: 0.0,
        //ReconcileAmount: 0.0,
        TotalDiscount: 0.0,
        InvoiceStatusId: 1,
        ItemDiscount: "",
        UserId: null,
        PaymentAmount: 0.0
    };

    $scope.InvoicePayment = {
        InvoiceId: 0,
        Amount: 0.0,
        PaymentID: null,
        UserId: null


    };
    $scope.Payment = {

        Amount: 0.0,
        DeductionAmount: 0.0,
        PaymentTypeId: 101,
        PatientID: $scope.Patient.Id,
        UserId: null,
        Date: $filter('date')(new Date(), 'MM/dd/yy hh:mm:ss'),
        PaymentMethodId: $scope.PaymentMethod,
        CardNumber: null

    };





    function ConvertJsonDateString(jsonDate) {
        var shortDate = null;
        if (jsonDate) {
            var regex = /-?\d+/;
            var matches = regex.exec(jsonDate);
            var dt = new Date(parseInt(matches[0]));
            var month = dt.getMonth() + 1;
            var monthString = month > 9 ? month : '0' + month;
            var day = dt.getDate();
            var dayString = day > 9 ? day : '0' + day;
            var year = dt.getFullYear();
            shortDate = monthString + '/' + dayString + '/' + year;
        }
        return shortDate;
    };

    function parseJsonDate(jsonDateString) {
        return new Date(parseInt(jsonDateString.replace('/Date(', '')));
    }



    $scope.GenerateServiceItem = function (item) {
        $scope.serviceItem = {};

        /*   var serviceItem = {
                PatientID: $scope.Patient.Id,
                ItemID: obj.Id,
                InvoiceID: '',
                ServiceListPrice: obj.Amount,
                ServiceActualPrice: obj.SalePrice,
                ServiceQuantity: obj.Quantity,
                ServiceDate: Date.now(),
                UserId: '',
                Discount: '',
                Refund: '',
                Billed: '',
                ReferralFee: obj.ReferralFee,
                DeliveryDate: obj.Date,
                DeliverTime:obj.ReportDeliveryTime
            };*/
        $scope.serviceItem.Id = item.Id;
        $scope.serviceItem.PatientId = item.PatientID;
        $scope.serviceItem.ItemID = item.ItemID;
        $scope.serviceItem.InvoiceID = 0;
        $scope.serviceItem.ServiceListPrice = item.ServiceListPriceAfterDiscount;
        $scope.serviceItem.ServiceActualPrice = item.ServiceActualPrice;
        $scope.serviceItem.ServiceQuantity = item.ServiceQuantity;
        $scope.serviceItem.ServiceDate = ToJavaScriptDate(item.ServiceDate);
        $scope.serviceItem.UserId = '';
        $scope.serviceItem.Discount = item.Discount;
        $scope.serviceItem.Refund = '';
        $scope.serviceItem.Billed = '';
        $scope.serviceItem.ReferralFee = item.ReferralAfterDiscount;
        $scope.serviceItem.DeliveryDate = ToJavaScriptDate(item.DeliveryDate);
        $scope.serviceItem.DeliveryTime = item.DeliveryTime;
        $scope.serviceItem.ReferralFeePaid = item.ReferralFeePaid;
        $scope.serviceItem.ServiceProviderId = item.ServiceProviderId;
        $scope.serviceItem.LabStatusId = item.LabStatusId;
        if (item.LabStatusId == 1) {
            $scope.isLabItem = true;
        }

        $scope.PatientServiceItem.push($scope.serviceItem);
    }

   function saveInvoice()  {
        BillingService.SaveInvoice($scope.Invoice, $scope.PatientServiceItem)
         .success(function (data) {

             console.log(data);
             $scope.Invoice = data;
             $scope.Invoice.InvoiceDate = ToJavaScriptDate($scope.Invoice.InvoiceDate);

             if ($scope.PaymentFlag) {
                 $scope.Invoice.PaymentAmount = parseFloat($scope.Invoice.TotalAmount);
             }else
             {
                 $scope.Invoice.PaymentAmount = $scope.PaymentAmount;
             }
             


         })
            .error(function (error) {
                $scope.status = 'Unable to save PatientServiceItem data: ' + error.message;
                console.log($scope.status);
                
            });
    }

    // first payment while invoice is not there
    if (singleInvoice.Id == null && billingItems.length > 0) {
        angular.forEach(billingItems, function (item, key) {
            $scope.Invoice.TotalAmount += item.ServiceListPriceAfterDiscount;
            $scope.Invoice.TotalDiscount += parseFloat(item.Discount);

            $scope.GenerateServiceItem(item);

        });

        if ($scope.isLabItem) {
            $scope.Invoice.LabStatusId = 1;
        }
        else {
            $scope.Invoice.LabStatusId = null;
        }

      saveInvoice();



    } else // second payment while invoice is there
    {
        // console.log("need to load invoice");
        $scope.Invoice = singleInvoice;

        if ($scope.Invoice.InvoicePayments.length > 0) {
            angular.forEach($scope.Invoice.InvoicePayments, function (item) {

                $scope.TotalPaid = $scope.TotalPaid + item.Amount;
                $scope.Invoice.PaymentAmount = parseFloat($scope.Invoice.TotalAmount) - parseFloat($scope.TotalPaid);

            });
        } else {

            $scope.Invoice.PaymentAmount = parseFloat($scope.Invoice.TotalAmount);
        }

    }

    /* reconcile amount adjust begin */

    var advanceAmount = 0;
    var keepGoing = true;
    $scope.TotalPayableAmount = 0;

    var totalPayableAmount = $scope.Invoice.TotalAmount - $scope.TotalPaid;

    $scope.InvoicePaymentList = [];

    angular.forEach(advancePayment, function (item) {

        $scope.InvoicePayment = {
            InvoiceId: 0,
            Amount: 0.0,
            PaymentID: null,
            UserId: null


        };

        if (keepGoing) {

            /* update invoice payment begin */

            $scope.InvoicePayment.PaymentID = item.Id;

            var itemAdvanceAmount = (item.Amount - item.DeductionAmount);

            advanceAmount = advanceAmount + itemAdvanceAmount;

            /*---------------- defination ---------------------*/

            // totalPayableAmount == total amount client need to pay

            //$scope.TotalPayableAmount  ==  summation of amount client paid from advance amount

            //itemAdvanceAmount  == total advance amount per item

            //  advanceAmount == summation of advance amount of items

            /*-----------------------end defination-------------------------*/

            if (totalPayableAmount >= advanceAmount) {
                item.DeductionAmount = item.DeductionAmount + itemAdvanceAmount;

                /* update invoice payment begin */

                $scope.InvoicePayment.Amount = itemAdvanceAmount;
                $scope.TotalPayableAmount += itemAdvanceAmount;

                $scope.InvoicePaymentList.push($scope.InvoicePayment);

                /* update invoice payment end */


                if (totalPayableAmount == advanceAmount) {
                    keepGoing = false;
                }

            } else {
                /*  var tempDeduction = $scope.Invoice.TotalAmount - advanceAmount;
      
                  if (tempDeduction > 0) {
                      item.DeductionAmount = item.Amount - tempDeduction;
                  } else {
      
                      item.DeductionAmount = item.Amount + tempDeduction;
                      advanceAmount = advanceAmount - tempDeduction;
                  }
                  */
                var itemPayableAmount = totalPayableAmount - $scope.TotalPayableAmount;

                item.DeductionAmount = item.DeductionAmount + itemPayableAmount;


                /* update invoice payment begin */


                $scope.InvoicePayment.Amount = itemPayableAmount;
                $scope.TotalPayableAmount += itemPayableAmount;

                $scope.InvoicePaymentList.push($scope.InvoicePayment);

                /* update invoice payment end */


                keepGoing = false;
            }
        }



    });

    if ($scope.InvoicePaymentList.length > 0) {
        $scope.ReconcileAmount = $scope.TotalPayableAmount;


        $scope.Invoice.PaymentAmount = $scope.Invoice.TotalAmount - $scope.ReconcileAmount - $scope.TotalPaid;
        $scope.PaymentFlag = false;
        $scope.PaymentAmount = $scope.Invoice.PaymentAmount;

    }

    console.log(advancePayment);

    /* reconcile amound adjust end */

    $scope.CheckReconcileAmount = function () {
        var totalPayableAmount = $scope.Invoice.TotalAmount - $scope.TotalPaid;
        var restPaidAmount = totalPayableAmount - $scope.TotalPayableAmount;

        if ($scope.Invoice.PaymentAmount > restPaidAmount) {
            $window.alert("Please endter correct amount");
            $scope.Invoice.PaymentAmount = restPaidAmount;
        }

    }

    $scope.ok = function () {

        $scope.InvoicePayment = {
            InvoiceId: 0,
            Amount: 0.0,
            PaymentID: null,
            UserId: null


        };


        if ($scope.InvoicePaymentList.length > 0) {
            angular.forEach($scope.InvoicePaymentList, function (item) {
                item.PatientInvoiceId = $scope.Invoice.Id;

            });
        }


        //  set payment method & card number
        $scope.Payment.PaymentMethodId = $scope.PaymentMethod;
        if ($scope.CardNumber != "1") {
            $scope.Payment.CardNumber = $scope.CardNumber;
        }


        if ($scope.Payment.PaymentMethodId != "1") {
            $scope.Payment.CardNumber = $scope.CardNumber;
        }

        if ($scope.Invoice.Id != null) {

            var paymentamount = 0;
            var total = parseFloat($scope.TotalPaid);
            var recenpayment = parseFloat($scope.Invoice.PaymentAmount);


            paymentamount = (total + recenpayment);



            if (paymentamount == $scope.Invoice.TotalAmount) {
                $scope.Invoice.InvoiceStatusId = "2";

            } else if (paymentamount > $scope.Invoice.TotalAmount) {
                $scope.Invoice.PaymentAmount = parseFloat($scope.Invoice.TotalAmount) - total;
                $scope.Invoice.InvoiceStatusId = "2";
            }


            if (($scope.ReconcileAmount + recenpayment) == ($scope.Invoice.TotalAmount - $scope.TotalPaid))
            {
                $scope.Invoice.InvoiceStatusId = "2";
            }





            $scope.Payment.Amount = $scope.Invoice.PaymentAmount;

            $scope.InvoicePayment.PatientInvoiceId = $scope.Invoice.Id;
            $scope.InvoicePayment.Amount = $scope.Invoice.PaymentAmount;
            $scope.InvoicePayments.push($scope.InvoicePayment);
            $scope.Payment.InvoicePayments = $scope.InvoicePayments;


            angular.forEach(advancePayment, function (item) {
                item.Date =ToJavaScriptDate(item.Date);

            });

          
            BillingService.SavePayment($scope.Payment, $scope.InvoicePaymentList, advancePayment, $scope.ReconcileAmount)
            .success(function (data) {

                console.log(data);
                // $scope.Invoice.Id = data;
                // $modalInstance.close({ Invoice: $scope.Invoice, });

                $scope.Invoice.DueDate = ToJavaScriptDate($scope.Invoice.DueDate);
                $scope.Invoice.InvoiceDate = ToJavaScriptDate($scope.Invoice.InvoiceDate);

               BillingService.SaveInvoice($scope.Invoice, $scope.PatientServiceItem)
                    .success(function (data) {

                        console.log(data);
                        $scope.Invoice = data;
                        $scope.Invoice.InvoiceDate = ToJavaScriptDate($scope.Invoice.InvoiceDate);
                        $modalInstance.dismiss('cancel');


                    })
                    .error(function (error) {
                        $scope.status = 'Unable to save PatientServiceItem data: ' + error.message;
                        console.log($scope.status);

                    });










            })
            .error(function (error) {
                $scope.status = 'Unable to save Payment data: ' + error.message;
                console.log($scope.status);
            });
            
        }





    };
    $scope.cancel = function () {

        $modalInstance.dismiss('cancel');
    };



});


HmsApp.controller("AdvancePaymentModalController", function ($scope, $modalInstance, $filter, BillingService) {


    $scope.PaymentMethod = "1";

    $scope.Payment = {

        Amount: 0.0,
        DeductionAmount: 0.0,
        PaymentTypeId: 103,
        PatientID: $scope.Patient.Id,
        UserId: null,
        Date: $filter('date')(new Date(), 'MM/dd/yy hh:mm:ss'),
        PaymentMethodId: $scope.PaymentMethod,
        CardNumber: null



    };


    $scope.ok = function (file) {

        //  set payment method & card number
        $scope.Payment.PaymentMethodId = $scope.PaymentMethod;
        if ($scope.CardNumber != "1") {
            $scope.Payment.CardNumber = $scope.CardNumber;
        }


        BillingService.SaveAdvancePayment($scope.Payment)
                .success(function (data) {


                    $modalInstance.dismiss('cancel');


                }).error(function (error) {
                    $scope.status = 'Unable to save Avance payment data: ' + error.message;
                    console.log($scope.status);

                });



        //$modalInstance.close();
    };
    $scope.cancel = function () {
        $modalInstance.dismiss('cancel');
    };


});