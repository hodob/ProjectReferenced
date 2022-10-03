<%@page import="vo.AddrBean"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html>
<head>
<title>최근 배송지 검색</title>
<meta http-equiv="CONTENT-TYPE" content="text/html;charset=EUC-KR">
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
<meta name="apple-mobile-web-app-capable" content="no">
<meta name="apple-mobile-web-app-status-bar-style"
	content="black-translucent">
<meta name="format-detection" content="telephone=no">
<script type="text/javascript" src="jquery-1.7.2.min.js"></script>
<script type="text/javascript" src="jquery.form.js"></script>
<script type="text/javascript" src="jquery.metadata.js"></script>
<link rel="apple-touch-icon-precomposed" href="/m/images/icon.png">
<link type="text/css" rel="stylesheet"
	href="/images/d3/m_01/css/font-awesome.min.css" />
</head>
<script type="text/javascript">
	// 취소 버튼 클릭 시
	function cancle(){
		window.close();
	}
	
</script>
<style text="text/css">
/* input[type="text"], input[type="date"], input[type="tel"], input[type="number"], */
/* 	input[type="email"], input[type="password"], select { */
/* 	height: 35px; */
/* 	border: 1px solid #bbb; */
/* 	vertical-align: middle; */
/* 	padding-left: 10px; */
/* 	box-sizing: border-box; */
/* 	-webkit-border-radius: 0; */
/* 	border-radius: 0; */
/* } */

form, fieldset, legend, label {
	margin: 0;
	padding: 0;
	border: 0;
}

fieldset legend {
	position: absolute;
	visibility: hidden;
	overflow: hidden;
	width: 0;
	height: 0;
	margin: 0;
	padding: 0;
	font: 0/0 Arial;
}

* {
	padding: 0;
	margin: 0;
}

a {
	text-decoration: none;
}

li {
	list-style: none;
}
/* pc 팝업 */
.address-pop {
	padding: 30px 20px;
}

.address-pop .tab-area {
	width: 100%;
	border-bottom: 2px solid #2868de;
}

.address-pop .tab-cnt {
	width: 100%;
}

.address-pop .tab-area ul {
	overflow: hidden;
}

.address-pop .tab-area ul li {
	width: 128px;
	float: left;
	border-top: 1px solid #cccccc;
	border-left: 1px solid #cccccc;
	border-right: 1px solid #cccccc;
}

.address-pop .tab-area ul li a {
	display: block;
	height: 30px;
	line-height: 30px;
	text-align: center;
	font-size: 12px;
	color: #666666;
	font-weight: bold;
}

.address-pop .tab-area ul li:first-child {
	border-right: none;
}

.address-pop .tab-area ul li.on {
	border-left: 1px solid #2868de;
	border-right: 1px solid #2868de;
	border-top: 1px solid #2868de;
}

.address-pop .tab-area ul li.on a {
	background: #6a8beb;
	color: #ffffff;
}

.address-pop .tab-area .title-box {
	width: 128px;
	border-top: 1px solid #ccc;
	border-left: 1px solid #ccc;
	border-right: 1px solid #ccc;
	height: 30px;
	line-height: 30px;
	text-align: center;
	font-size: 12px;
	font-weight: bold;
	color: #666666; /*background: #2868de;*/
}

.address-pop .adress {
	max-height: 464px;
	overflow-y: auto;
	border-bottom: 1px solid #cccccc;
}

.address-pop .adress li {
	display: table;
	width: 100%;
	padding: 13px 0px;
	border-top: 1px solid #cccccc; #
	overflow: hidden;
	position: relative;
}

.address-pop .adress li:first-child {
	border-top: none;
}

.address-pop .adress li .check {
	position: absolute;
	left: 10px;
}

.address-pop .adress li .text {
	width: 85%;
	padding: 0;
	float: left;
}

.address-pop .adress li .text p {
	width: 100%;
}

.address-pop .adress li .text .name {
	display: inline-block;
	font-weight: bold;
	line-height: 20px;
	font-size: 12px;
	color: #333333;
}

.address-pop .adress li .text .name .basic {
	display: inline-block;
	padding: 0 5px;
	margin-left: 5px;
	font-size: 11px;
	color: #ffffff;
	background: #68c40e;
	border-radius: 5px;
	line-height: 18px;
}

.address-pop .adress li .text .ad {
	line-height: 18px;
	font-size: 12px;
	color: #333333;
}

.address-pop .adress li .text .tell {
	line-height: 18px;
	font-size: 12px;
	color: #333333;
}

