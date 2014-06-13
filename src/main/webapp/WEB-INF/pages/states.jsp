<!doctype html>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html ng-app="angulartestApp">
<head>
    <meta charset="utf-8">
    <title>Demo Application</title>

    <meta content="IE=edge,chrome=1" http-equiv="X-UA-Compatible">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <link href="http://getbootstrap.com/dist/css/bootstrap.min.css" rel="stylesheet">
</head>

<body ng-controller="AngularTestCtrl">
<div class="container">
    <h3>Choose a state to find it's region:</h3>

    <select ng-model='state' ng-change="callShowRegion(state)" class="form-control">
        <option value="">Select a state...</option>
        <option ng-repeat="state in states">{{state.name}}</option>
    </select>

    <hr/>

    <p id="stateRegion" class="lead"></p>
</div>

<script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
<script src="//ajax.googleapis.com/ajax/libs/angularjs/1.2.17/angular.min.js"></script>
<script>

    var stateList = [];

    angular.
        module('angulartestApp', []).
        controller('AngularTestCtrl', ['$scope', 'showRegion', function ($scope, showRegion) {
            stateList = getStateList();
            $scope.states = stateList;
            $scope.callShowRegion = function(stateName) {
                showRegion(stateName);
            };
        }]).
        factory('showRegion', ['$window', function(win) {
            return function(stateName) {
                $("#stateRegion").text( getRegionForState(stateName) );
            };
        }]);

    function getRegionForState(stateName) {
        var matches = $.grep(stateList, function(e){ return e.name == stateName; });
        return matches.length==1 ? matches[0].region : '';
    }

    // Retrieve states from server - not async!
    function getStateList() {
        var stateList = [];
        $.ajax({
            dataType: "json",
            url: "api/states",
            async: false,
            success: function( data ) {
                stateList = data;
            }
        });
        return stateList;
    }

</script>

</body>
</html>