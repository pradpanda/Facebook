package edu.iiitb.facebook.action.event;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Calendar;
import java.sql.Connection;
import java.sql.Timestamp;
import java.util.Map;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Calendar;
import java.sql.Connection;
import java.sql.Timestamp;
import java.util.Map;

import javax.naming.NamingException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.FileUtils;
import org.apache.struts2.ServletActionContext;
import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;
import org.apache.struts2.interceptor.SessionAware;

import com.opensymphony.xwork2.ActionSupport;

//import edu.iiitb.facebook.event.displayevent;
import edu.iiitb.facebook.util.ConnectionPool;
import org.omg.CORBA.PRIVATE_MEMBER;

public class createevent extends ActionSupport implements SessionAware, ServletResponseAware, ServletRequestAware {
	private Map<String, Object> session;
	private String eventtitle;
	private String eventdescription;
	private String eventplace;
	private String eventdate;
	private String eventtime;
	private String ufirstname;
	private String ulastname;
	private Integer eventid;
	private Integer gcount;
	private Integer maybecount;
	private Integer invitecount;
	private Integer currentuserloggedin;
	
	ArrayList<displayevent>  diseve =new ArrayList<displayevent>();
	
	
	public String execute(){
		System.out.println("kksksexecute");
		return "success";
	}
	
	public String newevent() throws SQLException{
		
		//System.out.println(getEventdate());
		//System.out.println(getEventdescription());
		//System.out.println(getEventplace());
		//System.out.println(getEventtime());
		//System.out.println(getEventtitle());
		System.out.println("In new event........");
		setCurrentuserloggedin(Integer.parseInt(session.get("profileReference").toString()));
		System.out.println(getCurrentuserloggedin());
		String new_event;
		ConnectionPool data=new ConnectionPool();
		java.sql.Connection con= data.getConnection();
		PreparedStatement ps;
	
		new_event = "insert into events(eventtitle,eventdescription,eventplace,eventtime,eventdate,createdby) values(?,?,?,?,?,?)";

		ps = con.prepareStatement(new_event);
		ps.setString(1,getEventtitle());
		ps.setString(2,getEventdescription());
		ps.setString(3,getEventplace());
		ps.setString(4,getEventtime());
		ps.setString(5,getEventdate());
		ps.setInt(6,getCurrentuserloggedin());//user id placed karna hai....
		System.out.println("here");
		ps.execute();
		//ConnectionPool.freeConnection(con);
		//ServletActionContext.getResponse().addHeader("msg", "Data Has been Inserted Sucessfully");
		
		//ConnectionPool data1=new ConnectionPool();
		//java.sql.Connection conn= data.getConnection();
		PreparedStatement preparedStatement;
		ResultSet rs;
		int count = 0;
		String fetch_details = "select ufirstname,ulastname,eventtitle,eventdescription,eventplace,eventtime,eventdate,eventid from user,events where userid =? and createdby=? order by eventid desc limit 1;";
		preparedStatement = con.prepareStatement(fetch_details);
		preparedStatement.setInt(1,getCurrentuserloggedin());//userid
		preparedStatement.setInt(2,getCurrentuserloggedin());//created id
		rs = preparedStatement.executeQuery();
		
		if(rs.next())
		{
			System.out.println(rs.getString("ufirstname"));
			System.out.println(rs.getString("ulastname"));
			System.out.println(rs.getString("eventtitle"));
			System.out.println(rs.getString("eventdescription"));
			System.out.println(rs.getString("eventplace"));
			System.out.println(rs.getString("eventtime"));
			System.out.println(rs.getString("eventdate"));
			setUfirstname(rs.getString("ufirstname"));
			setUlastname(rs.getString("ulastname"));
			setEventtitle(rs.getString("eventtitle"));
			setEventdescription(rs.getString("eventdescription"));
			setEventtime(rs.getString("eventtime"));
			setEventdate(rs.getString("eventdate"));
			setEventplace(rs.getString("eventplace"));
			setEventid(rs.getInt("eventid"));
		}
		
		
		
		return "success";
	}
	