.address-pop .adress li .text .memo {
	width: 330px;
	overflow: hidden;
	text-overflow: ellipsis;
	white-space: nowrap;
	line-height: 17px;
	font-size: 12px;
	color: #666666;
}

.address-pop .adress li .btn-select {
	display: table-cell;
	width: 5%;
	padding: 0;
	vertical-align: middle; #
	float: right;
}

.address-pop .adress li .btn-select a {
	display: block;
	width: 45px;
	height: 24px;
	line-height: 24px;
	text-align: center;
	font-size: 11px;
	color: #ffffff;
	float: right;
}

.address-pop .adress li .btn-select a.select {
	background: #327add;
	border: 1px solid #2262cb;
}

.address-pop .adress li .btn-select a.ad-book {
	margin-top: 5px;
	background: #8d8d8d;
	border: 1px solid #666666;
}

.address-pop .adress.check-type li .text {
	padding: 0 15px 0 30px;
	width: 76%;
}

.address-pop .btn-area {
	margin-top: 30px;
	text-align: center;
}

.address-pop .btn-area div {
	display: inline-block; #
	display: inline; #
	zoom: 1;
}

.address-pop .btn-area div .btn40 {
	display: inline-block;
	width: 117px;
	line-height: 38px;
	text-align: center;
	font-size: 16px;
}

.address-pop .btn-area div .btn40.blue {
	border: 1px solid #0f62cb;
	background: #2d81ea;
	color: #ffffff;
}

.address-pop .btn-area div .btn40.black {
	border: 1px solid #333333;
	background: #555555;
	color: #ffffff;
}

.address-pop .btn-area .btn-go-myplace {
	margin-left: 10px;
}

.address-pop .none-ad {
	width: 100%;
	padding: 50px 0;
	vertical-align: middle;
}

.address-pop .none-ad p {
	font-size: 12px;
	color: #333;
	text-align: center;
}

.address-pop .addplace {
	width: 100%;
}

.address-pop .addplace .title {
	padding: 25px 0 10px;
	border-bottom: 1px solid #cccccc;
	line-height: 25px;
	font-size: 20px;
	color: #000;
	font-weight: bold;
}

.address-pop .addplace .table {
	padding: 20px 0 10px;
}

.address-pop .addplace .table table {
	width: 100%;
	border: 1px solid #97abe1;
}

.address-pop .addplace .table table th {
	padding: 0 15px;
	background: #f6f6f6;
	text-align: left;
	font-size: 12px;
	color: #333333;
	border-top: 1px solid #dbdbdb;
}

.address-pop .addplace .table table th em {
	font-weight: 400;
	font-size: 11px;
	font-style: normal;
}

.address-pop .addplace .table table td {
	padding: 12px 10px;
	border-top: 1px solid #dbdbdb;
	border-left: 1px solid #dbdbdb;
}

.address-pop .addplace .table table td input {
	width: 100%;
	height: 23px;
	font-size: 11px;
	color: #666;
}

.address-pop .addplace .table table td textarea {
	width: 100%;
	height: 60px;
	font-size: 11px;
	color: #666;
	padding: 5px 10px;
}

.address-pop .addplace .table table td select+textarea {
	margin-top: 10px;
}

.address-pop .addplace .table table td .post p {
	padding-top: 10px;
	overflow: hidden;
}

.address-pop .addplace .table table td .post p * {
	float: left;
}

.address-pop .addplace .table table td .post p a {
	display: inline-block;
	width: 59px;
	height: 23px;
	margin-left: 5px;
}

.address-pop .addplace .table table td .post p a img {
	width: 100%;
	border: 0;
}

.address-pop .addplace .table table td .post p:first-child {
	margin-top: 0;
}

.address-pop .addplace .table table td .post p:first-child input {
	width: 55px;
	float: left;
}

.address-pop .addplace .table table td .post p:first-child span {
	display: inline-block;
	width: 15px;
	line-height: 23px;
	text-align: center;
	font-size: 11px;
	color: #666666;
	float: left;
}

.address-pop .addplace .table table td p.post-number-input { #
	padding-top: 0px;
}

.address-pop .addplace .table table td p.post-number-input input {
	width: 55px;
	float: left;
}

.address-pop .addplace .table table td p.post-number-input span {
	display: inline-block;
	width: 15px;
	line-height: 23px;
	text-align: center;
	font-size: 11px;
	color: #666666;
	float: left;
}

.address-pop .addplace .table table td .phone {
	overflow: hidden;
}

.address-pop .addplace .table table td .phone input {
	width: 55px;
	float: left;
}

