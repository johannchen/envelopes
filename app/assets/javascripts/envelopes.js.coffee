# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->
  $(".alert").prependTo('section').effect "fade", "", 4000 
  $("#transfer_date").datepicker dateFormat: "yy-mm-dd"

  $("#monthly_envelopes").find("span[id$=budget]").bind "ajax:success", ->
    $(this).parent().siblings().find("meter").attr("max", $(this).attr("data-original-content")) 
    sum = 0
    $("#monthly_envelopes").find("span[id$=budget]").each ->
      sum += parseFloat($(this).attr("data-original-content"))
    $("#total_monthly_budget").text(sum).formatCurrency() 

  $("#annual_envelopes").find("span[id$=budget]").bind "ajax:success", ->
    $(this).parent().siblings().find("meter").attr("max", $(this).attr("data-original-content")) 
    sum = 0
    $("#annual_envelopes").find("span[id$=budget]").each ->
      sum += parseFloat($(this).attr("data-original-content"))
    $("#total_annual_budget").text(sum).formatCurrency() 
