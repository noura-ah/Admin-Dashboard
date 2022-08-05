package com.example.admin.repositories;

import java.util.List;
import java.util.Optional;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.example.admin.models.User;


@Repository
public interface UserRepository extends CrudRepository<User, Long>{
	Optional<User> findByEmail(String email);
	
	List<User> findByRole(String role);
	List<User> findByRoleNot(String role);
	List<User> findAll();
}