.address-pop .addplace .table table td .phone span {
	display: inline-block;
	width: 15px;
	line-height: 23px;
	text-align: center;
	font-size: 11px;
	color: #666666;
	float: left;
}

.address-pop .addplace .table table td select {
	width: 100%;
	height: 23px;
	font-size: 11px;
	color: #666;
}

.address-pop .addplace .table table tr:first-child th {
	border-top: none;
}

.address-pop .addplace .table table tr:first-child td {
	border-top: none;
}

.address-pop .addplace label {
	font-size: 12px;
	color: #333333;
}

.address-pop .addplace label input {
	margin-right: 5px;
	vertical-align: middle;
}
/* mobile 팝업 */
.popup {
	padding: 20px 10px;
	font-size: 11px;
	color: #4c4c4c;
}

.popup .address-add .title {
	padding: 8px 0 8px 13px;
	background: url(/images/d3/m_04/ico_arr_popup.png) left center no-repeat;
	background-size: 8px 13px;
	font-weight: bold;
	font-size: 14px;
	color: #4c4c4c;
}

.popup .address-add .table {
	margin-bottom: 10px;
}

.popup .address-add table {
	width: 100%;
	border: 1px solid #d5d5d5;
}

.popup .address-add table th {
	padding: 0 10px;
	border-top: 1px solid #e4e7e8;
	background: #f1f1f1;
	vertical-align: middle;
	text-align: left;
	font-size: 12px;
}

.popup .address-add table th em {
	font-style: normal;
}

.popup .address-add table td {
	padding: 5px 10px;
	border-top: 1px solid #e4e7e8;
	border-left: 1px solid #e4e7e8;
}

.popup .address-add table td input[type=text] {
	width: 100%;
	border: 1px solid #c9c9c9;
	height: 28px;
	font-size: 11px;
	color: #4c4c4c;
}

.popup .address-add table td select {
	width: 100%;
	font-size: 11px;
	color: #4c4c4c;
}

.popup .address-add table td textarea {
	width: 100%;
	height: 87px;
	padding: 10px;
	font-size: 11px;
	color: #4c4c4c;
}

.popup .address-add table td select+textarea {
	margin-top: 10px;
}

.popup .address-add table td .btn-gray {
	display: block;
	background: #858585;
	line-height: 29px;
	text-align: center;
	font-size: 12px;
	color: #ffffff;
}

.popup .address-add table td .address-box * {
	margin-top: 5px;
}

.popup .address-add table td .address-box p {
	margin-top: 5px;
}

.popup .address-add table td .address-box p:first-child {
	margin-top: 0;
}

.popup .address-add table td .address-box p:first-child * {
	margin-top: 0;
}

.popup .address-add table td .address-box p:first-child input {
	width: 55px;
	float: left;
}

.popup .address-add table td .address-box p.post {
	overflow: hidden;
}

.popup .address-add table td .address-box p.post * {
	float: left;
}

.popup .address-add table td .address-box p.post span {
	display: inline-block;
	width: 15px;
	line-height: 23px;
	text-align: center;
	font-size: 11px;
	color: #666;
}

.popup .address-add table td .address-box p.post a {
	width: 100%;
	margin-top: 5px;
}

.popup .address-add table td .phone {
	overflow: hidden;
}

.popup .address-add table td .phone input {
	width: 55px;
	float: left;
}

.popup .address-add table td .phone span {
	display: inline-block;
	width: 15px;
	line-height: 23px;
	text-align: center;
	font-size: 11px;
	color: #666666;
	float: left;
}

.popup .address-add table tr:first-child th {
	border-top: none;
}

.popup .address-add table tr:first-child td {
	border-top: none;
}

.popup .address-add label {
	font-size: 11px;
	color: #4c4c4c;
}

.popup .address-add label input[type=checkbox] {
	margin-right: 5px;
	vertical-align: middle;
}

.popup .address-add .btn-wrap a {
	margin-top: 5px;
}

.popup .address-add .btn-wrap .btn-white {
	width: auto;
	float: none;
}

.popup .address-add .btns {
	margin-top: 10px;
}

.popup .address-add .btns p {
	margin-top: 5px;
}

.popup .address-add .btns p a {
	display: block;
	line-height: 34px;
	text-align: center;
	font-size: 12px;
}

.popup .address-add .btns p a.btn-black {
	border: 1px solid #393939;
	background: #393939;
	color: #ffffff;
}

.popup .address-add .btns p a.btn-white {
	border: 1px solid #393939;
	background: #ffffff;
	color: #393939;
}

.popup.add .address-add {
	display: block;
}

.popup.add .tab-cnt {
	display: none;
}

