<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<script type="text/javascript">
	checkPasswdResult = false; 

	
	
	function checkPasswd(passwdForm) { 
		var passwd = passwdForm.value; 
		
		var element = document.getElementById('checkPasswdResult');
		
		var lengthRegex = /^[A-Za-z0-9!@#$%]{2,7}$/;
		var upperCaseRegex = /[A-Z]/;
		var lowerCaseRegex = /[a-z]/;
		var digitRegex = /[0-9]/;
		var specRegex = /[!@#$%]/;
		
		if(lengthRegex.exec(passwd)) {
			var count = 0;
			if(upperCaseRegex.exec(passwd)) count++;
			if(lowerCaseRegex.exec(passwd)) count++;
			if(digitRegex.exec(passwd)) count++;
			if(specRegex.exec(passwd)) count++;
			
// 			element.innerHTML = "��� ���� " + count;

			// ����(count) �� ���� ������ ���
			if(count == 4) {
				element.innerHTML = "��� ����(����)";
				checkPasswdResult = true; // �������� true �� ����
			} else if(count == 3) {
				element.innerHTML = "��� ����(����)";
				checkPasswdResult = true; // �������� true �� ����
			} else {
				element.innerHTML = "��� �Ұ�(������,����,Ư������(!@#$%)�� ȥ���Ͽ� 3~8���� �Է��ϼ���)";
				checkPasswdResult = false; // �������� false �� ����
			}

		} else {
			element.innerHTML = "��� �Ұ�(������,����,Ư������(!@#$%)�� ȥ���Ͽ� 3~8���� �Է��ϼ���)";
			checkPasswdResult = false; // �������� false �� ����
		}
		
	}
	
	function checkPasswd2(passwdForm){
		var passwd2 = passwdForm.value; 
		
		var element = document.getElementById('checkPasswdResult2');
		if(document.fr.password.value != document.fr.password2.value){
			element.innerHTML = "��й�ȣ ����ġ";
    		checkPasswdResult2 = true;    		
    	} else {
    		element.innerHTML = "��й�ȣ ��ġ";
    		checkPasswdResult2 = false;
    	}
	}
	
		
	// ���̵�, �н����� ����ǥ���� üũ �� �����̸� true ����(submit), �ƴϸ� false ����
	function check() {
		if(checkPasswdResult) {
			return true;
		} else {
			alert('�н����� ��Ģ Ȯ�� �ʼ�!');
			return false;
		}
	}
</script>
<%
	String id = (String) session.getAttribute("member_id");
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
			<h2 class="aside-tit"> ��й�ȣ ����</h2>
		</div>
			<div class="page-body">
			<form action="MemberPassPro.mo" method="POST" name="fr" onsubmit="return check()"
				style="border: 0.1px gray dashed; margin: 100px 20%; padding: 50px 10%; text-align: center;">
				<label style="font-size: 30px"><strong><%=id %></strong> ����</label>
				<br><br><br>
				
				<strong style="font-size: 18px">��й�ȣ�� �����Ͻðڽ��ϱ�?</strong>
				
				<br><br><hr><br><br><br>
				
				<input type="password" name="password" placeholder="������,����,Ư������(!@#$%)�� ȥ���Ͽ� 3~8���� �Է��ϼ���" 
				style="width: 450px; padding: 5px; text-align: center;" required="required" onkeyup="checkPasswd(this)">
							<div id="checkPasswdResult"></div>
				<br><br><br>
				
				<input type="password" name="password2" placeholder="Ȯ�� ��й�ȣ�� �Է��ϼ���" 
				style="width: 450px; padding: 5px; text-align: center;" required="required" onkeyup="checkPasswd2(this)"> 
							<div id="checkPasswdResult2"> </div>
				
				<input type="submit" value="Ȯ��" style="padding: 15px 20px; cursor: pointer;">
			</form>
			
			<!-- �ϴ� ���� -->
<div style="height: 150px"></div>
			</div>
		</div>
	</div>
</div>

<jsp:include page="/inc/footer.jsp" />
