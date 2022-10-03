package controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.Action;
import action.MainSelectAction;
import vo.ActionForward;

/**
 * Servlet implementation class MainFrontController
 */
@WebServlet("*.go")
public class MainFrontController extends HttpServlet {
	
	protected void doProcess(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		
		Action action = null;
		ActionForward forward = null;
		String command = request.getServletPath();
		
		if(command.equals("/Main.go")) {
			action = new MainSelectAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {

				e.printStackTrace();
			}
		}
		// -------------- 관리자 리스트 ----------------
		else if(command.equals("/ControlList.go")) {
			forward = new ActionForward();
			forward.setPath("/admin_control/control_main.jsp");
		}
		
		if(forward != null) {
			if(forward.isRedirect()) {
				response.sendRedirect(forward.getPath());
			} else {
				RequestDispatcher dispatcher = request.getRequestDispatcher(forward.getPath());
				dispatcher.forward(request, response);
			}
		}
	}
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doProcess(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
