﻿'use strict';

HmsApp.controller("ModalController", function ($scope, $modalInstance, patient, PatientService) {
    $scope.Patient = {};
    $scope.ok = function () {
        $modalInstance.close($scope.Patient);
    };
    $scope.cancel = function () {
        $modalInstance.dismiss('cancel');
    };
    $scope.Files = [];
    $scope.LoadFileData = function (files) {
        console.log(files[0].type);
       $scope.Patient.Photo = files[0].name;
    };
    $scope.UploadPhoto = function () {

        PatientService.UploadPhoto($scope.Patient)
    }
});