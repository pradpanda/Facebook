package edu.iiitb.facebook.action.groups;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Map;

import com.opensymphony.xwork2.ActionSupport;

import edu.iiitb.facebook.action.dao.EventDAO;
import edu.iiitb.facebook.action.dao.GroupsDAO;
import edu.iiitb.facebook.action.dao.impl.EventDAOImpl;
import edu.iiitb.facebook.action.dao.impl.GroupsDAOImpl;
import edu.iiitb.facebook.action.model.Group;
import edu.iiitb.facebook.action.model.User;
import edu.iiitb.facebook.util.ConnectionPool;

public class searchAction1 extends ActionSupport {

	/**
	 * nisarga
	 */
	private static final long serialVersionUID = 1L;

	private Map<String, Object> session;

	private ArrayList<User> grpUserList =new ArrayList<User>();


	public String execute() throws SQLException
	{

		System.out.println("in nisarga search action 1");

		Connection cn=ConnectionPool.getConnection();

		ArrayList<User> al=new ArrayList<User>();

		GroupsDAO groupDAO=new GroupsDAOImpl();

		al=groupDAO.searchMembers(cn);

		System.out.println("iiit");
		
		System.out.println(al.get(0));
		
		setGrpUserList(al);

		System.out.println("here="+grpUserList.get(0).getFirstName());

		ConnectionPool.freeConnection(cn);

		return "success";

	}

	public void setSession(Map<String, Object> session) {
		this.session = session;
	}

	public ArrayList<User> getGrpUserList() {
		return grpUserList;
	}

	public void setGrpUserList(ArrayList<User> grpUserList) {
		this.grpUserList = grpUserList;
	}



}
