package edu.iiitb.facebook.action.groups;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.ServletActionContext;
import org.apache.struts2.interceptor.RequestAware;
import org.apache.struts2.interceptor.SessionAware;

import com.opensymphony.xwork2.ActionSupport;

import edu.iiitb.facebook.action.dao.FriendsDAO;
import edu.iiitb.facebook.action.dao.GroupsDAO;
import edu.iiitb.facebook.action.dao.UserDAO;
import edu.iiitb.facebook.action.dao.impl.FriendsDAOImpl;
import edu.iiitb.facebook.action.dao.impl.GroupsDAOImpl;
import edu.iiitb.facebook.action.dao.impl.UserDAOImpl;
import edu.iiitb.facebook.action.model.User;
import edu.iiitb.facebook.util.ConnectionPool;

public class searchAction2 extends ActionSupport implements SessionAware,
RequestAware {

	private int grpID;
	
	private ArrayList<User> grpUserList1 =new ArrayList<User>();


	public ArrayList<User> getGrpUserList1() {
		return grpUserList1;
	}

	public void setGrpUserList1(ArrayList<User> grpUserList1) {
		
		this.grpUserList1 = grpUserList1;
	}


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

	String friendUserId;

	String fref;

	public String getFref() {
		return fref;
	}

	public void setFref(String fref) {
		this.fref = fref;
	}

	public String getFriendUserId() {
		return friendUserId;
	}

	public void setFriendUserId(String friendUserId) {
		this.friendUserId = friendUserId;
	}

	List<User> friendsList;

	public List<User> getFriendsList() {
		return friendsList;
	}

	public void setFriendsList(List<User> friendsList) {
		this.friendsList = friendsList;
	}

	/**
	 * nisarga
	 */
	private static final long serialVersionUID = 1L;

	public String execute() throws SQLException {


		System.out.println("IN Srchaction2 CLASS");

		System.out.println("grpID"+getGrpID());
		
		setGrpID(getGrpID());

		User user = (User) session.get("user");
		UserDAO userDAO = new UserDAOImpl();
		GroupsDAO groupsDao = new GroupsDAOImpl();

		System.out.println("fref   ");

		fref = (String) session.get("profileReference");

		System.out.println("hi" + fref);

		friendsList = groupsDao.getGroupMembersList(getGrpID());
		setFriendsList(groupsDao.getGroupMembersList(getGrpID()));

		System.out.println("IN ViewGroupMembers");

		System.out.println("ID"+getGrpID());
		Connection cn=ConnectionPool.getConnection();

		ArrayList<User> al=new ArrayList<User>();

		GroupsDAO groupDAO=new GroupsDAOImpl();

		al=groupDAO.searchMembersNotAlereadyAdded(cn,getGrpID());
		
		System.out.println("nisargalolage");
		System.out.println(al.get(0));
		
		setGrpUserList1(al);
		HttpServletRequest request = ServletActionContext.getRequest();
		
		
		Integer temp = getGrpID();
		String temp1 = new String(temp.toString());
		request.setAttribute("grpID", temp1);
		
		System.out.println("here="+grpUserList1.get(0).getFirstName());
		
		


		System.out.println("view friends main class");
		if (!friendsList.isEmpty()) {
			return SUCCESS;
		} else {
			return "error";
		}
	}

	Map<String, Object> session;
	Map<String, Object> request;

	@Override
	public void setSession(Map<String, Object> arg0) {
		this.session = arg0;
	}

	@Override
	public void setRequest(Map<String, Object> arg0) {
		this.request = arg0;
	}
}