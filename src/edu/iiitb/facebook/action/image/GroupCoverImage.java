package edu.iiitb.facebook.action.image;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;
import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.ResultPath;
import org.apache.struts2.convention.annotation.Results;
import org.apache.struts2.interceptor.SessionAware;

import com.opensymphony.xwork2.ActionSupport;

import edu.iiitb.facebook.action.dao.GroupsDAO;
import edu.iiitb.facebook.action.dao.UserDAO;
import edu.iiitb.facebook.action.dao.impl.GroupsDAOImpl;
import edu.iiitb.facebook.action.dao.impl.UserDAOImpl;
import edu.iiitb.facebook.action.model.Group;
import edu.iiitb.facebook.action.model.User;
import edu.iiitb.facebook.util.ConnectionPool;

@Namespace("/default")
@ResultPath(value = "/")
public class GroupCoverImage extends ActionSupport implements SessionAware{

  /**
   * serialVersionUID nisarga
   */
  private static final long serialVersionUID = -8188116769915480525L; 

  private int grpID;
  private String picType;
  private Map<String, Object> session;
  private GroupsDAO groupDao = new GroupsDAOImpl();
  
  @Action(value = "/groupImage")
  public String execute() throws SQLException, IOException {
	  System.out.println("in GRPIMAGE class" + grpID);
    Connection connection = ConnectionPool.getConnection();
    Group group = groupDao.getGroupImageByGrpId(grpID);
    
    HttpServletResponse response = ServletActionContext.getResponse();
    response.setContentType("image/jpeg");
    InputStream in = group.getGroupCoverPic();
    if (null != picType && picType.equals("cover")) {
      in = group.getGroupCoverPic();
    }
    OutputStream out = response.getOutputStream();
    byte[] buffer = new byte[1024];
    int len;
    while ((len = in.read(buffer)) != -1) {
      out.write(buffer, 0, len);
    }
    ConnectionPool.freeConnection(connection);
    return NONE;
  }

  
  
  public String getPicType() {
    return picType;
  }

  public void setPicType(String picType) {
    this.picType = picType;
  }

  @Override
  public void setSession(Map<String, Object> session) {
    this.session = session;
  }

public int getGrpID() {
	return grpID;
}

public void setGrpID(int grpID) {
	this.grpID = grpID;
}


   
}
