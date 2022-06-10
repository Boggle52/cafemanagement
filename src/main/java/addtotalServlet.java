

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class addtotalServlet
 */
@WebServlet("/addtotal")
public class addtotalServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public addtotalServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		incomeDTO iDto = new incomeDTO();
		iDto.setMobile(request.getParameter("mobile"));
		iDto.setSeqno(Integer.parseInt(request.getParameter("seqno")));
		iDto.setQty(request.getParameter("qty"));
		iDto.setPrice(request.getParameter("price"));
		incomeDAO dao = new incomeDAO();
		dao.addTotal(iDto);
		String outstr="";
		ArrayList<incomeDTO> list = dao.listIncome();
		for(int i = 0; i < list.size(); i++) {
			incomeDTO data = new incomeDTO();
			data = list.get(i);
			outstr += "<option>"+data.getMobile()+", "+data.getName()+", "
					+data.getQty()+", "+data.getPrice()+", "+data.getIncome_date()+"</option>";
		}
		response.getWriter().print(outstr);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
