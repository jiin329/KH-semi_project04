package comment.service;

import java.sql.Connection;
import java.util.ArrayList;

import comment.dao.CommentDao;
import comment.vo.Comment;
import riceThief.common.JdbcTemplate;

public class CommentService {
	public int insertComment(Comment vo) {
		int result =-1;
		Connection conn = JdbcTemplate.getConnection();
		result = new CommentDao().insertComment(conn, vo);
		JdbcTemplate.close(conn);
		return result;	
	}
	public int getCommentCount(int rno) {
		int result = 0;
		Connection conn = JdbcTemplate.getConnection();
		result = new CommentDao().getCommentCount(conn, rno);
		return result;
	}
	public ArrayList<Comment> commentList(int rno, int start, int end) {
		ArrayList<Comment> volist = null;
		Connection conn = JdbcTemplate.getConnection();
		volist = new CommentDao().commentList(conn, rno, start, end);
		JdbcTemplate.close(conn);
		return volist;
	}
	public Comment commentUpdateGet(int comno) {
		Comment vo = null;
		Connection conn = JdbcTemplate.getConnection();
		vo = new CommentDao().commentUpdateGet(conn, comno);
		JdbcTemplate.close(conn);
		return vo;
	}
	//update
	public int updateComment(Comment vo) {
		int result = -1;
		Connection conn = JdbcTemplate.getConnection();
		result = new CommentDao().updateComment(conn, vo);
		JdbcTemplate.close(conn);
		return result;
	}
	//delete
	public int deleteComment(int comno) {
		int result = -1;
		Connection conn = JdbcTemplate.getConnection();
		result = new CommentDao().deleteComment(conn, comno);
		JdbcTemplate.close(conn);
		return result;
	}
}