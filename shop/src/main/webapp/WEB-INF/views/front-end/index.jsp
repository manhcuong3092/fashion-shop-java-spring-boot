    <jsp:include page="/WEB-INF/views/front-end/common/header.jsp"></jsp:include>
    <jsp:include page="/WEB-INF/views/common/variables.jsp"></jsp:include>
	<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
	<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
	<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
	<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>

    <!-- Hero Section Begin -->
    <section class="hero-section">
        <div class="hero-items owl-carousel">
            <div class="single-hero-items set-bg" data-setbg="img/hero-1.jpg">
                <div class="container">
                    <div class="row">
                        <div class="col-lg-5">
                            <span>Phụ kiện</span>
                            <h1>Black friday</h1>
                            <p>Thứ sáu đen, khuyến mại nhiều sản phẩm lên đến 50%</p>
                            <a href="${base}/shop" class="primary-btn">Shop Now</a>
                        </div>
                    </div>
                    <div class="off-card">
                        <h2>Sale <span>50%</span></h2>
                    </div>
                </div>
            </div>
            <div class="single-hero-items set-bg" data-setbg="img/hero-2.jpg">
                <div class="container">
                    <div class="row">
                        <div class="col-lg-5">
                            <span>Quần Áo</span>
                            <h1>Black friday</h1>
                            <p>Thứ sáu đen, khuyến mại nhiều sản phẩm lên đến 50%</p>
                            <a href="${base}/shop"  class="primary-btn">Shop Now</a>
                        </div>
                    </div>
                    <div class="off-card">
                        <h2>Sale <span>50%</span></h2>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Hero Section End -->

    <!-- Banner Section Begin -->
    <div class="banner-section spad">
        <div class="container-fluid">
            <div class="row">
                <div class="col-lg-4">
                    <div class="single-banner">
                        <img src="img/banner-1.jpg" alt="">
                        <div class="inner-text">
                            <h4><a class="text-body" href="${ base }/shop/search-all?gender=Nam">Nam</a></h4>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4">
                    <div class="single-banner">
                        <img src="img/banner-2.jpg" alt="">
                        <div class="inner-text">
                            <h4><a class="text-body" href="${ base }/shop/search-all?gender=Nữ">Nữ</a></h4>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4">
                    <div class="single-banner">
                        <img src="img/banner-3.jpg" alt="">
                        <div class="inner-text">
                            <h4><a class="text-body" href="${ base }/shop/search-all?gender=Trẻ+em">Trẻ em</a></h4>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Banner Section End -->

    <!-- Women Banner Section Begin -->
    <section class="women-banner spad">
        <div class="container-fluid">
            <div class="row">
                <div class="col-lg-3">
                    <div class="product-large set-bg" data-setbg="img/products/women-large.jpg">
                        <h2>Nữ</h2>
                        <a href="${ base }/shop/search-all?gender=Nữ">Khám phá thêm</a>
                    </div>
                </div>
                <div class="col-lg-8 offset-lg-1">
                    <div class="filter-control">
                        <ul>
                            <li class="active">Sản phẩm</li>
                        </ul>
                    </div>
                    <div class="product-slider owl-carousel">
                        <c:forEach items="${ womanProducts }" var="product">
                        	<div class="product-item">
	                            <div class="pi-pic">
	                                <img src="${ base }/upload/${ product.avatar }" alt="">
	                                <c:if test="${ not empty product.priceSale }">
                                  		<div class="sale">
                                  			-<fmt:formatNumber value="${ 100 - product.priceSale*100/product.price }" maxFractionDigits="0" />%
                                  		</div>
                                  	</c:if>
	                                <ul>
	                                    <li class="quick-view"><a href="${ base }/product/${ product.seo }">Xem chi tiết</a></li>
	                                </ul>
	                            </div>
	                            <div class="pi-text">
	                                <div class="catagory-name">${ product.category.name }</div>
	                                <a href="${ base }/product/${ product.seo }">
	                                    <h5>${ product.title }</h5>
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
                        </c:forEach>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Women Banner Section End -->

    <!-- Man Banner Section Begin -->
    <section class="man-banner spad">
        <div class="container-fluid">
            <div class="row">
                <div class="col-lg-8">
                    <div class="filter-control">
                        <ul>
                            <li class="active">Sản phẩm</li>
                        </ul>
                    </div>
                    <div class="product-slider owl-carousel">
                    	<c:forEach items="${ manProducts }" var="product">
                    		<div class="product-item">
	                            <div class="pi-pic">
	                                <img src="${ base }/upload/${ product.avatar }" alt="">
	                                <c:if test="${ not empty product.priceSale }">
                                  		<div class="sale">
                                  			-<fmt:formatNumber value="${ 100 - product.priceSale*100/product.price }" maxFractionDigits="0" />%
                                  		</div>
                                  	</c:if>
	                                <ul>
	                                    <li class="quick-view"><a href="${ base }/product/${ product.seo }">Xem chi tiết</a></li>
	                                </ul>
	                            </div>
	                            <div class="pi-text">
	                                <div class="catagory-name">${ product.category.name }</div>
	                                <a href="${ base }/product/${ product.seo }">
	                                    <h5>${ product.title }</h5>
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
                    	</c:forEach>
                    </div>
                </div>
                <div class="col-lg-3 offset-lg-1">
                    <div class="product-large set-bg m-large" data-setbg="img/products/man-large.jpg">
                        <h2>Nam</h2>
                        <a href="${ base }/shop/search-all?gender=Nam">Khám phá thêm</a>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Man Banner Section End -->

    <!-- Instagram Section Begin -->
    <div class="instagram-photo">
        <div class="insta-item set-bg" data-setbg="img/insta-1.jpg">
            <div class="inside-text">
                <i class="ti-instagram"></i>
                <h5><a href="#">Bộ sưu tập</a></h5>
            </div>
        </div>
        <div class="insta-item set-bg" data-setbg="img/insta-2.jpg">
            <div class="inside-text">
                <i class="ti-instagram"></i>
                <h5><a href="#">Bộ sưu tập</a></h5>
            </div>
        </div>
        <div class="insta-item set-bg" data-setbg="img/insta-3.jpg">
            <div class="inside-text">
                <i class="ti-instagram"></i>
                <h5><a href="#">Bộ sưu tập</a></h5>
            </div>
        </div>
        <div class="insta-item set-bg" data-setbg="img/insta-4.jpg">
            <div class="inside-text">
                <i class="ti-instagram"></i>
                <h5><a href="#">Bộ sưu tập</a></h5>
            </div>
        </div>
        <div class="insta-item set-bg" data-setbg="img/insta-5.jpg">
            <div class="inside-text">
                <i class="ti-instagram"></i>
                <h5><a href="#">Bộ sưu tập</a></h5>
            </div>
        </div>
        <div class="insta-item set-bg" data-setbg="img/insta-6.jpg">
            <div class="inside-text">
                <i class="ti-instagram"></i>
                <h5><a href="#">Bộ sưu tập</a></h5>
            </div>
        </div>
    </div>
    <!-- Instagram Section End -->

    <!-- Latest Blog Section Begin -->
    <section class="latest-blog spad">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <div class="section-title">
                        <h2>Từ các Blog</h2>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-lg-4 col-md-6">
                    <div class="single-latest-blog">
                        <img src="img/latest-1.jpg" alt="">
                        <div class="latest-text">
                            <div class="tag-list">
                                <div class="tag-item">
                                    <i class="fa fa-calendar-o"></i>
                                    May 4,2019
                                </div>
                                <div class="tag-item">
                                    <i class="fa fa-comment-o"></i>
                                    5
                                </div>
                            </div>
                            <a href="#">
                                <h4>Phong cách đường phố đẹp nhất từ Tuần lễ thời trang Hà Nội</h4>
                            </a>
                            <p>Tuần lễ thời trang, với tên gọi tiếng Anh "fashion week", là một sự kiện của ngành công nghiệp thời trang... </p>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4 col-md-6">
                    <div class="single-latest-blog">
                        <img src="img/latest-2.jpg" alt="">
                        <div class="latest-text">
                            <div class="tag-list">
                                <div class="tag-item">
                                    <i class="fa fa-calendar-o"></i>
                                    May 4,2019
                                </div>
                                <div class="tag-item">
                                    <i class="fa fa-comment-o"></i>
                                    5
                                </div>
                            </div>
                            <a href="#">
                                <h4>Hướng dẫn cơ bản về giày Thu / Đông 2019 của Vogue</h4>
                            </a>
                            <p>Thiết kế của giày đã đa dạng và phong phú vô cùng theo thời gian, văn hoá và mục đích sử dụng. Ngoài ra thời trang cũng chi phối nhiều yếu tố thiết kế, chẳng hạn như giày có gót rất cao (giày cao gót) hay có gót phẳng (giày thể thao)...</p>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4 col-md-6">
                    <div class="single-latest-blog">
                        <img src="img/latest-3.jpg" alt="">
                        <div class="latest-text">
                            <div class="tag-list">
                                <div class="tag-item">
                                    <i class="fa fa-calendar-o"></i>
                                    May 4,2019
                                </div>
                                <div class="tag-item">
                                    <i class="fa fa-comment-o"></i>
                                    5
                                </div>
                            </div>
                            <a href="#">
                                <h4>Làm thế nào để làm sáng tủ quần áo của bạn với một chút vôi</h4>
                            </a>
                            <p>Đá vôi không rắn bằng đá granit, nhưng phổ biến hơn, khai thác và gia công dễ dàng hơn, nên được dùng rộng rãi hơn. Đá vôi thường được dùng làm cốt liệu cho bê tông...</p>
                        </div>
                    </div>
                </div>
            </div>
            <div class="benefit-items">
                <div class="row">
                    <div class="col-lg-4">
                        <div class="single-benefit">
                            <div class="sb-icon">
                                <img src="img/icon-1.png" alt="">
                            </div>
                            <div class="sb-text">
                                <h6>Miễn phí giao hàng</h6>
                                <p>Cho các đơn hàng trên 500.000 đồng</p>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-4">
                        <div class="single-benefit">
                            <div class="sb-icon">
                                <img src="img/icon-2.png" alt="">
                            </div>
                            <div class="sb-text">
                                <h6>Giao hành đúng hạn</h6>
                                <p>Nếu không có gì phát sinh thêm</p>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-4">
                        <div class="single-benefit">
                            <div class="sb-icon">
                                <img src="img/icon-1.png" alt="">
                            </div>
                            <div class="sb-text">
                                <h6>Thanh toán an toàn</h6>
                                <p>Cam kết chất lượng sản phẩm</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Latest Blog Section End -->


<jsp:include page="/WEB-INF/views/front-end/common/footer.jsp"></jsp:include>