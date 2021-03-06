package user.basket.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cartDetail.vo.CartDetailVo;
import user.basket.service.BasketService;

/**
 * Servlet implementation class SelectBasketServlet
 */
@WebServlet("/selectbasket")
public class SelectBasketServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SelectBasketServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("application/json; charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		request.setCharacterEncoding("UTF-8");
		
		String id = (String)request.getSession().getAttribute("sessionID");

		ArrayList<CartDetailVo> bkList = new BasketService().basketList(id);
		
		
		request.setAttribute("bkList", bkList);
		request.getRequestDispatcher("./WEB-INF/view/basket.jsp").forward(request, response);
	}
}
