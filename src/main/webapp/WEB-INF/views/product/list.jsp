<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" ></script>
<title>상품관리</title>
</head>
<body>
<%@ include file="../common/navbar.jsp" %>
<div class="container">
	<div class="row mb-3">
		<div class="col-12">
			<h1 class="fs-3">상품관리 - 상품 목록</h1>
			
			<form id="form-products" action="list">
				<input type="hidden" name="page"/>
				<div class="my-3 d-flex justify-content-between">
					<select class="form-control w-25" name="rows" onchange="changeRows()">
						<option value="5" ${param.rows eq 5 ? "selected" : ""}>5개씩 보기</option>
						<option value="10" ${empty param.rows or param.rows eq 10 ? "selected" : ""}>10개씩 보기</option>
						<option value="50" ${param.rows eq 50 ? "selected" : ""}>50개씩 보기</option>
					</select>
					<div>
						<div class="form-check form-check-inline">
							<input class="form-check-input" 
									type="radio" 
									name="sort" 
									value="date" 
									${empty param.sort or param.sort eq "date" ? "checked" : "" }
									onchange="changeSort()">
							<label class="form-check-label">최신순</label>
						</div>
						<div class="form-check form-check-inline">
							<input class="form-check-input" 
									type="radio" 
									name="sort" 
									value="name"
									${param.sort eq "name" ? "checked" : "" }
									onchange="changeSort()">
							<label class="form-check-label">이름순</label>
						</div>
						<div class="form-check form-check-inline">
							<input class="form-check-input" 
									type="radio" 
									name="sort" 
									value="lowprice"
									${param.sort eq "lowprice" ? "checked" : "" }
									onchange="changeSort()">
							<label class="form-check-label">낮은 가격순</label>
						</div>
						<div class="form-check form-check-inline">
							<input class="form-check-input" 
									type="radio" 
									name="sort" 
									value="highprice"
									${param.sort eq "highprice" ? "checked" : "" }
									onchange="changeSort()">
							<label class="form-check-label">높은 가격순</label>
						</div>
					</div>					
				</div>
				<table class="table">
					<colgroup>
						<col width = "5%">
						<col width = "*">
						<col width = "15%">
						<col width = "15%">
						<col width = "10%">
						<col width = "25%">
					</colgroup>
					<thead>
						<tr>
							<th><input type="checkbox"></th>
							<th>상품명</th>
							<th>가격</th>
							<th>재고수량</th>
							<th>상태</th>
							<th>비고</th>
						</tr>
					</thead>
					<tbody>
						<c:choose>
							<c:when test="${empty productList}">
								<tr>
									<td  colspan="6" class="text-center"> 조회결과가 없습니다.</td>
								</tr>
							</c:when>
							<c:otherwise>
								<c:forEach var="product" items="${productList }">
									<tr>
										<td><input type="checkbox" name="no" value="${product.no }"></td>
										<td><a href="detail?no=${product.no }">${product.name }</a></td>
										<td><fmt:formatNumber value="${product.price}" /> 원</td>
										<td><fmt:formatNumber value="${product.stock}" /> 개</td>
										<!-- Product 클래스의 getStatusText() 메소드명에서 get을 제거하여 사용 -->
										<td>${product.statusText}</td>
										<td>
											<a href="" class="btn btn-outline-primary btn-sm">입고</a>
											<a href="" class="btn btn-outline-danger btn-sm">판매중지</a>
											<a href="" class="btn btn-outline-success btn-sm">판매재개</a>
										</td>
									</tr>
								</c:forEach>
							</c:otherwise>
						</c:choose>
					</tbody>
				</table>
				
				<div class="row">
					<div class="col-4">
						<div class="row row-cols-lg-auto g-3">
							<div class="col-12">
								<select class="form-select" name="opt">
									<option value="name" ${param.opt eq "name" ? "selected" : ""}>상품이름</option>
									<option value="price" ${param.opt eq "pirce" ? "selected" : ""}>상품가격</option>
								</select>
							</div>
							<div class="col-12">
								<input type="text" class="form-control" name="keyword" value="${param.keyword }"/>
							</div>
							<div class="col-12">
								<button type="submit" class="btn btn-outline-secondary">검색</button>
							</div>
						</div>
					</div>
					<div class="col-4">
						<c:if test="${paging.totalRows ne 0 }">
							<nav>
								<ul class="pagination">
									<li class="page-item">
										<a href="list?page=${paging.currentPage - 1}" 
											class="page-link ${paging.first ? 'disabled' : '' }"
											onclick="changePage(${paging.currentPage - 1 }, event)">
											이전
										</a>
									</li>
									<c:forEach var="num" begin="${paging.beginPage }" end="${paging.endPage }">
									<li class="page-item ${paging.currentPage eq num ? "active" : ""}">
										<a href="list?page=${num }" 
											class="page-link" 
											onclick="changePage(${num }, event)">
											${num }
										</a>
									</li>
									</c:forEach>
									<li class="page-item">
										<a href="list?page=${paging.currentPage + 1}" 
											class="page-link ${paging.last ? 'disabled' : '' }"
											onclick="changePage(${paging.currentPage + 1 }, event)">
											다음
										</a>
									</li>
								</ul>
							</nav>
						</c:if>
					</div>
					<div class="col-4">
						<button type="button" class="btn btn-outline-secondary btn-sm" onclick="removeCheckedProducts()">선택삭제</button>
					</div>
				</div>
			</form>
		</div>
	</div>
	<div class="row mb-3">
		<div class="col-12">
			<div class="text-end">
				<a href="create" class="btn btn-primary">신규 상품</a>
			</div>
		</div>
	</div>
</div>
<script type="text/javascript">
function changeRows(){
	let form = document.getElementById("form-products").submit();
}

function changeSort(){
	let form = document.getElementById("form-products").submit();
}

function changePage(page, event){
	event.preventDefault();
	document.querySelector("input[name=page]").value = page;
	document.getElementById("form-products").submit();
}

function removeCheckedProducts(){
	let checkedCheckboxes = document.querySelectorAll("input[type=checkbox][name=no]:checked");	// 태그명이 input이고, type 속성값이 checkbox이고, name 속성값이 no이고, 체크상태가 checked인 모든 엘리먼트를 선택한다.
	if(checkedCheckboxes.length == 0){
		alert("체크된 체크박스가 없습니다.");
		return;
	}
	
	// <form> 엘리먼트를 선택한다.
	let form = document.getElementById("form-products");
	
	// <form> 엘리먼트의 action 속성값을 delete로 변경한다.
	// form을 제출하면 localhost/product/delete 요청을 서버로 보내게 된다.
	form.setAttribute("action", "delete");
	form.submit();
}
</script>
</body>
</html>