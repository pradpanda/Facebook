package edu.iiitb.facebook.action.messages;

import java.sql.Timestamp;

public class Friend {

	private int friendUserId;
	private String friendFname;
	private String friendLname;
	private String messagedetails;
	private Timestamp timestampMessage;
	
	public String getMessagedetails() {
		return messagedetails;
	}
	public void setMessagedetails(String messagedetails) {
		this.messagedetails = messagedetails;
	}
	public Timestamp getTimestampMessage() {
		return timestampMessage;
	}
	public void setTimestampMessage(Timestamp timestampMessage) {
		this.timestampMessage = timestampMessage;
	}
	public int getFriendUserId() {
		return friendUserId;
	}
	public void setFriendUserId(int friendUserId) {
		this.friendUserId = friendUserId;
	}
	public String getFriendFname() {
		return friendFname;
	}
	public void setFriendFname(String friendFname) {
		this.friendFname = friendFname;
	}
	public String getFriendLname() {
		return friendLname;
	}
	public void setFriendLname(String friendLname) {
		this.friendLname = friendLname;
	}
}
