<%@page import="java.text.SimpleDateFormat"%>
<%@page import="vo.CommBean"%>
<%@page import="vo.ProductBean"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:include page="/inc/header_index.jsp" />
<jsp:include page="/quickMenu_index.jsp" />
<link type="text/css" rel="stylesheet" href="css/common.css" />
<link type="text/css" rel="stylesheet" href="css/main_1.css" />
<link type="text/css" rel="stylesheet" href="css/header.css" />
<link type="text/css" rel="stylesheet" href="css/menu_1.css" />
<link type="text/css" rel="stylesheet" href="css/team.css" />


<style>
.event_ban_area > ul {
	position: flex;
}
.event_ban_area ul > li {
	display: inline-block;
  	align-items: center;
  	width: 20%;
  	height: 200px;
  	margin: 50px 20px;
}
.event_ban_area ul > li img {
	padding: 50px 0;
}
</style>

<%
	String member_id =(String)session.getAttribute("member_id");
	ArrayList<ProductBean> newList =(ArrayList<ProductBean>)request.getAttribute("newList");
	ArrayList<ProductBean> productList = (ArrayList<ProductBean>)request.getAttribute("productList");
	ArrayList<String> likeBaiscCodeList = (ArrayList<String>)request.getAttribute("likeBasicCodeList");
	DecimalFormat priceFormat = new DecimalFormat("###,###");
	SimpleDateFormat sdfYMD = new SimpleDateFormat("yy-MM-dd");
	
	ArrayList<CommBean> commList = (ArrayList) request.getAttribute("commList");
%>
<!-- Slider -->
<section class="section-slide">
	<div class="wrap-slick1">
		<div class="slick1">
			<div class="item-slick1"
				style="background-image: url(images/main_001.jpg);"></div>

			<div class="item-slick1"
				style="background-image: url(images/main_002.jpg);"></div>
		</div>
	</div>
</section>


<!-- 게시글 새 글 리스트 -->
<section class="bg0 p-t-23">
	<div class="container">
		<div class="main_pro_title_area cboth ">
			<div class="main_pro_title cboth">NEW ARTICLE</div>
		</div>

		<div class="row">
			<%
		for(int i=0; i<commList.size(); i++){
			CommBean article = commList.get(i);
			int c = article.getCommentCount();
			%>
			<div class="col-sm-6 col-md-4 col-lg-3 p-b-35 isotope-item">
						<!-- Block2 -->
						<div class="block2">
							<div class="block2-pic hov-img0">
								<a href="CommDetail.co?num=<%=article.getNum() %>" class="hov-img0 how-pos5-parent">
									<img src="upload/commUpload/<%=article.getImg() %>" alt="IMG-BLOG" onerror="this.style.display='none'"/>
								</a>
							</div>
							<div id="how-pos6" class="bookimg<%=article.getNum() %>" onclick="checkBook(<%=article.getNum() %>)">
								<img src="images/icons/bookmark_before.png" onerror="this.style.display='none'"/>
							</div>
	
							<div class="block2-txt flex-w flex-t p-t-14">
								<div class="block2-txt-child1 flex-col-l ">
									<a href="CommDetail.co?num=<%=article.getNum() %>"  class="stext-104 cl4 hov-cl1 trans-04 js-name-b2 p-b-6">
										<%=article.getSubject() %><span><%=(c > 0 ? "("+c+")" : "")%></span>
									</a>
									<div class="stext-105 cl3 w-full">
										<span>
											<%=article.getUsername() %>
										</span>
										<span class="float-r">
											<%=sdfYMD.format(article.getDate()) %>
										</span>
									</div>
									<div class="stext-105 cl3">
										<span>조회수 <%=article.getReadCount()%> &#183;</span>
										<span class="bookCount<%=article.getNum()%>">북마크 <%=article.getBookCount()%></span>
									</div>
								</div>
							</div>
						</div>
					</div>
		<% }%>
		</div>
	</div>
	
</section>


