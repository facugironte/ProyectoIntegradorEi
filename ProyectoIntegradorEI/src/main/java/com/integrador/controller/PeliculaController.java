package com.integrador.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.integrador.model.Pelicula;
import com.integrador.requests.RequestPelicula;
import com.integrador.service.PeliculaService;

@RestController
@RequestMapping("/pelicula")
public class PeliculaController {

	@Autowired
	private PeliculaService peliculaService;
	
	@PostMapping(value = "/add")
	public ResponseEntity<Void> addPelicula(@RequestBody Pelicula request){
		
		
		peliculaService.savePelicula(request);
		return new ResponseEntity<>(HttpStatus.CREATED);
		
	}
	
	@PostMapping(value = "/modify")
	public ResponseEntity<Void> modifyPelicula(@RequestBody Pelicula request){
		
	
		peliculaService.updatePelicula(request);
		return new ResponseEntity<>(HttpStatus.OK);
		
	}
	
	@PostMapping(value = "/get-pelicula")
	public ResponseEntity<Pelicula> getPeliculaByID(@RequestBody RequestPelicula request){
		
		com.integrador.entity.Pelicula pelicula = peliculaService.findPeliculaByID(request.getId());
		
		Pelicula peliculaModel = pelicula.toDto();
	
		
		return new ResponseEntity<>(peliculaModel, HttpStatus.OK);
		
	}
	
	
	@DeleteMapping(value = "/delete")
	public ResponseEntity<Void> deletePelicula(@RequestBody RequestPelicula request){
			
		peliculaService.deletePeliculaById(request.getId());
		return new ResponseEntity<>(HttpStatus.OK);
		
	}
	
	
}
