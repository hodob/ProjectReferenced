<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String basicCode = request.getParameter("basicCode"); 
%>
<div class="cboth detail_tabmenu">
	<ul>
		<li><a href="#page01" class="tab_scroll">상품상세정보</a></li>
		<li><a href="#page02" class="tab_scroll">상품사용후기 (<span class="count1"></span>)</a></li>
		<li><a href="#page03" class="tab_scroll">상품 Q&amp;A (<span class="count2"></span>)</a></li>
		<li><a href="#page04" class="tab_scroll">상품구매안내</a></li>
		<li><a href="#page05" class="tab_scroll bdr">배송/반품안내</a></li>
	</ul>
</div>