<div class="event_ban_area">
	<ul>
		<li><a href="ProductShop.po?type=X&xcode=CLOTHES">
			<img src="https://img.icons8.com/cotton/64/000000/hanger--v1.png"/><br>
			<b>CLOTHES</b>
		</a></li>
		
		<li><a href="ProductShop.po?type=X&xcode=BAGS">
			<img src="https://img.icons8.com/ios/64/000000/bag-back-view.png"/><br>
			<b>BAGS</b>
		</a></li>
		
		<li><a href="ProductShop.po?type=X&xcode=SHOES">
			<img src="https://img.icons8.com/ios/64/000000/sneakers.png"/><br>
			<b>SHOES</b>
		</a></li>
		
		<li><a href="CommList.co">
			<img src="https://img.icons8.com/ios/64/000000/clipboard.png"/><br>
			<b>COMMUNITY</b>
		</a></li>
	</ul>
</div>
<div class="cboth"></div>




<section class="bg0 p-t-23">
	<div class="container">
		<div class="main_pro_title_area cboth ">
			<div class="main_pro_title cboth">NEW ARRIVALS</div>
		</div>

		<div class="row">
			<%
		for(int i=0; i<newList.size(); i++){
			String[] main = newList.get(i).getMain_img().split("/");
			String likeCheck = member_id+"/"+newList.get(i).getBasicCode();
			%>
			<div class="col-sm-6 col-md-4 col-lg-3 p-b-35 isotope-item blogBox moreBox">
				<div class="block2">
					<div class="block2-pic hov-img0">
						<a href="ProductDetail.po?basicCode=<%=newList.get(i).getBasicCode()%>"
							class="stext-104 cl4 hov-cl1 trans-04 js-name-b2 p-b-6"> <img
							src="upload/productUploadImg/<%=main[0]%>" alt="IMG-PRODUCT">
						</a> 
					</div>

					<div class="block2-txt flex-w flex-t p-t-14">
						<div class="block2-txt-child1 flex-col-l ">
							<a href="ProductDetail.po?basicCode=<%=newList.get(i).getBasicCode() %>"
								class="stext-104 cl4 hov-cl1 trans-04 js-name-b2 p-b-6">
								<%=newList.get(i).getName()%></a>
								<span class="stext-105 cl3"> <%=priceFormat.format(newList.get(i).getPrice())%>원</span>
						</div>

						<div class="block2-txt-child2 flex-r p-t-3">
							<%if(member_id != null){ %>
							<button 
								class="btn-addwish-b2 dis-block pos-relative js-addwish-b2 <%
								if(likeBaiscCodeList.contains(newList.get(i).getBasicCode())){
								%>js-addedwish-b2<%
								}else{
									%>js-addedwish-b1<%
									}%>" 
								value="<%=likeCheck%>">
								<img class="icon-heart1 dis-block trans-04"
								src="images/icons/icon-heart-01.png" alt="ICON"> 
								<img class="icon-heart2 dis-block trans-04 ab-t-l"
								src="images/icons/icon-heart-02.png" alt="ICON">
							</button>
							<%}else{ %>
							<a href="#"
								class="not_member">
								<img class="icon-heart1 dis-block trans-04"
								src="images/icons/icon-heart-01.png" alt="ICON">
							</a>
							<%} %>
						</div>
					</div>
				</div>
			</div>
		<% }%>
		</div>
	</div>
	
</section>



