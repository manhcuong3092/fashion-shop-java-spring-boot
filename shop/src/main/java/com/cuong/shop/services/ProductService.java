package com.cuong.shop.services;

import java.io.File;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashSet;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;
import org.springframework.web.multipart.MultipartFile;

import com.cuong.shop.Constants;
import com.cuong.shop.Utilities;
import com.cuong.shop.dto.ProductSearch;
import com.cuong.shop.dto.QueryResultInfor;
import com.cuong.shop.entities.Color;
import com.cuong.shop.entities.Product;
import com.cuong.shop.entities.ProductImages;
import com.cuong.shop.entities.Size;
import com.cuong.shop.repositories.ProductRepo;
import com.cuong.shop.taglibs.PaginationTaglib;



@Service
public class ProductService implements Constants {
	
	@Autowired
	private ProductRepo productRepo;
	
	@PersistenceContext
	EntityManager entityManager;
	
	private QueryResultInfor queryResultInfor;
	
	//create a query by productSearch properties
	public List<Product> search(ProductSearch productSearch) {
		String jpql = "SELECT p FROM Product p where 1=1";
		
		if(!StringUtils.isEmpty(productSearch.getSeo())) {
			jpql = jpql + " AND p.seo = '" + productSearch.getSeo() + "'";
		}
		
		if(productSearch.getCategoryId() != null) {
			jpql = jpql + " AND (p.category.id = " + productSearch.getCategoryId() + 
					" OR p.category.parentId = " + productSearch.getCategoryId() + ")";
		} 
		
		if(!StringUtils.isEmpty(productSearch.getGender())) {
			jpql = jpql + " AND p.gender = '" + productSearch.getGender() + "'";
		}
		
		if(!StringUtils.isEmpty(productSearch.getSearchText())) {
			String st = "%" + productSearch.getSearchText() + "%";
			jpql = jpql + " AND (p.title LIKE '" + st + "' OR p.shortDescription LIKE '" + st + "')";
		}
		
		jpql = jpql + " AND p.status = true";
		
		Query query = entityManager.createQuery(jpql, Product.class);
		ArrayList<Product> products = (ArrayList<Product>) query.getResultList();
		
		if(!StringUtils.isEmpty(productSearch.getSize())) {
			searchBySize(products, productSearch.getSize());
		}
		
		if(!StringUtils.isEmpty(productSearch.getColor())) {
			searchByColor(products, productSearch.getColor());
		}
		
		if(productSearch.getMin() != null && productSearch.getMin().compareTo(new BigDecimal("-1")) > 0 ) {
			filterByMinPrice(products, productSearch.getMin());
		}
		
		if(productSearch.getMax() != null && productSearch.getMax().compareTo(new BigDecimal("-1")) > 0 ) {
			filterByMaxPrice(products, productSearch.getMax());
		}
		if(!StringUtils.isEmpty(productSearch.getOrder())) {
			if(productSearch.getOrder().equals("asc")) {
				sortProductByPrice(products, "asc");
			} else if (productSearch.getOrder().equals("des")) {
				sortProductByPrice(products, "des");
			}
		}
		
		int resultCount = products.size();
		queryResultInfor = new QueryResultInfor();
		queryResultInfor.setResultCount(resultCount);
		productSearch.setCount(resultCount);
		
		// paging
		int maxItemPerPage = (products.size() < PaginationTaglib.MAX) ? products.size() : PaginationTaglib.MAX;
		if(productSearch.getOffset() != null) {
			queryResultInfor.setStart(productSearch.getOffset() + 1);
		} else {
			queryResultInfor.setStart(1);
			productSearch.setOffset(0);
		}
		if(resultCount == 0) {
			queryResultInfor.setStart(0);
		}
		if(queryResultInfor.getStart() + maxItemPerPage <= resultCount) {
			queryResultInfor.setEnd(productSearch.getOffset() + maxItemPerPage);
		} else {
			queryResultInfor.setEnd(resultCount);
		}
		ArrayList<Product> resultProducts = new ArrayList<Product>(products.subList(productSearch.getOffset(), queryResultInfor.getEnd()));
		// paging
//		if (productSearch.getOffset() != null) {
//			productSearch.setCount(query.getResultList().size());
//			
//			query.setFirstResult(productSearch.getOffset());
//			query.setMaxResults(PaginationTaglib.MAX);
//		}
		return resultProducts;
	}
	
	private void filterByMaxPrice(ArrayList<Product> products, BigDecimal max) {
		for(Product p: new ArrayList<Product>(products)) {
			if(p.getPriceSale() != null) {
				if(p.getPriceSale().compareTo(max) > 0) {
					products.remove(p);
				}
			} else {
				if(p.getPrice().compareTo(max) > 0) {
					products.remove(p);
				}
			}
		}
	}

