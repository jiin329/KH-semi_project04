package notice.service;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.util.ArrayList;

import notice.vo.Notice;
import recipe.model.dao.RecipeDao;
import recipe.model.vo.Recipe;
import notice.dao.NoticeDao;
import riceThief.common.JdbcTemplate;

public class NoticeService {
	
	public ArrayList<Notice> noticeList(int start , int end) {
		ArrayList<Notice> volist = null;
		Connection conn = JdbcTemplate.getConnection();
		volist= new NoticeDao().noticeList(conn, start, end);
		JdbcTemplate.close(conn);
		return volist;
	}
	
	public int getNoticeCount() {
		int result = 0;
		Connection conn = JdbcTemplate.getConnection();
		result = new NoticeDao().getNoticeCount(conn);
		return result;
	}
	
	public Notice noticeDetailList(int nno) {
		Connection conn = JdbcTemplate.getConnection();
		Notice vo = new Notice();
		vo = new NoticeDao().noticeDetailList(conn, nno);
		JdbcTemplate.close(conn);
		return vo;
	}
	
	public int insertNotice(Notice vo) {
		int result =-1;
		Connection conn = JdbcTemplate.getConnection();
			
		result = new NoticeDao().insertNotice(conn, vo);				
		JdbcTemplate.close(conn);
		return result;
	}
	public int deleteNotice(int nno) {
		int result = -1;
		Connection conn = JdbcTemplate.getConnection();
		result = new NoticeDao().deleteNotice(conn, nno);
		JdbcTemplate.close(conn);
		return result;
		
	}
//	
//	public Notice Noticelist(int nno) {
//		Connection con = JdbcTemplate.getConnection();
//		Notice vo = new Notice();
//		vo = new NoticeDao().Noticelist(con, nno);
//		JdbcTemplate.close(con);
//		return vo;
//		
//	}
//	public Notice viewNotice(int nno) {
//		Connection con = JdbcTemplate.getConnection();
//		 Notice vo = new Notice();
//		 vo = new NoticeDao().viewNotice(nno);
//		 JdbcTemplate.close(con);
//		return vo;
//		 
//}
}
