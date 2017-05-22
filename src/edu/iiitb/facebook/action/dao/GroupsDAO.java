package edu.iiitb.facebook.action.dao;

import java.io.FileInputStream;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import edu.iiitb.facebook.action.model.Event;
import edu.iiitb.facebook.action.model.Group;
import edu.iiitb.facebook.action.model.NewsFeed;
import edu.iiitb.facebook.action.model.User;

public interface GroupsDAO {
	
	String CURRENT_COVER_PIC = "groupphoto";

	public void createGroup(Connection cn, ArrayList<Integer> ids1, String grpName,int userID) throws SQLException;

	public ArrayList<User> searchMembers(Connection cn) throws SQLException; 
	
	public ArrayList<Group> groupDetails(Connection cn,int id)throws SQLException;
	
	public ArrayList<Group> groupName(Connection cn,int id)throws SQLException;

	public List<User> getGroupMembersList(int groupID)throws SQLException;
	
	public void LeaveGroup(Connection cn,int userID,int grpID)throws SQLException;
	
	public ArrayList<User> searchMembersNotAlereadyAdded(Connection cn,int grpID) throws SQLException; 

	public void extraMembers(Connection cn, ArrayList<Integer> ids1,int grpID) throws SQLException;

	public String setCoverImageByGroupId(int GroupID, FileInputStream inputStream)throws SQLException;
	
	Group getGroupImageByGrpId(int grpID) throws SQLException;

	public int GroupPostbyGroupMember(int userId,int grpID, String status);
	
//	public ArrayList<NewsFeed> getGroupNewsFeedsForUser(Connection cn,int userId,int grpID);
	
}
