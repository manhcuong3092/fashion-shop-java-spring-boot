	<jsp:include page="/WEB-INF/views/front-end/common/header.jsp"></jsp:include>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"  %>  
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
	<!-- Paging -->
	<%@ taglib prefix="tag" uri="/WEB-INF/taglibs/pagingTagLibs.tld"%>
	<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %> 

    <!-- Breadcrumb Section Begin -->
    <div class="breacrumb-section">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <div class="breadcrumb-text">
                        <a href="/home"><i class="fa fa-home"></i> Trang chủ</a>
                        <span><a href="/shop">Shop</a></span>
                        <span>Tất cả</span>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Breadcrumb Section Begin -->

    <!-- Product Shop Section Begin -->
    <section class="product-shop spad">
        <div class="container">
            <div class="row">
                <div class="col-lg-3 col-md-6 col-sm-8 order-2 order-lg-1 produts-sidebar-filter">
                	<div class="mb-4">
                		<form class="form-inline" method="get" action="${ base }/shop/search-all">
						    <input class="form-control mr-sm-2" name="searchText" type="search" placeholder="Tìm kiếm" aria-label="Search">
						 </form>
                	</div>
                    <div class="filter-widget">
                        <h4 class="fw-title">Danh mục</h4>
                        <c:set var="queryUrl" scope="session" value="${''}"/>
                        <c:forEach items="${ queryMap }" var="map">
                       		<c:if test="${ map.key != 'categorySeo' }">
                        		<c:set var="queryUrl" scope="session" value="${queryUrl}${map.key}=${map.value}&"/>
                        	</c:if>
                       	</c:forEach>
                        <div class="filter-catagories">
                        	<c:forEach items="${ categories }" var="category">
                        		<h5 class='font-weight-bold mt-3 ml-4'><a style="color: #555555;" href="${ base }/shop/search-all?${ queryUrl }categorySeo=${ category.seo }">${ category.name }</a></h5>
                        		<ul class="ml-4">
                        			<c:forEach items="${ category.children }" var="child">
                        				<li class="ml-4 mt-2"><a style="color: #555555;" href="${ base }/shop/search-all?${ queryUrl }categorySeo=${ child.seo }">${ child.name }</a></li>
                        			</c:forEach>
                        		</ul>
                        	</c:forEach>
                        </div>
                    </div>
                    <div class="filter-widget">
                        <div class="filter-widget">
                        <h4 class="fw-title">Đối tượng</h4>
                        <div class="filter-catagories">
                        	<c:set var="queryUrl" scope="session" value="${''}"/>
                        	<c:forEach items="${ queryMap }" var="map">
                        		<c:if test="${ map.key != 'gender' }">
	                        		<c:set var="queryUrl" scope="session" value="${queryUrl}${map.key}=${map.value}&"/>
	                        	</c:if>
                        	</c:forEach>
                            <ul class="ml-4">
                            	<li><a href="${ base }/shop/search-all?${ queryUrl }gender=Nam">Nam</a>
                            	<li><a href="${ base }/shop/search-all?${ queryUrl }gender=Nữ">Nữ</a>
                            	<li><a href="${ base }/shop/search-all?${ queryUrl }gender=Trẻ+em">Trẻ em</a>
                            </ul>
                        </div>
                    </div>
                    </div>
                    <div class="filter-widget">
                        <h4 class="fw-title">Giá</h4>
                        <div class="filter-range-wrap">
                            <div class="range-slider">
                                <div class="price-input">
                                	<c:set var="minVal" value="0"></c:set>
                                	<c:set var="maxVal" value="1000000"></c:set>
                                	<c:if test="${ not empty min }">
                                		<c:set var="minVal" value="${ min }"></c:set>
                                	</c:if>
                                	<c:if test="${ not empty max }">
                                		<c:set var="maxVal" value="${ max }"></c:set>
                                	</c:if>
                                    <input type="text" id="minamount" value="${ minVal }">
                                    <input type="text" id="maxamount" value="${ maxVal }">
                                </div>
                            </div>
                            <div class="price-range ui-slider ui-corner-all ui-slider-horizontal ui-widget ui-widget-content"
                                data-min="0" data-max="1000000">
                                <div class="ui-slider-range ui-corner-all ui-widget-header"></div>
                                <span tabindex="0" class="ui-slider-handle ui-corner-all ui-state-default"></span>
                                <span tabindex="0" class="ui-slider-handle ui-corner-all ui-state-default"></span>
                            </div>
                        </div>
                        <c:set var="queryUrl" scope="session" value="${''}"/>
                       	<c:forEach items="${ queryMap }" var="map">
                       		<c:if test="${ (map.key != 'min') || (map.key != 'max') }">
                        		<c:set var="queryUrl" value="${queryUrl}${map.key}=${map.value}&"/>
                        	</c:if>
                       	</c:forEach>
                        <button id="priceFilter" href="${ base }/shop/search-all?${ queryUrl}" class="filter-btn">Lọc</button>
                    </div>
                    <div class="filter-widget">
                        <h4 class="fw-title">Màu</h4>
                        <c:set var="queryUrl" scope="session" value="${''}"/>
                       	<c:forEach items="${ queryMap }" var="map">
                       		<c:if test="${ map.key != 'color' }">
                        		<c:set var="queryUrl" scope="session" value="${queryUrl}${map.key}=${map.value}&"/>
                        	</c:if>
                       	</c:forEach>
                        <div class="fw-color-choose">
                            <div class="cs-item mb-1">
                                <input type="radio" id="cs-black">
                                <a href="${ base }/shop/search-all?${ queryUrl}color=đen" class="cs-black pt-1" for="cs-black">Đen</a>
                            </div>
                            <div class="cs-item mb-1">
                                <input type="radio" id="cs-violet">
                                <a href="${ base }/shop/search-all?${ queryUrl}color=tím" class="cs-violet pt-1" for="cs-violet">Tím</a>
                            </div>
                            <div class="cs-item mb-1">
                                <input type="radio" id="cs-blue">
                                <a href="${ base }/shop/search-all?${ queryUrl}color=xanh+dương" class="cs-blue pt-1" for="cs-blue">Xanh dương</a>
                            </div>
                            <div class="cs-item mb-1">
                                <input type="radio" id="cs-yellow">
                                <a href="${ base }/shop/search-all?${ queryUrl}color=vàng" class="cs-yellow pt-1" for="cs-yellow">Vàng</a>
                            </div>
                            <div class="cs-item mb-1">
                                <input type="radio" id="cs-red">
                                <a href="${ base }/shop/search-all?${ queryUrl}color=đỏ" class="cs-red pt-1" for="cs-red">Đỏ</a>
                            </div>
                            <div class="cs-item mb-1">
                                <input type="radio" id="cs-green">
                                <a href="${ base }/shop/search-all?${ queryUrl}color=xanh+lá" class="cs-green pt-1" for="cs-green">Xanh lá</a>
                            </div>
                            <div class="cs-item mb-1">
                                <input type="radio" id="cs-white">
                                <a href="${ base }/shop/search-all?${ queryUrl}color=trắng" class="cs-white pt-1" for="cs-white">Trắng</a>
                            </div>
                            <div class="cs-item mb-1">
                                <input type="radio" id="cs-pink">
                                <a href="${ base }/shop/search-all?${ queryUrl}color=hồng" class="cs-pink pt-1" for="cs-pink">Hồng</a>
                            </div>
                            <div class="cs-item mb-1">
                                <input type="radio" id="cs-brown">
                                <a href="${ base }/shop/search-all?${ queryUrl}color=nâu" class="cs-brown pt-1" for="cs-brown">Nâu</a>
                            </div>
                            <div class="cs-item mb-1">
                                <input type="radio" id="cs-gray">
                                <a href="${ base }/shop/search-all?${ queryUrl}color=xám" class="cs-gray pt-1" for="cs-gray">Xám</a>
                            </div>
                            <div class="cs-item mb-1">
                                <input type="radio" id="cs-orange">
                                <a href="${ base }/shop/search-all?${ queryUrl}color=cam" class="cs-orange pt-1" for="cs-orange">Cam</a>
                            </div>
                            <div class="cs-item mb-1">
                                <input type="radio" id="cs-cyan">
                                <a href="${ base }/shop/search-all?${ queryUrl}color=xanh+lơ" class="cs-cyan pt-1" for="cs-cyan">Xanh lơ</a>
                            </div>
                        </div>
                    </div>
                    <div class="filter-widget" style="margin-top: 220px;">
                        <h4 class="fw-title">Kích cỡ</h4>
                        <div class="fw-size-choose">
                        	<c:set var="queryUrl" scope="session" value="${''}"/>
                        	<c:forEach items="${ queryMap }" var="map">
                        		<c:if test="${ map.key != 'size' }">
	                        		<c:set var="queryUrl" scope="session" value="${queryUrl}${map.key}=${map.value}&"/>
	                        	</c:if>
                        	</c:forEach>
                            <div class="sc-item">
                                <input type="radio" id="s-size">
                                <a class="p-2" href="${ base }/shop/search-all?${ queryUrl }size=s">s</a>
                            </div>
                            <div class="sc-item">
                                <input type="radio" id="m-size">
                                <a class="p-2" href="${ base }/shop/search-all?${ queryUrl}size=m">m</a>
                            </div>
                            <div class="sc-item">
                                <input type="radio" id="l-size">
                                <a class="p-2" href="${ base }/shop/search-all?${ queryUrl }size=l">l</a>
                            </div>
                            <div class="sc-item">
                                <input type="radio" id="xl-size">
                                <a class="p-2" href="${ base }/shop/search-all?${ queryUrl }size=xl">xl</a>
                            </div>
                            <div class="sc-item">
                                <input type="radio" id="xxl-size">
                                <a class="p-2" href="${ base }/shop/search-all?${ queryUrl }size=xxl">xxl</a>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-9 order-1 order-lg-2">
                    <div class="product-show-option">
                        <div class="row">
                            <div class="col-lg-7 col-md-7">
                                <div class="select-option">
                                	<c:set var="queryUrl" scope="session" value="${''}"/>
			                       	<c:forEach items="${ queryMap }" var="map">
			                       		<c:if test="${ map.key != 'order' }">
			                        		<c:set var="queryUrl" scope="session" value="${queryUrl}${map.key}=${map.value}&"/>
			                        	</c:if>
			                       	</c:forEach>
                                    <select class="sorting" onchange="this.options[this.selectedIndex].value && (window.location = this.options[this.selectedIndex].value);">
                                        <option ${ (order == 'default') ? 'selected' : '' } value="${ base }/shop/search-all?${ queryUrl }order=default">Sắp xếp mặc định</option>
                                        <option ${ (order == 'asc') ? 'selected' : '' } value="${ base }/shop/search-all?${ queryUrl }order=asc">Giá tăng dần</option>
                                        <option ${ (order == 'des') ? 'selected' : '' } value="${ base }/shop/search-all?${ queryUrl }order=des">Giá giảm dần</option>
                                    </select>
                                </div>
                            </div>
                            <div class="col-lg-5 col-md-5 text-right">
                                <p>Xem ${ queryResultInfor.start } - ${ queryResultInfor.end } trong ${ queryResultInfor.resultCount } Sản phẩm</p>
                            </div>
                        </div>
                    </div>
                    <div class="product-list">
                        <div class="row">
                            <c:forEach items="${ products }" var="product">
                            	<div class="col-lg-4 col-sm-6">
	                                <div class="product-item">
	                                    <div class="pi-pic">
	                                        <img src="${pageContext.request.contextPath}/upload/${product.avatar}" alt="">
	                                        	<c:if test="${ not empty product.priceSale }">
	                                        		<div class="sale pp-sale">
	                                        			-<fmt:formatNumber value="${ 100 - product.priceSale*100/product.price }" maxFractionDigits="0" />%
	                                        		</div>
	                                        	</c:if>
	                                        <div class="icon">
	                                            <i class="icon_heart_alt"></i>
	                                        </div>
	                                        <ul>
	                                            <li class="quick-view"><a href="${pageContext.request.contextPath}/product/${product.seo}">Xem chi tiết</a></li>
	                                        </ul>
	                                    </div>
	                                    <div class="pi-text">
	                                        <div class="catagory-name">${ product.category.name }</div>
	                                        <a href="${pageContext.request.contextPath}/product/${product.seo}">
	                                            <h5 class="product-title">${product.title}</h5>
	                                        </a>
	                                        <div class="product-price">
	                                        	<c:choose>
	                                        		<c:when test="${ not empty product.priceSale }">
	                                        			<fmt:setLocale value="vi_VN" scope="session"/>
														<fmt:formatNumber value="${product.priceSale }" type="currency" />
			                                            <span><fmt:formatNumber value="${product.price }" type="currency" /></span>
	                                        		</c:when>
	                                        		<c:otherwise>
	                                        			<fmt:setLocale value="vi_VN" scope="session"/>
														<fmt:formatNumber value="${product.price }" type="currency" />
	                                        		</c:otherwise>
	                                        	</c:choose>
	                                        </div>
	                                    </div>
	                                </div>
	                            </div>
                            </c:forEach>
                        </div>
                    </div>
                    <div class="pagination justify-content-center">
	                    <div class="row">
	                    	<div class="col-lg-3"></div>
	                    	<div class="col-lg-9 d-flex-justify-content-center rounded">
	                    		<c:set var="req" value="${pageContext.request}" />
								<c:set var="baseURL" value="${fn:replace(req.requestURL, req.requestURI, '')}" />
								<c:set var="params" value="${requestScope['javax.servlet.forward.query_string']}" />
								<c:set var="requestPath" value="${requestScope['javax.servlet.forward.request_uri']}" />
								<c:set var="pageUrl" value="${ baseURL }${ requestPath }${ not empty params ? '?'+=params+='&':'' }" />
	                    		<tag:paginate offset="${productSearch.offset }" count="${productSearch.count }" uri="${pageUrl}" />
	                    	</div>
	                    </div>
	                </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Product Shop Section End -->

    <jsp:include page="/WEB-INF/views/front-end/common/footer.jsp"></jsp:include>
    <script>
    	$(document).ready(function(){
    		
    		$('#priceFilter').click(function(){
    			var min = $('#minamount').val();
    	        var max = $('#maxamount').val();
    	        var url = $(this).attr('href');
    	        if(url.indexOf('min') >= 0){
    	        	url = url.slice(0, url.indexOf('min'))
    	        }
    	        if(url.indexOf('max') >= 0){
    	        	url = url.slice(0, url.indexOf('max'))
    	        }
    	        if(min){
    	        	url = url + 'min=' + min + '&';
    	        }
    	        if(max){
    	        	url = url + 'max=' + max;
    	        }
    	        window.location.href = url;
    		})
    		
    	});
    </script>