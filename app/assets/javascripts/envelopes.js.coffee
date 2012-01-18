# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->
  $(".tabs").tabs
  $(".alert-message").effect "fade", "", 2000 
  $("#transfer_date").datepicker dateFormat: "yy-mm-dd"

  $("span[id$=budget]").attr("data-original-content").change ->
    $("#total_monthly_budget").text("0")
