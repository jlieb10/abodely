// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require vendor
//= require app
//= require ui
//= require jquery.bxslider
//= require_self

$(document).ready(function(){
  $('input.con, input.pro').change(function(){
    var form = $(this.form);

    var data = {
      authenticity_token: form.find("input[name='authenticity_token']").val(),
      detail: {procon: $(this).val()}
    };

    $.ajax({
      type: 'Put',
      url: form.attr('action'),
      data: data,
      dataType: 'json'
    }).success(function(data){
if (data.procon === "pro") {
  form.parents(".page-tasks .task-list .view").removeClass("con-label");
  form.parents(".page-tasks .task-list .view").addClass("pro-label");
}
else {
  form.parents(".page-tasks .task-list .view").removeClass("pro-label");
  form.parents(".page-tasks .task-list .view").addClass("con-label");
}
});
  });

  $('.addnewapt').click(function(){
    var form = $('.apt-form')
    $('tbody.apartments').append(form)
  });

  $('select.status').change(function(){
    $.ajax({
      type: 'Put',
      url: "/apartments/" + $(this).attr('id'),
      data: {"authenticity_token" : $("meta").last().attr("content"),
      "apartment" : {"status" : $("option:selected", this).text()}
    },
    dataType: 'json',
    success: function(data) {
      $("#" + data.id + ".status_success").fadeIn(500);
      $("#" + data.id + ".status_success").html("Status updated!");
      $("#" + data.id + ".status_success").fadeOut(2000);
    }
  });
  });

//add apt form opens when the side nav link is clicked
$("a span.newapt").click(function(){
  console.log("Clicked");
  $("div .newaptcollapse").addClass("in").animate({height: "auto"},1500);
});

//add hunt form opens when the side nav link is clicked
$("a span.newhunt").click(function(){
  console.log("Clicked");
  $("div .newhuntcollapse").addClass("in").animate({height: "auto"},1500);
});

$('.bxslider').bxSlider({
  minSlides: 1,
  maxSlides: 1,
  slideWidth: 500,
  slideMargin: 5,
  adaptiveHeight: true,
  mode: 'fade'
});

var geocoder;
var map;
var markersArray = [];
var bounds;
var address = $('#address').text();
var locationsArray = [];
var infowindow = new google.maps.InfoWindow();

function initialize() {
  address = $('#address').text();
  geocoder = new google.maps.Geocoder();
  bounds = new google.maps.LatLngBounds ();

  var myOptions = {
    maxZoom: 15,

    mapTypeId: google.maps.MapTypeId.ROADMAP,
    navigationControlOptions: {
      style: google.maps.NavigationControlStyle.SMALL
    }
  };
  map = new google.maps.Map(document.getElementById("map_canvas"), myOptions);

  codeAddresses(address);
}

function codeAddresses(address){
  geocoder.geocode( { 'address': address}, function(results, status) {
    if (status == google.maps.GeocoderStatus.OK) {
      marker = new google.maps.Marker({
        map: map,
        position: results[0].geometry.location
      });

      google.maps.event.addListener(marker, 'click', function() {
        infowindow.setContent(address);
        infowindow.open(map, this);
      });

      bounds.extend(results[0].geometry.location);

      markersArray.push(marker);
    }

    else {
      alert("Geocode was not successful for the following reason: " + status);
    }

    map.fitBounds(bounds);
  });
}

$(function() {
  google.maps.event.addDomListener(window, 'load', initialize);
});
});