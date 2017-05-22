package edu.iiitb.facebook.action.model;

import java.io.FileInputStream;
import java.io.InputStream;

public class Group
{
	private String groupName;
	private int groupID;
	private String groupDescription;
	private String groupPlace;
	private String groupDate;
	private String groupTime;
	private InputStream groupCoverPic;
	
	public Group(
			String groupName,
			int groupID,
			String groupDescription,
			String groupPlace,
			String groupDate,
			String groupTime)
	{
		this.setGroupName(groupName);
		this.setGroupID(groupID);
		this.setGroupDescription(groupDescription);
		this.setGroupPlace(groupPlace);
		this.setGroupDate(groupDate);
		this.setGroupTime(groupTime);
	}

	public Group() {
		// TODO Auto-generated constructor stub
	}

	public String getGroupName() {
		return groupName;
	}

	public void setGroupName(String groupName) {
		this.groupName = groupName;
	}

	public String getGroupDescription() {
		return groupDescription;
	}

	public void setGroupDescription(String groupDescription) {
		this.groupDescription = groupDescription;
	}

	public String getGroupPlace() {
		return groupPlace;
	}

	public void setGroupPlace(String groupPlace) {
		this.groupPlace = groupPlace;
	}

	public String getGroupDate() {
		return groupDate;
	}

	public void setGroupDate(String groupDate) {
		this.groupDate = groupDate;
	}

	public String getGroupTime() {
		return groupTime;
	}

	public void setGroupTime(String groupTime) {
		this.groupTime = groupTime;
	}

	public int getGroupID() {
		return groupID;
	}

	public void setGroupID(int groupID2) {
		this.groupID = groupID2;
	}
	public InputStream getGroupCoverPic() {
		return groupCoverPic;
	}
	public void setGroupCoverPic(InputStream inputStream) {
		this.groupCoverPic = inputStream;
	}	
}