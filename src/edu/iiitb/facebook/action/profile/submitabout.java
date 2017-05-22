package edu.iiitb.facebook.action.profile;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;
import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;
import org.apache.struts2.interceptor.SessionAware;

import com.opensymphony.xwork2.ActionSupport;

import edu.iiitb.facebook.util.ConnectionPool;



public class submitabout extends ActionSupport   implements SessionAware, ServletResponseAware, ServletRequestAware{
	private int userid;
	
	
	
	
	
	public int getUserid() {
		return userid;
	}
	public void setUserid(int userid) {
		this.userid = userid;
	}
	//organization
	private Map<String, Object> session;
	private String organizationname;
	private String designation;
	private String workingfrom;
	private String workingto;
	//institute
	private String institutename;
	private String degree;
    private String studiedfrom;
    private String studiedto;
	// martial status
    private String martialstatus;
    //location
    private String homeplace;
    private String currentplace;
    //gender and dob
    private String udob;
    private String ugender;
	public String getHomeplace() {
		return homeplace;
	}
	public void setHomeplace(String homeplace) {
		this.homeplace = homeplace;
	}
	public String getCurrentplace() {
		return currentplace;
	}
	public void setCurrentplace(String currentplace) {
		this.currentplace = currentplace;
	}
	public String getMartialstatus() {
		return martialstatus;
	}
	public void setMartialstatus(String martialstatus) {
		this.martialstatus = martialstatus;
	}
	public String getInstitutename() {
		return institutename;
	}
	public void setInstitutename(String institutename) {
		this.institutename = institutename;
	}
	public String getDegree() {
		return degree;
	}
	public void setDegree(String degree) {
		this.degree = degree;
	}
	public String getStudiedfrom() {
		return studiedfrom;
	}
	public void setStudiedfrom(String studiedfrom) {
		this.studiedfrom = studiedfrom;
	}
	public String getStudiedto() {
		return studiedto;
	}
	public void setStudiedto(String studiedto) {
		this.studiedto = studiedto;
	}
	
	public String execute() throws SQLException
	{
		//System.out.println(Integer.parseInt(ServletActionContext.getRequest().getSession().getAttribute("userid").toString()));
		setUserid(Integer.parseInt(session.get("profileReference").toString()));
		String m = null;
		ConnectionPool data=new ConnectionPool();
		java.sql.Connection con= data.getConnection();
		System.out.println(getOrganizationname());
		if( (getCurrentplace()!=null))
			
		{
			System.out.println(getHomeplace()+"hghh");
		PreparedStatement st;
			
		    st=con.prepareStatement("update profile set currentplace=?,homeplace=? where userid=?"); 
		    st.setInt(3,userid);
		    
		    st.setString(1,getCurrentplace());
		    st.setString(2,getHomeplace());
		   
		    st.execute();
		    ConnectionPool.freeConnection(con);
		}
		else if(getMartialstatus()!=null)
		{
		PreparedStatement st;
			System.out.println(getMartialstatus());
			System.out.println("the userid is" + userid);
		    st=con.prepareStatement("update profile set martialstatus=?  where userid=?"); 
		    st.setString(1,getMartialstatus());
		    st.setInt(2, userid);
		    st.execute();
		    ConnectionPool.freeConnection(con);
		}
		else if( getInstitutename()!=null)
		{
			PreparedStatement st;
			System.out.println("here");
		    st=con.prepareStatement("insert into institute VALUES (?,?,?,?,?)"); 
		    st.setInt(1, userid);
		    st.setString(2,getStudiedfrom());
		    st.setString(3,getInstitutename());
		    st.setString(4,getStudiedto());
		    st.setString(5,getDegree());
		    
		    st.execute();
		    ConnectionPool.freeConnection(con);
		}
		else if( getOrganizationname()!=null)
		{
			PreparedStatement st;
			
		    st=con.prepareStatement("insert into organization VALUES (?,?,?,?,?)"); 
		    st.setInt(1, userid);
		    st.setString(2,getOrganizationname());
		    st.setString(3,getWorkingfrom());
		    st.setString(4,getWorkingto());
		    st.setString(5,getDesignation());
		    
		    st.execute();
		    ConnectionPool.freeConnection(con);
		    
		}
		else if(getUdob()!=null)
		{
		PreparedStatement st;
		System.out.println(getUgender());
		    st=con.prepareStatement("update user set udob=?,ugender=? where userid=?"); 
		    st.setInt(3, userid);
		    st.setString(1,getUdob());
		    st.setString(2, getUgender());
		    
		    st.execute();
		    System.out.println(getUdob());
		    ConnectionPool.freeConnection(con);
		}
		
		//System.out.println("success");
		return "success";
		
	}
	public String getOrganizationname() {
		return organizationname;
	}

	public void setOrganizationname(String organizationname) {
		this.organizationname = organizationname;
	}

	public String getDesignation() {
		return designation;
	}

	public void setDesignation(String designation) {
		this.designation = designation;
	}

	public String getWorkingfrom() {
		return workingfrom;
	}

	public void setWorkingfrom(String workingfrom) {
		this.workingfrom = workingfrom;
	}

	public String getWorkingto() {
		return workingto;
	}

	public void setWorkingto(String workingto) {
		this.workingto = workingto;
	}
	/**
	 * @return the udob
	 */
	public String getUdob() {
		return udob;
	}
	/**
	 * @param udob the udob to set
	 */
	public void setUdob(String udob) {
		this.udob = udob;
	}
	/**
	 * @return the ugender
	 */
	public String getUgender() {
		return ugender;
	}
	/**
	 * @param ugender the ugender to set
	 */
	public void setUgender(String ugender) {
		this.ugender = ugender;
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
}