.popup.add>.btn-wrap {
	display: none;
}

.popup .tab-wrap ul {
	overflow: hidden;
}

.popup .tab-wrap ul li {
	float: left;
	width: 50%;
}

.popup .tab-wrap ul li a {
	display: block;
	border: 1px solid #858585;
	line-height: 40px;
	text-align: center;
	font-size: 13px;
	color: #3b3b3b;
	background: #f1f1f1;
}

.popup .tab-wrap ul li.on a {
	background: #858585;
	color: #ffffff;
}

.popup .tab-wrap ul li:first-child {
	border-right: none;
}

.popup .tab-wrap .title-box {
	width: 50%;
	border-top: 1px solid #858585;
	border-left: 1px solid #858585;
	border-right: 1px solid #858585;
	line-height: 40px;
	text-align: center;
	font-size: 13px;
	color: #3b3b3b;
	background: #f1f1f1;
}

.popup .tab-cnt .address.check-type li .text {
	padding: 0 15px 0 20px;
}

.popup .tab-cnt .address li {
	margin-top: 7px;
	padding: 15px 10px;
	border: 1px solid #d5d5d5;
	line-height: 14px;
	font-size: 12px;
	color: #4c4c4c;
	position: relative;
}

.popup .tab-cnt .address li .check {
	position: absolute;
	left: 10px;
}

.popup .tab-cnt .address li .text {
	width: auto;
	padding: 0 15px 0 0;
	vertical-align: middle;
}

.popup .tab-cnt .address li .text .name {
	margin-bottom: 5px;
	font-weight: bold;
	font-size: 13px;
	color: #4c4c4c;
}

.popup .tab-cnt .address li .text .name .basic {
	display: inline-block;
	padding: 0 5px;
	background: #68c40e;
	font-size: 10px;
	color: #ffffff;
	border-radius: 5px;
}

.popup .tab-cnt .address li .text .tell {
	line-height: 14px;
	font-size: 12px;
	color: #4c4c4c;
}

.popup .tab-cnt .address li .text .memo {
	display: inline-block;
	line-height: 14px;
	font-size: 12px;
	color: #666666;
	width: 100%;
	overflow: hidden;
	text-overflow: ellipsis;
	white-space: nowrap;
}

.popup .tab-cnt .address li .btn-select {
	margin-top: 5px;
	text-align: right;
}

.popup .tab-cnt .address li .btn-select a {
	display: inline-block;
	width: 50px;
	line-height: 24px;
	text-align: center;
	font-size: 11px;
	color: #ffffff;
}

.popup .tab-cnt .address li .btn-select a.btn-black {
	background: #393939;
}

.popup .tab-cnt .address li .btn-select a.btn-gray {
	background: #858585;
}

.popup .tab-cnt .address li .ad-book {
	margin-top: 5px;
}

.popup .tab-cnt .address li.on {
	border: 2px solid #000000;
}

.popup .tab-cnt .none-ad {
	padding: 50px 0;
}

.popup .tab-cnt .none-ad p {
	text-align: center;
	font-size: 12px;
	color: #000;
}

.popup .btn-wrap {
	display: block;
	margin-top: 15px;
}

.popup .btn-wrap div {
	overflow: hidden;
	margin-top: 5px;
}

.popup .btn-wrap div a {
	display: block;
	line-height: 35px;
	text-align: center;
	font-size: 12px;
	color: #393939;
}

.popup .btn-wrap div a.btn-black {
	border: 1px solid #393939;
	background: #393939;
	color: #ffffff;
}

.popup .btn-wrap div a.btn-white {
	border: 1px solid #393939;
	width: 48%;
	float: left;
}

.popup .btn-wrap div a.btn-white+.btn-white {
	float: right;
}

/* 우편번호 레이어 */
.layer {
	width: 100%;
	min-height: 100%;
	z-index: 3;
	position: fixed;
	left: 0;
	top: 0;
	background: rgba(60, 60, 60, 0.8);
	font-size: 12px;
}

.layer .layer-pop {
	width: 90%;
	background-color: #fff;
	position: relative;
	box-shadow: 0px 1px 10px #494949;
	margin: 80px auto;
}

.layer .layer-pop h3 {
	background-color: #efefef;
	height: 36px;
	line-height: 36px;
	font-weight: bold;
	padding: 0 10px;
	color: #3b3b3b;
}

.layer .layer-pop .txt {
	max-height: 300px;
	overflow-y: auto;
	padding: 10px;
}

