package com.integrador.entity;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import com.fasterxml.jackson.annotation.JsonIgnore;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.JoinTable;
import jakarta.persistence.ManyToMany;
import jakarta.persistence.Table;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Entity
@Table (name = "peliculas")
@Getter
@Setter
@ToString
public class Pelicula {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private long id;
	
	@Column(name="titulo", nullable = false, length = 255)
	private String titulo;
	
	@Column(name = "url")
	private String url;
	
	@Column(name = "imagen_url", length = 1000)
	private String img;
	
	@ManyToMany(fetch = FetchType.EAGER, cascade = CascadeType.ALL)
	@JoinTable(
		name = "peliculas_genero", 
		joinColumns = @JoinColumn(name = "pelicula_id"), 
		inverseJoinColumns = @JoinColumn(name = "genero_id")
	)
	@JsonIgnore
	private Set<Genero> generos = new HashSet<>();
	
	public com.integrador.model.Pelicula toDto(){
		return new com.integrador.model.Pelicula(this.id, this.titulo, this.img, this.url, generosToString(this.generos));
	}

	private List<String> generosToString(Set<Genero> generos2) {
		
		List<String> generosString = new ArrayList<>();
		for(Genero g: this.generos) {
			generosString.add(g.getGenero());
		}
		return generosString;
	}
	
}
