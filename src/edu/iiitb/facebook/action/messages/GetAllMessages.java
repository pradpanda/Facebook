package edu.iiitb.facebook.action.messages;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Map;

import org.apache.struts2.interceptor.SessionAware;
import edu.iiitb.facebook.util.ConnectionPool;
import edu.iiitb.facebook.util.Constants;

import com.opensymphony.xwork2.ActionSupport;

public class GetAllMessages extends ActionSupport implements SessionAware
{
	private String friendId;
	private String friendName;
	private ArrayList<Friend> GetAllMessagesList=new ArrayList<Friend>();
	Connection conn;
	PreparedStatement ps;
	ResultSet rs;
	private Map<String, Object> session;
	
	public String getAllMessages() throws SQLException
	{
		//System.out.println("Hi"+friendId);
		conn=ConnectionPool.getConnection();
		int userid=Integer.parseInt(session.get("profileReference").toString());
		ps=conn.prepareStatement(Constants.GET_ALL_MESSAGES);
		ps.setInt(1,Integer.parseInt(friendId));
		ps.setInt(2,userid);
		ps.setInt(3,Integer.parseInt(friendId));
		ps.setInt(4,userid);
		
		rs=ps.executeQuery();
		while (rs.next()) {
			Friend AllMessages=new Friend();
			AllMessages.setMessagedetails(rs.getString(1));
			AllMessages.setTimestampMessage(rs.getTimestamp(2));
			if(rs.getInt(3)!=userid)
				AllMessages.setFriendUserId(rs.getInt(3));
			setGetAllMessagesList(AllMessages);
		}
		//System.out.println(timestamp);
		//System.out.println(message);
		//System.out.println(id);
		ConnectionPool.freeConnection(conn);
		return "success";
	}
	
	public String getFriendId() {
		return friendId;
	}

	public void setFriendId(String friendId) {
		this.friendId = friendId;
	}

	public String getFriendName() {
		return friendName;
	}

	public void setFriendName(String friendName) {
		this.friendName = friendName;
	}
	public Map<String, Object> getSession() {
		return session;
	}

	public void setSession(Map<String, Object> session) {
		this.session = session;
	}

	public ArrayList<Friend> getGetAllMessagesList() {
		return GetAllMessagesList;
	}

	public void setGetAllMessagesList(Friend MessagesList) {
		GetAllMessagesList.add(MessagesList);
	}


}