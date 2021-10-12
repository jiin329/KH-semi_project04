package user.dao;

import java.sql.Connection;
import static riceThief.common.JdbcTemplate.*;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import user.vo.User;

public class UserDao {

	public UserDao() {
		
	}
	public int insertUser(Connection conn,User vo) {
		 int result= -1;
		 String sql="insert into member(id,pw,uname,nickname,age,gender,email,phone,address,join_date,point,kind) values(?,?,?,?,?,?,?,?,?,sysdate,0,'U')";
		 try {
			 PreparedStatement pstmt=conn.prepareStatement(sql);
			 pstmt.setString(1,vo.getUid());
			 pstmt.setString(2,vo.getPw());
			 pstmt.setString(3,vo.getUname());
			 pstmt.setString(4,vo.getNickname());
			 pstmt.setInt(5,vo.getAge());
			 pstmt.setString(6, String.valueOf(vo.getGender()));
			 pstmt.setString(7,vo.getEmail());
			 pstmt.setString(8,vo.getPhone());
			 pstmt.setString(9,vo.getAddress());
			 result=pstmt.executeUpdate();
		 }catch(Exception e){
			 e.printStackTrace();	
		 }
		 return result;
	}
	
	public int loginUser(Connection conn,String uid,String pw,String nickname) {
		int result=-1;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
//		String sql="SELECT * FROM member WHERE ID = ? AND PASSWD = ?";
		StringBuffer sql = new StringBuffer();
		sql.append("SELECT pw,nickname").append(" FROM member").append(" WHERE ID = ?");
		try {
			pstmt=conn.prepareStatement(sql.toString());
			pstmt.setString(1, uid);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				if(rs.getString("pw").equals(pw)) {
					return 1;
				}else {
					return 0;
				}
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			close(rs);
			close(pstmt);
		}
		return result;
	}
	
	public User dupIdCheck(Connection conn,String uid) {
		User u=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		String sql="select * from member where id=?";
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, uid);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				u=new User();
				u.setUid(rs.getString("uid"));
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			close(rs);
			close(pstmt);
		}
		return u;
	}
	public User findId(Connection conn,String uname,String phone) {
		User u=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		String sql="select id from member where name=? and  phone=? ";
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, uname);
			pstmt.setString(2, phone);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				u=new User();
				u.setUid(rs.getString("uid"));
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			close(rs);
			close(pstmt);
		}
		return u;
	}
	
}