document.addEventListener('DOMContentLoaded', function() {
    const token = localStorage.getItem('token');
    
    
    
	if (token != null){
		//redirect("/home");
	}
	
	document.getElementById("login-form").addEventListener("submit", function(event) {
        event.preventDefault();
        login();
    });
    
    document.getElementById("register-form").addEventListener("submit", function(event) {
        event.preventDefault();
        register();
    });
	
	
});


