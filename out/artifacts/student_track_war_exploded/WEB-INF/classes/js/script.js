$('.btn').click(function(){
  var buttonId = "two";
  console.log(buttonId);
  $('#modal-container').removeAttr('class').addClass(buttonId);
  $('body').addClass('modal-active');
  tableContent="";
  tableContent = '<button  class="btn1">确定</button>';
  $("#content").append(tableContent);
})

$('#modal-container').click(function(){
  $(this).addClass('out');
  $('body').removeClass('modal-active');
});