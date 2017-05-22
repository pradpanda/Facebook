$(document).ready(function(){
    $.ajax({url: "getMessageLeftDiv", success: function(result){
        $("#conversations-div").html(result);
    }});
}); 