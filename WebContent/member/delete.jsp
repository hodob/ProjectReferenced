<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%
	String member_id = (String) session.getAttribute("member_id");
%>

<jsp:include page="/inc/header.jsp" />

<link type="text/css" rel="stylesheet" href="css/common.css" />
<link type="text/css" rel="stylesheet" href="css/mp_main.css" />
<link type="text/css" rel="stylesheet" href="css/header.css" />
<link type="text/css" rel="stylesheet" href="css/menu_2.css" />

<div id="contentWrapper">
	<div id="contentWrap">
		<hr>
		<div id="content">
		
		<div id="aside">
			<h2 class="aside-tit"> ȸ�� Ż�� </h2>
		</div>
			<div class="page-body">
			<form action="MemberDeletePro.mo" method="POST"
				style="border: 0.1px gray dashed; margin: 100px 20%; padding: 50px 10%; text-align: center;">
				<label style="font-size: 30px"><strong><%=member_id %></strong> ����</label>
				<br><br><br>
				
				<strong style="font-size: 18px">ȸ�� Ż�� ���Ͻʴϱ�?</strong>
				
				<br><br><hr><br><br><br>
				
				<input type="password" name="password" placeholder="Ȯ�� ��й�ȣ�� �Է��ϼ���" 
				style="width: 450px; padding: 5px; text-align: center;" required="required">
				<br><br><br>
				
				<input type="submit" value="Ȯ��" style="padding: 15px 20px; cursor: pointer;">
			</form>
			
			<!-- �ϴ� ���� -->
<div style="height: 150px"></div>
			</div>
		</div>
	</div>
</div>


<jsp:include page="/inc/footer.jsp" />