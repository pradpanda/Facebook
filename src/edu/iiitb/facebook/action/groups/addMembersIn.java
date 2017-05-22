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

public class addMembersIn  extends ActionSupport  implements SessionAware {

	/**
	 * nisarga
	 */
	private static final long serialVersionUID = 1L;
	private Map<String, Object> session;
	private String grpMembers;
	private String grpName;
	private int userId;
	private ArrayList<Group> grpDetails;
	private int grpID;
	
	
	public Map<String, Object> getSession() {
		return session;
	}
	public void setSession(Map<String, Object> session) {
		this.session = session;
	}
	public String getGrpMembers() {
		return grpMembers;
	}
	public void setGrpMembers(String grpMembers) {
		this.grpMembers = grpMembers;
	}
	public String getGrpName() {
		return grpName;
	}
	public void setGrpName(String grpName) {
		this.grpName = grpName;
	}
	public int getUserId() {
		return userId;
	}
	public void setUserId(int userId) {
		this.userId = userId;
	}
	public ArrayList<Group> getGrpDetails() {
		return grpDetails;
	}
	public void setGrpDetails(ArrayList<Group> grpDetails) {
		this.grpDetails = grpDetails;
	}
	
	

	@SuppressWarnings("null")
	public String execute() throws SQLException
	{
		System.out.println("in nisarga ADDExtra GRUP");
		System.out.println(grpMembers);
		
		//add
		
		Connection cn=ConnectionPool.getConnection();

		ArrayList<Integer> ids1=new ArrayList<Integer>();
		 User user = (User) session.get("user");
		    if (null != user) {
		    	userId=user.getUserId();
		    }
		    System.out.println("ID="+userId);
		
		int[] ids = new int[20];
		int k=0;
System.out.println("here");
		String names[]=grpMembers.split("×");
		StringBuilder builder = new StringBuilder();
		for(String s : names) {
			builder.append(s);
		}
		String everything=builder.toString();
		System.out.println("here");

		String upNames[]=everything.split("\\s+");
		for(String s:upNames)
			System.out.println(s);

		for(int i=2;i<upNames.length;i++)
		{
			try
			{
				ids[k]=Integer.parseInt(upNames[i]);
				k++;
				i++;
				i++;
			}
			catch(ArrayIndexOutOfBoundsException e)
			{
				e.printStackTrace();
			}
		}
		for(int i=0;i<ids.length;i++)
		{
			if(ids[i]!=0)
				ids1.add(ids[i]);
			else
				break;
		}
		
		for(int x:ids1)
			System.out.println(x);
		GroupsDAO groupDAO1 =new GroupsDAOImpl();
		
		groupDAO1.extraMembers(cn,ids1,getGrpID());

		
		ConnectionPool.freeConnection(cn);
		
		System.out.println("b4 success");
		
		return "success";
	}
	public int getGrpID() {
		return grpID;
	}
	public void setGrpID(int grpID) {
		this.grpID = grpID;
	}

}