	public String cancelevent() throws SQLException{
		System.out.println("kksksjkjk");
		return "success";
	}
	
	public String deleteevent() throws SQLException{
		//System.out.println(getEventid());
		//System.out.println(getEventplace());
		//System.out.println(getEventtitle());
		
		ConnectionPool data=new ConnectionPool();
		java.sql.Connection con= data.getConnection();
		String delete_event = "delete from event_invitees where eventid=?;";
		PreparedStatement preparedStatement = con.prepareStatement(delete_event);
		preparedStatement.setInt(1,getEventid());
		preparedStatement.execute();
		
		String delete_event2 = "delete from events where eventid=?;";
		PreparedStatement preparedStatement2 = con.prepareStatement(delete_event2);
		preparedStatement2.setInt(1,getEventid());
		preparedStatement2.execute();
		
		data.freeConnection(con);
		
		return "success";
	}
	
	public String updateevent() throws SQLException{
		System.out.println("I m in update event");
		System.out.println(getEventid());
		System.out.println(getEventplace());
		System.out.println(getEventtitle());
		System.out.println(getEventdate());
		System.out.println(getEventtime());
		System.out.println(getEventdescription());
		
		ConnectionPool data=new ConnectionPool();
		java.sql.Connection con= data.getConnection();
		String update_event = "update events set eventtitle=?,eventplace=?,eventdescription=?,eventdate=?,eventtime=? where eventid=?;";
		PreparedStatement ps = con.prepareStatement(update_event);
		ps.setString(1,getEventtitle());
		ps.setString(2,getEventplace());
		ps.setString(3,getEventdescription());
		ps.setString(4,getEventdate());
		ps.setString(5,getEventtime());
		ps.setInt(6,getEventid());
		
		ps.execute();
		
		System.out.println("Update is done.......");
		return "success";
		}
	

	
	
	
	
	
	
	
	public String getEventtitle() {
		return eventtitle;
	}

	public void setEventtitle(String eventtitle) {
		this.eventtitle = eventtitle;
	}

	public String getEventdescription() {
		return eventdescription;
	}

	public void setEventdescription(String eventdescription) {
		this.eventdescription = eventdescription;
	}

	public String getEventplace() {
		return eventplace;
	}

	public void setEventplace(String eventplace) {
		this.eventplace = eventplace;
	}

	public String getEventdate() {
		return eventdate;
	}

	public void setEventdate(String eventdate) {
		this.eventdate = eventdate;
	}

	public String getEventtime() {
		return eventtime;
	}

	public void setEventtime(String eventtime) {
		this.eventtime = eventtime;
	}

	public String getUfirstname() {
		return ufirstname;
	}

	public void setUfirstname(String ufirstname) {
		this.ufirstname = ufirstname;
	}

	public String getUlastname() {
		return ulastname;
	}

	public void setUlastname(String ulastname) {
		this.ulastname = ulastname;
	}

	public Integer getEventid() {
		return eventid;
	}

	public void setEventid(Integer eventid) {
		this.eventid = eventid;
	}

	public Integer getGcount() {
		return gcount;
	}

	public void setGcount(Integer gcount) {
		this.gcount = gcount;
	}
	
	public Integer getMaybecount() {
		return maybecount;
	}

	public void setMaybecount(Integer maybecount) {
		this.maybecount = maybecount;
	}

	public Integer getInvitecount() {
		return invitecount;
	}

	public void setInvitecount(Integer invitecount) {
		this.invitecount = invitecount;
	}
	@Override
	public void setSession(Map<String, Object> session) {
		this.session = session;
	}
	@Override
	public void setServletRequest(HttpServletRequest arg0) {
		// TODO Auto-generated method stub
		
	}
	@Override
	public void setServletResponse(HttpServletResponse arg0) {
		// TODO Auto-generated method stub
		
	}
	public Map<String, Object> getSession() {
		return session;
	}

	public Integer getCurrentuserloggedin() {
		return currentuserloggedin;
	}

	public void setCurrentuserloggedin(Integer currentuserloggedin) {
		this.currentuserloggedin = currentuserloggedin;
	}
	
}