<section class="bg0 p-t-23">
	<div class="container">


		<div class="main_pro_title_area cboth ">
			<div class="main_pro_title cboth">BEST SELLER</div>
		</div>


		<div class="row">
			<%
		for(int i=0; i<productList.size(); i++){
			String[] main = productList.get(i).getMain_img().split("/");
			String likeCheck = member_id+"/"+productList.get(i).getBasicCode();
			%>
			<div class="col-sm-6 col-md-4 col-lg-3 p-b-35 isotope-item blogBox moreBox">
				<div class="block2">
					<div class="block2-pic hov-img0">
						<a href="ProductDetail.po?basicCode=<%=productList.get(i).getBasicCode()%>"
							class="stext-104 cl4 hov-cl1 trans-04 js-name-b2 p-b-6"> <img
							src="upload/productUploadImg/<%=main[0]%>" alt="IMG-PRODUCT">
						</a> 
					</div>

					<div class="block2-txt flex-w flex-t p-t-14">
						<div class="block2-txt-child1 flex-col-l ">
							<a href="ProductDetail.po?basicCode=<%=productList.get(i).getBasicCode() %>"
								class="stext-104 cl4 hov-cl1 trans-04 js-name-b2 p-b-6">
								<%=productList.get(i).getName()%></a>
								<span class="stext-105 cl3"> <%=priceFormat.format(productList.get(i).getPrice())%>원</span>
						</div>

						<div class="block2-txt-child2 flex-r p-t-3">
							<%if(member_id != null){ %>
							<button 
								class="btn-addwish-b2 dis-block pos-relative js-addwish-b2 <%
								if(likeBaiscCodeList.contains(productList.get(i).getBasicCode())){
								%>js-addedwish-b2<%
								}else{
									%>js-addedwish-b1<%
									}%>" 
								value="<%=likeCheck%>">
								<img class="icon-heart1 dis-block trans-04"
								src="images/icons/icon-heart-01.png" alt="ICON"> 
								<img class="icon-heart2 dis-block trans-04 ab-t-l"
								src="images/icons/icon-heart-02.png" alt="ICON">
							</button>
							<%}else{ %>
							<a href="#"
								class="not_member">
								<img class="icon-heart1 dis-block trans-04"
								src="images/icons/icon-heart-01.png" alt="ICON">
							</a>
							<%} %>
						</div>
					</div>
				</div>
			</div>
		<% }%>
		</div>
	</div>
	
</section>
<%
	
	String[] name ={"SUJIN","JUNGHA","SANGBIN","BYUNGHOON","UNA","YEJIN","SEYONG"};
	String[] github={"jeongsujin001","pumkin-ha","SangBinKR","lbhlucky","GoUNaa","eee269","xeyong"};
%>
<section id="team">
	<div class="container">
		<div class="main_pro_title_area cboth ">
			<div class="main_pro_title cboth">MEET OUR TEAM</div>
		</div>
		<div class="row mt-50">
			<%
				for (int i = 0; i < 7; i++) {
			%>
			<div class="col-xl-3 col-sm-6 mb-5">
				<div class="team-single wow zoomIn" data-wow-delay=".3s">
					<div class="team-thumb">
						<img
							src="upload/developers/<%=i%>.png"
							alt="" />
						<div class="social-icons style-2">
							<a href="https://github.com/<%=github[i]%>" target="blank" class="fa fa-github"></a>
							<a href="" class="fa fa-instagram"></a>
							<a href="" class="fa fa-facebook"></a>
						</div>
					</div>
					<div class="team-bio">
						<h4><%=name[i] %></h4>
						<h5>#OOTD</h5>
					</div>
				</div>
			</div>
			<%
				}
			%>
		</div>
	</div>
</section>

<script type="text/javascript">
// 북마크버튼 클릭시(북마크 추가 또는 북마크 제거)
function checkBook(num){
	var member_id = '<%=member_id%>';
	if(member_id=='null'){
		if(!confirm("로그인을 하셔야 이용 가능합니다. 로그인을 하시겠습니까?")){
			return;
		}else{
			location.href='MemberLoginForm.mo';
		}
	}else{
		$.ajax({
			url: "CommBook.co",
            type: "POST",
            data: {
                num: num,
            },
            success: function () {
            	var path = $('.bookimg'+num).children("img");
            	path.attr("src",function(index,attr){
            		if(attr.match('before')){
            			swal("٩(ˊᗜˋ*)و" ,"게시글이 북마크에 추가됬습니다!", "success");
            			return attr.replace("before","after");
            		}else{
            			swal("(｡•́︿•̀｡)","게시글이 북마크에서 삭제됬습니다!", "success");
            			return attr.replace("after","before");
            		}
            	});
		        bookmarkCount(num);
            },
		});
	}
}
// 게시글 북마크 수
function bookmarkCount(num) {
	var articleNum = num;
	$.ajax({
		url: "CommBookCount.co",
        type: "POST",
        data: {
            num: articleNum
		},
		success : function(json) {
			var img = "images/icons/bookmark_after.png";
			var jsonP = JSON.parse(json);
			var book = "북마크 "+jsonP.total;
			if(!num){
				for(key in jsonP.list){
					var num = jsonP.list[key][key];
					$(".bookimg"+num).children().attr("src",img);
				}
			}
			$(".bookCount"+articleNum).html(book);
		},
	})
};
bookmarkCount();
</script>

<jsp:include page="/inc/footer.jsp" />
