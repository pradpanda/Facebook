package edu.iiitb.facebook.action.messages;
import java.io.InputStream;
import java.io.OutputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import org.apache.struts2.ServletActionContext;
import edu.iiitb.facebook.util.ConnectionPool;
import edu.iiitb.facebook.util.Constants;
import com.opensymphony.xwork2.ActionSupport;

public class LastFriendsPhotos extends ActionSupport
{
	private int userid;
	
	public int getUserid() {
		return userid;
	}
	public void setUserid(int userid) {
		this.userid = userid;
	}
	public String getImage()
	{
		OutputStream out;
		Connection con = null;
		try 
		{
			con=ConnectionPool.getConnection();
			PreparedStatement pstmt = con.prepareStatement(Constants.GET_USER_IMAGE);
			
			//sid=Integer.parseInt(ServletActionContext.getRequest().getSession().getAttribute("userid").toString());
			pstmt.setInt(1, userid);
			ResultSet rs = pstmt.executeQuery();
			if(rs.next())
			{				
				ServletActionContext.getResponse().setContentType("image/jpeg");
				InputStream in=rs.getBinaryStream(1);
				out=ServletActionContext.getResponse().getOutputStream();
				byte[] buffer=new byte[1024];
				int len;
				while((len=in.read(buffer))!=-1)
				{
					out.write(buffer,0,len);
				}
			}
			else
			{
				ServletActionContext.getResponse().setContentType("image/jpeg");
				//System.out.println("No Image Found");
			}
		} 
		catch (Exception e) 
		{
			e.printStackTrace();
		} 
		ConnectionPool.freeConnection(con);
	    return NONE;
	}
}