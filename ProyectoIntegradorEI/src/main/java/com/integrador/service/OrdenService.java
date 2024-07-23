package com.integrador.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.integrador.entity.Cupon;
import com.integrador.entity.Orden;
import com.integrador.entity.Pelicula;
import com.integrador.entity.User;
import com.integrador.repository.CuponRepository;
import com.integrador.repository.EstadoOrdenRepository;
import com.integrador.repository.OrdenRepository;
import com.integrador.repository.PeliculaRepository;
import com.integrador.repository.UserRepository;
import com.integrador.requests.RequestOrden;

@Service
public class OrdenService {
	
	@Autowired
	private OrdenRepository ordenRepository;
	
	@Autowired
	private UserRepository userRepository;
	
	@Autowired
	private EstadoOrdenRepository estadoOrdenRepository;
	
	@Autowired
	private CuponRepository cuponRepository;
	
	@Autowired
	private PeliculaRepository peliculaRepository;
		
	public void saveOrden(RequestOrden request) {
		Orden orden = new Orden();
		
		Optional<User> userOpt= userRepository.findByEmail(request.getEmail());
		
		if(userOpt.isPresent()) {
			User user = userOpt.get();
			orden.setSocio(user);
			orden.setEstadoOrden(estadoOrdenRepository.findByEstado("PENDIENTE APROBACION"));
			
			double totalSinDescuento = 0;
			for(String p: request.getPeliculas()) {
				Optional<Pelicula> peliculaOpt = peliculaRepository.findById(Long.valueOf(p));
				
				if(peliculaOpt.isPresent()) {
					Pelicula pelicula = peliculaOpt.get();
					orden.addPelicula(pelicula);
					double value = pelicula.getPrecio();
					
					totalSinDescuento += value;					
				}
							
				
			}
			
			double descuento = 0;
			Optional<Cupon> cupon = cuponRepository.findByCodigo(request.getCuponCodigo());
			
			if(cupon.isPresent()) {				
				orden.setCupon(cupon.get());
				descuento = cupon.get().getPorcentaje();
			}
			
			orden.setMonto(Math.round(totalSinDescuento * (1-descuento) * 100.0) /100.0);
			
			
			
		}
		
		
		
		ordenRepository.save(orden);
	}
	
	public List<com.integrador.model.Orden> findOrdenesByEmail(String email) {
		
		List<Optional<Orden>> ordenesOpt = ordenRepository.findBySocioId(userRepository.findByEmail(email).get().getId());
		List<com.integrador.model.Orden> ordenesModelo = new ArrayList<>();
		if(!ordenesOpt.isEmpty()) {
			for (Optional<Orden> o: ordenesOpt) {
				ordenesModelo.add(o.get().toDto());
			}
		}
		
		return ordenesModelo;
		
	}

	public List<com.integrador.model.Orden> findAllOrdenes() {
		
		List<Orden> ordenesOpt = ordenRepository.findAll();
		List<com.integrador.model.Orden> ordenesModelo = new ArrayList<>();
		if(!ordenesOpt.isEmpty()) {
			for (Orden o: ordenesOpt) {
				ordenesModelo.add(o.toDto());
			}
		}
		
		return ordenesModelo;
	}
	
	public void approveOrden(int id) {
		Orden orden = ordenRepository.getById(id);
		orden.setEstadoOrden(estadoOrdenRepository.findByEstado("APROBADA"));
		ordenRepository.save(orden);
	}
	
	public void declineOrden(int id) {
		Orden orden = ordenRepository.getById(id);
		orden.setEstadoOrden(estadoOrdenRepository.findByEstado("RECHAZADA"));
		ordenRepository.save(orden);
	}

	
}
