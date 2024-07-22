package com.integrador.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.integrador.model.Orden;
import com.integrador.requests.RequestOrden;
import com.integrador.requests.RequestOrdenesSocio;
import com.integrador.service.OrdenService;

@RestController
@RequestMapping("/orden")
public class OrdenController {

	@Autowired
	private OrdenService ordenService;
	
	@PostMapping(value = "/add")
	public ResponseEntity<Void> addOrden(@RequestBody RequestOrden request){
		
		ordenService.saveOrden(request);
		return new ResponseEntity<>(HttpStatus.CREATED);
		
	}
	
	@PostMapping(value = "/get-ordenes-socio")
	public ResponseEntity<List<Orden>> getOrdenesByEmail(@RequestBody RequestOrdenesSocio request){
		
		List<Orden> ordenes = ordenService.findOrdenesByEmail(request.getEmail());
		
		for(Orden o: ordenes) {
			System.out.println(o.toString());
		}
		
		return new ResponseEntity<>(ordenes, HttpStatus.OK);
		
	}
	
	
	
}
