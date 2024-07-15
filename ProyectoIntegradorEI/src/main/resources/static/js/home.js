document.addEventListener('DOMContentLoaded', function() {
    const token = localStorage.getItem('token');
	if (token == null){
		redirect("/login");
	} 
	
	document.getElementById("addPeliculaForm").addEventListener("submit", function(event) {
        event.preventDefault();
        addPelicula();
    });
    
    document.getElementById("modifyPeliculaForm").addEventListener("submit", function(event) {
        event.preventDefault();
        modifyPelicula();
    });
    
    
});


function addPelicula(){
	
	const titulo = document.getElementById("addTitulo").value
	const sitio = document.getElementById("addSitio").value
	const img = document.getElementById("addImg").value
	
	var generos = []
	var select = document.getElementById("addGeneros")
	var elegidos = select.selectedOptions;
		
	for (var i = 0; i < elegidos.length; i++){
		generos.push(elegidos[i].value);
	}
	
	
	fetch('/pelicula/add', {
    method: 'POST',
    headers: {
        'Content-Type': 'application/json'
    },
    body: JSON.stringify({ titulo: titulo, img: img, url: sitio, generos: generos })
    })
	.then(response => {
		if(response.status == "201"){
			alert("Pelicula creada")
			redirect("/home")
		}
		
	})
	.catch(error =>{
		alert("Registro de pelicula fallido")
	})
	
}

function openModifyPelicula(id){
	
	fetch('/pelicula/get-pelicula', {
    method: 'POST',
    headers: {
        'Content-Type': 'application/json'
    },
    body: JSON.stringify({ id: id })
    })
	.then(response => {
	    if (!response.ok) {
	        throw new Error('Network response was not ok');
	    }
	    return response.json();
	})
	.then(data => {
		
		document.getElementById("modifyModalLabel").innerHTML = "Modificar pelicula (" + data.id + ")"
				
		document.getElementById("modifyTitulo").value = data.titulo
		document.getElementById("modifySitio").value = data.url
		document.getElementById("modifyImg").value = data.img
		
		var generos = data.generos
		var select = document.getElementById("modifyGeneros")

		for (let i = 0; i < select.options.length; i++){
			let option = select.options[i]
			if(generos.includes(option.value)){
				option.selected = true;
			} else{
				option.selected = false;
			} 
		}	
		
		
	})
	.catch(error =>{
		alert("Pelicula inexistente")
	})
		
	//document.getElementById("modifyTitulo").value = pelicula.titulo
	
	showModal("modifyPeliculaModal")
	

}

function modifyPelicula(){
	const idTexto = document.getElementById("modifyModalLabel").innerHTML
	const inicio = idTexto.indexOf("(")
	const fin = idTexto.indexOf(")", inicio)
	const id = idTexto.substring(inicio + 1, fin)
	
	const titulo = document.getElementById("modifyTitulo").value
	const sitio = document.getElementById("modifySitio").value
	const img = document.getElementById("modifyImg").value
	
	var generos = []
	var select = document.getElementById("modifyGeneros")
	var elegidos = select.selectedOptions;
		
	for (var i = 0; i < elegidos.length; i++){
		generos.push(elegidos[i].value);
	}
	
	
	fetch('/pelicula/modify', {
    method: 'POST',
    headers: {
        'Content-Type': 'application/json'
    },
    body: JSON.stringify({ id: id, titulo: titulo, img: img, url: sitio, generos: generos })
    })
	.then(response => {
		if(response.status == "200"){
			alert("Pelicula modificada")
			redirect("/home")
		}
		
	})
	.catch(error =>{
		alert("Registro de pelicula fallido")
	})
}

function deletePelicula(id){
	
	
	fetch('/pelicula/delete', {
    method: 'DELETE',
    headers: {
        'Content-Type': 'application/json'
    },
    body: JSON.stringify({ id: id})
    })
	.then(response => {
		if(response.status == "200"){
			alert("Pelicula eliminada")
			redirect("/home")
		}
		
	})
	.catch(error =>{
		alert("No se pudo eliminar la pelicula")
	})
}



