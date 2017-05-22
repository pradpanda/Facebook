package edu.iiitb.facebook.action.profile;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Calendar;
import java.sql.Connection;
import java.sql.Timestamp;
import java.util.Map;
import org.apache.struts2.ServletActionContext;
import javax.mail.Session;
import javax.naming.NamingException;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.FileUtils;

import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;
import org.apache.struts2.interceptor.SessionAware;

import com.opensymphony.xwork2.ActionSupport;

import edu.iiitb.facebook.util.ConnectionPool;
import edu.iiitb.facebook.action.dao.UserDAO;
import edu.iiitb.facebook.action.dao.impl.UserDAOImpl;
import edu.iiitb.facebook.action.model.User;

public class getabout extends ActionSupport   implements SessionAware, ServletResponseAware, ServletRequestAware {
	
	private Map<String, Object> session;
	private String currentplace;
	private String currentname;
	private String currentfrom;
	private String homeplace;
	private String language;
	private String aboutme;
	private String martialstatus;
	private String udob;
	private String ugender;
	private String uid;
	private File image;
    private String imageContentType;
    private String imageFileName;
	private int count;
	private String ufirstname;
	private String ulastname;
	private int mainuserid;
	private String purefriend;
	private String ishesentfriendrequest;
	
	
	public int getMainuserid() {
		return mainuserid;
	}
	public void setMainuserid(int mainuserid) {
		this.mainuserid = mainuserid;
	}
	public String getUfirstname() {
		return ufirstname;
	}
	public void setUfirstname(String ufirstname) {
		this.ufirstname = ufirstname;
	}
	public String getUlastname() {
		return ulastname;
	}
	public void setUlastname(String ulastname) {
		this.ulastname = ulastname;
	}
	private int profilepicid;
	private String isfriend;
	private String isfriendRequestsent;
	
	
	public String getIsfriend() {
		return isfriend;
	}
	public void setIsfriend(String isfriend) {
		this.isfriend = isfriend;
	}
	String insexist="yes";
	String orgexist="yes";
	String current="";
	String past="";
	
	// change userid here--------------------------------------
	private int userid;
	//--------------------------------------------------
	
	public int getUserid() {
		return userid;
	}
	public void setUserid(int userid) {
		this.userid = userid;
	}
	ArrayList<institute>  inst =new ArrayList<institute>();
	ArrayList<organization>  organ =new ArrayList<organization>();
	ArrayList<friends> friend =new ArrayList<friends>();
	
