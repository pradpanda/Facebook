package edu.iiitb.facebook.action.groups;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Map;

import org.apache.struts2.interceptor.SessionAware;

import com.opensymphony.xwork2.ActionSupport;

import edu.iiitb.facebook.action.dao.GroupsDAO;
import edu.iiitb.facebook.action.dao.impl.GroupsDAOImpl;
import edu.iiitb.facebook.action.model.User;
import edu.iiitb.facebook.util.ConnectionPool;

public class DeleteGroup extends ActionSupport  implements SessionAware{

	
	/**
	 * nisarga
	 */
	private static final long serialVersionUID = 1L;

	private Map<String, Object> session;
	
	private int grpID;
	
	private int userId;

	
	public void setSession(Map<String, Object> session) {
		this.session = session;
	}

	public int getGrpID() {
		return grpID;
	}

	public void setGrpID(int grpID) {
		this.grpID = grpID;
	}
	
	public String execute() throws SQLException
	{
	System.out.println("in nisarga DELETE GRUP");
		
		//delete
		System.out.println("grpID="+grpID);
		Connection cn=ConnectionPool.getConnection();
		ArrayList<Integer> ids1=new ArrayList<Integer>();
		 User user = (User) session.get("user");
		    if (null != user) {
		    	setUserId(user.getUserId());
		    }
			GroupsDAO groupDAO1 =new GroupsDAOImpl();
			try {
				PreparedStatement ps=cn.prepareStatement("select groupuserid from group_members where groupid=?");
				ps.setInt(1, grpID);
				ResultSet rs=ps.executeQuery();
				while(rs.next())
				{
					ids1.add(rs.getInt(1));
				}
				PreparedStatement ps1=cn.prepareStatement("update groups set isactive='0' where groupid=?");
				ps1.setInt(1, grpID);
				ps1.executeUpdate();
				
				PreparedStatement ps2=cn.prepareStatement("update group_members set isactive='0' where groupid=? and groupuserid=?");
				ps2.setInt(1, grpID);
				for(int i=0;i<ids1.size();i++)
				{
					ps2.setInt(2, ids1.get(i));
					ps2.executeUpdate();
				}
				
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		return SUCCESS;
	}

	public int getUserId() {
		return userId;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}
}
