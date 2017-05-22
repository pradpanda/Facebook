package edu.iiitb.facebook.action.groups;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.Map;

import javax.naming.NamingException;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.io.FileUtils;
import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.SessionAware;

import com.opensymphony.xwork2.ActionSupport;

import edu.iiitb.facebook.action.dao.GroupsDAO;
import edu.iiitb.facebook.action.dao.UserDAO;
import edu.iiitb.facebook.action.dao.impl.GroupsDAOImpl;
import edu.iiitb.facebook.action.dao.impl.UserDAOImpl;
import edu.iiitb.facebook.action.model.Group;
import edu.iiitb.facebook.action.model.User;

public class GroupCoverAction extends ActionSupport implements SessionAware,
ServletRequestAware {
	
	/**
	 * nisarga
	 */
	private static final long serialVersionUID = 1L;
	String coverContentType;
	private int grpID;
	public int getGrpID() {
		return grpID;
	}

	public void setGrpID(int grpID) {
		System.out.println("hi groupid"+grpID);
		this.grpID = grpID;
	}

	private String coverFileName;
	
	private File cover;
	File fileToCreate;

	public String getCoverContentType() {
		return coverContentType;
	}

	public void setCoverContentType(String coverContentType) {
		this.coverContentType = coverContentType;
	}

	public String getCoverFileName() {
		return coverFileName;
	}

	public void setCoverFileName(String coverFileName) {
		this.coverFileName = coverFileName;
	}

	public File getCover() {
		return cover;
	}

	public void setCover(File cover) {
		System.out.println(cover);
		this.cover = cover;
	}

	private HttpServletRequest servletRequest;

	public void setServletRequest(HttpServletRequest servletRequest) {
		this.servletRequest = servletRequest;
	}

	private Map<String, Object> session;

	public Map<String, Object> getSession() {
		return session;
	}

	public void setSession(Map<String, Object> session) {
		this.session = session;
	}



	public String cover() throws NamingException, FileNotFoundException {
		/*user = (User) session.get("user");*/
		try {
			GroupsDAO dao = new GroupsDAOImpl();
			Group group = new Group();
			
			System.out.println("Cover Class");
			System.out.println(getGrpID());
		      String destpath = servletRequest.getSession().getServletContext()
		              .getRealPath("/");
		          System.out.println("Server path:" + destpath);

		          File destFile = new File(destpath, getCoverContentType());
		          try {
		            FileUtils.copyFile(cover, destFile);

		          } catch (IOException e) {
		            e.printStackTrace();
		            return ERROR;
		          }
		          
		     FileInputStream inputStream = new FileInputStream(destFile);
			// System.out.println("in input Stream :" + inputStream);
			System.out.println("place4 in 3rdsignup");
			group.setGroupCoverPic(inputStream);
			/*dao.setCoverImageByGroupId(group.getGroupID(), inputStream);*/
			dao.setCoverImageByGroupId(getGrpID(), inputStream);
		} catch (Exception e) {
			e.printStackTrace();
			addActionError(e.getMessage());
			return INPUT;
		}
		
		/*session.put("user", user);*/
		return SUCCESS;
	}
}