	private void filterByMinPrice(ArrayList<Product> products, BigDecimal min) {
		for(Product p: new ArrayList<Product>(products)) {
			if(p.getPriceSale() != null) {
				if(p.getPriceSale().compareTo(min) < 0) {
					products.remove(p);
				}
			} else {
				if(p.getPrice().compareTo(min) < 0) {
					products.remove(p);
				}
			}
		}
	}

	private void sortProductByPrice(ArrayList<Product> products, String order) {
		int compare = (order.equals("asc") ? 1 : -1);
		Collections.sort(products, new Comparator<Product>() {
			@Override
			public int compare(Product p1, Product p2) {
				BigDecimal price1 = (p1.getPriceSale() != null) ? p1.getPriceSale() : p1.getPrice();
				BigDecimal price2 = (p2.getPriceSale() != null) ? p2.getPriceSale() : p2.getPrice();
				return price1.compareTo(price2)*compare;
			}
		});
		
	}

	//filter by size
	private void searchBySize(List<Product> products, String size) {
		for(Product p: new ArrayList<Product>(products)) {
			boolean isExist = false;
			for(Size s: p.getSizes()) {
				if(s.getName().compareToIgnoreCase(size) == 0) {
					isExist = true;
					break;
				}
			}
			if(!isExist) {
				products.remove(p);
			}
		}
	}
	
	//filter by color
	private void searchByColor(List<Product> products, String color) {
		for(Product p: new ArrayList<Product>(products)) {
			boolean isExist = false;
			for(Color s: p.getColors()) {
				if(s.getName().compareToIgnoreCase(color) == 0) {
					isExist = true;
					break;
				}
			}
			if(!isExist) {
				products.remove(p);
			}
		}
	}
	
	/**
	 * Kiem tra uploaded file.
	 * @param images
	 * @return true - khi nguoi dung khong upload file.
	 */
	private boolean isEmptyUploadFile(MultipartFile[] images) {
		if (images == null || images.length <= 0)
			return true;
		if (images.length == 1 && images[0].getOriginalFilename().isEmpty())
			return true;
		return false;
	}

	private boolean isEmptyUploadFile(MultipartFile image) {
		return image == null || image.getOriginalFilename().isEmpty();
	}
	
	@Transactional(rollbackOn = Exception.class)
	public void saveOrUpdate(Product product, MultipartFile productAvatar, MultipartFile[] images) throws Exception {
		try {
			// truong hop la chinh sua
			if(product.getId() != null && product.getId() > 0) {
				Product productIdDB = productRepo.findById(product.getId()).get();
				
				// neu upload lai anh thi phai xoa anh cu di
				if(!isEmptyUploadFile(productAvatar)) {
					String avatarPath = ROOT_UPLOAD_PATH + productIdDB.getAvatar();
					new File(avatarPath).delete();
				}
			}
						
			// kiem tra neu nguoi dung co upload file.
			if(productAvatar != null && !productAvatar.getOriginalFilename().equals("")) {
				String avatarPath = "product/avatar/" + System.currentTimeMillis() + "-" + productAvatar.getOriginalFilename();
				productAvatar.transferTo(new File(ROOT_UPLOAD_PATH + avatarPath));
				// add time id
				product.setAvatar(avatarPath);
			}
			if(images != null && images.length > 0 && !images[0].getOriginalFilename().equals("") ) {
				HashSet<ProductImages> imageSet = new HashSet<ProductImages>();
				for(int i = 0; i < images.length; i++) {
					String imagePath = "product/images/" + System.currentTimeMillis() + "-" + images[i].getOriginalFilename();
					images[i].transferTo(new File(ROOT_UPLOAD_PATH + imagePath));
					// add time id
					ProductImages productImages = new ProductImages();
					productImages.setProduct(product);
					productImages.setTitle(images[i].getOriginalFilename());
					productImages.setPath(imagePath);
					imageSet.add(productImages);
					product.setProductImages(imageSet);
				}
			}
			
			product.setSeo(Utilities.seo(product.getTitle()+ " " + System.currentTimeMillis()));
			
			for(Size size: product.getSizes()) {
				if(size.getName().length() == 0) throw new Exception();
				size.setProduct(product);
			}
			
			for(Color color: product.getColors()) {
				if(color.getName().length() == 0) throw new Exception();
				color.setProduct(product);
			}
			
			productRepo.save(product);
			
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	
	@Transactional(rollbackOn = Exception.class)
	public boolean delete(int productId) throws Exception {
		try {
			Product product = productRepo.findById(productId).get();
			String avatarPath = ROOT_UPLOAD_PATH + product.getAvatar();
			new File(avatarPath).delete();
			for(ProductImages image: product.getProductImages()) {
				new File(ROOT_UPLOAD_PATH + image.getPath()).delete();
			}
			productRepo.deleteById(productId);
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	public QueryResultInfor getQueryResultInfor() {
		return queryResultInfor;
	}
	
}
