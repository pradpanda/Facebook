package edu.iiitb.facebook.action.groups;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.ServletActionContext;
import org.apache.struts2.interceptor.SessionAware;

import com.opensymphony.xwork2.ActionSupport;

import edu.iiitb.facebook.action.dao.GroupsDAO;
import edu.iiitb.facebook.action.dao.impl.GroupsDAOImpl;
import edu.iiitb.facebook.action.model.Group;
import edu.iiitb.facebook.action.model.User;
import edu.iiitb.facebook.util.ConnectionPool;

public class LeaveGroup extends ActionSupport  implements SessionAware{

	/**
	 * nisarga
	 */
	private static final long serialVersionUID = 1L;
	private Map<String, Object> session;
	private int grpID;

	private String grpDetails;

	public String getGrpDetails() {
		return grpDetails;
	}

	public void setGrpDetails(String grpDetails) {
		this.grpDetails = grpDetails;
	}
	
	public int getGrpID() {
		return grpID;
	}

	public void setGrpID(int grpID) {
		this.grpID = grpID;
	}


	private int userId;
	
	

	public int getUserId() {
		return userId;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}

	public void setSession(Map<String, Object> session) {
		this.session = session;
	}
	
	
	public String execute() throws SQLException
	{
		System.out.println("in nisarga LEAVE GRUP");
		Connection cn=ConnectionPool.getConnection();
		 User user = (User) session.get("user");
		    if (null != user) {
		    	userId=user.getUserId();
		    }
		    System.out.println("ID="+userId);
		    
		    GroupsDAO groupDAO=new GroupsDAOImpl();
		    
		    groupDAO.LeaveGroup(cn, userId, getGrpID());
			ConnectionPool.freeConnection(cn);
			
//load panel
			ArrayList<Group> al=new ArrayList<Group>();


			GroupsDAO groupDAO1 =new GroupsDAOImpl();
			
			al=groupDAO1.groupDetails(cn, userId);
			
			HttpServletRequest request = ServletActionContext.getRequest();
			
			request.setAttribute("grpDetails", al);

			
		
		return SUCCESS;
	}
}
