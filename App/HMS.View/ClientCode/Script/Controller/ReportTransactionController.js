﻿'use strict';


HmsApp.controller("ReportTransactionController", function ($scope, $routeParams, $window, $filter, $route, $modal, ReportTransactionService, IniService) {


    function init() {


        var tabClass = ".summary";
        if ($routeParams.tab != null) {
            tabClass = "." + $routeParams.tab;
        }
        $('.tabs li').removeClass('active');
        $(tabClass).addClass('active');
        $(tabClass).removeClass('hide');


    }
    /*------------------------- configuration begin -------------------------*/

    $scope.GetConfiguration = function () {

        IniService.GetConfiguration()
            .success(function (data) {

                $scope.Configuration = data;


                $scope.medicalTypeID = $scope.Configuration.Configuration.MedicalTypeDrug.toString();
                // $scope.SingleItem.MedicalTypeId = $scope.Configuration.Configuration.MedicalTypeDrug;
                $scope.NonRegisterPatientId = $scope.Configuration.Configuration.NonRegisterPatientId;
                $scope.ServiceProviderType = $scope.Configuration.Configuration.DoctorTypeId;
                // $scope.SingleItem.ItemTypeId = $scope.Configuration.Configuration.ServiceItem;
                $scope.medicalTypeIDLab = $scope.Configuration.Configuration.MedicalTypeLabTest.toString();

                init();

            }).error(function (error) {

                $scope.status = 'Unable to Discharge Admission: ' + error.message;
                console.log($scope.status);

            });

    }

    $scope.GetConfiguration();

    /*------------------------- configuration end -------------------------*/
});