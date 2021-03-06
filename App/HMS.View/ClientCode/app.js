﻿'use strict';

// App Module: the name HMS matches the ng-app attribute in the main <html> tag
// the route provides parses the URL and injects the appropriate partial page
var HmsApp = angular.module('HMS', ['ngRoute', 'ui.bootstrap', 'ngFileUpload', 'ngLoadingSpinner', 'ngSanitize', 'ngStorage']).
  config(['$routeProvider', function ($routeProvider) {
      $routeProvider.
        when('/patient', {
            templateUrl: '/ClientCode/Template/PatientInfo.html',
        }).
        when('/patientResistration', {
            templateUrl: '/ClientCode/Template/EditPatient.html',
        }).
        when('/patientResistration/:id', {
            templateUrl: '/ClientCode/Template/EditPatient.html',
        }).
        when('/bedsetup', {
            templateUrl: '/ClientCode/Template/BedSetup.html',
        }).
        when('/bedsetup/:tab', {
            templateUrl: '/ClientCode/Template/BedSetup.html',
        }).
        when('/bedsetup/:tab/:id', {
            templateUrl: '/ClientCode/Template/BedSetup.html',
        }).

        when('/pharmacy', {
            templateUrl: '/ClientCode/Template/Pharmacy.html',
        }).
        when('/pharmacy/:tab', {
            templateUrl: '/ClientCode/Template/Pharmacy.html',
        }).
        when('/pharmacy/:tab/:id', {
            templateUrl: '/ClientCode/Template/pharmacy.html',
        }).
        when('/surgery', {
            templateUrl: '/ClientCode/Template/Surgery.html',
        }).
        when('/surgery/:tab', {
            templateUrl: '/ClientCode/Template/Surgery.html',
        }).
        when('/surgery/:tab/:id', {
            templateUrl: '/ClientCode/Template/Surgery.html',
        }).
        when('/doctor', {
            templateUrl: '/ClientCode/Template/Doctor.html',
        }).
        when('/doctor/:tab', {
            templateUrl: '/ClientCode/Template/Doctor.html',
        }).
        when('/doctor/:tab/:id', {
            templateUrl: '/ClientCode/Template/Doctor.html',
        }).
        when('/expense', {
            templateUrl: '/ClientCode/Template/Expense.html',
        }).
        when('/expense/:tab', {
            templateUrl: '/ClientCode/Template/Expense.html',
        }).
        when('/expense/:tab/:id', {
            templateUrl: '/ClientCode/Template/Expense.html',
        }).
        when('/billing', {
            templateUrl: '/ClientCode/Template/Billing.html',
        }).
        when('/billing/:tab', {
            templateUrl: '/ClientCode/Template/Billing.html',
        }).
        when('/appointment', {
            templateUrl: '/ClientCode/Template/Appointment.html',
        }).
        when('/appointment/:tab', {
            templateUrl: '/ClientCode/Template/Appointment.html',
        }).
        when('/labtest', {
            templateUrl: '/ClientCode/Template/LabTest.html',
        }).
        when('/labtest/:tab', {
            templateUrl: '/ClientCode/Template/LabTest.html',
        }).
        when('/labtest/:tab/:id', {
            templateUrl: '/ClientCode/Template/LabTest.html',
        }).
        when('/configuration', {
            templateUrl: '/ClientCode/Template/Configuration.html',
        }).
        when('/configuration/:tab', {
            templateUrl: '/ClientCode/Template/Configuration.html',
        }).
        when('/configuration/:tab/:id', {
            templateUrl: '/ClientCode/Template/Configuration.html',
        }).

      when('/admin', {
          templateUrl: '/ClientCode/Template/Admin.html',
      }).
      when('/admin/approval/:tab', {
          templateUrl: '/ClientCode/Template/Admin.html',
      }).
      when('/admin/patientsummaryreport/:tab', {
          templateUrl: '/ClientCode/Template/PatientSummaryReport.html',
      }).
      when('/report', {
          templateUrl: '/ClientCode/Template/ReportTransaction.html',
      }).
      when('/report/transaction/:tab', {
          templateUrl: '/ClientCode/Template/ReportTransaction.html',
      }).
      when('/contact/:id', {
            templateUrl: '/ClientCode/Template/EditContact.html',
            controller: 'ContactController'
        }).
        when('/contact', {
            templateUrl: '/ClientCode/Template/Contact.html',
            controller: 'ContactController'
        }).
        otherwise({
            redirectTo: '/patient'
        });
  }]);

//HmsApp.run(['$route', function ($route) {
//    $route.reload();
//}]);