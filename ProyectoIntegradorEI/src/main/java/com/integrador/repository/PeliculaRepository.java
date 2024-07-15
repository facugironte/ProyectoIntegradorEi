package com.integrador.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.integrador.entity.Pelicula;


public interface PeliculaRepository extends JpaRepository<Pelicula, Long> {
	
	List<Pelicula> findByTituloContaining(String title);

}
