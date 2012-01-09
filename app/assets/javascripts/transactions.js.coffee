# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
#

jQuery ->
  $("#transaction_date").datepicker dateFormat: 'yy-mm-dd'
  $("input[name=income]").change ->
    if $("input[name=income]").val() == 1
      $("#transaction_envelope").hide
    else
      $("#transaction_envelope").show
    
