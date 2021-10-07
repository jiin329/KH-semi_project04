package recipe.model.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import ingredient.vo.Ingredient;
import recipe.model.vo.Recipe;
import recipe_steps.vo.RecipeSteps;
import riceThief.common.JdbcTemplate;

public class RecipeDao {
	public RecipeDao() {}
	
	public int insertRecipe(Connection conn, Recipe recipeVo, ArrayList<Ingredient> IngreList, ArrayList<RecipeSteps> stepList) {
		int result = -1;
		PreparedStatement ps = null;
		ResultSet rs = null;
	
		String recipeInsert = "insert into recipe"
					+ " values(rec_seq_no.NEXTVAL, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, sysdate)";
		String ingreInsert = "insert into ingredient"
				+ " values(ingre_seq_no.NEXTVAL, ?, ?, rec_seq_no.CURRVAL)";
		String stepInsert = "insert into recipe_steps"
				+ " values(step_seq_no.NEXTVAL, ?, ?, rec_seq_no.CURRVAL)";
		try {
			//레시피
			ps = conn.prepareStatement(recipeInsert);
			ps.setString(1, recipeVo.getUid());
			ps.setString(2, recipeVo.getRec_img());
			ps.setString(3, recipeVo.getRec_title());
			ps.setString(4, recipeVo.getRec_summary());
			ps.setString(5, recipeVo.getRec_tip());
			ps.setString(6, recipeVo.getInfo_serving());
			ps.setString(7, recipeVo.getInfo_time());
			ps.setString(8, recipeVo.getInfo_level());
			ps.setString(9, recipeVo.getRec_video());
			ps.setInt(10, recipeVo.getRec_cate_no());
			result = ps.executeUpdate();
			JdbcTemplate.close(ps);
			
			//재료
			for(int i=0; i<IngreList.size(); i++) {
				ps = conn.prepareStatement(ingreInsert);
				ps.setString(1, IngreList.get(i).getIngre_name());
				ps.setString(2, IngreList.get(i).getIngre_unit());
				result = ps.executeUpdate();
			}
			
			JdbcTemplate.close(ps);
			
			//순서
			for(int i=0; i<stepList.size(); i++) {
				ps = conn.prepareStatement(stepInsert);
				ps.setString(1, stepList.get(i).getStep_content());
				ps.setString(2, stepList.get(i).getStep_img());
				result = ps.executeUpdate();
			}
		} catch (Exception e) {
			//-1
			System.out.println("연결 실패");
			e.printStackTrace();
		} finally {
			JdbcTemplate.close(rs);
			JdbcTemplate.close(ps);
		}
		return result;
	}
	public int getRecipeCount(Connection conn, int catenum) {
		int result = 0;
		String countAllQuery = "select count(recipe_no) from recipe";
		String countCateQuery = "select count(recipe_no) from recipe where rec_cate_no like ?";
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			if(catenum == 0) {
				ps = conn.prepareStatement(countAllQuery);
			}else {
				ps = conn.prepareStatement(countCateQuery);
				ps.setInt(1, catenum);
			}
			rs = ps.executeQuery();
			if(rs.next()) {
				result = rs.getInt(1);
			}
		} catch (Exception e) {
			//-1
			System.out.println("연결 실패");
			e.printStackTrace();
		} finally {
			JdbcTemplate.close(rs);
			JdbcTemplate.close(ps);
		}
		return result;
	}
	public ArrayList<Recipe> recipeList(Connection conn, int start , int end, int catenum) {
		ArrayList<Recipe> volist = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		String selectAllQuery = "select t2.recipe_no, t2.rec_img, t2.rec_title"
				+ " from (select ROWNUM r, t1.* from recipe t1 order by recipe_no desc) t2"
				+ " where t2.r between ? and ?";
		
		String selectCateQuery = "select t2.recipe_no, t2.rec_img, t2.rec_title"
				+ " from (select ROWNUM r, t1.* from recipe t1 where t1.rec_cate_no like ? order by recipe_no desc) t2"
				+ " where t2.r between ? and ?";
		try {
			if(catenum == 0) {
				ps = conn.prepareStatement(selectAllQuery);
				ps.setInt(1, start);
				ps.setInt(2, end);
			}else {
				ps = conn.prepareStatement(selectCateQuery);
				ps.setInt(1, catenum);
				ps.setInt(2, start);
				ps.setInt(3, end);
			}
			rs = ps.executeQuery();
			
			volist = new ArrayList<Recipe>();
			while(rs.next()) {
				Recipe vo = new Recipe();
				vo.setRecipe_no(rs.getInt("recipe_no"));
				vo.setRec_img(rs.getString("rec_img"));
				vo.setRec_title(rs.getString("rec_title"));
				volist.add(vo);
			}
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println(e.getMessage());
		} finally {
			JdbcTemplate.close(rs);
			JdbcTemplate.close(ps);
		}
		return volist;
	}
	public Recipe recipeDetailList(Connection conn, int rno) {
		PreparedStatement ps = null;
		ResultSet rs = null;
		Recipe vo = new Recipe();
		String query = "select * from recipe where recipe_no like ?";
		try {
			ps = conn.prepareStatement(query);
			ps.setInt(1, rno);
			rs = ps.executeQuery();
			
			while(rs.next()) {
				vo.setRecipe_no(rs.getInt("recipe_no"));
				vo.setUid(rs.getString("id"));
				vo.setRec_img(rs.getString("rec_img"));
				vo.setRec_title(rs.getString("rec_title"));
				vo.setRec_summary(rs.getString("rec_summary"));
				vo.setRec_tip(rs.getString("rec_tip"));
				vo.setInfo_serving(rs.getString("info_serving"));
				vo.setInfo_time(rs.getString("info_time"));
				vo.setInfo_level(rs.getString("info_level"));
				vo.setRec_video(rs.getString("rec_video"));
				vo.setRec_cate_no(rs.getInt("rec_cate_no"));
				vo.setRec_write_date(rs.getDate("rec_write_date"));
			}
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println(e.getMessage());
		} finally {
			JdbcTemplate.close(rs);
			JdbcTemplate.close(ps);
		}
		return vo;
	}
	public ArrayList<Ingredient> ingreList(Connection conn, int rno){
		ArrayList<Ingredient> volist = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		String selectIngreQuery = "select ingre_name, ingre_unit from ingredient where recipe_no like ? order by ingre_no";
		try {
			ps = conn.prepareStatement(selectIngreQuery);
			ps.setInt(1, rno);
			rs = ps.executeQuery();
			
			volist = new ArrayList<Ingredient>();
			while(rs.next()) {
				Ingredient vo = new Ingredient();
				vo.setIngre_name(rs.getString("ingre_name"));
				vo.setIngre_unit(rs.getString("ingre_unit"));
				volist.add(vo);
			}
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println(e.getMessage());
		} finally {
			JdbcTemplate.close(rs);
			JdbcTemplate.close(ps);
		}
		return volist;
	}
	public ArrayList<RecipeSteps> stepList(Connection conn, int rno){
		ArrayList<RecipeSteps> volist = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		String selectStepQuery = "select rownum r, step_content, step_img from recipe_steps where recipe_no like ? order by step_no";
		try {
			ps = conn.prepareStatement(selectStepQuery);
			ps.setInt(1, rno);
			rs = ps.executeQuery();
			
			volist = new ArrayList<RecipeSteps>();
			while(rs.next()) {
				RecipeSteps vo = new RecipeSteps();
				vo.setStep_no(rs.getInt("r"));
				vo.setStep_content(rs.getString("step_content"));
				vo.setStep_img(rs.getString("step_img"));
				volist.add(vo);
			}
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println(e.getMessage());
		} finally {
			JdbcTemplate.close(rs);
			JdbcTemplate.close(ps);
		}
		return volist;
	}
}