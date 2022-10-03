package action.product;

import java.io.File;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.Action;
import action.product.review.ProdReviewListAction;
import svc.product.ProductDeleteService;
import svc.product.ProductDetailSelectService;
import svc.product.qna.ProdQnaService;
import svc.product.review.ProdReviewListService;
import vo.ActionForward;
import vo.ProdQnaBean;
import vo.ProdReviewBean;
import vo.ProductBean;

public class ProductDeleteAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ActionForward forward = null;
		
		// OptionDeleteAction에서 넘겨 받음
		String basicCode = (String) request.getAttribute("basicCode");
		
		// basicCode에 딸린 review, qna의 file 이름 list가져오기
		ProdReviewListService reviewService = new ProdReviewListService();
		ArrayList<ProdReviewBean> reviewList = reviewService.getReviewList(basicCode);
		
		ProdQnaService qnaService = new ProdQnaService();
		ArrayList<ProdQnaBean> qnaList = qnaService.getQnaList(basicCode);
		
		// basicCode에 딸린 상품 mainImg, subImg 가져오기
		ProductDetailSelectService detailService = new ProductDetailSelectService();
		ArrayList<ProductBean> productDetailList = detailService.getProductDetailList(basicCode);
		
		ProductBean product = productDetailList.get(0);
		String mainImg = product.getMain_img();
		String subImg = product.getSub_img();
		
		ProductDeleteService productDeleteService = new ProductDeleteService();
		boolean isDelete = productDeleteService.deleteProduct(basicCode);
		
		if(!isDelete) {
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();

			out.println("<script>");
			out.println("alert('상품 삭제 실패!')");
			out.println("history.back()");
			out.println("</script>");
		} else {

			ServletContext context = request.getServletContext();
			
			// 해당 basicCode를 가지는 product의 저장된 이미지 삭제
			String saveFolder = "upload/productUploadImg";
			String realFolder = context.getRealPath(saveFolder);
			
			String[] main = mainImg.split("/");
			String[] sub = subImg.split("/");

			File f = new File(realFolder + "/" + mainImg);
			
			if(main.length == 0) {
				if(f.exists()) 		f.delete();
			} else {
				for(String s: main) {
					f = new File(realFolder + "/" + s);
					if(f.exists()) 	f.delete();
				}
			}
			if(sub.length == 0) {
				f = new File(realFolder + "/" + subImg);
				if(f.exists()) 		f.delete();
			} else {
				for(String s: sub) {
					f = new File(realFolder + "/" + s);
					if(f.exists()) 	f.delete();
				}
			}

			// 해당 basicCode를 가지는 review의 저장된 이미지 삭제
			saveFolder = "upload/prodReviewUpload";
			realFolder = context.getRealPath(saveFolder);
			
			for(ProdReviewBean review: reviewList) {
				String img = review.getProduct_img();
				f = new File(realFolder + "/" + img);
				if(f.exists()) 	f.delete();
			}

			// 해당 basicCode를 가지는 qna의 저장된 이미지 삭제
			saveFolder = "upload/prodQnaUpload";
			realFolder = context.getRealPath(saveFolder);
			
			for(ProdQnaBean qna: qnaList) {
				String img = qna.getQna_file();
				f = new File(realFolder + "/" + img);
				if(f.exists()) 	f.delete();
			}
			
			
			forward = new ActionForward();
			forward.setPath("ControlProductList.po");
			forward.setRedirect(true);
		}
		
		return forward;
	}

}
