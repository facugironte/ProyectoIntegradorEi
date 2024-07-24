package com.integrador.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;

import com.integrador.entity.Orden;
import com.integrador.entity.Pelicula;

public interface OrdenRepository extends JpaRepository<Orden, Integer>{

	List<Optional<Orden>> findBySocioId(Integer id);
	List<Orden> findByPeliculasContains(Pelicula pelicula);
	
	
}

