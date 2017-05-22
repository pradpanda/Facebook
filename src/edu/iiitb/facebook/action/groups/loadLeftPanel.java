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

public class loadLeftPanel extends ActionSupport implements SessionAware {

	/**
	 * nisarga
	 */
	private static final long serialVersionUID = 1L;

	private ArrayList<Group> grpDetails;
	
	private int userId;
	
	private Map<String, Object> session;


	public ArrayList<Group> getGrpDetails() {
		return grpDetails;
	}

	public void setGrpDetails(ArrayList<Group> grpDetails) {
		this.grpDetails = grpDetails;
	}

	public int getUserId() {
		return userId;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}

	@Override
	public void setSession(Map<String, Object> session) {
		this.session = session;
	}
	
	public String execute() throws SQLException
	{
		System.out.println("IN LOADPANEL clas");
		
		User user = (User) session.get("user");
		userId = user.getUserId();
		
		ArrayList<Group> al=new ArrayList<Group>();

		Connection cn=ConnectionPool.getConnection();

		GroupsDAO groupDAO =new GroupsDAOImpl();
		
		al=groupDAO.groupDetails(cn, userId);
		
		HttpServletRequest request = ServletActionContext.getRequest();
		
		request.setAttribute("grpDetails", al);
		for(Group p:al)
			System.out.println(p.getGroupName()+"  "+p.getGroupID());
		
		return " ";
		
	}
	

}
