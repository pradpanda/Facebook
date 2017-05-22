package edu.iiitb.facebook.action.messages;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Map;

import org.apache.struts2.interceptor.SessionAware;
import edu.iiitb.facebook.util.ConnectionPool;
import edu.iiitb.facebook.util.Constants;

import com.opensymphony.xwork2.ActionSupport;

public class SendMessage extends ActionSupport implements SessionAware
{
	private String recipientId;
	private String text;
	private String datetime;
	private Map<String, Object> session;
	private ArrayList<Friend> lastFriendMessage=new ArrayList<Friend>();
	Connection conn;
	PreparedStatement ps;
	ResultSet rs;
	
	public String sendMessage() throws SQLException, ParseException
	{
		int newMessageId = 0;
		int userid=Integer.parseInt(session.get("profileReference").toString());
		//System.out.println(userid);
		conn=ConnectionPool.getConnection();
		
		DateFormat readFormat = new SimpleDateFormat( "dd/MM/yyyy HH:mm:ss");
		DateFormat writeFormat = new SimpleDateFormat( "yyyy-MM-dd HH:mm:ss");
	    Date date = null;
	    date = readFormat.parse(datetime);
	    String formattedDate = "";
	    if( date != null )
	    {
	    	formattedDate = writeFormat.format( date );
	    }
	    //System.out.println(formattedDate);
		//SimpleDateFormat dateFormat = new SimpleDateFormat("dd/mm/yyyy hh:mm:ss.SSS");
		Date parsedDate = writeFormat.parse(formattedDate);
		Timestamp timestamp = new java.sql.Timestamp(parsedDate.getTime());
		//System.out.println(timestamp);
		//store the messages in the database.
		ps=conn.prepareStatement(Constants.SEND_MESSAGE);
		ps.setInt(1,userid);
		ps.setInt(2,Integer.parseInt(recipientId));
		ps.setString(3, text);
		ps.setTimestamp(4, timestamp);
		ps.executeUpdate();
		//System.out.println(text);
		//GET the message id for the last message.
		ps=conn.prepareStatement(Constants.GET_MESSAGE_ID);
		rs=ps.executeQuery();
		if (rs.next()) {
			rs.last();
			newMessageId = rs.getInt(1);
		}
		//store the notifications for messages.
		ps=conn.prepareStatement(Constants.MESSAGE_NOTIFY);
		ps.setInt(1,newMessageId);
		ps.setInt(2,Integer.parseInt(recipientId));
		ps.setString(3, text);
		ps.setTimestamp(4, timestamp);
		ps.executeUpdate();
		
		//get last messages for left div.
		ps=conn.prepareStatement(Constants.GET_LAST_MESSAGES);
		ps.setInt(1,userid);
		ps.setInt(2,userid);
		rs=ps.executeQuery();
		while(rs.next())
		{
			Friend lastMessage=new Friend();
			lastMessage.setFriendUserId(rs.getInt(1));
			lastMessage.setFriendFname(rs.getString(2));
			lastMessage.setFriendLname(rs.getString(3));
			lastMessage.setMessagedetails(rs.getString(4));
			lastMessage.setTimestampMessage(rs.getTimestamp(5));
			//System.out.println(rs.getTimestamp(5));
			setLastFriendMessage(lastMessage);
		}	
		
		//Removing previous messages for the same user. Only latest messages are preserved.
		for(int i=0;i<lastFriendMessage.size();i++)
		{
			int tobeRemoved=lastFriendMessage.get(i).getFriendUserId();
			for(int j=i+1;j<lastFriendMessage.size();j++)
			{
				if(lastFriendMessage.get(j).getFriendUserId()==tobeRemoved)
				{
					lastFriendMessage.remove(j);
				}
			}			
		}

		ConnectionPool.freeConnection(conn);
		return "success";
	}
	
	public String getLeftDiv() throws SQLException
	{
		//int userid_stub=1;
		//session.put("userid",userid_stub);
		int userid=Integer.parseInt(session.get("profileReference").toString());
		conn=ConnectionPool.getConnection();
		ps=conn.prepareStatement(Constants.GET_LAST_MESSAGES);
		ps.setInt(1,userid);
		ps.setInt(2,userid);
		rs=ps.executeQuery();
		while(rs.next())
		{
			Friend lastMessage=new Friend();
			lastMessage.setFriendUserId(rs.getInt(1));
			lastMessage.setFriendFname(rs.getString(2));
			lastMessage.setFriendLname(rs.getString(3));
			lastMessage.setMessagedetails(rs.getString(4));
			lastMessage.setTimestampMessage(rs.getTimestamp(5));
			//System.out.println(rs.getTimestamp(5));
			setLastFriendMessage(lastMessage);
		}	
		
		//Removing previous messages for the same user. Only latest messages are preserved.
		for(int i=0;i<lastFriendMessage.size();i++)
		{
			int tobeRemoved=lastFriendMessage.get(i).getFriendUserId();
			for(int j=i+1;j<lastFriendMessage.size();j++)
			{
				if(lastFriendMessage.get(j).getFriendUserId()==tobeRemoved)
				{
					lastFriendMessage.remove(j);
				}
			}			
		}

		ConnectionPool.freeConnection(conn);
		return "success";
	}
	public String getText() {
		return text;
	}
	public void setText(String text) {
		this.text = text;
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
	public String getRecipientId() {
		return recipientId;
	}
	public void setRecipientId(String recipientId) {
		this.recipientId = recipientId;
	}
	public ArrayList<Friend> getLastFriendMessage() {
		return lastFriendMessage;
	}
	public void setLastFriendMessage(Friend FriendMessage) {
		lastFriendMessage.add(FriendMessage);
	}

	public String getDatetime() {
		return datetime;
	}

	public void setDatetime(String datetime) {
		this.datetime = datetime;
	}

}