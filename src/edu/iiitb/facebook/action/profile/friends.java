package edu.iiitb.facebook.action.profile;

public class friends {
	private int friendid;
	private String name;
	private String lastname;
	private int fofcount;
	
	public int getFofcount() {
		return fofcount;
	}
	public void setFofcount(int fofcount) {
		this.fofcount = fofcount;
	}
	public String getLastname() {
		return lastname;
	}
	public void setLastname(String lastname) {
		this.lastname = lastname;
	}
	
	public int getFriendid() {
		return friendid;
	}
	public void setFriendid(int friendid) {
		this.friendid = friendid;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	
}