.layer .layer-pop .close {
	width: 45px;
	height: 36px;
	color: #fff;
	line-height: 36px;
	position: absolute;
	top: 0;
	right: 0;
	background-color: #4f4f4f;
	text-align: center;
}

body #comment_password {
	border-radius: 0 !important;
	font-size: 1em;
}

body #comment_password .head {
	background-color: #efefef;
	height: 36px;
	line-height: 36px;
	font-weight: bold;
	text-align: left !important;
	padding: 0 10px;
}

body #comment_password .head h5 {
	border-bottom: 0px none !important;
	font-size: 1em !important;
	padding: 0 !important;
}

body #comment_password .head a.close {
	width: 45px;
	height: 36px;
	color: #fff;
	line-height: 42px;
	top: 0 !important;
	right: 0 !important;
	text-align: center;
}

body #comment_password .contents p {
	font-size: 1em !important;
	font-weight: normal;
}

body #comment_password .contents .form-wrap2 input {
	height: 35px;
}

body #comment_password .contents .form-wrap2 p:last-child a {
	display: block;
	background-color: #393939;
	color: #fff;
	position: initial !important;
	padding: 10px 0;
	margin-top: 10px;
}

.step-comm {
	display: none;
}

.layer input {
	height: 35px;
	border: 1px solid #bbb;
	vertical-align: middle;
	padding-left: 10px;
	box-sizing: border-box;
}

.layer select {
	margin-top: 5px;
	height: 35px;
}

.layer .keyword input {
	width: 45%;
}

.layer .msg01 {
	text-align: center;
}

.layer .MS_addr_type_area {
	text-align: center;
	margin: 10px 0;
}

.layer .search-form .btn_Grey {
	width: 105px;
	display: inline;
	margin-left: 10px;
}

.layer .addr-list {
	width: 100%;
}

.layer .msg-wrap {
	background-color: #fbfbfb;
	padding: 10px 0;
	text-align: center;
}

.layer .msg-wrap .msg01-highlight {
	color: #1984f1;
}

.layer #searchStep02 {
	margin-top: 10px;
}

.layer #searchStep02 h4 {
	font-weight: bold;
}

.layer #searchStep02 .btn_Black {
	margin-top: 10px;
}

.layer #searchStep03 table {
	width: 100%;
}

.layer #searchStep03 table th {
	width: 20%;
	text-align: left;
	font-size: 12px;
}

.layer #searchStep03 table td {
	padding: 10px 0;
}

.layer #searchStep03 table .detail-addrPost input {
	width: 50px;
}

.layer #searchStep03 table .detail-addrAddress input {
	width: 90%;
	margin-bottom: 5px;
}

.addr_type {
	text-align: center;
	font-weight: bold;
}

.addr_type label {
	margin: 0 5px;
}
</style>
</head>
<body>
	<div class="address-pop">
		<div class="addplace">
			<div class="title">배송지 추가</div>
			<form action="../RegistDestination.ad" name="form1" method="post">
				<div class="table">
					<table class="addplace-table" cellpadding="0" cellspacing="0">
						<colgroup>
							<col width="30%" />
							<col width="auto;" />
						</colgroup>
						<tbody>
							<tr>
								<th>배송지명</th>
								<td><input type="text" name="location" maxlength="30" placeholder="배송지명" /></td>
							</tr>
							<tr>
								<th>주소</th>
								<td>
									<div class="post">
										<p class="post-number-input">
											<input type="text" name="postcode" id="postcode" placeholder="우편번호" />
											<input type="button" onclick="execDaumPostcode()" value="주소 찾기">
										</p>
										<p>
											<input type="text" name="address" id="address" placeholder="주소"/>
										</p>
										<p>
											<input type="text" name="detailAddress" id="detailAddress" placeholder="상세주소" />
										</p>
										<p>
											<input type="text" name="extraAddress" id="extraAddress" placeholder="참고항목" />
										</p>
									</div>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
				<div class="btn-area">
					<div>
						<input type="submit" value="저장" class="btn40 blue btn-save-addrbook" style="cursor: pointer;"> 
						<input type="button" value="취소" class="btn40 black btn-cancel" style="cursor: pointer;" onclick="cancle()">
					</div>
				</div>
			</form>
		</div>
	</div>
	
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
    function execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if(data.userSelectedType === 'R'){
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                    // 조합된 참고항목을 해당 필드에 넣는다.
                    document.getElementById("extraAddress").value = extraAddr;
                
                } else {
                    document.getElementById("extraAddress").value = '';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('postcode').value = data.zonecode;
                document.getElementById("address").value = addr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("detailAddress").focus();
            }
        }).open();
    }
</script>
</body>
</html>
