# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->
  $(".tabs").tabs
  $(".alert-message").effect "fade", "", 4000 
  $("#transfer_date").datepicker dateFormat: "yy-mm-dd"

  $("span[id$=budget]").bind "ajax:success", ->
    sum = 0
    $("span[id$=budget]").each ->
      sum += parseFloat($(this).attr("data-original-content"))
    $("#total_monthly_budget").text(sum) 
