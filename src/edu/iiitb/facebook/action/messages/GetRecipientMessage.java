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


public class GetRecipientMessage extends ActionSupport implements SessionAware
{
	private String id=null;
	private String message=null;
	private String lastTimestamp=null;
	private Map<String, Object> session;
	private ArrayList<Friend> RecipientMessages=new ArrayList<Friend>();
	Connection conn;
	PreparedStatement ps;
	ResultSet rs;

	public String getRecipientMessage() throws ParseException, SQLException
	{
		if(id!=null && id!="")
		{
			//message="Hello";
			conn=ConnectionPool.getConnection();
			int userid=Integer.parseInt(session.get("profileReference").toString());
			//converting String lastTimestamp to timestamp
			DateFormat readFormat = new SimpleDateFormat( "dd/MM/yyyy HH:mm:ss");
			DateFormat writeFormat = new SimpleDateFormat( "yyyy-MM-dd HH:mm:ss");
		    Date date = null;
		    date = readFormat.parse(lastTimestamp);
		    String formattedDate = "";
		    if( date != null )
		    {
		    	formattedDate = writeFormat.format( date );
		    }
		    //System.out.println(formattedDate);
			//SimpleDateFormat dateFormat = new SimpleDateFormat("dd/mm/yyyy hh:mm:ss.SSS");
			Date parsedDate = writeFormat.parse(formattedDate);
			Timestamp timestamp = new java.sql.Timestamp(parsedDate.getTime());
			
			ps=conn.prepareStatement(Constants.GET_RECIPIENT_MESSAGES);
			ps.setTimestamp(1,timestamp);
			ps.setInt(2,userid);
			ps.setInt(3, Integer.parseInt(id));
			rs=ps.executeQuery();
			while (rs.next()) {
				Friend recipientMessages=new Friend();
				recipientMessages.setTimestampMessage(rs.getTimestamp(1));
				recipientMessages.setMessagedetails(rs.getString(2));
				setRecipientMessages(recipientMessages);
			}
			//System.out.println(timestamp);
			//System.out.println(message);
			//System.out.println(id);
			ConnectionPool.freeConnection(conn);
		}
		return "success";
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}
	public String getLastTimestamp() {
		return lastTimestamp;
	}
	public void setLastTimestamp(String lastTimestamp) {
		this.lastTimestamp = lastTimestamp;
	}
	public Map<String, Object> getSession() {
		return session;
	}
	public void setSession(Map<String, Object> session) {
		this.session = session;
	}
	public ArrayList<Friend> getRecipientMessages() {
		return RecipientMessages;
	}
	public void setRecipientMessages(Friend recipient) {
		RecipientMessages.add(recipient);
	}
}