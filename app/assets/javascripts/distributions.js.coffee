# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->
  $("#distribution_date").datepicker dateFormat: 'yy-mm-dd' 

  
  $("input[name*=transactions]").change ->
    sum = 0
    $("input[name*=transactions]").each ->
      sum += parseFloat($(this).val())
    $("#distribution_amount").val(sum)

