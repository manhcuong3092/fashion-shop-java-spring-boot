	<%@page import="com.cuong.shop.entities.User"%>
<%@page import="org.springframework.security.core.userdetails.UserDetails"%>
	<%@page import="org.springframework.security.core.context.SecurityContextHolder"%>
	<jsp:include page="/WEB-INF/views/front-end/common/header.jsp"></jsp:include>
	<jsp:include page="/WEB-INF/views/common/variables.jsp"></jsp:include>
	<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
	<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
	<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
	<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
	
    <!-- Header End -->

    <!-- Breadcrumb Section Begin -->
    <div class="breacrumb-section">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <div class="breadcrumb-text product-more">
                        <a href="/home"><i class="fa fa-home"></i> Trang chủ</a>
                        <a href="/shop">Shop</a>
                        <span>Sản phẩm</span>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Breadcrumb Section Begin -->

    <!-- Product Shop Section Begin -->
    <section class="product-shop spad page-details">
        <div class="container">
            <div class="row">
                <div class="col-lg-3">
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
                                    <input type="text" id="minamount">
                                    <input type="text" id="maxamount">
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
                        		<c:set var="queryUrl" scope="session" value="${queryUrl}${map.key}=${map.value}&"/>
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
                <div class="col-lg-9">
                    <div class="row">
                        <div class="col-lg-6">
                            <div class="product-pic-zoom">
                                <img class="product-big-img" src="${pageContext.request.contextPath}/upload/${ product.avatar }" alt="">
                                <div class="zoom-icon">
                                    <i class="fa fa-search-plus"></i>
                                </div>
                            </div>
                            <div class="product-thumbs">
                                <div class="product-thumbs-track ps-slider owl-carousel">
                                	<c:forEach var = "image" items="${ product.productImages }">
                                		<div class="pt" data-imgbigurl="${pageContext.request.contextPath}/upload/${ image.path }">
                                		<img src="${pageContext.request.contextPath}/upload/${ image.path }" alt=""></div>
							    	</c:forEach>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-6">
                            <div class="product-details">
                                <div class="pd-title">
                                    <span>${ product.category.name }</span>
                                    <h3>${ product.title }</h3>
                                    <a href="#" class="heart-icon"><i class="icon_heart_alt"></i></a>
                                </div>
                                <div class="pd-rating">
                                	<c:set var = "totalStar" value = "${0}"/>
                                	<c:forEach items = "${ product.comments }" var="comment">
                                		<c:set var = "totalStar" value = "${totalStar + comment.star}"/>
								    </c:forEach>
								    <c:set var = "totalComments" value = "${fn:length(product.comments)}"/>
								    <c:set var = "avgStar" value = "${totalStar/totalComments}"/>
								    <c:set var="roundedAvgStar"
										value="${Math.round( avgStar )}"/>
								    <c:forEach var = "i" begin = "1" end = "5">
                                		<c:choose>
                                			<c:when test="${ i <= roundedAvgStar }">
	                                			<i class="fa fa-star"></i>
	                                		</c:when>
	                                		<c:otherwise>
	                                			<i class="fa fa-star-o"></i>
	                                		</c:otherwise>
                                		</c:choose>
								    </c:forEach>
                                    <c:choose>
                                    	<c:when test="${ avgStar != 'NaN' }">
	                                    	<span>(
		                                    	<fmt:formatNumber type = "number" 
										         maxFractionDigits = "1" value = "${avgStar}" /> )
										    </span>
	                                    </c:when>
	                                    <c:otherwise>
	                                    	<span>( 0 )</span>
	                                    </c:otherwise>
                                    </c:choose>
                                </div>
                                <div class="pd-desc">
                                	<p>${ product.shortDescription }</p>
                                	<c:choose>
                                		<c:when test="${ not empty product.priceSale }">
                                    		<h4><fmt:formatNumber value="${ product.priceSale }" maxFractionDigits="0"/> &#8363
                                    			<span><fmt:formatNumber value="${ product.price }" maxFractionDigits="0"/> &#8363</span>
                                    		</h4>
                                		</c:when>
                                		<c:otherwise>
                                			<h4><fmt:formatNumber value="${ product.price }" maxFractionDigits="0"/> &#8363</h4>
                                		</c:otherwise>
                                	</c:choose>
                                </div>
                                <div class="pd-color-buton-choose">
                                	<h5>Màu</h5>
                                	<c:forEach var='color' items="${ product.colors }">
	                                 	<div class="sc-item">
	                                 		<input type="radio" name="color" value="${ color.name }" id="${ color.id }-color">
	                                     	<label for="${ color.id }-color">${ color.name }</label>
	                                 	</div>
                                 	</c:forEach>
                                </div>
                                <div class="pd-size-choose">
                                	<h5>Kích cỡ</h5>
                                    <c:forEach var='size' items="${ product.sizes }">
                                    	<div class="sc-item">
                                    		<input type="radio" name="size" value="${ size.name }" id="${ size.id }-size">
                                        	<label for="${ size.id }-size">${ size.name }</label>
                                    	</div>
                                    </c:forEach>
                                </div>
                                <div class="quantity">
                                    <div class="pro-qty">
                                    	<span class="dec qtybtn">-</span>
                                        <input type="number" value="1" id="quantity">
                                        <span class="inc qtybtn">+</span>
                                    </div>
                                    <button style="border: none" class="primary-btn pd-cart" id="add-to-cart" onclick="addProductToCart(${product.id})">Thêm vào giỏ</button>
                                </div>
                                <ul class="pd-tags">
                                    <li><span>Thể loại</span>: ${ product.category.name }</li>
                                    <li><span>Đối tượng</span>: ${ product.gender }</li>
                                </ul>
                                <div class="pd-share">
                                    <div class="pd-social">
                                        <a href="#"><i class="ti-facebook"></i></a>
                                        <a href="#"><i class="ti-twitter-alt"></i></a>
                                        <a href="#"><i class="ti-linkedin"></i></a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="product-tab">
                        <div class="tab-item">
                            <ul class="nav" role="tablist">
                                <li>
                                    <a class="active" data-toggle="tab" href="#tab-1" role="tab">Mô tả</a>
                                </li>
                                <li>
                                    <a data-toggle="tab" href="#tab-2" role="tab">Đặc điểm</a>
                                </li>
                                <li>
                                    <a data-toggle="tab" href="#tab-3" role="tab">Khách hàng đánh giá (${ fn:length(product.comments) })</a>
                                </li>
                            </ul>
                        </div>
                        <div class="tab-item-content">
                            <div class="tab-content">
                                <div class="tab-pane fade-in active" id="tab-1" role="tabpanel">
                                    <div class="product-content">
                                        ${ product.detailDescription }
                                    </div>
                                </div>
                                <div class="tab-pane fade" id="tab-2" role="tabpanel">
                                    <div class="specification-table">
                                        <table>
                                            <tr>
                                                <td class="p-catagory">Customer Rating</td>
                                                <td>
                                                    <div class="pd-rating">
                                                        <c:forEach var = "i" begin = "1" end = "5">
					                                		<c:choose>
					                                			<c:when test="${ i <= roundedAvgStar }">
						                                			<i class="fa fa-star"></i>
						                                		</c:when>
						                                		<c:otherwise>
						                                			<i class="fa fa-star-o"></i>
						                                		</c:otherwise>
					                                		</c:choose>
													    </c:forEach>
                                                        <span> (<fmt:formatNumber type = "number" 
													         maxFractionDigits = "1" value = "${avgStar}" />)
													    </span>
                                                    </div>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="p-catagory">Giá gốc</td>
                                                <td>
                                                    <div class="p-price"><fmt:formatNumber value="${ product.price }" maxFractionDigits="0"/> &#8363</div>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="p-catagory">Tình trạng</td>
                                                <td>
                                                    <div class="p-stock">Có sẵn</div>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="p-catagory">Cỡ</td>
                                                <td>
                                                    <div class="p-size">Xxl</div>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="p-catagory">Màu</td>
                                                <td><span class="cs-color"></span></td>
                                            </tr>
                                        </table>
                                    </div>
                                </div>
                                <div class="tab-pane fade" id="tab-3" role="tabpanel">
                                    <div class="customer-review-option">
                                        <div class="comment-option" id="comments">
                                        	<c:forEach var = "comment" items="${ product.comments }">
		                                		<div class="co-item">
		                                			<div class="avatar-pic">
		                                				<c:choose>
		                                					<c:when test="${ not empty comment.user }">
		                                						<img style="width: 64px; height:64px;" src="${base}/upload/${ comment.user.avatar }" alt="">
		                                					</c:when>
		                                					<c:otherwise>
		                                						<img style="width: 64px; height:64px;" src="${base}/img/user.png" alt="">
		                                					</c:otherwise>
		                                				</c:choose>
	                                                </div>
	                                                <div class="avatar-text">
	                                                	<div class="at-rating">
	                                                        <c:forEach var = "i" begin = "1" end = "5">
						                                		<c:choose>
						                                			<c:when test="${ i <= comment.star }">
							                                			<i class="fa fa-star"></i>
							                                		</c:when>
							                                		<c:otherwise>
							                                			<i class="fa fa-star-o"></i>
							                                		</c:otherwise>
						                                		</c:choose>
														    </c:forEach>
	                                                    </div>
	                                                    <h5>${ comment.name } <span><fmt:formatDate type = "date" value = "${ comment.createdDate }" /></span></h5>
	                                                    <div class="at-reply">${ comment.content }</div>
	                                                </div>
	                                            </div>
									    	</c:forEach>
                                        </div>
                                        <div class="leave-comment mt-5">
                                            <h4>Nhận xét của bạn</h4>
                                            <form action="#" class="comment-form">
                                            	<div class="personal-rating">
		                                           	<h6>Đánh giá</h6>
		                                            <div class="pd-rating-choose mt-3">
					                                	<div class="sc-item">
					                                		<input type="radio" name="star" value="1" id="1-star">
					                                    	<label for="1-star">1 <i class="fa fa-star"></i></label>
					                                	</div>
					                                	<div class="sc-item">
					                                		<input type="radio" name="star" value="2" id="2-star">
					                                    	<label for="2-star">2 <i class="fa fa-star"></i></label>
					                                	</div>
					                                	<div class="sc-item">
					                                		<input type="radio" name="star" value="3" id="3-star">
					                                    	<label for="3-star">3 <i class="fa fa-star"></i></label>
					                                	</div>
					                                	<div class="sc-item">
					                                		<input type="radio" name="star" value="4" id="4-star">
					                                    	<label for="4-star">4 <i class="fa fa-star"></i></label>
					                                	</div>
					                                	<div class="sc-item">
					                                		<input type="radio" name="star" value="5" id="5-star" checked>
					                                    	<label for="5-star" class="active">5 <i class="fa fa-star"></i></label>
					                                	</div>
						                              </div>
		                                        </div>
                                                <div class="row">
                                               	 	<%
														boolean isLogined = false;
														Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
														if (principal instanceof UserDetails) {
															isLogined = true;
														}
													%>
													<% if(!isLogined) { %>
	                                                    <div class="col-lg-6">
	                                                        <input type="text" placeholder="Tên" id="commentName">
	                                                    </div>
	                                                    <div class="col-lg-6">
	                                                        <input type="text" placeholder="Email" id="commentEmail">
	                                                    </div>
	                                                <% } else { %>
	                                                	<div class="col-lg-6">
	                                                        <input type="hidden" placeholder="Tên" value="<%= ((User)principal).getFullname() %>" id="commentName">
	                                                    </div>
	                                                    <div class="col-lg-6">
	                                                        <input type="hidden" placeholder="Email" value="<%= ((User)principal).getEmail() %>" id="commentEmail">
	                                                    </div>
	                                                <% }%>
                                                    <div class="col-lg-12">
                                                        <textarea placeholder="Nội dung" id="commentContent"></textarea>
                                                        <button type="button" class="site-btn" id="postComment">Gửi</button>
                                                    </div>
                                                </div>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Product Shop Section End -->


<jsp:include page="/WEB-INF/views/front-end/common/footer.jsp"></jsp:include>
<script src="${pageContext.request.contextPath}/js/product.js"></script>