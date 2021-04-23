package com.cuong.shop.services;

import java.io.File;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.cuong.shop.Constants;
import com.cuong.shop.entities.Role;
import com.cuong.shop.entities.User;
import com.cuong.shop.repositories.RoleRepo;
import com.cuong.shop.repositories.UserRepo;


@Service
public class UserService implements Constants {
	
	@PersistenceContext
	protected EntityManager entityManager;
	
	@Autowired UserRepo userRepo;
	
	@Autowired RoleRepo roleRepo;

	public User loadUserByUsername(String userName) {
		try {
			String jpql = "Select u From User u Where u.username='" + userName + "'";
			Query query = entityManager.createQuery(jpql, User.class);
			return (User) query.getSingleResult();
		} catch (Exception e) {
			return null;
		}
	}
	
	public List<User> search(Date limitDate){
		String jpql = "SELECT u FROM User u where 1=1";
		jpql = jpql + " AND u.createdDate > :limitDate";
		Query query = entityManager.createQuery(jpql, User.class);
		query.setParameter("limitDate", limitDate);
		return query.getResultList();
	}
	
	private boolean isEmptyUploadFile(MultipartFile image) {
		return image == null || image.getOriginalFilename().isEmpty();
	}
	
	@Transactional(rollbackOn = Exception.class)
	public void saveOrUpdate(User user,  MultipartFile userAvatar) throws Exception {
		try {
			//Change Avatar if have upload file
			if(user.getId() != null && user.getId() > 0) {
				User userInDb = userRepo.findById(user.getId()).get();
				//delete file
				if(!isEmptyUploadFile(userAvatar)) {
					String avatarPath = ROOT_UPLOAD_PATH + user.getAvatar();
					new File(avatarPath).delete();
				}
			}
			
			if(userAvatar.getOriginalFilename().length() != 0) {
				String avatarPath = "user/avatar/" + System.currentTimeMillis() + "-" + userAvatar.getOriginalFilename();
				userAvatar.transferTo(new File(ROOT_UPLOAD_PATH + avatarPath));
				user.setAvatar(avatarPath);
			}
			
			if(user.getId() == null) {
				if(user.getUsername().length() <= 5) throw new Exception("Tên người dùng không hợp lệ");
				if(user.getUsername().contains(" ")) throw new Exception("Tên người dùng không được chứa dấu cách");
				if(user.getPassword().length() < 8) throw new Exception("Mật khẩu phải ít nhất 8 kí tự");
			}
			
			//validate input
			if(user.getAddress().isBlank()) throw new Exception("Địa chỉ không hợp lệ");
			if(user.getFullname().isBlank()) throw new Exception("Họ tên người dùng không hợp lệ");
			if(user.getEmail().isBlank()) throw new Exception("Email không hợp lệ");
			if(user.getEmail().indexOf("@") == -1) throw new Exception("Email không hợp lệ");
			if(user.getPhone().isBlank()) throw new Exception("Số điện thoại không hợp lệ");
			if(!user.getPhone().matches("[0-9]{10,11}")) throw new Exception("Số điện thoại không hợp lệ");
			
			//check if create new user, find username already exist or not
			if(user.getId() == null) {
				String jpql = "Select u From User u Where u.username='" + user.getUsername().toLowerCase() + "'";
				Query query = entityManager.createQuery(jpql, User.class);
				List<User> existUser = query.getResultList();
				if(existUser.size() > 0) throw new Exception("Tên tài khoản này đã tồn tại");
				BCryptPasswordEncoder encoder = new BCryptPasswordEncoder(4);
				String result = encoder.encode(user.getPassword());
				user.setPassword(result);
				user.setCreatedDate(new Date());
			}
			
			user.setUsername(user.getUsername().toLowerCase());
			Role role = roleRepo.findById(user.getRoles().get(0).getId()).get();
			ArrayList<Role> roles = new ArrayList<Role>();
			roles.add(role);
			user.setRoles(roles);
			
			userRepo.save(user);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	
	//delete User
	@Transactional(rollbackOn = Exception.class)
	public boolean delete(int userId) throws Exception {
		try {
			User user = userRepo.findById(userId).get();
			String avatarPath = ROOT_UPLOAD_PATH + user.getAvatar();
			new File(avatarPath).delete();
			//many to many: remove user in this role then delete by id
			user.getRoles().get(0).removeUser(user);
			userRepo.deleteById(userId);
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
}
