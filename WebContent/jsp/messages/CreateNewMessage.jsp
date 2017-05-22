
<div class="row">
	<div id="other-participants-div" class="col-lg-6" align="left">
		<b>New Message</b>
	</div>
	<div id="action-buttons-div" class="col-lg-6" align="right">
		<input type="button" class="btn-success" id="new-message-button" onclick="createNewMessage()" value="+ New Message"/>
	</div>
</div>
<hr>

<div id="AllMessages">
	<div class="row" id="remove-this-after1">
		<div class="col-lg-6" align="left">
			<input type="text" class="form-control" id="recipients-text" name="name" onkeyup="search()" placeholder="Name"/>
		</div>
	</div>
	<div class="row" id="remove-this-after2">
		<div id="friendList" class="col-lg-6" align="left">
		</div>
	</div>	
	<div id="conversations-row" class="col-lg-12" align="right">
			<!-- <div id="receiver">
			</div>
			<br>	
			<div id="sender">
			</div> -->
	</div>
	<div id="fix-at-bottom">
		<div id="write-message" class="row">
			<div class="col-lg-12" align="center">
				<textarea id="new-message-textarea" name="messageText" class="form-control" cols="96" rows="4" placeholder="Write a message..."></textarea>
			</div>
		</div>
		<div id="send-message" class="col-lg-12" align="right">
			<input id="send-button" class="btn-success" onclick="SendMessage()" type="button" value="Send" />
		</div>
	</div>
</div>
