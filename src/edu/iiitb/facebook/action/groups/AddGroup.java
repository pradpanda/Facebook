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

public class AddGroup extends ActionSupport  implements SessionAware {
	
	/**
	 * nisarga
	 */
	private static final long serialVersionUID = 1L;

	private String grpMembers;
	private String grpName;
	private int userId;
	private ArrayList<Group> grpDetails;
	

	private Map<String, Object> session;
	
	public void setGrpDetails(ArrayList<Group> grpDetails) {
		this.grpDetails = grpDetails;
	}

	public void setSession(Map<String, Object> session) {
		this.session = session;
	}
	
	public String getGrpName() {
		return grpName;
	}

	public void setGrpName(String grpName) {
		this.grpName = grpName;
	}

	public String getGrpMembers() {
		return grpMembers;
	}

	public void setGrpMembers(String grpMembers) {
		this.grpMembers = grpMembers;
	}


	@SuppressWarnings("null")
	public String execute() throws SQLException
	{
		System.out.println("in nisarga ADD GRUP");
		
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

		String names[]=grpMembers.split("×");
		StringBuilder builder = new StringBuilder();
		for(String s : names) {
			builder.append(s);
		}
		String everything=builder.toString();

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
		
		GroupsDAO groupDAO1 =new GroupsDAOImpl();
		groupDAO1.createGroup(cn,ids1, grpName,userId);

		//load grups 1st
		ArrayList<Group> al=new ArrayList<Group>();


		GroupsDAO groupDAO =new GroupsDAOImpl();
		
		al=groupDAO.groupDetails(cn, userId);
		
		HttpServletRequest request = ServletActionContext.getRequest();
		
		request.setAttribute("grpDetails", al);
		System.out.println("rajlist");
		for(Group g:al)
		System.out.println(g.getGroupName());

		ConnectionPool.freeConnection(cn);
		
		System.out.println("b4 success");
		
		return "success";
	}
	public int getUserId() {
		return userId;
	}
	public void setUserId(int userId) {
		this.userId = userId;
	}


}
