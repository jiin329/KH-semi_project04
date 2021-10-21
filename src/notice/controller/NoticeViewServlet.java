package notice.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import notice.service.NoticeService;
import notice.vo.Notice;

/**
 * Servlet implementation class NoticeServlet
 */
@WebServlet("/usernotice")
public class NoticeViewServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public NoticeViewServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html; charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		request.setCharacterEncoding("UTF-8");
		
		final int PAGE_SIZE = 10;  //한페이지당 글 수 
		final int PAGE_BLOCK = 5;  //한화면에 나타날 페이지 링크 수
		int nCount = 0;  //총 글수
		int pageCount = 0;  //총페이지 수 
		int startPage = 1;  //화면에 나타날 시작페이지
		int endPage = 1;  //화면에 나타날 마지막페이지
		int currentPage =1;  //눌려진 페이지
		int startNnum = 1; //화면에 나타날 글 번호
		int endNnum = 1; //화면에 나타날 글 번호
		
		String pageNum = request.getParameter("pagenum");
		if(pageNum != null) {
			currentPage = Integer.parseInt(pageNum);
		}
		nCount = new NoticeService().getNoticeCount();
		System.out.println("nCount:"+ nCount);
		pageCount = (nCount/PAGE_SIZE) + (nCount%PAGE_SIZE == 0 ? 0 : 1);

		startNnum = (currentPage - 1) * PAGE_SIZE + 1;
		endNnum = startNnum + PAGE_SIZE -1;
		if(endNnum > nCount) {
			endNnum = nCount;
		}
		
		if(currentPage%PAGE_BLOCK == 0) {
			startPage = (currentPage/PAGE_BLOCK - 1) *PAGE_BLOCK + 1;
		}else {
			startPage = (currentPage/PAGE_BLOCK) *PAGE_BLOCK + 1;
		}
		
		endPage = startPage + PAGE_BLOCK - 1;
		if(endPage > pageCount) {
			endPage = pageCount;
		}
		System.out.println(endNnum);
		ArrayList<Notice> volist = new NoticeService().noticeList(startNnum, endNnum);
		System.out.println("여기 들어오나? 2");
		System.out.println("noticeList:"+ volist);
		
		request.setAttribute("noticeVoList", volist);
		request.setAttribute("startPage", startPage);
		request.setAttribute("endPage", endPage);
		request.setAttribute("pageCount", pageCount);

		request.getRequestDispatcher("./WEB-INF/view/notice_main.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
