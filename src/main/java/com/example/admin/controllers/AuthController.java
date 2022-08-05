package com.example.admin.controllers;

import java.util.List;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.example.admin.models.User;
import com.example.admin.requests.UserLoginRequest;
import com.example.admin.services.UserService;



@Controller
public class AuthController {
	private final UserService userService;
	public AuthController(UserService userService) {
		this.userService = userService;
	}
	
	@GetMapping("/")
	public String ShowRegisterLogin(Model model) {
		if(!model.containsAttribute("newUser")) {
			model.addAttribute("newUser",new User());
		}
		if(!model.containsAttribute("loginUser")) {
			model.addAttribute("loginUser", new UserLoginRequest());
		}
		return "index.jsp";
		
	}
	
	@PostMapping("/register")
	public String createUser(
			@Valid @ModelAttribute("newUser") User newUser,
			BindingResult result,
			RedirectAttributes redirectAttributes,
			HttpSession session) {
		User user = userService.createUser(newUser, result);
		if (user== null) {
			redirectAttributes.addFlashAttribute("newUser", newUser);
			redirectAttributes.addFlashAttribute("org.springframework.validation.BindingResult.newUser", result);
			return "redirect:/";
		}
		else {
			session.setAttribute("user_id", user.getId());
			String role = user.getRole();
			session.setAttribute("role",role );
			return role.equals("non-admin")? "redirect:/dashboard": "redirect:/admin" ;
		}
		
	}
	@PostMapping("/login")
	public String userLogin(
			@Valid @ModelAttribute("loginUser") UserLoginRequest user,
			BindingResult result,
			RedirectAttributes redirectAttributes,
			HttpSession session) {
		if(result.hasErrors()) {
			redirectAttributes.addFlashAttribute("loginUser", user);
			redirectAttributes.addFlashAttribute("org.springframework.validation.BindingResult.loginUser", result);
			return "redirect:/";
		}

		User userLogged = userService.loginUser(user, result);
		if (userLogged== null) {
			redirectAttributes.addFlashAttribute("loginUser", user);
			redirectAttributes.addFlashAttribute("org.springframework.validation.BindingResult.loginUser", result);
			return "redirect:/";
		}
		else {
			session.setAttribute("user_id", userLogged.getId());
			String role = userLogged.getRole();
			session.setAttribute("role",role );
			return role.equals("non-admin")? "redirect:/dashboard": "redirect:/admin" ;
		}
		
	}
	
	@GetMapping("/logout")
	public String logout(HttpSession session) {
		session.removeAttribute("user_id");
		return "redirect:/";
	}
	
	@GetMapping("/admin")
	public String showAdmin(Model model, HttpSession session,RedirectAttributes redirectAttributes) {
		if (session.getAttribute("role").equals("non-admin"))
		{
			redirectAttributes.addFlashAttribute("error", "only admin allowed to enter this page");
			return "redirect:/dashboard";
		}
			
		List<User> users = userService.findAllExceptSuper();
		model.addAttribute("users",users);
		return "/admin.jsp";
	}
	
	@GetMapping("/dashboard")
	public String showAdmin(Model model,HttpSession session) {
		User user = userService.findUser((Long) session.getAttribute("user_id"));
		model.addAttribute("user",user);
		return "/dashboard.jsp";
	}
	
	@PutMapping("/users/{id}/make_admin")
	public String makeAdmin(@PathVariable("id") Long id) {
		User user = userService.findUser(id);
		userService.makeUserAdmin(user);
		return "redirect:/admin";
	}
	
	@DeleteMapping("/users/{id}/delete")
	public String deleteUser(@PathVariable("id") Long id) {
		userService.deleteUser(id);
		return "redirect:/admin";
	}
}
