package edu.iiitb.facebook.action.messages;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Map;
import org.apache.struts2.interceptor.SessionAware;
import com.opensymphony.xwork2.ActionSupport;
import edu.iiitb.facebook.util.ConnectionPool;
import edu.iiitb.facebook.util.Constants;

public class SearchFriends extends ActionSupport implements SessionAware
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String name;
	private Map<String, Object> session;
	private ArrayList<Friend> friends=new ArrayList<Friend>();
	Connection conn;
	
	public String searchFriends() throws SQLException 
	{
		//stub used - temporary - remove afterwards.
		//int userid_stub=1;
		//session.put("userid",userid_stub);
		//search for friend
		//int userid=Integer.parseInt(session.get("userid").toString());
		int userid=Integer.parseInt(session.get("profileReference").toString());
		//System.out.println("In search");
		System.out.println(userid);
		conn=ConnectionPool.getConnection();
		PreparedStatement ps=conn.prepareStatement(Constants.GET_FRIEND_LIST);
		ps.setString(1,"%"+name+"%");
		ps.setString(2,"%"+name+"%");
		ps.setInt(3,userid);
		ps.setInt(4,userid);
		ps.setInt(5,userid);
		ps.setInt(6,userid);
		ResultSet rs=ps.executeQuery();	
		while(rs.next())
		{
			Friend friend_dto=new Friend();
			friend_dto.setFriendUserId(rs.getInt(1));
			friend_dto.setFriendFname(rs.getString(2));
			friend_dto.setFriendLname(rs.getString(3));
			//friends.add(friend_dto);
			//System.out.println(rs.getInt(1)+rs.getString(2));
			setFriends(friend_dto);
		}
		ConnectionPool.freeConnection(conn);
		//setFriends(friends);
		return "success";
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public Map<String, Object> getSession()
	{
		return session;
	}
	@Override
	public void setSession(Map<String, Object> session)
	{
		this.session = session;
	}
	public ArrayList<Friend> getFriends() {
		return friends;
	}
	public void setFriends(Friend friend) {
		friends.add(friend);
	}
}