	public ArrayList<friends> getFriend() {
		return friend;
	}
	public void setFriend(ArrayList<friends> friend) {
		this.friend = friend;
	}
	
	
	
	
	public String getAbout()
	{   
		
		System.out.println("the user id is"); 
	    System.out.println(userid);	
		int friendcount=0;
		
		ConnectionPool data=new ConnectionPool();
		java.sql.Connection con= data.getConnection();
	//	System.out.println(Integer.parseInt(ServletActionContext.getRequest().getSession().getAttribute("userid").toString()));
		//System.out.println(session.get("userid").toString());
		System.out.println(session.get("profileReference").toString());
		setMainuserid(Integer.parseInt(session.get("profileReference").toString()));
		//setMainuserid(userid);
		//System.out.println("main user id is");
		System.out.println(getMainuserid() + "this is my session id");
		//setUserid(2);
	
		
		
		
		
		PreparedStatement ps;
		try{
			PreparedStatement ps4;
			
			ps4=con.prepareStatement("select count(*) from friends where (friend_sender=? or friend_receiver=?) and  friendshipstatus='Accepted'");
			ps4.setInt(1,userid);
			ps4.setInt(2,userid);
			ResultSet rs4=ps4.executeQuery();
				while(rs4.next())
				{
					setCount(rs4.getInt(1));
					
				}
			PreparedStatement ps5;
			
			ps5=con.prepareStatement("select ufirstname, userid from friends f,user u where (friend_sender=? or friend_receiver=?) and  friendshipstatus='Accepted' and (u.userid=f.friend_receiver or u.userid=f.friend_sender) and u.ufirstname not in (select ufirstname from user where userid=?)");
			ps5.setInt(1,userid);
			ps5.setInt(2,userid);
			ps5.setInt(3, userid);
			//System.out.println(userid);
			ResultSet rs5=ps5.executeQuery();
			while(rs5.next())
			{
				friends obj=new friends();
				obj.setName(rs5.getString(1));
				obj.setFriendid(rs5.getInt(2));
				friend.add(obj);
				System.out.println("the friend id is");
				System.out.println(rs5.getInt(2));
				System.out.println(userid);
				System.out.println(rs5.getString(1));
				
			}

		ps=con.prepareStatement("Select currentplace,homeplace,aboutme,language,martialstatus from profile where userid = ?");
		ps.setInt(1,userid);
		ResultSet rs=ps.executeQuery();
			while(rs.next())
			{
				setCurrentplace(rs.getString(1));
				setHomeplace(rs.getString(2));
				setAboutme(rs.getString(3));
				setLanguage(rs.getString(4));
				setMartialstatus(rs.getString(5));
			}
			PreparedStatement ps1;
			
			ps1=con.prepareStatement("Select ufirstname,ulastname,udob,ugender from user where userid = ?");
			ps1.setInt(1,userid);
			ResultSet rs1=ps1.executeQuery();
				while(rs1.next())
				{
					setUfirstname(rs1.getString(1));
					setUlastname(rs1.getString(2));
					setUdob(rs1.getString(3));
					setUgender(rs1.getString(4));
				}
				PreparedStatement ps2;
				
				ps2=con.prepareStatement("Select organizationname,workingfrom,workingto,designation from organization where userid = ?");
				ps2.setInt(1,userid);
				ResultSet rs2=ps2.executeQuery();
					while(rs2.next())
					{
						organization org=new organization();
						org.setOrganizationname(rs2.getString(1));
						org.setWorkingfrom(rs2.getString(2));
						org.setWorkingto(rs2.getString(3));
						org.setDesignation(rs2.getString(4));
						organ.add(org);
					}
					PreparedStatement ps3;
					
					ps3=con.prepareStatement("Select studiedfrom,institutename,studiedto,degree from institute where userid = ?");
					ps3.setInt(1,userid);
					ResultSet rs3=ps3.executeQuery();
						while(rs3.next())
						{
							institute in=new institute();
							in.setStudiedfrom(rs3.getString(1));
							in.setInstitutename(rs3.getString(2));
							in.setStudiedto(rs3.getString(3));
							in.setDegree(rs3.getString(4));
							inst.add(in);
						}
					
						
						ps4=con.prepareStatement("select  count(*) from friends f where ((friend_sender=? and friend_receiver=?)) or (friend_sender=? and friend_receiver=?)");
						ps4.setInt(1,getMainuserid());
						ps4.setInt(2,getUserid());
						ps4.setInt(3,getUserid());
						ps4.setInt(4,getMainuserid());
						ResultSet res=ps4.executeQuery();
							while(res.next())
							{   
								friendcount=res.getInt(1);
							}
							
							if(friendcount==1)
							setIsfriend("yes");
							else
							setIsfriend("no");
					// isfriend="no";
							System.out.println(getIsfriend());
			
		
		       /////////////////////////
		PreparedStatement ps100;
		ps100=con.prepareStatement("select  count(*) from friends f where ((friend_sender=? and friend_receiver=?)) and  friendshipstatus='Pending'");
		ps100.setInt(1,getMainuserid());
		ps100.setInt(2,getUserid());
		
		
		ResultSet rss=ps100.executeQuery();
			while(rss.next())
			{
				friendcount=rss.getInt(1);
			}
			
			if(friendcount==1)
			setIsfriendRequestsent("yes");
			else
			setIsfriendRequestsent("no");
	// isfriend="no";
/////ACEEPT REJECT//////////////////
			PreparedStatement ps102;
			ps102=con.prepareStatement("select  count(*) from friends f where ((friend_sender=? and friend_receiver=?)) and  friendshipstatus='Pending'");
			ps102.setInt(1,getUserid());
			ps102.setInt(2,getMainuserid());
			
			ResultSet rss2=ps102.executeQuery();
				while(rss2.next())
				{
					friendcount=rss2.getInt(1);
				}
				
				if(friendcount==1)
				setIshesentfriendrequest("yes");
				else
			   setIshesentfriendrequest("no");

			////////////////////////
		
		
		
		PreparedStatement ps101;
		ps101=con.prepareStatement("select  count(*) from friends f where ((friend_sender=? and friend_receiver=?) or (friend_sender=? and friend_receiver=? )) and  friendshipstatus='Accepted'");
		ps101.setInt(1,getMainuserid());
		ps101.setInt(2,getUserid());
		ps101.setInt(3,getUserid());
		ps101.setInt(4,getMainuserid());
		
		ResultSet rss1=ps101.executeQuery();
			while(rss1.next())
			{
				friendcount=rss1.getInt(1);
			}
			
			if(friendcount==1)
			setPurefriend("yes");
			else
		    setPurefriend("no");
	// isfriend="no";
			System.out.println(getIsfriend());
			ConnectionPool.freeConnection(con);
		}
		
		
		
		
		
		
		
		
		catch(SQLException e)
		{
			e.printStackTrace();
			return "error";
		}

		//////////////////////////////
		return "success";
		
	}
	public String gettimeline()
	{
		ConnectionPool data=new ConnectionPool();
		java.sql.Connection con= data.getConnection();
		PreparedStatement ps;
		try{
		ps=con.prepareStatement("Select currentplace,homeplace,aboutme,language,martialstatus from profile where userid = ?");
		ps.setInt(1,userid);
		ResultSet rs=ps.executeQuery();
			while(rs.next())
			{
				setCurrentplace(rs.getString(1));
				setHomeplace(rs.getString(2));
				setAboutme(rs.getString(3));
				setLanguage(rs.getString(4));
				setMartialstatus(rs.getString(5));
			}
			PreparedStatement ps1;
			
			ps1=con.prepareStatement("Select udob,ugender from user where userid = ?");
			ps1.setInt(1,userid);
			ResultSet rs1=ps1.executeQuery();
				while(rs1.next())
				{
					setUdob(rs1.getString(1));
					setUgender(rs1.getString(2));
				}
			
				int year = Calendar.getInstance().get(Calendar.YEAR);
		Integer arr[];
		//arr=getUdob().split(":",2);
				PreparedStatement ps2;
				
				ps2=con.prepareStatement("Select organizationname,workingfrom,workingto,designation from organization where userid = ? order by workingfrom ASC");
				ps2.setInt(1,userid);
				
				ResultSet rs2=ps2.executeQuery();
					if(rs2.last())
					{
						organization org=new organization();
						org.setOrganizationname(rs2.getString(1));
						org.setWorkingfrom(rs2.getString(2));
						//org.setWorkingto(rs2.getString(3));
						org.setDesignation(rs2.getString(4));
						organ.add(org);
					}
					else
					{
						orgexist="no";
					}
					
					PreparedStatement ps3;
					
					ps3=con.prepareStatement("Select studiedfrom,institutename,studiedto,degree from institute where userid = ? order by studiedfrom ASC");
					ps3.setInt(1,userid);
					ResultSet rs3=ps3.executeQuery();
						if(rs3.last())
						{
							institute in=new institute();
							in.setStudiedfrom(rs3.getString(1));
							in.setInstitutename(rs3.getString(2));
							in.setStudiedto(rs3.getString(3));
							in.setDegree(rs3.getString(4));
							inst.add(in);
						}
						else
						{
							insexist="no";
						}
						if(insexist.equals("yes")&& orgexist.equals("yes"))
						{
							String[] study=inst.get(0).getStudiedfrom().split("-");
							String[] organiz=organ.get(0).getWorkingfrom().split("-");
						
							if(Integer.parseInt(study[0])>=Integer.parseInt(organiz[0]))
							{
								if(Integer.parseInt(study[1])>=Integer.parseInt(organiz[1]))
								{
									if(Integer.parseInt(study[2])>Integer.parseInt(organiz[2]))
									{
										current="institute";
									}
									else
										current="orgnization";
								}
								else
								{
									current="organization";
								}
								
							}
							else
							{
								current="organization";
							}
							if(current.equals("organization"))
							{
								setCurrentname(organ.get(0).getOrganizationname());
								setCurrentfrom(organ.get(0).getWorkingfrom());
							}
							else
							{
								setCurrentname(inst.get(0).getInstitutename());
								setCurrentfrom(inst.get(0).getStudiedfrom());
							}
						}
						else
						{
							setCurrentname("NONE");
							setCurrentfrom("NONE");
						}
						
						PreparedStatement ps4;
						
						ps4=con.prepareStatement("select count(*) from friends where (friend_sender=? or friend_receiver=?) and  friendshipstatus='Accepted'");
						ps4.setInt(1,userid);
						ps4.setInt(2,userid);
						ResultSet rs4=ps4.executeQuery();
							while(rs4.next())
							{
								setCount(rs4.getInt(1));
								
							}
							PreparedStatement ps5;
							
							ps5=con.prepareStatement("select ufirstname, userid from friends f,user u where (friend_sender=? or friend_receiver=?) and  friendshipstatus='Accepted' and (u.userid=f.friend_receiver or u.userid=f.friend_sender) and u.ufirstname not in (select ufirstname from user where userid=?)");
							ps5.setInt(1,userid);
							ps5.setInt(2,userid);
							ps5.setInt(3, userid);
							System.out.println(userid);
							ResultSet rs5=ps5.executeQuery();
							while(rs5.next())
							{
								friends obj=new friends();
								obj.setName(rs5.getString(1));
								obj.setFriendid(rs5.getInt(2));
								friend.add(obj);
						
								
							}
		
							ConnectionPool.freeConnection(con);
		}
		
		
		catch(SQLException e)
		{
			e.printStackTrace();
			return "error";
		}
		
		return "success";
		
	}
	
	
	public void getcoverimage()
	{
		
		OutputStream out;
		ConnectionPool data=new ConnectionPool();
		java.sql.Connection con= data.getConnection();
		try 
		{
			
			con=ConnectionPool.getConnection();
			PreparedStatement pstmt = con.prepareStatement("select ucoverpic from user where userid=?");
			//userid=Integer.parseInt(ServletActionContext.getRequest().getSession().getAttribute("userid").toString());
			//pstmt.setInt(1, userid);
			pstmt.setInt(1, getUserid());
			
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
	    
	}
	public void getprofileimage()
	{
		
		OutputStream out;
		ConnectionPool data=new ConnectionPool();
		java.sql.Connection con= data.getConnection();
		try 
		{
			System.out.println(getProfilepicid());
			con=ConnectionPool.getConnection();
			PreparedStatement pstmt = con.prepareStatement("select uprofilepic from user where userid=?");
			//userid=Integer.parseInt(ServletActionContext.getRequest().getSession().getAttribute("userid").toString());
			//pstmt.setInt(1, userid);
			pstmt.setInt(1, getProfilepicid());
			
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
	    
	}
	public String getimage() throws SQLException, FileNotFoundException
	{
		String destpath=null;
		//System.out.println(":hffhd");
		ConnectionPool data=new ConnectionPool();
		java.sql.Connection con= data.getConnection();
		if(getImage()!=null)
		{
			try
			{
				destpath=this.getClass().getResource("/").getPath();
				System.out.println("Server path:" + destpath);
			}
			catch(Exception E)
			{
				System.out.println("Exception in destination path");
			}
			File destFile = new File(destpath, getImageFileName());
			try 
			{
				FileUtils.copyFile(getImage(), destFile);
			} catch (IOException e)
			{
				e.printStackTrace();
			}
			con=ConnectionPool.getConnection();
			PreparedStatement pstmt = con.prepareStatement("update user set uprofilepic=?  where userid=?");
			//userid=Integer.parseInt(ServletActionContext.getRequest().getSession().getAttribute("userid").toString());
			//pstmt.setInt(1, userid);
			pstmt.setInt(2, 8);
			FileInputStream inputStream = new FileInputStream(destFile);
			pstmt.setBinaryStream(1,inputStream,(int)getImage().length());
			pstmt.execute();
		}
		
		return "success";
	}
	
	public String getfriends()
	{
		ConnectionPool data=new ConnectionPool();
		java.sql.Connection con= data.getConnection();
		PreparedStatement ps;
		try{
		ps=con.prepareStatement("select ufirstname,ulastname, userid from friends f,user u where (friend_sender=? or friend_receiver=?) and  friendshipstatus='Accepted' and (u.userid=f.friend_receiver or u.userid=f.friend_sender) and u.ufirstname not in (select ufirstname from user where userid=?)");
		ps.setInt(1,userid);
		ps.setInt(2, userid);
		ps.setInt(3,userid);
		count=0;
		ResultSet rs=ps.executeQuery();
			while(rs.next())
			{
				count++;
				friends obj=new friends();
				obj.setName(rs.getString(1));
				obj.setLastname(rs.getString(2));
				obj.setFriendid(rs.getInt(3));
				friend.add(obj);
			}
			setCount(count);
			
		}
		catch (Exception e) 
		{
			e.printStackTrace();
			return "error";
		}
		PreparedStatement ps1;
		try{
		ps1=con.prepareStatement("select count(*) from friends where (friend_sender=? or friend_receiver=?) and  friendshipstatus='Accepted'");
		for(friends i:friend)
		{
			ps1.setInt(1,i.getFriendid());
			ps1.setInt(2,i.getFriendid());
		
			ResultSet rs1=ps1.executeQuery();
			if(rs1.next())
			{
			   i.setFofcount(rs1.getInt(1));
			}
			
		}
		}
		catch (Exception e) 
		{
			e.printStackTrace();
			return "error";
		}
		
		ConnectionPool.freeConnection(con);
		return "success";
		
	}
	
	public ArrayList<institute> getInst() {
		return inst;
	}
	public void setInst(ArrayList<institute> inst) {
		this.inst = inst;
	}
	public ArrayList<organization> getOrgan() {
		return organ;
	}
	public void setOrgan(ArrayList<organization> organ) {
		this.organ = organ;
	}
	public String editabout()
	{
		return "success";
	}
	public String getCurrentplace() {
		return currentplace;
	}
	public void setCurrentplace(String currentplace) {
		this.currentplace = currentplace;
	}
	
	public String getHomeplace() {
		return homeplace;
	}
	public void setHomeplace(String homeplace) {
		this.homeplace = homeplace;
	}
	public String getLanguage() {
		return language;
	}
	public void setLanguage(String language) {
		this.language = language;
	}
	public String getAboutme() {
		return aboutme;
	}
	public void setAboutme(String aboutme) {
		this.aboutme = aboutme;
	}
	public String getMartialstatus() {
		return martialstatus;
	}
	public void setMartialstatus(String martialstatus) {
		this.martialstatus = martialstatus;
	}
	public String getUdob() {
		return udob;
	}
	public void setUdob(String udob) {
		this.udob = udob;
	}
	public String getUgender() {
		return ugender;
	}
	public void setUgender(String ugender) {
		this.ugender = ugender;
	}
	/**
	 * @return the uid
	 */
	public String getUid() {
		return uid;
	}
	/**
	 * @param uid the uid to set
	 */
	public void setUid(String uid) {
		this.uid = uid;
	}
	public String getCurrentname() {
		return currentname;
	}
	public void setCurrentname(String currentname) {
		this.currentname = currentname;
	}
	public String getCurrentfrom() {
		return currentfrom;
	}
	public void setCurrentfrom(String currentfrom) {
		this.currentfrom = currentfrom;
	}

	public int getCount() {
		return count;
	}
	public void setCount(int count) {
		this.count = count;
	}
	public File getImage() {
		return image;
	}
	public void setImage(File image) {
		this.image = image;
	}
	public String getImageContentType() {
		return imageContentType;
	}
	public void setImageContentType(String imageContentType) {
		this.imageContentType = imageContentType;
	}
	public String getImageFileName() {
		return imageFileName;
	}
	public void setImageFileName(String imageFileName) {
		this.imageFileName = imageFileName;
	}
	
	public int getProfilepicid() {
		return profilepicid;
	}
	public void setProfilepicid(int profilepicid) {
		this.profilepicid = profilepicid;
	}
	@Override
	public void setSession(Map<String, Object> session) {
		this.session = session;
	}
	@Override
	public void setServletRequest(HttpServletRequest arg0) {
		// TODO Auto-generated method stub
		
	}
	@Override
	public void setServletResponse(HttpServletResponse arg0) {
		// TODO Auto-generated method stub
		
	}
	public Map<String, Object> getSession() {
		return session;
	}
	public String getIsfriendRequestsent() {
		return isfriendRequestsent;
	}
	public void setIsfriendRequestsent(String isfriendRequestsent) {
		this.isfriendRequestsent = isfriendRequestsent;
	}
	public String getPurefriend() {
		return purefriend;
	}
	public void setPurefriend(String purefriend) {
		this.purefriend = purefriend;
	}
	public String getIshesentfriendrequest() {
		return ishesentfriendrequest;
	}
	public void setIshesentfriendrequest(String ishesentfriendrequest) {
		this.ishesentfriendrequest = ishesentfriendrequest;
	}
	
	

}
