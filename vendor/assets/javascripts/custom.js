$('#search').keyup(function(e){

  // e.keyCode == 13 , for handle button enter

  if(e.keyCode == 13) {

    $.ajax({

      url : '/articles',

      type : 'GET',

      dataType : 'script',

      data : {

        "search" : $(this).val()

      }

    });

  }

});