package comment.service;

import java.sql.Connection;
import java.util.ArrayList;

import comment.dao.CommentDao;
import comment.vo.Comment;
import riceThief.common.JdbcTemplate;

public class CommentService {
	public int getCommentCount(int rno) {
		int result = 0;
		Connection conn = JdbcTemplate.getConnection();
		result = new CommentDao().getCommentCount(conn, rno);
		return result;
	}
	//read comment
	public ArrayList<Comment> commentList(int rno, int start, int end) {
		ArrayList<Comment> volist = null;
		Connection conn = JdbcTemplate.getConnection();
		volist = new CommentDao().commentList(conn, rno, start, end);
		JdbcTemplate.close(conn);
		return volist;
	}
}