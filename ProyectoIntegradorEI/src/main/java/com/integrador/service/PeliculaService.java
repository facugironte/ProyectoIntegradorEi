package com.integrador.service;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Optional;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.integrador.entity.Genero;
import com.integrador.entity.Pelicula;
import com.integrador.repository.GeneroRepository;
import com.integrador.repository.PeliculaRepository;

@Service
public class PeliculaService {
	
	@Autowired
	private PeliculaRepository peliculaRepository;
	
	@Autowired
	private GeneroRepository generoRepository;
	
	public void savePelicula(com.integrador.model.Pelicula request) {
		Pelicula pelicula = new Pelicula();
		
		pelicula.setTitulo(request.getTitulo());
		pelicula.setImg(request.getImg());
		pelicula.setUrl(request.getUrl());
		pelicula.setPrecio(request.getPrecio());
		
		for(String g: request.getGeneros()) {
			Genero genero = generoRepository.findByGenero(g);
			genero.setGenero(g);
			pelicula.getGeneros().add(genero);	
		}
		peliculaRepository.save(pelicula);
	}
	
	public void updatePelicula(com.integrador.model.Pelicula request) {
		
		Optional<Pelicula> existePelicula = peliculaRepository.findById(request.getId());
		
		if(existePelicula.isPresent()) {
			Pelicula pelicula = existePelicula.get();
			
			pelicula.setTitulo(request.getTitulo());
			pelicula.setImg(request.getImg());
			pelicula.setUrl(request.getUrl());
			pelicula.setPrecio(request.getPrecio());
			
			Set<Genero> generos = new HashSet<>();
			
			for(String g: request.getGeneros()) {
				generos.add(generoRepository.findByGenero(g));
			}
			
			pelicula.setGeneros(generos);
			
			peliculaRepository.save(pelicula);
			
		}
		
		
	}
	
	public List<com.integrador.model.Pelicula> findAllPeliculas(){
		
		List<Pelicula> peliculasEntity = peliculaRepository.findAll();
		List<com.integrador.model.Pelicula> peliculasModel = new ArrayList<>();
		 
		for(Pelicula p: peliculasEntity) {
			peliculasModel.add(p.toDto());
		}
		
		
		return peliculasModel;
	}
	
	public Pelicula findPeliculaByID(Long id) {
		
		Optional<Pelicula> peliculaOpt = peliculaRepository.findById(id);
		
		if(peliculaOpt.isPresent()) {
			Pelicula pelicula = peliculaOpt.get();
			return pelicula;
		}
		
		return null;
		
	}

	public List<com.integrador.model.Pelicula> findPeliculasByString(String busqueda) {

		List<Pelicula> peliculasEntity = peliculaRepository.findByTituloContaining(busqueda);
		List<com.integrador.model.Pelicula> peliculasModel = new ArrayList<>();
		 
		for(Pelicula p: peliculasEntity) {
			peliculasModel.add(p.toDto());
		}
		
		
		return peliculasModel;
				
	}
	
	public void deletePeliculaById(Long id) {
		Pelicula pelicula = peliculaRepository.findById(id).orElse(null);
		
		if(pelicula != null) {
			pelicula.getGeneros().clear();
			peliculaRepository.deleteById(id);
		}
		
	}




	
}
