var app = angular.module('myApp', ['ngTagsInput','toaster',]);
app.controller("TodoController", function($scope, $http)
{
  $scope.index = 0;
  $scope.tasks = {};
  $scope.tagslist = [];
  $scope.finish = [];
  $scope.object = {};
  $scope.id = {};

$scope.find=function (){
  alert($scope.tagfind);
  tagToSearch={tag: $scope.tagfind};
  $http({
    method : 'POST',
    url : 'todocontroller/search',
    data : tagToSearch,
  }).success(function (data){
    $scope.tasks=data;});
}

  $scope.list = function() {
    $http({
        method: 'GET',
        url: 'todocontroller/show_all'
      })
      .success(function(data) {
        $scope.tasks = data;
      });
      $scope.tagfind="";
  }

  $scope.addTask = function(form) {
    var myEl;

    if (form.$invalid) {
      console.log(form.$invalid);
      myEl = angular.element(document.querySelector('#addbtn'));
      myEl.attr('data-toggle', "");
      return;
    }
    $scope.newtask = $scope.newTask.name;
    myEl = angular.element(document.querySelector('#addbtn'));
    myEl.attr('data-toggle', "modal");
    return;
  }

/*$scope.pop = function()
  {
    toaster.pop({
                type: 'error',
                title: 'Title text',
                body: 'Body text',
                showCloseButton: true
            });
  };*/

  $scope.addData = function() {


    $scope.object = {
      name: $scope.newTask.name,
      desc: $scope.newTask.Description,
      tags: $scope.addMe,
      status: false
    };
    $http({
      method: 'POST',
      url: 'todocontroller/new',
      data: $scope.object,

    }).success(function (data){
      $scope.tasks=data;
    });

    $scope.newTask.Description = "";
    $scope.newTask.tag = '';
    $scope.newTask.name = '';

  }

  $scope.editTask = function($index)

  {

    $scope.ingidex = $index;
    // $scope.newTask.name = $scope.tasks[$index].task_name;
    // console.info($scope.tasks[$index].task_name);
    // alert($scope.newTask.name);
    $scope.editName=$scope.tasks[$index].task_name;
    $scope.editDetail = $scope.tasks[$index].description;
    angular.forEach($scope.tasks[$index].tags,function (value,key){
      $scope.tagslist.push(value.tag)
    });
    $scope.editTag = $scope.tagslist
    $scope.tagslist=[];
    alert($scope.editTag);

  }
  $scope.updateData = function()
  {

    $scope.tasks[$scope.index].task_name = $scope.editName;
    $scope.tasks[$scope.index].description = $scope.editDetail;
    var data =
    {
      id: $scope.tasks[$scope.index].id,
      name: $scope.tasks[$scope.index].task_name,
      desc: $scope.tasks[$scope.index].description,
      tags: $scope.editTag
    }

    console.info(data);

    $http({
      method : 'PUT',
      url : 'todocontroller/update_task',
      params : {data},
    })
    .success(function(data){
      $scope.tasks=data;
    });
    $scope.editName = "";
    $scope.editDetail = "";
    $scope.editTag = [];
    $scope.index = 0;
  }

  $scope.clear = function() {
    $scope.newTask.name = "";
    $scope.newTask.Description = "";
    $scope.addMe = [];
  }

  $scope.delTask = function($index)
  {
    $scope.id = $scope.tasks[$index];
    $http({
        method: 'POST',
        url: 'todocontroller/delete',
        data: $scope.id,
      })
      .success(function(data) {
        alert(data);
        $scope.tasks = data;
      //  console.log($scope.tasks[0].task_name);
        //alert($scope.tasks);
        alert("Task removed");
      });

  }

  $scope.removeCompleted = function()
  {
    $http({
          method : 'DELETE',
        url: 'todocontroller/delete_completed',

      })
      .success(function(data) {
        $scope.tasks = data;
      });
  }
  $scope.changeStatus = function($index)
  {
    $http({
        method: 'POST',
        url: 'todocontroller/toggle_status',
        data: $scope.tasks[$index],
      })
      .success(function(data) {
        $scope.tasks = data;
      });

  }
  $scope.showCompleted = function() {
    $http({
      method: 'GET',
      url: 'todocontroller/show_completed',

    }).success(function(data) {
      $scope.tasks = data;
    });
  }
  $scope.showIncomplete = function() {
    $http({
      method: 'GET',
      url: 'todocontroller/show_incomplete',

    }).success(function(data) {
      $scope.tasks = data;
    });
  }

});
