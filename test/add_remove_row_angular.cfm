<!DOCTYPE html>
<html ng-app>
<head>
    <title>Add / List Data (AngularJS)</title>
    <style>
	    .list_data { margin-bottom: 2rem }
	    table, th, td { border: 1px solid #AAA }
	    th { cursor: pointer }
    </style>
</head>
  
<body ng-controller="RecordCtrl">
    <div class="list_data">
        <h1>List Data</h1>
        <table>
            <tr>
                <th ng-click="type = 'include'; reverse = !reverse">Status</th>
                <th ng-click="type = 'state'; reverse = !reverse">State</th>
                <th ng-click="type = 'price'; reverse = !reverse">Price</th>
                <th ng-click="type = 'tax'; reverse = !reverse">Tax</th>
                <th>Action</th>
            </tr>
            <tr ng-repeat="record in records | orderBy:type:reverse">
                <td><input type="checkbox" ng-model="record.include"></td>
                <td>{{record.state | uppercase}}</td>
                <td>{{record.price | currency}}</td>
                <td>{{record.tax | currency}}</td>
                <td><button ng-click="Delete($index)">Delete</button></td>
            </tr>
            <tr>
                <td colspan="2">Total</td>
                <td>{{Totals().price | currency}}</td>
                <td>{{Totals().tax | currency}}</td>
                <td>&nbsp;</td>
            </tr>
        </table>
        <button ng-show="history.length > 0" ng-click="Undo()">Undo Delete</button>
    </div>
  
    <div class="add_data">
        <h1>Add Data</h1>
        <form ng-submit="Add()">
            <div class="field">
                <label for="state">State: </label>
                <input id="state" type="text" placeholder="State" maxlength="2" ng-model="newState">
            </div>
            <div class="field">
                <label for="price">Price: </label>
                <input id="price" type="number" placeholder="Price" min="0" ng-model="newPrice">
            </div>
            <div class="field">
                <label for="tax">Tax: </label>
                <input id="tax" type="number" placeholder="Tax" min="0" ng-model="newTax">
            </div>
            <div class="action">
                <button type="submit">Add</button>
                <button ng-click="Reset()">Reset</button>
            </div>
        </form>
    </div>

	<script src="//ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
	<script src="//ajax.googleapis.com/ajax/libs/angularjs/1.2.11/angular.min.js"></script>
	<script>
	function RecordCtrl ($scope) {
        // Historical data
        $scope.history = [];
        // Default data (can be loaded from a database)
		$scope.records = [
			{ state: 'CA', price: 22, tax: 5, include: false },
			{ state: 'MA', price: 32, tax: 8, include: false }
		];
        // Total prices
		$scope.Totals = function () {
			var priceTotal = 0;
            var taxTotal = 0;
            // Loop through main records and calculate aggregate prices and taxes if include is true
			angular.forEach($scope.records, function (record) {
		        if (record.include) {
					priceTotal += record.price;
		            taxTotal += record.tax;
		        }
			});
            // Return aggregate data
            return { price: priceTotal , tax: taxTotal };
		};
        // Delete data
        $scope.Delete = function (index) {
            // Remove first / oldest element from history if it reaches maximum capacity of 10 records
            if ($scope.history.length === 10)
                $scope.history.shift();
            // Add deleted record to historical records
            $scope.history.push($scope.records[index]);
            // Remove from main records (using index)
            $scope.records.splice(index, 1);
        };
        // Reset new data model
        $scope.Reset = function () {
            $scope.newState = '';
            $scope.newPrice = 0;
            $scope.newTax = 0;
        }
        $scope.Reset();
        // Add new data
        $scope.Add = function () {
            // Do nothing if no state is entered (blank)
            if (!$scope.newState)
                return;
            // Add to main records
            $scope.records.push({
                state: $scope.newState,
                price: $scope.newPrice,
                tax: $scope.newTax,
                include: false
            });
            // See $Scope.Reset...
            $scope.Reset();
        }
        // Undo action (delete)
        $scope.Undo = function () {
            // Add last / most recent historical record to the main records
            $scope.records.push($scope.history[ $scope.history.length - 1 ]);
            // Remove last / most recent historical record
            $scope.history.pop();
        }
	}
	</script>
</body>
</html>