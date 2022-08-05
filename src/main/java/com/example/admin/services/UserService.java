package com.example.admin.services;

import java.util.List;
import java.util.Optional;

import org.mindrot.jbcrypt.BCrypt;
import org.springframework.stereotype.Service;
import org.springframework.validation.BindingResult;

import com.example.admin.models.User;
import com.example.admin.repositories.UserRepository;
import com.example.admin.requests.UserLoginRequest;


@Service
public class UserService {
	private UserRepository userRepository;
	
	public UserService (UserRepository userRepository) {
		this.userRepository = userRepository;
	}
	
	public User createUser(User user, BindingResult result) {
		Optional<User> userOptional =  userRepository.findByEmail(user.getEmail());
		if(userOptional.isPresent()) {
			result.rejectValue("email", "unique", "Email address already exist");
		}
		if(!user.getPassword().equals(user.getConfirmPassword())) {
			result.rejectValue("password", "matches", "Passwords do not match");
		}
		
		if(result.hasErrors()) {
			return null; 
		}
		else {
			
			//role() will return the role of user 
			user.setRole(SuperAdmin());
			System.out.print(user.getRole());
			String hashed = BCrypt.hashpw(user.getPassword(), BCrypt.gensalt());
			user.setPassword(hashed);
			return userRepository.save(user);
		}
	}
	
	public User loginUser(UserLoginRequest userLoginRequest, BindingResult result) {
		Optional<User> optionalUser = userRepository.findByEmail(userLoginRequest.getEmail());
		if(!optionalUser.isPresent()) {
			result.rejectValue("email", "exists", "Email address does not exist.");
		}
		else {
			User user = optionalUser.get();
			if(BCrypt.checkpw(userLoginRequest.getPassword(), user.getPassword())) {
				return user;
			}
			else {
				result.rejectValue("password", "Invalid", "Invalid password.");
			}	
		}
		return null;
	}
	
	public User findUser(Long id) {
		Optional<User> optionalUser =  userRepository.findById(id);
	    return optionalUser.isPresent()?  optionalUser.get() : null;
	}
	
	public String SuperAdmin() {
		// if super_admin exist make the user non-admin, if not the he is the super_admin .. 
		// i.e the first user signed up will be super admin
		return userRepository.findByRole("super_admin").isEmpty()? "super_admin": "non-admin";
	}
	
	public void deleteUser (Long id) {
		userRepository.deleteById(id);
	}
	
	public List<User> allUsers(){
		return userRepository.findAll();
		
	}
	
	public List<User> findAllExceptSuper(){
		return userRepository.findByRoleNot("super_admin");
		
	}
	
	public void makeUserAdmin(User user) {
		user.setRole("admin");
		userRepository.save(user);
	}
}


