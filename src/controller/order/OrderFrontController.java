package controller.order;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.Action;
import action.member.ControlMemberListAction;
import action.order.ControlOrderListAction;
import action.order.CopyDataAction;
import action.order.DeleteMainorderAction;
import action.order.MyorderDetailAction;
import action.order.OrderAction;
import action.order.OrderDetailProAction;
import action.order.OrderListAction;
import action.order.OrderProAction;
import action.order.UpdateOrderStatusAction;
import vo.ActionForward;
import vo.Cart;

@WebServlet("*.or")
public class OrderFrontController extends HttpServlet {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private void doProcess(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");

		ActionForward forward = null;
		Action action = null;
		String command = request.getServletPath();

		if(command.equals("/Order.or")) {
			System.out.println("Order.or 포워딩");
			forward = new ActionForward();
			action = new OrderAction();
			
			try {
				System.out.println("OrderAction으로 포워딩");
				forward = action.execute(request, response);
				
			} catch (Exception e) {
				System.out.println("OrderAction으로 포워딩 중 오류! - " +e.getMessage());
				e.printStackTrace();
			}
		}else if(command.equals("/OrderPro.or")){
			forward = new ActionForward();
			action = new OrderProAction();
			
			try {
				System.out.println("OrderProAction으로 포워딩");
				forward = action.execute(request, response);
				
			} catch (Exception e) {
				System.out.println("OrderProAction으로 포워딩 중 오류! - " +e.getMessage());
				e.printStackTrace();
			}
			
		}else if(command.equals("/MyOrderList.or")) {
			forward = new ActionForward();
			
			action = new OrderListAction();
			try {
				System.out.println("MyOrderListAction으로 포워딩");

				forward = action.execute(request, response);
			} catch(Exception e) {
				System.out.println("MyOrderListAction으로 포워딩 중 오류! - " +e.getMessage());

				e.printStackTrace();
			}
		} else if(command.equals("/CopyData.or")) {
			System.out.println("CopyData.or 포워딩");
			forward = new ActionForward();
			action = new CopyDataAction();
			try {
				System.out.println("CopyDataAction으로 포워딩");

				forward = action.execute(request, response);
			} catch(Exception e) {
				System.out.println("CopyDataAction으로 포워딩 중 오류! - " +e.getMessage());

				e.printStackTrace();
			}
		}else if(command.equals("/Payment.or")) {
			System.out.println("Payment.or 포워딩");
			forward = new ActionForward();
			forward.setPath("/order/payment.jsp");
		} else if(command.equals("/OrderDetail.or")) {
			System.out.println("OrderDetail.or 포워딩");
			forward = new ActionForward();
			action = new OrderDetailProAction();
			try {
				System.out.println("OrderDetailPro로 포워딩");
				
				forward = action.execute(request, response);
			} catch (Exception e) {
				System.out.println("OrderDetailPro로 포워딩 중 오류! - "+e.getMessage());
				e.printStackTrace();
			}
		} 
		
		// -------------------------주문 상세 페이지--------------------------------
		else if(command.equals("/MyorderDetail.or")) {
			System.out.println("MyOrderDetailPro");
//			forward = new ActionForward();
			
			action = new MyorderDetailAction();
			try {
				System.out.println("MyOrderListAction으로 포워딩");

				forward = action.execute(request, response);
			} catch(Exception e) {
				System.out.println("MyOrderListAction으로 포워딩 중 오류! - " +e.getMessage());

				e.printStackTrace();
			}
			
		}

		// -------------------------주문 관리 페이지--------------------------------
		else if (command.equals("/ControlOrderList.or")) {
//			forward = new ActionForward();

			action = new ControlOrderListAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				System.out.println("OrderListAction으로 포워딩 중 오류! - " + e.getMessage());

				e.printStackTrace();
			}
		}
		// -------------------------주문 상태 변경--------------------------------
		else if (command.equals("/UpdateOrderStatus.or")) {
//			forward = new ActionForward();

			action = new UpdateOrderStatusAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				System.out.println("UpdateOrderStatusAction으로 포워딩 중 오류! - " + e.getMessage());

				e.printStackTrace();
			}
		}
		// -------------------------주문 취소--------------------------------
		else if (command.equals("/DeleteMainorder.or")) {
//			forward = new ActionForward();

			action = new DeleteMainorderAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				System.out.println("UpdateOrderStatusAction으로 포워딩 중 오류! - " + e.getMessage());

				e.printStackTrace();
			}
		}
		// ------------공통적으로 수행할 포워딩 작업----------------
		if (forward != null) {

			if (forward.isRedirect()) {
				// Redirect 방식일 경우
				response.sendRedirect(forward.getPath());
			} else {
				// Dispatcher 방식일 경우
				RequestDispatcher dispatcher = request.getRequestDispatcher(forward.getPath());
				dispatcher.forward(request, response);
			}
		}
		// ------------공통적으로 수행할 포워딩 작업----------------

	}

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doProcess(request, response);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doProcess(request, response);
	}

}
