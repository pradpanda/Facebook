	window.setInterval(function(){
	  /// call your function here
		//alert("Hi");
		
		if($("#other-participants-div").text()==$("#dummyRecipientName").text())
		{
			//alert($("#other-participants-div").text()+" "+$("#dummyRecipientName").text());
			var received = $.post("RecipientMessage",{
				id: document.getElementById("recipientId").value,
				lastTimestamp: $('#conversations-row span.badge:last').text()
		    });
			received.done(function(response){
				
				//var receivedMessage = [];
				/*$.each(response, function(key, value){
					$("#conversations-row").append("<br><div class='receiver alert alert-info' align='left'>"+key + ":" + value + "</div>");
					var elem = document.getElementById('conversations-row');
					elem.scrollTop = elem.scrollHeight;
		        });*/
					$.each(response.RecipientMessages, function(index, recipient){
						//receivedMessage.push({ timestamp : recipient.timestampMessage, message : recipient.messagedetails });
						if(recipient.messagedetails!=null)
						{
							$("#conversations-row").append("<br>"+$("#conversations-row").html().trim()+"<div class='receiver alert alert-info' align='left'>"+recipient.messagedetails.trim()+"<br><span class='badge'>  "+recipient.timestampMessage+"</span>"+"</div>");
							//alert("Hi"+recipient.messagedetails.trim());
							var elem = document.getElementById('conversations-row');
							elem.scrollTop = elem.scrollHeight;
						}
					});
				
			});
		}
	}, 10000);
	window.setInterval(function(){
		var recipientIdNew=document.getElementById("recipientId").value;
		var dummyRecipientNameNew=document.getElementById("dummyRecipientName").value;
		if(dummyRecipientNameNew==$("#other-participants-div").text())
			document.getElementById(recipientIdNew+","+dummyRecipientNameNew).style.backgroundColor = "#6D84B4";
	}, 500);